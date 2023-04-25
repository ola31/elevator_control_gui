#include <iostream>
#include "elevator_control_gui/ola_view_model.hpp"


OlaViewModel::OlaViewModel(int argc, char ** argv, QObject * parent)
: QObject(parent)
{
  rclcpp::init(argc, argv);
  ola_model_ = std::make_shared<OlaModel>();

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

  connect(
    ola_model_.get(), SIGNAL(image_callback_signal()), this,
    SLOT(updateMainImage()));

  connect(
    ola_model_.get(), SIGNAL(sequence_topic_signal()), this,
    SIGNAL(sequence_recieve_notify()));

  connect(
    ola_model_.get(), SIGNAL(robot_service_result_signal()), this,
    SIGNAL(robot_service_responsed_notify()));

  connect(
    ola_model_.get(), SIGNAL(ev_status_result_signal()), this,
    SIGNAL(ev_status_responsed_notify()));

}

OlaViewModel::~OlaViewModel()
{
  spin_thread.join();
}


QString OlaViewModel::get_sequence_topic() //new
{
  return QString::fromStdString(ola_model_->get_sequence());
}


void OlaViewModel::call_robot_service_button_clicked(
  //new
  int ev_num, QString call_floor,
  QString dest_floor)
{
  std::string call_floor_ = call_floor.toStdString();
  std::string dest_floor_ = dest_floor.toStdString();
  ola_model_->robot_service_call(ev_num, call_floor_, dest_floor_);
}

QString OlaViewModel::robot_service_status_read() //new
{
  bool result = ola_model_->get_robot_service_result();
  if (result) {
    return QString("True");
  } else {
    return QString("False");
  }
}

void OlaViewModel::set_status_button_clicked(QString status)  //new
{
  ola_model_->set_robot_service(status.toStdString());
}

void OlaViewModel::get_ev_status_button_clicked() //new
{
  ola_model_->get_ev_status(0);
}

QString OlaViewModel::get_ev_status() //new
{
  //std::cout << ola_model_->get_ev_status_qstr().toStdString() << std::endl;
  return ola_model_->get_ev_status_qstr();
}


void OlaViewModel::ola_function(int ola_value)
{
  std::cout << "hello qml world" << std::endl;
}

void OlaViewModel::go_button_clicked()
{
  ola_model_->update_is_stop();
  emit isStopStateChanged();
}

bool OlaViewModel::getIsStopState(void)
{
  return ola_model_->get_is_stop();
}

void OlaViewModel::updateMainImage()
{
  emit mainImageUpdated();
}

QImage OlaViewModel::getMainImage(void)
{
  return ola_model_->get_main_image();
}


void OlaViewModel::apply_button_clicked()
{
  ola_model_->apply_changes();
}


void OlaViewModel::fb_step_changed(double fb_step_meter)
{
  return ola_model_->update_fb_step(fb_step_meter);
}

void OlaViewModel::rl_step_changed(double rl_step_meter)
{
  return ola_model_->update_rl_step(rl_step_meter);
}

void OlaViewModel::rl_turn_changed(double rl_turn_degree)
{
  return ola_model_->update_rl_turn(rl_turn_degree);
}

QString OlaViewModel::getDisplayMsg(void)
{
  QString ola_msg("olaola");
  return ola_msg;
}
