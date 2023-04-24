/**
 * @file /src/main.cpp
 *
 * @brief Qt based gui.
 *
 * @date November 2010
 **/
/*****************************************************************************
** Includes
*****************************************************************************/

#include <QtGui>
#include <QApplication>
#include <QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QQmlContext>

/**** QML ****/
//#include <QtQml/QQmlEngine>
//#include <QtQuick/QQuickView>
//#include <QtQml>

#include "elevator_control_gui/ola_view_model.hpp"

/*****************************************************************************
** Main
*****************************************************************************/

using namespace QtQml;

int main(int argc, char ** argv)
{

  /*********************
  ** Qt
  **********************/
  QApplication app(argc, argv);
  //QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


  /*** QML ***/
  QQmlApplicationEngine engine;

  OlaViewModel ola_view_model(argc, argv);
  engine.rootContext()->setContextProperty("ola_view_model", &ola_view_model);

  engine.load(QUrl(QStringLiteral("qrc:/qml/ola.qml")));
  //engine.load(QUrl(QStringLiteral("/home/ola/robot_ws/src/kubot_gui/resources/qml/ola.qml")));


  return app.exec();


  //kubot_gui::MainWindow w(argc,argv);
  //w.show();
  //app.connect(&app, SIGNAL(lastWindowClosed()), &app, SLOT(quit()));
  //int result = app.exec();

  //return result;
}
