import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.3
import "."
Item {
    id: elevator_service_box

    property int width_: 500
    property int height_: 500
    property string color_: 'grey'
    property string border_color_: 'grey'
    property string color1: 'yellow'
    property string color2: 'green'
    property string button_off_color: 'black'
    property string button_on_color: 'limegreen'
    property string bytton_cancel_on_color: 'red'
    property string button_background_color: 'grey'
    property string button_cancel_background_color : 'grey'
    property string font_color: 'black'

    property int ev_num: 0
    property string call_floor: 'none'
    property string dest_floor: 'none'

    property string service_result: 'none'

    signal clicked()
    signal cancelClicked()

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
                elevator_service_box.cancelClicked();
            }

        }


        Round_squere_button{
            id: cancel_button
            height: parent.height*0.2
            width: height
            text:'Cancel\nRobot\nService'
            anchors{
                left : parent.left
                leftMargin : parent.width*0.7
                top : parent.top
                topMargin: parent.height*0.7
            }
            color_off: button_off_color
            color_on: bytton_cancel_on_color
            background_color: button_cancel_background_color
            onClicked: {
                elevator_service_box.clicked();
            }
            radius_gain: 3
            text_size_gain: 0.9

        }

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
                    TextField {
                        id: textField_ev_num
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        width : parent.width
                        height: parent.height
                        placeholderText: qsTr("type here")
                        font.pointSize: height*0.4
                        font.bold: true
                        onTextChanged: {
//                            var centimeter = parseFloat(text);
//                            centimeter = centimeter.toFixed(1)
//                            if(!(text.length<3) &&
//                               !(text.charAt(0) == '-' && text.length<4) &&
//                               !isNaN(centimeter)){
//                                 fb_step_slider.value = centimeter.toString();
//                            }
                            ev_num = parseInt(text);
                        }
                        style: TextFieldStyle {
                            textColor: font_color
                            background: Rectangle {
                                radius: 2
                                color : color1
                                width : parent.width
                                height: parent.height
                                border.color: color
                                border.width: 1
                            }
                        }
                    }
                }
                Rectangle {
                    color:color2
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    TextField {
                        id: textField_call_floor
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        width : parent.width
                        height: parent.height

                        placeholderText: qsTr("type here")
                        font.pointSize: height*0.4
                        font.bold: true
                        onTextChanged: {
                            call_floor = text
                        }
                        style: TextFieldStyle {
                            textColor: font_color
                            background: Rectangle {
                                radius: 2
                                color : color2
                                width : parent.width
                                height: parent.height
                                border.color: color
                                border.width: 1
                            }
                        }
                    }
                }
                Rectangle {
                    color:color1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    TextField {
                        id: textField_dest_floor
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        width : parent.width
                        height: parent.height
                        placeholderText: qsTr("type here")
                        font.pointSize: height*0.4
                        font.bold: true
                        onTextChanged: {
                            dest_floor = text
                        }
                        style: TextFieldStyle {
                            textColor: font_color
                            background: Rectangle {
                                radius: 2
                                color : color1
                                width : parent.width
                                height: parent.height
                                border.color: color
                                border.width: 1
                            }
                        }
                    }
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
                    Text{
                        id: text22
                        width:parent.width
                        height:parent.height
                        text: elevator_service_box.service_result
                        color : 'black'
                        font.pixelSize: parent.width*0.25
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