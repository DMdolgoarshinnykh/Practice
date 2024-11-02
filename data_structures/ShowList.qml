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
        id: dataModel
        property var myList: [
            { value: 0, next: 1 },
            { value: 0, next: 2 },
            { value: 0, next: 3 },
            { value: 0, next: 4 },
            { value: 0, next: -1 }
        ]
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
                text: qsTr("Связный список — это динамическая коллекция элементов, в которой каждый элемент указывает на следующий. На практике в некоторых языках реализуется с помощью пересоздания статического массива")
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
                        model: dataModel.myList
                        delegate: Rectangle {
                            width: 50
                            height: 50
                            color: "skyblue"
                            border.color: "blue"

                            Column {
                                anchors.centerIn: parent
                                Text {
                                    text: modelData.value
                                    color: "black"
                                }
                                Text {
                                    text: modelData.next !== -1 ? modelData.next : "null"
                                    color: "black"
                                    font.pointSize: 8
                                }
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Text {
                    text: "Индекс:"
                    color: "white"
                }

                SpinBox {
                    id: indexSpinBox
                    from: 0
                    to: dataModel.myList.length - 1
                    value: 0
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
                    text: "Установить"
                    onClicked: {
                        var newList = dataModel.myList.slice()
                        newList[indexSpinBox.value].value = valueSpinBox.value
                        dataModel.myList = newList
                    }
                }

                Button {
                    text: "Обнулить"
                    onClicked: {
                        var newList = dataModel.myList.slice()
                        newList[indexSpinBox.value].value = 0
                        dataModel.myList = newList
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Button {
                    text: "Добавить"
                    onClicked: {
                        var newList = dataModel.myList.slice()
                        var newItem = { value: 0, next: -1 }
                        if (newList.length > 0) {
                            newList[newList.length - 1].next = newList.length
                        }
                        newList.push(newItem)
                        dataModel.myList = newList
                        indexSpinBox.to = dataModel.myList.length - 1
                    }
                }

                Button {
                    text: "Удалить"
                    onClicked: {
                        var newList = dataModel.myList.slice()
                        if (newList.length > 1) {
                            if (indexSpinBox.value < newList.length - 1) {
                                newList[indexSpinBox.value].next = newList[indexSpinBox.value + 1].next
                            } else {
                                newList[indexSpinBox.value - 1].next = -1
                            }
                            newList.splice(indexSpinBox.value, 1)
                            dataModel.myList = newList
                            indexSpinBox.to = dataModel.myList.length - 1
                        }
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Список: [" + dataModel.myList.map(function(item) { return item.value }).join(", ") + "]"
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
