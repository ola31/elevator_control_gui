import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles 1.2
import "."


Item {
    id:set_robot_service_box
    width:300
    height:80

    property string color_on: 'limegreen'
    property string color_off: 'black'
    property string background_color: 'grey'


    signal taking_on_clicked()
    signal getting_off_clicked()


    Round_squere_button{
        id : button_taking_on
        width: parent.width/2.2
        height: parent.height
        text : 'Taking\nOn'
        onClicked:set_robot_service_box.taking_on_clicked()
        color_off: set_robot_service_box.color_off
        color_on: set_robot_service_box.color_on
        background_color: set_robot_service_box.background_color
        text_size_gain: 1.5
        border_width_gain: 1.2
        radius_gain : 0.8

    }

    Round_squere_button{
        id : button_getting_off
        width: parent.width/2.2
        height: parent.height
        anchors{
            top:parent.top
            right:parent.right
        }
        onClicked: set_robot_service_box.getting_off_clicked
        color_off: set_robot_service_box.color_off
        color_on: set_robot_service_box.color_on
        background_color: set_robot_service_box.background_color
        text : 'Getting\nOff'
        text_size_gain: 1.5
        border_width_gain: 1.2
        radius_gain : 0.8

    }



}
