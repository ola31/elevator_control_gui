#ifndef ELEVATOR_CONTROL_GUI__OLA_MODEL_HPP_
#define ELEVATOR_CONTROL_GUI__OLA_MODEL_HPP_


#include <chrono>
#include <functional>
#include <memory>

#include <thread>

#include <string>
#include <vector>
#include <stdint.h>
#include <thread>

#include <map>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/bool.hpp"
#include "std_msgs/msg/float64.hpp"
#include "std_msgs/msg/u_int16.hpp"
#include "std_msgs/msg/string.hpp"
#include "sensor_msgs/msg/image.hpp"

#include "elevator_interfaces/msg/result_check_elevator_status.hpp"
#include "elevator_interfaces/msg/robot_service_sequence.hpp"
#include "elevator_interfaces/srv/call_elevator_service.hpp"
#include "elevator_interfaces/srv/call_robot_service.hpp"
#include "elevator_interfaces/srv/call_robot_service_in_ev.hpp"
#include "elevator_interfaces/srv/cancel_robot_service.hpp"
#include "elevator_interfaces/srv/check_elevator_status.hpp"
#include "elevator_interfaces/srv/get_elevator_status.hpp"
#include "elevator_interfaces/srv/get_robot_service_status.hpp"
#include "elevator_interfaces/srv/hold_door.hpp"
#include "elevator_interfaces/srv/set_robot_service.hpp"
#include "elevator_interfaces/srv/add_robot_service_timeout.hpp"
#include "elevator_interfaces/srv/get_robot_service_last_sequence.hpp"
#include "elevator_interfaces/srv/set_elevator_group_control.hpp"


#include <QImage>


using namespace std::chrono_literals;
using std::placeholders::_1;

class OlaModel : public QObject, public rclcpp::Node
{
  Q_OBJECT

public:
  OlaModel();
  ~OlaModel();

  //ROS Subscriber
  rclcpp::Subscription<elevator_interfaces::msg::RobotServiceSequence>::SharedPtr
    sequence_subscriber;

  //ROS Service Client
  rclcpp::Client<elevator_interfaces::srv::CallRobotService>::SharedPtr call_robot_service_client;
  rclcpp::Client<elevator_interfaces::srv::CallElevatorService>::SharedPtr call_ev_service_client;
  rclcpp::Client<elevator_interfaces::srv::CancelRobotService>::SharedPtr
    cancel_robot_service_client;
  rclcpp::Client<elevator_interfaces::srv::GetElevatorStatus>::SharedPtr get_ev_status_client;
  rclcpp::Client<elevator_interfaces::srv::SetRobotService>::SharedPtr set_robot_status_client;

  //Robot Service Callers
  void robot_service_call(int ev_num, std::string call_floor, std::string dest_floor);
  void elevator_service_call(int ev_num, std::string direction, std::string floor);
  void cancel_robot_service();
  void get_ev_status(int ev_num);
  void set_robot_service(std::string robot_status);

  //getter functions
  std::string get_sequence();
  bool get_robot_service_result();
  QString get_ev_status_qstr();

private:
  std::thread spin_thread;

  //ROS Topic Callback
  void robot_service_seqeunce_callback(
    const elevator_interfaces::msg::RobotServiceSequence::SharedPtr msg);

  //Member Variables
  std::string sequence;
  bool robot_service_result;

  std::string ev_num_s;
  std::string ev_name_s;
  std::string floor_s;
  std::string direction_s;
  std::string run_s;
  std::string door_s;
  std::string mode_s;
  std::string error_code_s;
  std::string group_s;

  std::map<std::string, std::string> ev_status_map;

  //Member Functions
  std::string array_msg_to_string(std::vector<int8_t> array_msg);
  std::string array_msg_to_string(std::vector<int32_t> array_msg);
  std::string array_msg_to_string(std::vector<std::string> array_msg);

signals:
  void sequence_topic_signal(QString);
  void resultCallRobotService(QString);
  void resultElevatorService(QString);
  void resultGetEvStatus(QString);

};


#endif // ELEVATOR_CONTROL_GUI__OLA_MODEL_HPP_
