#include "elevator_control_gui/ola_model.hpp"

OlaModel::OlaModel()
: QObject(), Node("ola_model_node")                 //, count_(0)
{
  auto qos_profile = rclcpp::QoS(rclcpp::KeepLast(20)).best_effort().durability_volatile();
  using namespace std::placeholders;

  //Subscriber
  sequence_subscriber = this->create_subscription<elevator_interfaces::msg::RobotServiceSequence>(
    "/robot_service_sequence", qos_profile, std::bind(
      &OlaModel::robot_service_seqeunce_callback, this, _1));

  // Service
  call_robot_service_client = this->create_client<elevator_interfaces::srv::CallRobotService>(
    "call_robot_service");

  call_ev_service_client = this->create_client<elevator_interfaces::srv::CallElevatorService>(
    "call_elevator_service");

  cancel_robot_service_client = this->create_client<elevator_interfaces::srv::CancelRobotService>(
    "cancel_robot_service");

  get_ev_status_client = this->create_client<elevator_interfaces::srv::GetElevatorStatus>(
    "get_elevator_status");

  set_robot_status_client = this->create_client<elevator_interfaces::srv::SetRobotService>(
    "set_robot_service");

}

OlaModel::~OlaModel()
{
}


void OlaModel::robot_service_seqeunce_callback(
  const elevator_interfaces::msg::RobotServiceSequence::SharedPtr msg)
{
  //RCLCPP_INFO(this->get_logger(), "sequence : %s", msg->sequence.c_str());
  this->sequence = msg->sequence;
  emit sequence_topic_signal(QString::fromStdString(this->sequence));
}


void OlaModel::robot_service_call(int ev_num, std::string call_floor, std::string dest_floor)
{
  auto request = std::make_shared<elevator_interfaces::srv::CallRobotService::Request>();
  request->ev_num = ev_num;
  request->call_floor = call_floor;
  request->dest_floor = dest_floor;

  using ServiceResponseFuture =
    rclcpp::Client<elevator_interfaces::srv::CallRobotService>::SharedFuture;
  auto response_received_callback = [this](ServiceResponseFuture future) {
      auto response = future.get();
      //RCLCPP_INFO(this->get_logger(), "Result : %s", response->result.c_str());
      bool result = response->result;
      this->robot_service_result = result;
      QString result_qstr;
      if (result) {
        result_qstr = QString("True");
      } else {
        result_qstr = QString("False");
      }

      emit resultCallRobotService(result_qstr); //signal
      return;
    };

  auto future_result =
    call_robot_service_client->async_send_request(request, response_received_callback);
}


void OlaModel::elevator_service_call(int ev_num, std::string direction, std::string floor)
{
  auto request = std::make_shared<elevator_interfaces::srv::CallElevatorService::Request>();
  request->ev_num = ev_num;
  request->direction = direction;
  request->floor = floor;

  using ServiceResponseFuture =
    rclcpp::Client<elevator_interfaces::srv::CallElevatorService>::SharedFuture;
  auto response_received_callback = [this](ServiceResponseFuture future) {
      auto response = future.get();
      bool result = response->result;
      QString result_qstr;
      if (result) {
        result_qstr = QString("True");
      } else {
        result_qstr = QString("False");
      }
      emit resultElevatorService(result_qstr); //signal
      return;
    };

  auto future_result =
    call_ev_service_client->async_send_request(request, response_received_callback);
}


void OlaModel::cancel_robot_service()
{
  auto request = std::make_shared<elevator_interfaces::srv::CancelRobotService::Request>();

  using ServiceResponseFuture =
    rclcpp::Client<elevator_interfaces::srv::CancelRobotService>::SharedFuture;
  auto response_received_callback = [this](ServiceResponseFuture future) {
      auto response = future.get();
      RCLCPP_INFO(this->get_logger(), "Result : %s", response->result);
      bool result = response->result;
      return;
    };

  auto future_result =
    cancel_robot_service_client->async_send_request(request, response_received_callback);
}


