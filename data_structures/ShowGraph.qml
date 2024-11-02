import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

Popup {
    id: graphPopup
    modal: true
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: parent.height * 0.9

    property var nodes: []
    property var edges: []
    property var nodePositions: []

    function calculatePositions(nodes, edges) {
        let positions = [];
        for (let node of nodes) {
            let existingPosition = nodePositions.find(pos => pos.id === node.id);
            if (existingPosition) {
                positions.push(existingPosition);
            } else {
                let x = Math.random() * (graphVisualization.width - 30) + 15;
                let y = Math.random() * (graphVisualization.height - 30) + 15;
                positions.push({ x: x, y: y, id: node.id });
            }
        }
        return positions;
    }

    Connections {
        target: graphManager
        function onGraphChanged() {
            nodes = graphManager.getNodes().slice();
            edges = graphManager.getEdges().slice();
            graphManager.print();
            nodePositions = calculatePositions(nodes, edges);
            graphRepeater.model = nodePositions;
            edgesCanvas.requestPaint();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            id: graphVisualization
            Layout.fillWidth: true
            Layout.fillHeight: true

            Canvas {
                id: edgesCanvas
                anchors.fill: parent
                z: -1

                onPaint: {
                    let ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.strokeStyle = "darkblue";
                    ctx.lineWidth = 2;

                    for (let edge of edges) {
                        let sourceNode = nodePositions.find(pos => pos.id === edge.source);
                        let targetNode = nodePositions.find(pos => pos.id === edge.target);

                        if (sourceNode && targetNode) {
                            ctx.beginPath();
                            ctx.moveTo(sourceNode.x + 15, sourceNode.y + 15);
                            ctx.lineTo(targetNode.x + 15, targetNode.y + 15);
                            ctx.stroke();
                        } else {
                            console.warn(`Edge from ${edge.source} to ${edge.target} cannot be drawn: missing nodes or coordinates`);
                        }
                    }
                }
            }

            Repeater {
                id: graphRepeater
                model: nodePositions

                delegate: Rectangle {
                    width: 30
                    height: 30
                    x: modelData.x !== undefined ? modelData.x : 0
                    y: modelData.y !== undefined ? modelData.y : 0
                    color: "blue"
                    border.color: "darkblue"
                    radius: 15

                    Text {
                        anchors.centerIn: parent
                        text: modelData.id
                        color: "white"
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            SpinBox {
                id: nodeIdInput
                from: 0
                to: 100
            }

            Button {
                text: "Добавить узел"
                onClicked: {
                    graphManager.addNode(nodeIdInput.value);
                    nodePositions = calculatePositions(graphManager.getNodes(), graphManager.getEdges());
                }
            }

            SpinBox {
                id: sourceIdInput
                from: 0
                to: 100
            }

            SpinBox {
                id: targetIdInput
                from: 0
                to: 100
            }

            Button {
                text: "Добавить ребро"
                onClicked: {
                    graphManager.addEdge(sourceIdInput.value, targetIdInput.value);
                    edgesCanvas.requestPaint();
                }
            }
        }
    }
}
