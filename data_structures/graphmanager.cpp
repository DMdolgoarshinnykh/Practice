#include "graphmanager.h"
#include <iostream>

void GraphManager::addNode(int id) {
    for (const auto& node : nodes_) {
        if (node.id == id) {
            return;
        }
    }
    nodes_.emplace_back(Node{id});
    emit graphChanged();
}

void GraphManager::addEdge(int sourceId, int targetId) {
    bool sourceExists = false;
    bool targetExists = false;
    for (const auto& node : nodes_) {
        if (node.id == sourceId) {
            sourceExists = true;
        }
        if (node.id == targetId) {
            targetExists = true;
        }
        if (sourceExists && targetExists) {
            break;
        }
    }

    if (!sourceExists || !targetExists) {
        return;
    }

    for (const auto& edge : edges_) {
        if (edge.source() == sourceId && edge.target() == targetId) {
            return;
        }
    }

    edges_.emplace_back(sourceId, targetId);
    emit graphChanged();
}

QVariantList GraphManager::getNodes() const {
    QVariantList nodeList;
    for (const auto& node : nodes_) {
        QVariantMap nodeMap;
        nodeMap["id"] = node.id;
        nodeList.append(nodeMap);
    }
    return nodeList;
}

QVariantList GraphManager::getEdges() const {
    QVariantList edgeList;
    for (const auto& edge : edges_) {
        QVariantMap edgeMap;
        edgeMap["source"] = edge.source();
        edgeMap["target"] = edge.target();
        edgeList.append(edgeMap);
    }
    return edgeList;
}

void GraphManager::print() const {
    std::cout << "Nodes:\n";
    for (const auto& node : nodes_) {
        std::cout << node.id << '\n';
    }
    std::cout << "Edges:\n";
    for (const auto& edge : edges_) {
        std::cout << edge.source() << " -> " << edge.target() << '\n';
    }
}
