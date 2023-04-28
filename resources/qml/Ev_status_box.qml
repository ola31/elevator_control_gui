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
        var list = informations.split('/')
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
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
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        Timer {
            id : repeat_timer
            interval : 500
            repeat: true
            running: false
            property int cnt: 0
            onTriggered:{
                cnt += 1;
                if(cnt==1) {
                    ev_status_box.clicked();
                    button_get_ev_status.pressed_ = true;
                }
                else if(cnt==2){
                    button_get_ev_status.pressed_ = false;
                    cnt = 0
                }
            }
        }

        CheckBox {
            id: checkBox

            property bool ischecked: false

            anchors{
                top:parent.top
                right: parent.right
                topMargin: parent.height*0.13
                rightMargin: parent.width*0.05
            }
            width : parent.width*0.45
            height: width*0.18

            onCheckedChanged: {
                ischecked = ischecked ? false : true
                repeat_timer.running = ischecked
                if (!ischecked) button_get_ev_status.pressed_ = false;
            }

            Text{
                id : repeat_every_n_sec_text
                function set_text(value){
                    text = value;
                }
                width: parent.width*0.8
                height: parent.height
                text: "repeat every 1 sec"
                font.pixelSize: height*0.5
                anchors.verticalCenterOffset: 0
                //anchors.horizontalCenterOffset: 0
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter

            }
            style: CheckBoxStyle {
                indicator: Rectangle {
                    implicitWidth: checkBox.height*0.6
                    implicitHeight: implicitWidth
                    radius: 3
                    border.color: control.activeFocus ? "darkblue" : "black"
                    border.width: 1
                    Rectangle {
                        visible: control.checked
                        color: button_on_color//"#555"
                        border.color: button_on_color
                        radius: 2
                        anchors.margins: 3
                        anchors.fill: parent

                    }
                    Text { // check
                      visible: control.checked
                      anchors.centerIn: parent
                      text: '\u2713' // CHECK MARK
                      font.pixelSize: parent.height
                    }
                }
            }
        }

        Rectangle{
            color : parent.color
            anchors{
                top : parent.top
                topMargin: parent.height*0.25
                right : parent.right
                rightMargin: parent.width*0.05
            }
            width: parent.width*0.45
            height: width*0.1

            Slider {
                id: slider1
                anchors{
                    verticalCenter: parent.verticalCenter
                    right : parent.right
                }
                width: parent.width
                height: parent.height
                stepSize: 1
                minimumValue: 1
                maximumValue: 5
                value : 1
                onValueChanged: {
                    var text_value = 'repeat every ' + String(value) + ' sec'
                    repeat_every_n_sec_text.set_text(text_value)
                    repeat_timer.interval = value*500;
                }
                style: SliderStyle{
                    groove: Rectangle {
                        implicitWidth: slider1.width
                        implicitHeight: slider1.height/2
                        color: "lightgray"
                        radius: 8
                    }
                    handle: Rectangle {
                          anchors.centerIn: parent
                          color: control.pressed ? "white" : "lightgray"
                          border.color: "gray"
                          border.width: 2
                          implicitWidth: slider1.width*0.15
                          implicitHeight: implicitWidth
                          radius: implicitWidth/2
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
