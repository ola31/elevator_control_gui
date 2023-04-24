import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Window 2.10
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import "."
Item {
    id: robot_service_box
    property int width_: 500
    property int height_: 500
    property string color_: 'grey'
    property string border_color_: 'grey'
    property string color1: 'yellow'
    property string color2: 'green'
    property string button_off_color: 'black'
    property string button_on_color: 'limegreen'
    property string button_background_color: 'grey'

    Rectangle {
        id: box1
        color:color_
        border.color:border_color_
        height: height_
        width: width_

        Round_squere_button{
            id: call_button
            height: parent.height*0.22
            width: height
            text:'Call\nRobot\nService'
            anchors{
                left :parent.left
                leftMargin: parent.width*0.7
                top : parent.top
                topMargin: parent.height*0.2
            }
            color_off: button_off_color
            color_on: button_on_color
            background_color: button_background_color
            onClicked: {
                //
            }

        }
/*
        Button{
            id: button_call_robot_serivce
            height : parent.height*0.22
            width: height
            property bool pressed_: false
            anchors{
                left :parent.left
                leftMargin: parent.width*0.7
                top : parent.top
                topMargin: parent.height*0.2
            }
            style: ButtonStyle{
              background: Rectangle{
                  color: button_background_color
                  border.width: button_call_robot_serivce.width*0.05
                  border.color : (button_call_robot_serivce.pressed_)?button_on_color:button_off_color
                  radius: button_call_robot_serivce.width*0.2
              }
            }

            Text {
                id : text_set_all_zero
                text:"Call\nRobot\nService"
                font.pixelSize: text_set_all_zero.width * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors{
                    fill:parent
                }
                color: (button_call_robot_serivce.pressed_)?button_on_color:button_off_color
            }
            onClicked: {
                //textField_fb_step.text = "0.0";
                //textField_rl_step.text = "0.0";
                //textField_rl_turn.text = "0.0";
            }
            onPressedChanged : pressed_ = (pressed_) ? false : true
        }
*/

        RowLayout {
            id: rowLayout1
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.15
            width:parent.width*0.6
            height: parent.height*0.3
            ColumnLayout{
                id: colunmLayout1
                Layout.fillHeight: true
                Layout.fillWidth:true
                Layout.preferredWidth : parent.width/3
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text1
                        width:parent.width
                        height:parent.height
                        text: qsTr("ev_num")
                        color : 'black'
                        font.pixelSize: parent.width*0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text2
                        width:parent.width
                        height:parent.height
                        text: qsTr("call_floor")
                        color : 'black'
                        font.pixelSize: parent.width*0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text3
                        width:parent.width
                        height:parent.height
                        text: qsTr("dest_floor")
                        color : 'black'
                        font.pixelSize: parent.width*0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }


            }
            ColumnLayout{
                id: colunmLayout2
                Layout.fillHeight: true
                Layout.fillWidth:true
                Layout.preferredWidth : parent.width/2
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

            }

        }


        RowLayout {
            id: rowLayout2
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.15
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.5
            width:parent.width*0.5
            height: parent.height*0.08
            ColumnLayout{
                id: colunmLayout3
                Layout.fillHeight: true
                Layout.fillWidth:true
                Layout.preferredWidth : parent.width/2.5
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text11
                        width:parent.width
                        height:parent.height
                        text: qsTr("result")
                        color : 'black'
                        font.pixelSize: parent.width*0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }


            }
            ColumnLayout{
                id: colunmLayout4
                Layout.fillHeight: true
                Layout.fillWidth:true
                Layout.preferredWidth : parent.width/2
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

            }
        }
    }

}













/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
