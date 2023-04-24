#include "elevator_control_gui/ola_model.hpp"

OlaModel::OlaModel()
: QObject(), Node("ola_model_node")                 //, count_(0)
{
  auto qos_profile = rclcpp::QoS(rclcpp::KeepLast(20)).reliable().transient_local();
  using namespace std::placeholders;
//  pub_ = this->create_publisher<std_msgs::msg::Bool>("ola_topic", qos_profile);


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

void OlaModel::publish_()
{
  //auto msg = std_msgs::msg::Bool();
  std_msgs::msg::Bool msg;
  msg.data = true;
}

void OlaModel::is_stop_pub(bool is_stop_)
{
  //auto msg = std_msgs::msg::Bool();
  std_msgs::msg::Bool msg;
  msg.data = is_stop;
}

void OlaModel::robot_service_seqeunce_callback(
  const elevator_interfaces::msg::RobotServiceSequence::SharedPtr msg)
{

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
      RCLCPP_INFO(this->get_logger(), "Result : %s", response->result);
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
      RCLCPP_INFO(this->get_logger(), "Result : %s", response->result);
      bool result = response->result;
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
      std::vector<std::string> mode = response->mode;
      std::vector<int32_t> error_code = response->error_code;
      std::vector<std::string> group = response->group;
      return;
    };

  auto future_result =
    get_ev_status_client->async_send_request(request, response_received_callback);
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


std::string OlaModel::array_msg_to_string(int8_t array_msg[])
{
  int size = (sizeof(array_msg) / sizeof(*array_msg));
  std::string result = std::string("[");
  for (int i = 0; i < size; i++) {
    result = result + std::to_string(array_msg[i]);
    if (i < size - 1) {
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


QImage OlaModel::get_main_image()
{
  return image_;
}

void OlaModel::apply_changes()
{
  std_msgs::msg::Float64 msg1;
  std_msgs::msg::Float64 msg2;
  std_msgs::msg::Float64 msg3;
  msg1.data = fb_step;
  msg2.data = rl_step;
  msg3.data = rl_turn;
}

void OlaModel::update_is_stop()
{
  is_stop = is_stop ? false : true;
  is_stop_pub(is_stop);
}

void OlaModel::update_fb_step(double fb_step_meter)
{
  fb_step = fb_step_meter;
}

void OlaModel::update_rl_step(double rl_step_meter)
{
  rl_step = rl_step_meter;
}

void OlaModel::update_rl_turn(double rl_turn_degree)
{
  rl_turn = rl_turn_degree;
}

bool OlaModel::get_is_stop()
{
  return is_stop;
}
