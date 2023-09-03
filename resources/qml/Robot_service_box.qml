import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles 1.2
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
    property string bytton_cancel_on_color: 'red'
    property string button_background_color: 'grey'
    property string button_cancel_background_color : 'grey'
    property string font_color: 'black'

    property int ev_num: 0
    property string call_floor: 'none'
    property string dest_floor: 'none'

    property string service_result: 'none'

    property bool in_ev: false

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
                leftMargin: parent.width*0.75
                top : parent.top
                topMargin: parent.height*0.2
            }
            color_off: button_off_color
            color_on: button_on_color
            background_color: button_background_color
            onClicked: {
                robot_service_box.clicked();
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
                robot_service_box.cancelClicked();
            }
            radius_gain: 3
            text_size_gain: 0.9
        }

        CheckBox {
            id: checkBox

            property bool ischecked: false

            anchors{
                bottom:parent.bottom
                left: parent.left
                bottomMargin: parent.height*0.13
                leftMargin: parent.width*0.05
            }
            width : parent.width*0.45
            height: width*0.25

            onCheckedChanged: {
                ischecked = ischecked ? false : true;
                robot_service_box.in_ev = ischecked;
                textField_call_floor.enabled = !ischecked;
            }

            Text{
                id : repeat_every_n_sec_text
                function set_text(value){
                    text = value;
                }
                width: parent.width*0.8
                height: parent.height
                text: "in EV"
                font.pixelSize: height*0.7
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

        RowLayout {
            id: rowLayout1
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.15
            width:parent.width*0.5
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
                    TextField {
                        id: textField_ev_num
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        width : parent.width
                        height: parent.height
                        placeholderText: qsTr("type here")
                        text: ""
                        font.pointSize: height*0.4
                        font.bold: true
                        onTextChanged: {
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
                        text: ""
                        font.pointSize: height*0.4
                        font.bold: true
                        onTextChanged: {
                            call_floor = text
                        }
                        style: TextFieldStyle {
                            textColor: font_color
                            background: Rectangle {
                                radius: 2
                                color : {
                                    enabled ? color2 : box1.color
                                }
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
                        text: ""
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

        ColumnLayout{
            id : updown_panels
            width : parent.width/6
            height: rowLayout1.height
            anchors{
                top:rowLayout1.top
                left: rowLayout1.right
                leftMargin: width*0.05
            }

            Item_updown_panel{
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: {
                    var curr_txt = textField_ev_num.text;
                    var txt;
                    var intfloor;
                    if(is_up){
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            txt = (parseInt(curr_txt) +1).toString();
                        }
                    }
                    else{
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            intfloor = parseInt(curr_txt);
                            txt = (parseInt(curr_txt) -1).toString();
                            if(txt === "-1") txt = 0;
                        }
                    }
                    textField_ev_num.text = txt;
                }
            }
            Item_updown_panel{
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: {
                    var curr_txt = textField_call_floor.text;
                    var txt;
                    var intfloor;
                    if(is_up){
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            if(curr_txt.charAt(0) === 'B'){
                                console.log("curr_txt: ",curr_txt);
                                intfloor = parseInt(curr_txt.substr(1, curr_txt.length-1));
                                if(intfloor === 1) {
                                    txt = "1"
                                }
                                else{
                                    txt = "B" + (intfloor-1).toString();
                                }
                            }else{
                                txt = (parseInt(curr_txt) +1).toString();
                            }
                        }
                    }
                    else{
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            if(curr_txt.charAt(0) === 'B'){
                                intfloor = parseInt(curr_txt.substr(1, curr_txt.length-1));
                                txt = "B" + (intfloor+1).toString();
                            }else{
                                intfloor = parseInt(curr_txt);
                                if(intfloor === 1) {
                                    txt = "B1"
                                }else{
                                   txt = (parseInt(curr_txt) -1).toString();
                                }
                            }
                        }
                    }
                    textField_call_floor.text = txt;
                }
            }
            Item_updown_panel{
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: {
                    var curr_txt = textField_dest_floor.text;
                    var txt;
                    var intfloor;
                    if(is_up){
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            if(curr_txt.charAt(0) === 'B'){
                                console.log("curr_txt: ",curr_txt);
                                intfloor = parseInt(curr_txt.substr(1, curr_txt.length-1));
                                if(intfloor === 1) {
                                    txt = "1"
                                }
                                else{
                                    txt = "B" + (intfloor-1).toString();
                                }
                            }else{
                                txt = (parseInt(curr_txt) +1).toString();
                            }
                        }
                    }
                    else{
                        if(curr_txt===""){
                            txt = "1"
                        }
                        else{
                            if(curr_txt.charAt(0) === 'B'){
                                intfloor = parseInt(curr_txt.substr(1, curr_txt.length-1));
                                txt = "B" + (intfloor+1).toString();
                            }else{
                                intfloor = parseInt(curr_txt);
                                if(intfloor === 1) {
                                    txt = "B1"
                                }else{
                                   txt = (parseInt(curr_txt) -1).toString();
                                }
                            }
                        }
                    }
                    textField_dest_floor.text = txt;
                }
            }
        }


        RowLayout {
            id: rowLayout2
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.15
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.5
            width:parent.width*0.4
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
                        text: robot_service_box.service_result
                        color : 'black'
                        font.pixelSize: parent.width*0.2
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
