import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Window 2.10
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import "."


Window {
    id : ola_window
    property int w_: 1280
    property int h_: 1080
    width: w_
    height: h_
    title: "EV TEST GUI"
    visible: true
    color : "#334457"

    Rectangle {
        id : main_window_box
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width : (parent.width/parent.height >= w_/h_)? parent.height * w_/h_ : parent.width
        height :(parent.width/parent.height >= w_/h_)? parent.height : parent.width * h_/w_
        color: "#2d2d2d"

        SplitView {
            id: splitView1

            orientation: Qt.Horizontal
            width: main_window_box.width
            height: main_window_box.height

            SplitView{
                id: splitView_left
                orientation: Qt.Vertical
                width:splitView1.width/2

                /* EV STATUS BOX */

                Rectangle {
                    color:'#588196'
                    border.color:'#588196'
                    Layout.fillWidth:true
                    height:parent.height/2
                    Ev_status_box{
                        id : ev_status_box
                        width_: parent.width
                        height_:parent.height
                        color_: parent.color
                        border_color_: parent.border.color
                        color1: '#E3CFC6'
                        color2: '#EFF0FE'
                        button_off_color: 'black'
                        button_on_color: 'limegreen'
                        button_background_color:'#588196'
                        onClicked: ola_view_model.bttnGetEvStatusClicked();
                        info_text_size_gain: 1.4
                        informations: ola_view_model.evStatus
                        Connections{
                            target: ola_view_model
                            onEvStatusChanged: ev_status_box.update_info();
                        }
                    }
                }


                /* ROBOT SERVICE BOX */

                Rectangle {
                    color:'#CEAE88'
                    border.color:'#CEAE88'
                    Layout.fillWidth:true
                    height:parent.height/2
                    Robot_service_box{
                        width_: parent.width
                        height_:parent.height
                        color_: parent.color
                        border_color_: parent.border.color
                        color1: '#E3CFC6'
                        color2: '#EFF0FE'
                        button_off_color: 'black'
                        button_on_color: 'limegreen'
                        button_background_color:'#588196'
                        button_cancel_background_color : '#588196'// '#334457'
                        onClicked: ola_view_model.bttnCallRobotServiceClicked(ev_num, call_floor, dest_floor);
                        onCancelClicked: ola_view_model.bttnCancelRobotServiceClicked();
                        service_result : ola_view_model.robotServiceResult
                    }

                }
            }
            SplitView{
                id: splitView_right
                orientation: Qt.Vertical
                width: splitView1.width/2

                /* ELEVATOR SERVICE BOX */

                Rectangle {
                    color:'#EFF0F2'
                    border.color:'#EFF0F2'
                    Layout.fillWidth:true
                    height:parent.height/2
                    Elevator_service_box{
                        width_: parent.width
                        height_:parent.height
                        color_: parent.color
                        color1: '#E3CFC6'
                        color2: '#CEAE88'
                        button_off_color: 'black'
                        button_on_color: 'limegreen'
                        button_background_color:'#CEAE88' //'#588196'
                        button_cancel_background_color : '#588196'// '#334457'
                        onClicked: {
                            ola_view_model.bttnElevatorServiceClicked(ev_num, direction, floor);
                        }
                        service_result : ola_view_model.elevatorServiceResult

                    }
                    Button {
                        id: button
                        x: 120
                        y: 359
                        width: 238
                        height: 132
                        text: qsTr("Button")
                        onClicked: {
                            var component = Qt.createComponent("New_window.qml")
                            var window    = component.createObject(ola_window)
                            window.show()
                        }
                    }
                }

                /* SEQUENCE VIEWER & SET ROBOT SERVICE BOX */

                Rectangle {
                    color:'#588196'
                    border.color:'#588196'
                    Layout.fillWidth:true
                    height:parent.height/2

                    Sequence_viewer{
                        id: sequence_viewer
                        width : parent.width*0.7
                        height : parent.height*0.15
                        border_width_gain: 1.5
                        background_color: '#E3CFC6'
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top:parent.top
                            topMargin: parent.height*0.3
                        }
                        text: ola_view_model.sequence

                        Connections{
                            target: ola_view_model
                            onSequenceChanged: sequence_viewer.blink();
                        }
                    }

                    Set_robot_service_box{
                        height: parent.height/5
                        width: parent.width*0.8
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top:parent.top
                            topMargin: parent.height*0.55
                        }
                        background_color: parent.color
                        color_off: 'black'
                        color_on: 'limegreen'
                        onTaking_on_clicked: ola_view_model.bttnSetStatusClicked("Taking On")
                        onGetting_off_clicked: ola_view_model.bttnSetStatusClicked("Getting Off")
                    }
                }
            }
        }
    }
}
//
