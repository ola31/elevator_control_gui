#include <iostream>
#include "elevator_control_gui/ola_view_model.hpp"


OlaViewModel::OlaViewModel(int argc, char ** argv, QObject * parent)
: QObject(parent)
{
  rclcpp::init(argc, argv);
  ola_model_ = std::make_shared<OlaModel>();

  //ROS Spin Thread
  auto ros_spin = [this]() {
      rclcpp::executors::SingleThreadedExecutor exec;
      rclcpp::WallRate loop_rate(100);

      while (rclcpp::ok()) {
        exec.spin_node_some(ola_model_);
        loop_rate.sleep();
      }
      rclcpp::shutdown();
      return;
    };
  spin_thread = std::thread(ros_spin);

  // Model -> View Model Connection

  connect(
    ola_model_.get(), SIGNAL(sequence_topic_signal(QString)), this,
    SLOT(setSequence(QString)));

  connect(
    ola_model_.get(), SIGNAL(resultCallRobotService(QString)), this,
    SLOT(setRobotServiceResult(QString)));

  connect(
    ola_model_.get(), SIGNAL(resultElevatorService(QString)), this,
    SLOT(setElevatorServiceResult(QString)));

  connect(
    ola_model_.get(), SIGNAL(resultGetEvStatus(QString)), this,
    SLOT(setEvStatus(QString)));

}

OlaViewModel::~OlaViewModel()
{
  spin_thread.join();
}


QString OlaViewModel::sequence() const
{
  return m_sequence;
}
void OlaViewModel::setSequence(QString value)
{
  m_sequence = value;
  emit sequenceChanged();
}

QString OlaViewModel::robotServiceResult() const
{
  return m_robotServiceResult;
}
void OlaViewModel::setRobotServiceResult(QString value)
{
  m_robotServiceResult = value;
  emit robotServiceResultChanged();
}

QString OlaViewModel::elevatorServiceResult() const
{
  return m_elevatorServiceResult;
}

void OlaViewModel::setElevatorServiceResult(QString value)
{
  m_elevatorServiceResult = value;
  emit elevatorServiceResultChanged();
}

QString OlaViewModel::evStatus() const
{
  return m_evStatus;
}
void OlaViewModel::setEvStatus(QString value)
{
  m_evStatus = value;
  emit evStatusChanged();
}

int OlaViewModel::evMonitorNum() const
{
  return m_evMonitorNum;
}

void OlaViewModel::setEvMonitorNum(int value)
{
  m_evMonitorNum = value;
}

void OlaViewModel::bttnCallRobotServiceClicked(
  int ev_num, QString call_floor,
  QString dest_floor, bool in_ev)
{
  if (in_ev) {
    std::string dest_floor_ = dest_floor.toStdString();
    ola_model_->robot_service_in_ev_call(ev_num, dest_floor_);
  } else {
    std::string call_floor_ = call_floor.toStdString();
    std::string dest_floor_ = dest_floor.toStdString();
    ola_model_->robot_service_call(ev_num, call_floor_, dest_floor_);
  }
}

void OlaViewModel::bttnElevatorServiceClicked(int ev_num, QString direction, QString floor)
{
  std::string direction_ = direction.toStdString();
  std::string floor_ = floor.toStdString();
  ola_model_->elevator_service_call(ev_num, direction_, floor_);
}

void OlaViewModel::bttnSetStatusClicked(QString status)
{
  ola_model_->set_robot_service(status.toStdString());
}

void OlaViewModel::bttnGetEvStatusClicked()
{
  ola_model_->get_ev_status(m_evMonitorNum);
}

void OlaViewModel::bttnCancelRobotServiceClicked()
{
  ola_model_->cancel_robot_service();
}
