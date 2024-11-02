import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: popup
    modal: true
    property int pos_x: 0
    property int pos_y: 0
    property int size_x: 800
    property int size_y: 600
    x: pos_x
    y: pos_y
    width: size_x
    height: size_y

    QtObject {
        id: dataModel
        property var hashTable: ({})
        property int tableSize: 5  // Начальный размер таблицы
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3E5063" }
            GradientStop { position: 1.0; color: "#A0A0A0" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: size_y * 0.2
                color: "transparent"
                Text {
                    anchors.fill: parent
                    font.pixelSize: 16
                    text: qsTr("Хеш-таблица - это структура данных, которая позволяет хранить пары ключ-значение и обеспечивает быстрый доступ к значениям по их ключам. Она использует хеш-функцию для вычисления индекса, по которому элемент должен быть сохранен в массиве. В этой реализации используется динамическое изменение размера таблицы.")
                    wrapMode: Text.WordWrap
                    color: "white"
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                opacity: 0.7
                border.color: "black"

                ListView {
                    anchors.fill: parent
                    anchors.margins: 5
                    model: dataModel.tableSize
                    delegate: Rectangle {
                        width: parent.width
                        height: 25
                        color: "skyblue"
                        border.color: "blue"

                        Row {
                            spacing: 5
                            Text {
                                width: 50
                                text: "Индекс " + index + ": "
                                color: "black"
                            }
                            Text {
                                text: {
                                    var items = dataModel.hashTable[index] || [];
                                    if (items.length === 0) {
                                        return "Пусто";
                                    }
                                    return items.map(function(item) { return item.key + ": " + item.value; }).join(", ");
                                }
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
                    text: "Ключ:"
                    color: "white"
                }

                TextField {
                    id: keyInput
                    placeholderText: "Введите ключ"
                }

                Text {
                    text: "Значение:"
                    color: "white"
                }

                TextField {
                    id: valueInput
                    placeholderText: "Введите значение"
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Button {
                    text: "Добавить/Обновить"
                    onClicked: {
                        var key = keyInput.text;
                        var value = valueInput.text;
                        if (key && value) {
                            addOrUpdateItem(key, value);
                        }
                    }
                }

                Button {
                    text: "Удалить"
                    onClicked: {
                        var key = keyInput.text;
                        if (key) {
                            removeItem(key);
                        }
                    }
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

    function hashFunction(key) {
        var total = 0;
        for (var i = 0; i < key.length; i++) {
            total += key.charCodeAt(i);
        }
        return total % dataModel.tableSize;
    }

    function addOrUpdateItem(key, value) {
        var hash = hashFunction(key);
        var newHashTable = JSON.parse(JSON.stringify(dataModel.hashTable));
        if (!newHashTable[hash]) {
            newHashTable[hash] = [];
        }
        var index = newHashTable[hash].findIndex(item => item.key === key);
        if (index !== -1) {
            newHashTable[hash][index].value = value;
        } else {
            newHashTable[hash].push({key: key, value: value});
        }
        dataModel.hashTable = newHashTable;

        var totalItems = Object.values(newHashTable).reduce((sum, arr) => sum + arr.length, 0);
        if (totalItems > dataModel.tableSize * 0.7) {
            resizeTable(dataModel.tableSize * 2);
        }
    }

    function removeItem(key) {
        var hash = hashFunction(key);
        var newHashTable = JSON.parse(JSON.stringify(dataModel.hashTable));
        if (newHashTable[hash]) {
            newHashTable[hash] = newHashTable[hash].filter(item => item.key !== key);
            if (newHashTable[hash].length === 0) {
                delete newHashTable[hash];
            }
        }
        dataModel.hashTable = newHashTable;

        var totalItems = Object.values(newHashTable).reduce((sum, arr) => sum + arr.length, 0);
        if (totalItems < dataModel.tableSize * 0.3 && dataModel.tableSize > 5) {
            resizeTable(Math.max(5, Math.floor(dataModel.tableSize / 2)));
        }
    }

    function resizeTable(newSize) {
        var oldHashTable = dataModel.hashTable;
        dataModel.tableSize = newSize;
        dataModel.hashTable = {};

        Object.values(oldHashTable).forEach(bucket => {bucket.forEach(item => {var hash = hashFunction(item.key);
                                                                          if (!dataModel.hashTable[hash]) {
                                                                              dataModel.hashTable[hash] = [];
                                                                          }
                                                                          dataModel.hashTable[hash].push({key: item.key, value: item.value});
                                                                      });
                                            });
    }
}
