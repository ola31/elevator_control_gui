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

    property double info_text_size_gain: 1.0

    property string informations: ''

    property string ev_num: ''
    property string ev_name: ''
    property string floor: ''
    property string direction: ''
    property string run: ''
    property string door: ''
    property string mode: ''

    signal clicked();

    function update_info(){
        var dict = {}
        var list = ola_view_model.ev_status.split('/')
        for(var i in list){
            var list2 = list[i].split(':');
            dict[list2[0]] = list2[1]
        }
        ev_status_box.ev_num = dict['ev_num'];
        ev_status_box.ev_name = dict['ev_name'];
        ev_status_box.floor = dict['floor'];
        ev_status_box.direction = dict['direction'];
        ev_status_box.run = dict['run'];
        ev_status_box.door = dict['door'];
        ev_status_box.mode = dict['mode'];
    }

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
            onClicked: ev_status_box.clicked();
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
                    Text {
                        id: text11
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.ev_num
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text22
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.ev_name
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text33
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.floor
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text44
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.direction
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text55
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.run
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text66
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.door
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        id: text77
                        width:parent.width
                        height:parent.height
                        text: ev_status_box.mode
                        color : 'black'
                        font.pixelSize: parent.height*0.4*info_text_size_gain
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}






















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
