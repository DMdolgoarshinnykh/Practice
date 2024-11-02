#include "heapmanager.h"

HeapManager::HeapManager(QObject *parent) : QObject(parent) {}

void HeapManager::addValue(int value) {
    heap.push_back(value);
    heapifyUp(heap.size() - 1);
    emit heapChanged();
}

int HeapManager::removeMax() {
    if (heap.empty()) return -1;
    int max = heap.front();
    if (heap.size() > 1) {
        heap[0] = heap.back();
        heap.pop_back();
        heapifyDown(0);
    } else {
        heap.pop_back();
    }
    emit heapChanged();
    return max;
}

QVector<int> HeapManager::getHeap() const {
    QVector<int> qHeap;
    for(int value : heap) {
        qHeap.append(value);
    }
    return qHeap;
}

void HeapManager::heapifyUp(int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap[index] <= heap[parent]) break;
        std::swap(heap[index], heap[parent]);
        index = parent;
    }
}

void HeapManager::heapifyDown(int index) {
    int size = heap.size();
    while (true) {
        int largest = index;
        int left = 2 * index + 1;
        int right = 2 * index + 2;

        if (left < size && heap[left] > heap[largest]) largest = left;
        if (right < size && heap[right] > heap[largest]) largest = right;

        if (largest == index) break;
        std::swap(heap[index], heap[largest]);
        index = largest;
    }
}
