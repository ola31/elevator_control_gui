import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles 1.2

Item {
    id: round_squre_button

    signal clicked()

    property string color_on: 'limegreen'
    property string color_off: 'black'
    property string background_color: 'grey'
    property bool pressed_: false
    property string text: 'Round\nSquere\nButton'
    property double text_size_gain: 1.0
    property double border_width_gain: 1.0
    property double radius_gain: 1.0


    Button{
        id: button1
        height : parent.height
        width: parent.width
        anchors{
            left :parent.left
            leftMargin: parent.leftMargin
            top : parent.top
            topMargin: parent.topMargin
        }
        style: ButtonStyle{
            background: Rectangle{
                color: background_color
                border.width: {
                    if(round_squre_button.height>=round_squre_button.width)
                        round_squre_button.width*0.05*border_width_gain
                    else
                        round_squre_button.height*0.05*border_width_gain
                }
                border.color : (round_squre_button.pressed_)?color_on:color_off
                radius: round_squre_button.width*0.2*radius_gain
            }
        }

        Text {
            id : text_round_squere_button
            text: round_squre_button.text
            font.pixelSize: {
                if(text_round_squere_button.width>=text_round_squere_button.height)
                    text_round_squere_button.height * 0.2*text_size_gain
                else
                    text_round_squere_button.width * 0.2*text_size_gain
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors{
                fill:parent
            }
            color: (round_squre_button.pressed_)?color_on:color_off
        }
        onClicked: round_squre_button.clicked();
        onPressedChanged : pressed_ = (pressed_) ? false : true
    }
}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
