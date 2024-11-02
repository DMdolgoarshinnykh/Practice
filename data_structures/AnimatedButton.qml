import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button
    property int buttonWidth: 120
    property int buttonHeight: 90
    property string buttonText: "Click Me"
    property color buttonColor: "#8BC34A"
    property string buttonFontFamily: "Roboto"
    property var clickHandlerFunction
    property int dur: 2000
    property int start_pos_x: 0
    property int start_pos_y: 0
    property int finish_pos_x: 0
    property int finish_pos_y: 0

    property int windowWidth
    property int windowHeight

    width: buttonWidth
    height: buttonHeight
    text: buttonText

    background: Rectangle {
        color: buttonColor
        radius: 20
    }

    font.family: buttonFontFamily

    x: start_pos_x
    y: start_pos_y
    NumberAnimation {
        id: moveAnimation
        target: button
        property: "x"
        to: finish_pos_x
        duration: dur
        easing.type: Easing.InOutQuad
        onRunningChanged: {
            if (!running) {
                rotationAnimation.start();
            }
        }
    }

    RotationAnimation {
        id: rotationAnimation
        target: button
        from: 0
        to: 360
        duration: 300
        running: false
    }

    function startAnimation() {
        moveAnimation.start();
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            button.clicked();
        }
        onEntered: {
            button.scale = 1.07;
        }
        onExited: {
            button.scale = 1;
        }
    }

    onClicked: {
        if (clickHandlerFunction) {
            clickHandlerFunction();
        }
    }
}
