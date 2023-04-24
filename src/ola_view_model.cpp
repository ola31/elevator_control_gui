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

}

OlaViewModel::~OlaViewModel()
{
  spin_thread.join();
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
