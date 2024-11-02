#ifndef HEAPMANAGER_H
#define HEAPMANAGER_H

#include <QObject>
#include <vector>

class HeapManager : public QObject
{
    Q_OBJECT

public:
    explicit HeapManager(QObject *parent = nullptr);

    Q_INVOKABLE void addValue(int value);
    Q_INVOKABLE int removeMax();
    Q_INVOKABLE QVector<int> getHeap() const;

signals:
    void heapChanged();

private:
    std::vector<int> heap;

    void heapifyUp(int index);
    void heapifyDown(int index);
};

#endif // HEAPMANAGER_H
