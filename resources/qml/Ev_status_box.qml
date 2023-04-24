import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Window 2.10
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import "."
Item {
    id: ev_status_box
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
        Button{
            id: button_get_ev_status
            height : parent.height*0.22
            width: height
            property bool pressed_: false
            anchors{
                left :parent.left
                leftMargin: parent.height*0.08
                top : parent.top
                topMargin: parent.height*0.08
            }
            style: ButtonStyle{
              background: Rectangle{
                  color: button_background_color
                  border.width: button_get_ev_status.width*0.05
                  border.color : (button_get_ev_status.pressed_)?button_on_color:button_off_color
                  radius: button_get_ev_status.width*0.2
              }
            }

            Text {
                id : text_set_all_zero
                text:"Get\nEV\nStatus"
                font.pixelSize: text_set_all_zero.width * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors{
                    fill:parent
                }
                color: (button_get_ev_status.pressed_)?button_on_color:button_off_color
            }
            onClicked: {
                //textField_fb_step.text = "0.0";
                //textField_rl_step.text = "0.0";
                //textField_rl_turn.text = "0.0";
            }
            onPressedChanged : pressed_ = (pressed_) ? false : true
        }

        RowLayout {
            id: rowLayout1
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.05
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: parent.height*0.15
            width:parent.width*0.9
            height: parent.height*0.6
            ColumnLayout{
                id: colunmLayout1
                Layout.fillHeight: true
                Layout.fillWidth:true
                Layout.preferredWidth : parent.width/6
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
                        text: qsTr("ev_name")
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
                        text: qsTr("floor")
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
                        id: text4
                        width:parent.width
                        height:parent.height
                        text: qsTr("direction")
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
                        id: text5
                        width:parent.width
                        height:parent.height
                        text: qsTr("run")
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
                        id: text6
                        width:parent.width
                        height:parent.height
                        text: qsTr("door")
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
                        id: text7
                        width:parent.width
                        height:parent.height
                        text: qsTr("mode")
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
    }

}






















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
