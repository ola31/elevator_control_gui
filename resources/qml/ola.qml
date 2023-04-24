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
    title: "ola_window"
    visible: true
    color : "#334457"//"black"
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
            width:main_window_box.width
            height:main_window_box.height


            SplitView{
                id: splitView_left
                orientation: Qt.Vertical
                width:splitView1.width/2
                Rectangle {
                    color:'#588196'
                    border.color:'#588196'
                    Layout.fillWidth:true
                    height:parent.height/2
                    Ev_status_box{
                        width_: parent.width
                        height_:parent.height
                        color_: parent.color
                        border_color_: parent.border.color
                        color1: '#E3CFC6'
                        color2: '#EFF0FE'
                        button_off_color: 'black'
                        button_on_color: 'limegreen'
                        button_background_color:'#588196'
                    }

                }

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
                    }

                }


            }
            SplitView{
                id: splitView_right
                orientation: Qt.Vertical
                width: splitView1.width/2
                Rectangle {
                    color:'#EFF0F2'
                    border.color:'#EFF0F2'
                    Layout.fillWidth:true
                    height:parent.height/2
                }
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
                            topMargin: parent.height*0.2
                        }

                    }

                    Set_robot_service_box{
                        height: parent.height/5
                        width: parent.width*0.8
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top:parent.top
                            topMargin: parent.height*0.6
                        }
                        background_color: parent.color
                        color_off: 'black'
                        color_on: 'limegreen'
                        onTaking_on_clicked: sequence_viewer.blink()

                    }
                }

            }
        }

    }
}
//
