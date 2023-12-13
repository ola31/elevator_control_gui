// Copyright 2023 ROBOTIS CO., LTD.

#ifndef ELEVATOR_CONTROL_GUI__VIEW_MODEL_HPP_
#define ELEVATOR_CONTROL_GUI__VIEW_MODEL_HPP_

#include <QObject>
#include <QMap>
#include <QImage>

#include <map>
#include <memory>

#include "elevator_control_gui/model.hpp"


class ViewModel : public QObject
{
  Q_OBJECT

  Q_PROPERTY(
    QString sequence READ sequence WRITE setSequence NOTIFY sequenceChanged SCRIPTABLE true)
  Q_PROPERTY(
    QString robotServiceResult
    READ robotServiceResult WRITE setRobotServiceResult NOTIFY robotServiceResultChanged)
  Q_PROPERTY(
    QString elevatorServiceResult
    READ elevatorServiceResult WRITE setElevatorServiceResult NOTIFY elevatorServiceResultChanged)
  Q_PROPERTY(
    QString evStatus READ evStatus WRITE setEvStatus NOTIFY evStatusChanged)
  Q_PROPERTY(
    int evMonitorNum READ evMonitorNum WRITE setEvMonitorNum)

public:
  explicit ViewModel(int argc, char ** argv, QObject * parent = nullptr);
  virtual ~ViewModel();


  // Q PROPERTY <READ>
  QString sequence() const;
  QString robotServiceResult() const;
  QString elevatorServiceResult() const;
  QString evStatus() const;
  int evMonitorNum() const;

  Q_INVOKABLE void bttnCallRobotServiceClicked(
    int ev_num, QString call_floor, QString dest_floor,
    bool in_ev);
  Q_INVOKABLE void bttnElevatorServiceClicked(
    int ev_num, QString direction, QString floor);
  Q_INVOKABLE void bttnSetStatusClicked(QString status);
  Q_INVOKABLE void bttnGetEvStatusClicked();
  Q_INVOKABLE void bttnCancelRobotServiceClicked();

public slots:
  // Q PROPERTY <WRITE>
  void setSequence(QString value);
  void setRobotServiceResult(QString value);
  void setElevatorServiceResult(QString value);
  void setEvStatus(QString value);
  void setEvMonitorNum(int value);

signals:
  // Q PROPERTY <NOTIFY>
  void sequenceChanged();
  void robotServiceResultChanged();
  void elevatorServiceResultChanged();
  void evStatusChanged();

protected:
  int m_olaValue = -1;

private:
  std::thread spin_thread;
  std::shared_ptr<Model> model_;

  QString m_sequence;
  QString m_robotServiceResult;
  QString m_elevatorServiceResult;
  QString m_evStatus = "";
  int m_evMonitorNum = 0;
};


#endif  // ELEVATOR_CONTROL_GUI__VIEW_MODEL_HPP_
