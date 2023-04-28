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

//using namespace QtQml;

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

  engine.addImportPath("../lib");
  engine.addImportPath("../qml/QtQml");
  engine.addImportPath("../qml/QtQuick");
  engine.addImportPath("../qml/QtQuick.2");

  engine.addImportPath(QStringLiteral("qml"));
  engine.addImportPath(QStringLiteral("lib"));
  engine.addImportPath(QStringLiteral("../lib"));
  engine.addImportPath(QStringLiteral("../qml"));

  engine.addImportPath(QStringLiteral("../qml/QtQml"));
  engine.addImportPath(QStringLiteral("../qml/QtQuick"));
  engine.addImportPath(QStringLiteral("../qml/QtQuick.2"));
  engine.addImportPath(QStringLiteral("qml/QtQml"));
  engine.addImportPath(QStringLiteral("qml/QtQuick"));
  engine.addImportPath(QStringLiteral("qml/QtQuick.2"));

  engine.addImportPath(QStringLiteral("qrc:/quick"));
  engine.addImportPath(QStringLiteral("qrc:/quick/QtQuick"));
  engine.addImportPath(QStringLiteral("qrc:/quick/QtQml"));

  engine.rootContext()->setContextProperty("ola_view_model", &ola_view_model);

  engine.load(QUrl(QStringLiteral("qrc:/qml/ola.qml")));
//engine.load(QUrl(QStringLiteral("/home/ola/robot_ws/src/kubot_gui/resources/qml/ola.qml")));


  return app.exec();

}
