import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: popup
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property int pos_x: 0
    property int pos_y: 0
    property int size_x: 600
    property int size_y: 400
    x: pos_x
    y: pos_y
    width: size_x
    height: size_y

    ListModel {
        id: setModel
    }

    function isUnique(value) {
        for(var i = 0; i < setModel.count; i++) {
            if(setModel.get(i).modelData === value) {
                return false;
            }
        }
        return true;
    }

    contentItem: Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3E5063" }
            GradientStop { position: 1.0; color: "#A0A0A0" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Text {
                Layout.fillWidth: true
                Layout.margins: 10
                font.pixelSize: 20
                text: qsTr("Set — это структура данных, которая позволяет хранить уникальные значения.")
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "white"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "white"
                opacity: 0.7
                border.color: "black"

                Row {
                    spacing: 5
                    anchors.centerIn: parent

                    Repeater {
                        model: setModel
                        delegate: Rectangle {
                            width: 50
                            height: 50
                            color: "skyblue"
                            border.color: "blue"

                            Column {
                                anchors.centerIn: parent
                                Text {
                                    text: modelData
                                    color: "black"
                                }
                                Text {
                                    text: index < setModel.count - 1 ? "→" : "null"
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
                    text: "Значение:"
                    color: "white"
                }

                TextField {
                    id: valueTextField
                    Layout.fillWidth: true
                    placeholderText: "Введите значение"
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Button {
                    text: "Добавить"
                    onClicked: {
                        if(valueTextField.text !== "" && isUnique(valueTextField.text)) {
                            setModel.append({modelData: valueTextField.text});
                            valueTextField.clear();
                        }
                    }
                }

                Button {
                    text: "Удалить"
                    onClicked: {
                        for(var i = 0; i < setModel.count; i++) {
                            if(setModel.get(i).modelData === valueTextField.text) {
                                setModel.remove(i);
                                break;
                            }
                        }
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Набор: [" + setModelToJson() + "]"
                color: "white"
                function setModelToJson() {
                    var items = [];
                    for(var i = 0; i < setModel.count; i++) {
                        items.push(setModel.get(i).modelData);
                    }
                    return items.join(", ");
                }
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
