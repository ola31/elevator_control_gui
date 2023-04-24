#ifndef KUBOT_GUI__OLA_MODEL_HPP_
#define KUBOT_GUI__OLA_MODEL_HPP_


#include <chrono>
#include <functional>
#include <memory>

#include <thread>

#include <string>
#include <vector>
#include <stdint.h>
#include <thread>

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


  //rclcpp::Subscription<std_msgs::msg::Bool>::SharedPtr debug_sub_;
  //rclcpp::Publisher<aimbot_hw_interfaces::msg::CargoUnlockCmd>::SharedPtr cargo_lock_cmd_pub_;
  //rclcpp::Service<task_manager_interfaces::srv::GetGUIPage>::SharedPtr get_gui_page_srv_;

//  rclcpp::Publisher<std_msgs::msg::Bool>::SharedPtr pub_;

  //Publisher
//  rclcpp::Publisher<std_msgs::msg::UInt16>::SharedPtr mission_publisher;
//  rclcpp::Publisher<std_msgs::msg::String>::SharedPtr command_publisher;

//  rclcpp::Publisher<std_msgs::msg::Bool>::SharedPtr is_stop_publisher;
//  rclcpp::Publisher<std_msgs::msg::Float64>::SharedPtr fb_step_publisher;
//  rclcpp::Publisher<std_msgs::msg::Float64>::SharedPtr rl_step_publisher;
//  rclcpp::Publisher<std_msgs::msg::Float64>::SharedPtr rl_turn_publisher;

  rclcpp::Subscription<elevator_interfaces::msg::RobotServiceSequence>::SharedPtr
    sequence_subscriber;

  rclcpp::Client<elevator_interfaces::srv::CallRobotService>::SharedPtr call_robot_service_client;
  rclcpp::Client<elevator_interfaces::srv::CallElevatorService>::SharedPtr call_ev_service_client;
  rclcpp::Client<elevator_interfaces::srv::CancelRobotService>::SharedPtr
    cancel_robot_service_client;
  rclcpp::Client<elevator_interfaces::srv::GetElevatorStatus>::SharedPtr get_ev_status_client;
  rclcpp::Client<elevator_interfaces::srv::SetRobotService>::SharedPtr set_robot_status_client;


  void publish_();
  void is_stop_pub(bool is_stop_);

  void update_is_stop();
  bool get_is_stop();
  void update_fb_step(double fb_step_meter);
  void update_rl_step(double rl_step_meter);
  void update_rl_turn(double rl_turn_degree);
  void apply_changes();
  QImage get_main_image();

  void robot_service_call(int ev_num, std::string call_floor, std::string dest_floor);
  void elevator_service_call(int ev_num, std::string direction, std::string floor);
  void cancel_robot_service();
  void get_ev_status(int ev_num);
  void set_robot_service(std::string robot_status);

  //
  std::string get_sequence();

private:
  std::thread spin_thread;

  std::string sequence;


  bool is_stop = true;
  double fb_step = 0.0;
  double rl_step = 0.0;
  double rl_turn = 0.0;
  QImage image_;

  void robot_service_seqeunce_callback(
    const elevator_interfaces::msg::RobotServiceSequence::SharedPtr msg);


  std::string array_msg_to_string(int8_t array_msg[]);
  std::string array_msg_to_string(std::vector<std::string> array_msg);

signals:
  void image_callback_signal();
  void sequence_topic_signal();
};


#endif // KUBOT_GUI__OLA_MODEL_HPP_
