#ifndef GRAPHMANAGER_H
#define GRAPHMANAGER_H

#include <vector>
#include <stdexcept>
#include <QObject>
#include <QVariantMap>
#include <QVariantList>

struct Node {
    int id;
};

class Edge {
public:
    Edge(int source, int target) : source_(source), target_(target) {}
    int source() const { return source_; }
    int target() const { return target_; }
private:
    int source_;
    int target_;
};

class GraphManager : public QObject {
    Q_OBJECT
public:
    explicit GraphManager(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void addNode(int id);
    Q_INVOKABLE void addEdge(int sourceId, int targetId);
    Q_INVOKABLE void print() const;
    Q_INVOKABLE QVariantList getNodes() const;
    Q_INVOKABLE QVariantList getEdges() const;

signals:
    void graphChanged();

private:
    std::vector<Node> nodes_;
    std::vector<Edge> edges_;
};

#endif // GRAPHMANAGER_H
