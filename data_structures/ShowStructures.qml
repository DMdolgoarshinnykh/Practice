import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

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

    contentItem: Rectangle {
        anchors.fill: parent
        color: "white"

        TableView {
            id: tableView
            anchors.fill: parent
            columnSpacing: 1
            rowSpacing: 1
            clip: true

            model: TableModel {
                TableModelColumn { display: "name" }
                TableModelColumn { display: "access" }
                TableModelColumn { display: "search" }
                TableModelColumn { display: "insert" }
                TableModelColumn { display: "deleteOp" }
                TableModelColumn { display: "notes" }

                rows: [
                    { "name": "Array (массив)", "access": "O(1)", "search": "O(n)", "insert": "O(n)", "deleteOp": "O(n)", "notes": "Статический размер, доступ по индексу." },
                    { "name": "Deque (дек)", "access": "O(1)", "search": "O(n)", "insert": "O(1) (в начало/конец)", "deleteOp": "O(1) (в начало/конец)", "notes": "Двусторонняя очередь, вставка/удаление с обоих концов." },
                    { "name": "Graph (граф, матрица смежности)", "access": "O(1)", "search": "O(V) или O(E)", "insert": "O(1)", "deleteOp": "O(1)", "notes": "V - вершины, E - ребра. Для поиска зависит от реализации (матрица или список смежности)." },
                    { "name": "Graph (граф, список смежности)", "access": "O(V)", "search": "O(V + E)", "insert": "O(1)", "deleteOp": "O(1)", "notes": "Вершины и рёбра хранятся в списке смежности." },
                    { "name": "Heap (куча)", "access": "O(log n)", "search": "O(n)", "insert": "O(log n)", "deleteOp": "O(log n)", "notes": "Бинарная куча (минимальная/максимальная)." },
                    { "name": "List (связанный список)", "access": "O(n)", "search": "O(n)", "insert": "O(1) (в начало)", "deleteOp": "O(1) (в начало)", "notes": "Односвязный список. Вставка/удаление с конца O(n)." },
                    { "name": "Queue (очередь)", "access": "O(n)", "search": "O(n)", "insert": "O(1) (в конец)", "deleteOp": "O(1) (с начала)", "notes": "Очередь с доступом по принципу FIFO." },
                    { "name": "Set (множество)", "access": "O(1)", "search": "O(1)", "insert": "O(1)", "deleteOp": "O(1)", "notes": "На основе хеш-таблицы. Сбалансированные деревья: O(log n)." },
                    { "name": "Stack (стек)", "access": "O(n)", "search": "O(n)", "insert": "O(1)", "deleteOp": "O(1)", "notes": "Стек с доступом по принципу LIFO." },
                    { "name": "Tree (дерево, бинарное)", "access": "O(log n)", "search": "O(log n)", "insert": "O(log n)", "deleteOp": "O(log n)", "notes": "Для сбалансированных деревьев." },
                    { "name": "Tree (дерево, несбалансированное)", "access": "O(n)", "search": "O(n)", "insert": "O(n)", "deleteOp": "O(n)", "notes": "Для несбалансированных деревьев в худшем случае." }
                ]
            }

            onWidthChanged: tableView.forceLayout()

            delegate: Rectangle {
                implicitWidth: tableView.columnWidthProvider(column)
                implicitHeight: 100
                border.width: 1
                color: "#f0f0f0"
                Text {
                    text: display
                    anchors.fill: parent
                    anchors.margins: 5
                    wrapMode: Text.Wrap
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                }
            }

            columnWidthProvider: function(column) {
                return tableView.width / tableView.columns;
            }
        }
    }
}
