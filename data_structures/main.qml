import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    id: rootWindow
    width: 1920 / 1.5
    height: 1080 / 1.5
    visible: true
    title: "Классические структуры данных"
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2E4053" }
            GradientStop { position: 1.0; color: "#808080" }
        }
    }

    ShowArray {
        id: array
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_array
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Array / массив"
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5
        finish_pos_x: (rootWindow.width-120)*0.5 - 120
        dur: 2100
        clickHandlerFunction: function() {
            array.open()
        }
    }

    ShowList {
        id: list
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_linked_list
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "List / лист"
        start_pos_x: 0
        dur: 1800
        start_pos_y: (rootWindow.height-90)*0.5 - 120
        finish_pos_x: (rootWindow.width-120)*0.5 - 120
        clickHandlerFunction: function() {
            list.open()
        }
    }

    ShowStack {
        id: stack
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_stack
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Stack / Стек"
        dur: 2300
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 - 240
        finish_pos_x: (rootWindow.width-120)*0.5 - 120
        clickHandlerFunction: function() {
            stack.open()
        }
    }

    ShowQueue {
        id: queue
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_queue
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "queue / очередь"
        dur: 1600
        start_pos_x: 0
        start_pos_y: (rootWindow.height-90)*0.5 + 120
        finish_pos_x: (rootWindow.width-120)*0.5 - 120
        clickHandlerFunction: function() {
            queue.open()
        }
    }

    ShowDeque {
        id: deque
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_deque
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "deque / двухсторонняя очередь"
        dur: 1600
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 + 240
        finish_pos_x: (rootWindow.width-120)*0.5 - 120
        clickHandlerFunction: function() {
            deque.open()
        }
    }

    ShowHeap {
        id: heap
        //pos_x: rootWindow.width*0.1
        //pos_y: rootWindow.height*0.1
        //size_x: rootWindow.width*0.8
        //size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_heap
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "heap / куча"
        dur: 1400
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 - 240
        finish_pos_x: (rootWindow.width-120)*0.5 + 120
        clickHandlerFunction: function() {
            heap.open()
        }
    }

    ShowHashTable {
        id: hashtable
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_hashtable
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Hash Table / Хеш-таблица"
        dur: 2100
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 - 120
        finish_pos_x: (rootWindow.width-120)*0.5 + 120
        clickHandlerFunction: function() {
            hashtable.open()
        }
    }


    ShowTree {
        id: tree
    }

    AnimatedButton {
        id: animatedButton_tree
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Tree / Дерево"
        dur: 1900
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5
        finish_pos_x: (rootWindow.width-120)*0.5 + 120
        clickHandlerFunction: function() {
            tree.open()
        }
    }

    ShowGraph {
        id: graph
        //pos_x: rootWindow.width*0.1
        //pos_y: rootWindow.height*0.1
        //size_x: rootWindow.width*0.8
        //size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_graph
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Graph / граф"
        dur: 1500
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 + 120
        finish_pos_x: (rootWindow.width-120)*0.5 + 120
        clickHandlerFunction: function() {
            graph.open()
        }
    }

    ShowSet {
        id: set
        pos_x: rootWindow.width*0.1
        pos_y: rootWindow.height*0.1
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height*0.8
    }

    AnimatedButton {
        id: animatedButton_Set
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Set / Множество/сет"
        dur: 1800
        start_pos_x: rootWindow.width
        start_pos_y: (rootWindow.height-90)*0.5 + 240
        finish_pos_x: (rootWindow.width-120)*0.5 + 120
        clickHandlerFunction: function() {
            set.open()
        }
    }

    ShowStructures {
        id: _structures
        pos_x: rootWindow.width*0.1
        pos_y: 0
        size_x: rootWindow.width*0.8
        size_y: rootWindow.height
    }

    AnimatedButton {
        id: animatedButton_structures
        windowWidth: rootWindow.width
        windowHeight: rootWindow.height
        buttonText: "Structures"
        start_pos_x: 0
        start_pos_y: rootWindow.height - 90
        finish_pos_x: (rootWindow.width - 120) * 0.5
        finish_pos_y: rootWindow.height - 90
        dur: 1000

        clickHandlerFunction: function() {
            _structures.open()
        }
    }

    Component.onCompleted: {
        animatedButton_array.startAnimation();
        animatedButton_linked_list.startAnimation();
        animatedButton_stack.startAnimation();
        animatedButton_queue.startAnimation();
        animatedButton_deque.startAnimation();
        animatedButton_heap.startAnimation();
        animatedButton_hashtable.startAnimation();
        animatedButton_tree.startAnimation();
        animatedButton_graph.startAnimation();
        animatedButton_Set.startAnimation();
    }


}
