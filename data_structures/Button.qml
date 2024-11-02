// AnimatedButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button
    property alias buttonText: button.text
    property alias buttonWidth: button.width
    property alias buttonHeight: button.height
    property alias buttonColor: background.color
    property alias buttonFontFamily: font.family

    signal buttonClicked()
    property var onButtonClicked: undefined

    width: buttonWidth
    height: buttonHeight
    text: buttonText

    background: Rectangle {
        color: buttonColor
        radius: 20
    }

    font.family: buttonFontFamily

    Behavior on x {
        NumberAnimation {
            duration: 2000
        }
    }

    Behavior on rotation {
        NumberAnimation {
            duration: 500
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 200
        }
    }

    Timer {
        id: timer
        interval: 2000
        onTriggered: {
            button.rotation = 360
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            button.scale = 1.05
        }
        onExited: {
            button.scale = 1
        }

        onClicked: {
            buttonClicked()
            if (onButtonClicked !== undefined) {
                onButtonClicked()
            }
        }
    }

    Component.onCompleted: {
        button.x = parent ? parent.width / 2 - button.width / 2 : 0
        timer.start()
    }
}
