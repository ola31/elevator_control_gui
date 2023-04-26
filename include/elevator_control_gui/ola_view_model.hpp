#ifndef KUBOT_GUI__OLA_VIEW_MODEL_HPP_
#define KUBOT_GUI__OLA_VIEW_MODEL_HPP_


#include <QObject>
#include <QImage>
#include "elevator_control_gui/ola_model.hpp"
#include <QMap>
#include <map>

class OlaViewModel : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QString sequence READ sequence WRITE setSequence NOTIFY sequenceChanged)
  Q_PROPERTY(
    QString robotServiceResult READ robotServiceResult WRITE setRobotServiceResult NOTIFY robotServiceResultChanged)
  Q_PROPERTY(
    QString evStatus READ evStatus WRITE setEvStatus NOTIFY evStatusChanged)

public:
  explicit OlaViewModel(int argc, char ** argv, QObject * parent = nullptr);
  virtual ~OlaViewModel();


  //Q PROPERTY Setter, Getter

  QString sequence() const;
  QString robotServiceResult() const;
  QString evStatus() const;

  Q_INVOKABLE void bttnCallRobotServiceClicked(
    int ev_num, QString call_floor,
    QString dest_floor);
  Q_INVOKABLE void bttnSetStatusClicked(QString status);
  Q_INVOKABLE void bttnGetEvStatusClicked();
  Q_INVOKABLE void bttnCancelRobotServiceClicked();

public slots:
  void setSequence(QString value);
  void setRobotServiceResult(QString value);
  void setEvStatus(QString value);

signals:
  //Q PROPERTY <NOTIFY>
  void sequenceChanged();
  void robotServiceResultChanged();
  void evStatusChanged();

protected:
  int m_olaValue = -1;

private:
  std::thread spin_thread;
  std::shared_ptr<OlaModel> ola_model_;

  QString m_sequence;
  QString m_robotServiceResult;
  QString m_evStatus = "";


};


#endif // KUBOT_GUI__OLA_VIEW_MODEL_HPP_
