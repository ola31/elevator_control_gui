import QtQuick 2.0
import QtQuick.Controls 1.6

Item{
    id : ola_dial
    property int diameter: 300
    property double inital_deg: 0.0
    property double theta_dial: inital_deg
    property string outer_circle_color : 'white'
    property string inner_circle_color : 'green'
    property int dial_range_deg: 270
    property double max_value: 100.0
    property double min_value: -100.0
    property string max_text: max.toString()
    property string min_text: min.toString()
    property string text_color: 'black'
    property bool flip: false
    property double max : {
        if(flip) min_value
        else max_value
    }
    property double min: {
        if(flip) max_value
        else min_value
    }


    signal pressAndHold_()

    function set_dial_theta(theta_deg){
        var offset_deg;
        if(ola_dial.dial_range_deg>180.0){
            if(flip) offset_deg = (180.0-dial_range_deg)/2.0;
            else offset_deg = 180.0 -(180.0-dial_range_deg)/2.0;
        }
        else {
            if(flip) offset_deg = (180.0-dial_range_deg)/2.0;
            else offset_deg = 180 - (180.0-dial_range_deg)/2.0;
        }
        var sign_ = flip ? 1 : -1;
        small_circle.theta_= sign_*ola_dial.dial_range_deg*(theta_deg-min_value)/(max_value-min_value) + offset_deg;
        theta_dial = theta_deg;
        return
    }

    Rectangle {
        id: big_circle
        x: 0
        y: 0
        width: ola_dial.diameter
        height: width
        color: ola_dial.outer_circle_color
        radius : width/2

        Rectangle {
            id: small_circle
            width: parent.width*0.2
            height: width
            radius : width/2
            color: ola_dial.inner_circle_color

            property double theta_: inital_deg
            property double radius_: parent.radius*0.7
            property double deg2rad: 0.0174533

            x : parent.width/2 + radius_ * Math.cos(-1.0*theta_*deg2rad) - width/2
            y : parent.width/2 + radius_ * Math.sin(-1.0*theta_*deg2rad) - width/2
        }

        MouseArea{
            id : mouse_area_
            anchors.fill: small_circle
            hoverEnabled: true

            onPressedChanged: {
                if ( pressed ) long_press_timer.running = true;
                else long_press_timer.running = false;

            }
            Timer {
                id : long_press_timer
                interval : 20
                repeat: true
                running: false
                property int x_from_center: 0
                property int y_from_center: 0

                onTriggered:{
                    x_from_center = mouse_area_.mouseX + mouse_area_.x - big_circle.radius
                    y_from_center = -1.0*(mouse_area_.mouseY + mouse_area_.y - big_circle.radius)
                    small_circle.theta_ = Math.atan2(y_from_center, x_from_center)/small_circle.deg2rad;
                    var right_bound;
                    var left_bound;
                    if(dial_range_deg>180){
                        right_bound = -90 + (360 - dial_range_deg)/2;
                        left_bound = -180 - right_bound;
                        if(small_circle.theta_< right_bound && small_circle.theta_>left_bound){
                            if(small_circle.theta_>-90) small_circle.theta_ = right_bound;
                            else small_circle.theta_ = left_bound;
                        }
                    }
                    else{
                       right_bound = (180-ola_dial.dial_range_deg)/2;
                       left_bound = 180-right_bound;

                       if(small_circle.theta_ >=0.0 && small_circle.theta_<=180.0){
                            if(small_circle.theta_<=right_bound) small_circle.theta_ = right_bound;
                            else if(small_circle.theta_>=left_bound) small_circle.theta_ = left_bound;
                       }
                       else{
                           if(small_circle.theta_>-90) small_circle.theta_ = right_bound;
                           else small_circle.theta_ = left_bound;
                       }
                    }
                    var theta1 = small_circle.theta_;
                    if(small_circle.theta_<=-90.0) theta1 = theta1+360.0;

                    var theta2;
                    if(dial_range_deg>180) theta2 = -theta1 + left_bound + 360.0;
                    else theta2 = -theta1 + left_bound;
                    var theta3 = theta2*(parseFloat(max-min)/parseFloat(ola_dial.dial_range_deg)) + ola_dial.min;

                    ola_dial.theta_dial = theta3.toFixed(2);
                    ola_dial.pressAndHold_()
                }
            }
        }
        Text{
            id : max_text
            text : ola_dial.max_text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            width: ola_dial.diameter*0.3
            height: width*0.3
            font.pixelSize: width*0.3
            color : text_color

            property double radius : (ola_dial.diameter/2)*1.5
            property double deg2rad: 0.0174533
            property double right_bound : {
                if(dial_range_deg>180) -90 + (360 - dial_range_deg)/2
                else (180-ola_dial.dial_range_deg)/2
            }
            x : parent.width/2 + radius * Math.cos(-1.0*right_bound*deg2rad) - width/2
            y : parent.width/2 + radius * Math.sin(-1.0*right_bound*deg2rad) - width/2

        }
        Text{
            id : min_text
            text : ola_dial.min_text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            width: ola_dial.diameter*0.3
            height: width*0.3
            font.pixelSize: width*0.3
            color: text_color

            property double radius : max_text.radius
            property double deg2rad: 0.0174533
            property double left_bound : {
                if(dial_range_deg>180) -180 - max_text.right_bound
                else 180-max_text.right_bound
            }
            x : parent.width/2 + radius * Math.cos(-1.0*left_bound*deg2rad) - width/2
            y : parent.width/2 + radius * Math.sin(-1.0*left_bound*deg2rad) - width/2

        }
    }

}







































































































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
