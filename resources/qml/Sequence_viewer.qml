import QtQuick 2.0

Item {
    id: sequence_viewer
    width : 200
    height: 50
    property bool is_on: false
    property string color_on: 'limegreen'
    property string color_off: 'black'
    property string background_color: 'grey'
    property double text_size_gain: 1.0
    property double border_width_gain: 1.0
    property string text: 'default_text'

    Timer {
        id : blink_timer
        interval : 50
        repeat: false
        running: false
        onTriggered:{
            is_on = false;
            running = false;
        }
    }

    function blink(){
        sequence_viewer.is_on = true;
        blink_timer.running = true;
    }

    function set_text(text){
        sequence_viewer.text = text;
        sequence_text.text = text;
    }

    Rectangle{
        id : sequence_viewer_box
        width: parent.width
        height: parent.height
        color: background_color
        border.width: sequence_viewer_box.height*0.05*border_width_gain
        border.color : (is_on)?color_on:color_off
        radius: 0//round_squre_button.width*0.2*radius_gain

        Text {
            id: sequence_text
            text: sequence_viewer.text
            color: {
                if(text=='Waiting For Robot') 'limegreen'
                else if (text=='Arrived') 'limegreen'
                else 'black'
            }
            font.bold:{
                if(text=='Waiting For Robot') true
                else if (text=='Arrived') true
                else false
            }

            font.pixelSize: sequence_viewer_box.height*0.4*text_size_gain
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors{
                fill:parent
            }
        }
    }
}







