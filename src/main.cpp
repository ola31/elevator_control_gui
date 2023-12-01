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


#include "elevator_control_gui/view_model.hpp"

/*****************************************************************************
** Main
*****************************************************************************/

int main(int argc, char ** argv)
{

  /*********************
  ** Qt
  **********************/
  QApplication app(argc, argv);
  //QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


  /*** QML ***/
  QQmlApplicationEngine engine;
  ViewModel view_model(argc, argv);

  engine.addImportPath(QStringLiteral("qrc:/qml"));
  // engine.addImportPath(QStringLiteral("resources/qml/QtQuick.2/qmldir"));
  // engine.setImportPathList(QStringList(QStringLiteral("qrc:/qml")));
  // engine.setImportPathList(QStringList(QStringLiteral("qrc:/")));
  // engine.addImportPath(QStringLiteral("qrc:/quick/QtQuick"));
  // engine.addImportPath(QStringLiteral("qrc:/quick/QtQml"));

  // engine.setImportPathList(QStringList(QStringLiteral("qrc:/qml")));

  engine.rootContext()->setContextProperty("ev_gui_view_model", &view_model);

  engine.load(QUrl(QStringLiteral("qrc:/qml/main_page.qml")));
  // engine.load(QUrl(QStringLiteral("/home/ola/robot_ws/src/kubot_gui/resources/qml/ola.qml")));


  return app.exec();

}