void OlaModel::get_ev_status(int ev_num)
{
  auto request = std::make_shared<elevator_interfaces::srv::GetElevatorStatus::Request>();
  request->ev_num = ev_num;

  using ServiceResponseFuture =
    rclcpp::Client<elevator_interfaces::srv::GetElevatorStatus>::SharedFuture;
  auto response_received_callback = [this](ServiceResponseFuture future) {
      auto response = future.get();
      //RCLCPP_INFO(this->get_logger(), "Result : %s", response->result);

      std::vector<int8_t> ev_num = response->ev_num;
      std::vector<std::string> ev_name = response->ev_name;
      std::vector<std::string> floor = response->floor;
      std::vector<std::string> direction = response->direction;
      std::vector<std::string> run = response->run;
      std::vector<std::string> door = response->door;
      std::vector<std::string> mode = response->mode;
      std::vector<int32_t> error_code = response->error_code;
      std::vector<std::string> group = response->group;

      ev_num_s = array_msg_to_string(ev_num);
      ev_name_s = array_msg_to_string(ev_name);
      floor_s = array_msg_to_string(floor);
      direction_s = array_msg_to_string(direction);
      run_s = array_msg_to_string(run);
      door_s = array_msg_to_string(door);
      mode_s = array_msg_to_string(mode);
      error_code_s = array_msg_to_string(error_code);
      group_s = array_msg_to_string(group);
      /*
      std::cout << ev_num_s << std::endl;
      std::cout << ev_name_s << std::endl;
      std::cout << floor_s << std::endl;
      std::cout << direction_s << std::endl;
      std::cout << run_s << std::endl;
      std::cout << mode_s << std::endl;
      std::cout << error_code_s << std::endl;
      std::cout << group_s << std::endl;
      std::cout << group_s << std::endl;
      */

      ev_status_map["ev_num"] = ev_num_s;
      ev_status_map["ev_name"] = ev_name_s;
      ev_status_map["floor"] = floor_s;
      ev_status_map["direction"] = direction_s;
      ev_status_map["run"] = run_s;
      ev_status_map["door"] = door_s;
      ev_status_map["mode"] = mode_s;
      ev_status_map["error_code"] = error_code_s;
      ev_status_map["group"] = group_s;

      emit resultGetEvStatus(get_ev_status_qstr());
      return;
    };

  auto future_result =
    get_ev_status_client->async_send_request(request, response_received_callback);
}

std::string OlaModel::array_msg_to_string(std::vector<int8_t> array_msg)
{
  std::string result = std::string("[");
  for (int i = 0; i < array_msg.size(); i++) {
    result = result + std::to_string(array_msg[i]);
    if (i < array_msg.size() - 1) {
      result = result + ", ";
    }
  }
  result = result + "]";
  return result;
}


std::string OlaModel::array_msg_to_string(std::vector<int32_t> array_msg)
{
  std::string result = std::string("[");
  for (int i = 0; i < array_msg.size(); i++) {
    result = result + std::to_string(array_msg[i]);
    if (i < array_msg.size() - 1) {
      result = result + ", ";
    }
  }
  result = result + "]";
  return result;
}


std::string OlaModel::array_msg_to_string(std::vector<std::string> array_msg)
{
  std::string result = std::string("[");
  for (int i = 0; i < array_msg.size(); i++) {
    result = result + array_msg[i];
    if (i < array_msg.size() - 1) {
      result = result + ", ";
    }
  }
  result = result + "]";
  return result;
}

QString OlaModel::get_ev_status_qstr()
{
  std::string ev_status_stdstr("");
  std::map<std::string, std::string>::iterator it;
  for (it = ev_status_map.begin(); it != ev_status_map.end(); it++) {
    if (it == ev_status_map.begin()) {
      ev_status_stdstr = ev_status_stdstr + it->first + ":" + it->second;
    } else {
      ev_status_stdstr = ev_status_stdstr + "/" + it->first + ":" + it->second;
    }
  }
  return QString::fromStdString(ev_status_stdstr);
}


void OlaModel::set_robot_service(std::string robot_status)
{
  auto request = std::make_shared<elevator_interfaces::srv::SetRobotService::Request>();
  request->robot_status = robot_status;

  using ServiceResponseFuture =
    rclcpp::Client<elevator_interfaces::srv::SetRobotService>::SharedFuture;
  auto response_received_callback = [this](ServiceResponseFuture future) {
      auto response = future.get();
      //RCLCPP_INFO(this->get_logger(), "Result : %s", response->result);
      bool result = response->result;
      std::string ev_service_status = response->ev_service_status;
      return;
    };

  auto future_result =
    set_robot_status_client->async_send_request(request, response_received_callback);
}


bool OlaModel::get_robot_service_result()
{
  return robot_service_result;
}


std::string OlaModel::get_sequence()
{
  return sequence;
}
