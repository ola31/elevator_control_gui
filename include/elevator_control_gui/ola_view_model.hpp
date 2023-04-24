#ifndef KUBOT_GUI__OLA_VIEW_MODEL_HPP_
#define KUBOT_GUI__OLA_VIEW_MODEL_HPP_


#include <QObject>
#include <QImage>
#include "elevator_control_gui/ola_model.hpp"

class OlaViewModel : public QObject
{
  Q_OBJECT
  //Q_PROPERTY(QString name_ola READ getDisplayMsg /*WRITE setName NOTIFY nameChanged*/)
  Q_PROPERTY(bool is_stop_state READ getIsStopState /*WRITE setName*/ NOTIFY isStopStateChanged)
  Q_PROPERTY(QImage main_image READ getMainImage /*WRITE setName*/ NOTIFY mainImageUpdated)

public:
  explicit OlaViewModel(int argc, char ** argv, QObject * parent = nullptr);
  virtual ~OlaViewModel();

  Q_INVOKABLE void ola_function(int ola_value);
  Q_INVOKABLE void go_button_clicked();
  Q_INVOKABLE void fb_step_changed(double fb_step_meter);
  Q_INVOKABLE void rl_step_changed(double rl_step_meter);
  Q_INVOKABLE void rl_turn_changed(double rl_turn_degree);
  Q_INVOKABLE void apply_button_clicked();


  bool getIsStopState(void);
  QImage getMainImage(void);
  QString getDisplayMsg(void);

private slots:
  void updateMainImage();

signals:
  bool isStopStateChanged(void);
  bool mainImageUpdated(void);

protected:
  int m_olaValue = -1;

private:
  std::thread spin_thread;
  std::shared_ptr<OlaModel> ola_model_;


};


#endif // KUBOT_GUI__OLA_VIEW_MODEL_HPP_
