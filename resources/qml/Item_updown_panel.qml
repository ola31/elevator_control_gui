import QtQuick 2.0

Item {
    id : root
    width: 300
    height: 100

    property string color_pressed: "#4DFFFFFF"
    property string color_released: "#00000000"

    signal clicked(var is_up)


    Rectangle{
        id : btn_up
        property bool is_pressed: false

        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width : parent.height
        height: parent.height
        radius: parent.height*0.2
        border.color: "black"
        border.width: 3
        color : color_released
        Text {
            text: "▲"
            font.pointSize: parent.height*0.7
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: parent.height/8
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        MouseArea{
            anchors.fill: parent
            onContainsMouseChanged:{
                btn_up.is_pressed = btn_up.is_pressed ? false : true
                if(btn_up.is_pressed) btn_up.color = color_pressed;
                else btn_up.color = color_released;
            }
            onClicked: {
                root.clicked(true);
            }
        }
    }

    Rectangle{
        id : btn_dn
        property bool is_pressed: false

        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        width : parent.height
        height: parent.height
        radius: parent.height*0.2
        border.color: "black"
        border.width: 3
        color : color_released
        Text {
            text: "▼"
            font.pointSize: parent.height*0.7
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: parent.height/8
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        MouseArea{
            anchors.fill: parent
            onContainsMouseChanged:{
                btn_dn.is_pressed = btn_dn.is_pressed ? false : true
                if(btn_dn.is_pressed) btn_dn.color = color_pressed;
                else btn_dn.color = color_released;
            }
            onClicked: {
                root.clicked(false);
            }
        }
    }

}






































































































































