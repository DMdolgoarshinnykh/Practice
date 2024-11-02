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
        id: dequeModel
        property var deque: []
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
            width: size_x * 0.2
            height: size_y * 0.5
            Text {
                id: title
                anchors.fill: parent
                anchors.margins: 10
                font.pixelSize: 20
                text: qsTr("Deque — это список каждый элемент которого хранит 2 указателя, структура позволяет добавлять и удалять элементы с обеих сторон.")
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
                        model: dequeModel.deque
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
                    text: "Добавить в начало (pushFront)"
                    onClicked: {
                        if (dequeModel.deque.length < dequeModel.maxSize) {
                            var newDeque = dequeModel.deque.slice();
                            newDeque.unshift(valueSpinBox.value);
                            dequeModel.deque = newDeque;
                        } else {
                            console.log("Deque переполнен");
                        }
                    }
                }

                Button {
                    text: "Добавить в конец (pushBack)"
                    onClicked: {
                        if (dequeModel.deque.length < dequeModel.maxSize) {
                            var newDeque = dequeModel.deque.slice();
                            newDeque.push(valueSpinBox.value);
                            dequeModel.deque = newDeque;
                        } else {
                            console.log("Deque переполнен");
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Button {
                    text: "Удалить с начала (popFront)"
                    onClicked: {
                        if (dequeModel.deque.length > 0) {
                            var newDeque = dequeModel.deque.slice();
                            newDeque.shift();
                            dequeModel.deque = newDeque;
                        } else {
                            console.log("Deque пуст");
                        }
                    }
                }

                Button {
                    text: "Удалить с конца (popBack)"
                    onClicked: {
                        if (dequeModel.deque.length > 0) {
                            var newDeque = dequeModel.deque.slice();
                            newDeque.pop();
                            dequeModel.deque = newDeque;
                        } else {
                            console.log("Deque пуст");
                        }
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Deque: [" + dequeModel.deque.join(", ") + "]"
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
