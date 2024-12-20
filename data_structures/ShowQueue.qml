import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: popup
    modal: true
    property int pos_x: 0
    property int pos_y: 0
    property int size_x: 600
    property int size_y: 400
    x: pos_x
    y: pos_y
    width: size_x
    height: size_y

    QtObject {
        id: queueModel
        property var queue: []
        property int maxSize: 10
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3E5063" }
            GradientStop { position: 1.0; color: "#A0A0A0" }
        }

        Rectangle {
            x: size_x * 0.05
            y: size_y * 0.4
            width: size_x * 0.3
            height: size_y * 0.5
            Text {
                id: title
                anchors.fill: parent
                anchors.margins: 10
                font.pixelSize: 20
                text: qsTr("Очередь — это структура данных, работающая по принципу FIFO (первый пришёл — первый ушёл). Реализуется с помощью установки указателя на следующий элемент")
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                height: 100
                color: "white"
                opacity: 0.7
                border.color: "black"

                Row {
                    spacing: 5
                    anchors.centerIn: parent

                    Repeater {
                        model: queueModel.queue
                        delegate: Rectangle {
                            width: 50
                            height: 50
                            color: "lightgreen"
                            border.color: "green"

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "black"
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Text {
                    text: "Значение:"
                    color: "white"
                }

                SpinBox {
                    id: valueSpinBox
                    from: -100
                    to: 100
                    value: 0
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Button {
                    text: "Добавить"
                    onClicked: {
                        if (queueModel.queue.length < queueModel.maxSize) {
                            var newQueue = queueModel.queue.slice();
                            newQueue.push(valueSpinBox.value);
                            queueModel.queue = newQueue;
                        } else {
                            console.log("Очередь переполнена");
                        }
                    }
                }

                Button {
                    text: "Удалить"
                    onClicked: {
                        if (queueModel.queue.length > 0) {
                            var newQueue = queueModel.queue.slice();
                            newQueue.shift();
                            queueModel.queue = newQueue;
                        } else {
                            console.log("Очередь пуста");
                        }
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Очередь: [" + queueModel.queue.join(", ") + "]"
                color: "white"
            }

            Button {
                text: "Закрыть"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    popup.close();
                }
            }
        }
    }
}
