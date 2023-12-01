#include <iostream>
#include "elevator_control_gui/view_model.hpp"


ViewModel::ViewModel(int argc, char ** argv, QObject * parent)
: QObject(parent)
{
  rclcpp::init(argc, argv);
  model_ = std::make_shared<Model>();

  //ROS Spin Thread
  auto ros_spin = [this]() {
      rclcpp::executors::SingleThreadedExecutor exec;
      rclcpp::WallRate loop_rate(100);

      while (rclcpp::ok()) {
        exec.spin_node_some(model_);
        loop_rate.sleep();
      }
      rclcpp::shutdown();
      return;
    };
  spin_thread = std::thread(ros_spin);

  // Model -> View Model Connection

  connect(
    model_.get(), SIGNAL(sequence_topic_signal(QString)), this,
    SLOT(setSequence(QString)));

  connect(
    model_.get(), SIGNAL(resultCallRobotService(QString)), this,
    SLOT(setRobotServiceResult(QString)));

  connect(
    model_.get(), SIGNAL(resultElevatorService(QString)), this,
    SLOT(setElevatorServiceResult(QString)));

  connect(
    model_.get(), SIGNAL(resultGetEvStatus(QString)), this,
    SLOT(setEvStatus(QString)));

}

ViewModel::~ViewModel()
{
  spin_thread.join();
}


QString ViewModel::sequence() const
{
  return m_sequence;
}
void ViewModel::setSequence(QString value)
{
  m_sequence = value;
  emit sequenceChanged();
}

QString ViewModel::robotServiceResult() const
{
  return m_robotServiceResult;
}
void ViewModel::setRobotServiceResult(QString value)
{
  m_robotServiceResult = value;
  emit robotServiceResultChanged();
}

QString ViewModel::elevatorServiceResult() const
{
  return m_elevatorServiceResult;
}

void ViewModel::setElevatorServiceResult(QString value)
{
  m_elevatorServiceResult = value;
  emit elevatorServiceResultChanged();
}

QString ViewModel::evStatus() const
{
  return m_evStatus;
}
void ViewModel::setEvStatus(QString value)
{
  m_evStatus = value;
  emit evStatusChanged();
}

int ViewModel::evMonitorNum() const
{
  return m_evMonitorNum;
}

void ViewModel::setEvMonitorNum(int value)
{
  m_evMonitorNum = value;
}

void ViewModel::bttnCallRobotServiceClicked(
  int ev_num, QString call_floor,
  QString dest_floor, bool in_ev)
{
  if (in_ev) {
    std::string dest_floor_ = dest_floor.toStdString();
    model_->robot_service_in_ev_call(ev_num, dest_floor_);
  } else {
    std::string call_floor_ = call_floor.toStdString();
    std::string dest_floor_ = dest_floor.toStdString();
    model_->robot_service_call(ev_num, call_floor_, dest_floor_);
  }
}

void ViewModel::bttnElevatorServiceClicked(int ev_num, QString direction, QString floor)
{
  std::string direction_ = direction.toStdString();
  std::string floor_ = floor.toStdString();
  model_->elevator_service_call(ev_num, direction_, floor_);
}

void ViewModel::bttnSetStatusClicked(QString status)
{
  model_->set_robot_service(status.toStdString());
}

void ViewModel::bttnGetEvStatusClicked()
{
  model_->get_ev_status(m_evMonitorNum);
}

void ViewModel::bttnCancelRobotServiceClicked()
{
  model_->cancel_robot_service();
}
