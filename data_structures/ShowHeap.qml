import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: heapPopup
    modal: true
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: parent.height * 0.9

    property var heap: heapManager.getHeap()

    Connections {
        target: heapManager
        function onHeapChanged() {
            console.log("Heap changed event received");
            heap = heapManager.getHeap().slice();
            console.log("Updated heap:", heap);
            linesCanvas.requestPaint();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            id: heapVisualization
            Layout.fillWidth: true
            Layout.fillHeight: true

            Canvas {
                id: linesCanvas
                anchors.fill: parent
                onPaint: {
                    console.log("Painting lines");
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.strokeStyle = "gray";
                    ctx.lineWidth = 2;

                    for (var i = 1; i < heap.length; i++) {
                        var parentIndex = Math.floor((i - 1) / 2);
                        var startX = calculateX(i, heap.length) + 15;
                        var startY = calculateY(i) + 15;
                        var endX = calculateX(parentIndex, heap.length) + 15;
                        var endY = calculateY(parentIndex) + 15;

                        ctx.beginPath();
                        ctx.moveTo(startX, startY);
                        ctx.lineTo(endX, endY);
                        ctx.stroke();
                    }
                }
            }

            Repeater {
                id: heapRepeater
                model: heap
                delegate: Rectangle {
                    width: 30
                    height: 30
                    x: calculateX(index, heap.length)
                    y: calculateY(index)
                    color: "skyblue"
                    border.color: "blue"
                    radius: 15

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: "black"
                        font.pixelSize: 12
                    }

                    Component.onCompleted: {
                        console.log("Node created at index:", index, "with value:", modelData, "at position:", x, y);
                    }
                }

                onItemAdded: {
                    console.log("Item added at index", index);
                }

                onItemRemoved: {
                    console.log("Item removed at index", index);
                }

                onModelChanged: {
                    console.log("Repeater model changed:", model);
                    console.log("Heap content:", heap);
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            SpinBox {
                id: valueInput
                from: -100
                to: 100
            }

            Button {
                text: "Добавить"
                onClicked: {
                    console.log("Button Add clicked, value:", valueInput.value);
                    heapManager.addValue(valueInput.value)
                }
            }

            Button {
                text: "Удалить макс."
                onClicked: {
                    console.log("Button Remove Max clicked");
                    let removedValue = heapManager.removeMax();
                    console.log("Removed value:", removedValue);
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Куча: [" + heap.join(", ") + "]"
            color: "black"
        }

        Button {
            text: "Закрыть"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                console.log("Close button clicked");
                heapPopup.close()
            }
        }
    }

    function calculateX(index, length) {
        console.log("Calculating X for index:", index, "with length:", length);
        let level = Math.floor(Math.log2(index + 1));
        let levelNodes = Math.pow(2, level);
        let nodeWidth = heapVisualization.width / levelNodes;
        let x = (index - (Math.pow(2, level) - 1)) * nodeWidth + nodeWidth / 2 - 15;
        console.log("Calculated X:", x);
        return x;
    }

    function calculateY(index) {
        console.log("Calculating Y for index:", index);
        let y = Math.floor(Math.log2(index + 1)) * 50;
        console.log("Calculated Y:", y);
        return y;
    }
}
