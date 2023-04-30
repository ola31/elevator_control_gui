import QtQuick 2.0
import QtQuick.Controls 1.6
import QtQuick.Window 2.10

Window {
    id : sample_window

    width: 1080
    height: 720
    Rectangle {
        id: rectangle
        x: 138
        y: 50
        width: 200
        height: 200
        color: 'green'
    }


    Canvas{
        id: canvas
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top//colorTools.bottom
            bottom: parent.bottom
            margins: 8
        }
        property real lastX
        property real lastY
        property color color: 'green'//colorTools.paintColor

        onPaint: {
            var ctx = getContext('2d')
            ctx.lineWidth = 1.5
            ctx.strokeStyle = canvas.color
            ctx.beginPath()
            ctx.moveTo(lastX, lastY)
            lastX = area.mouseX
            lastY = area.mouseY
            ctx.lineTo(lastX, lastY)
            ctx.stroke()
        }
        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
            }
            onPositionChanged: {
                canvas.requestPaint()
            }
        }
    }
}








