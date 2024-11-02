import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: treePopup
    modal: true
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: parent.height * 0.9

    property var tree: treeManager.getTree()
    property var tree_root:

        Connections {
        target: treeManager
        function onTreeChanged() {
            tree = treeManager.getTree().slice();
            tree_root = treeManager.getRoot()
            treeRepeater.model = calculatePositions(tree, tree_root)
        }

        function calculatePositions(tree, root) {
            let positions = [];
            let level = 0;
            let nodesOnLevel = 1;
            let levelWidth = treeVisualization.width / nodesOnLevel;

            function traverse(node, currentLevel, parent_x, orintation) {
                if (!node) return;
                let x
                if (orintation == 1)
                {
                    x = parent_x - levelWidth / Math.pow(2, currentLevel);
                }
                else
                {
                    x = parent_x + levelWidth / Math.pow(2, currentLevel);
                }

                let y = (currentLevel - 1) * 60;

                positions.push({ x: x - 15, y: y, value: node.value });

                if (node.left!=-1) {
                    traverse(tree[node.left], currentLevel + 1, x, 1);
                }
                if (node.right!=-1) {
                    traverse(tree[node.right], currentLevel + 1, x, 0);
                }
            }

            traverse(tree[root], 1, 0, 0);
            return positions;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            id: treeVisualization
            Layout.fillWidth: true
            Layout.fillHeight: true


            Repeater {
                id: treeRepeater
                model: tree

                delegate: Rectangle {
                    width: 30
                    height: 30
                    x: modelData.x
                    y: modelData.y
                    color: "green"
                    border.color: "darkgreen"
                    radius: 15

                    Text {
                        anchors.centerIn: parent
                        text: modelData.value
                        color: "white"
                    }

                    Component.onCompleted: {
                        console.log("Node created at index:", index, "with value:", modelData.value, "at position:", x, y);
                    }
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
                onClicked: treeManager.addNode(valueInput.value)
            }

            Button {
                text: "Удалить"
                onClicked: treeManager.removeNode(valueInput.value)
            }
        }
    }
}
