#include <iostream>
#include <ctime>
#include <cstdlib>

void merge(int* left, int* right, int* result, int leftSize, int rightSize) {
    int i = 0, j = 0, k = 0;
    std::cout << "Слияние массивов: ";
    for (int i = 0; i < leftSize; i++) {
        std::cout << left[i] << " ";
    }
    std::cout << "и ";
    for (int i = 0; i < rightSize; i++) {
        std::cout << right[i] << " ";
    }
    std::cout << std::endl;
    while (i < leftSize && j < rightSize) {
        if (left[i] <= right[j]) {
            result[k] = left[i];
            i++;
        } else {
            result[k] = right[j];
            j++;
        }
        k++;
    }
    while (i < leftSize) {
        result[k] = left[i];
        i++;
        k++;
    }
    while (j < rightSize) {
        result[k] = right[j];
        j++;
        k++;
    }
    std::cout << "Результат слияния: ";
    for (int i = 0; i < leftSize + rightSize; i++) {
        std::cout << result[i] << " ";
    }
    std::cout << std::endl;
}

void mergeSort(int* arr, int size) {
    if (size <= 1) {
        return;
    }
    int mid = size / 2;
    int* left = new int[mid];
    int* right = new int[size - mid];
    for (int i = 0; i < mid; i++) {
        left[i] = arr[i];
    }
    for (int i = mid; i < size; i++) {
        right[i - mid] = arr[i];
    }
    std::cout << "Сортировка массива: ";
    for (int i = 0; i < size; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    mergeSort(left, mid);
    mergeSort(right, size - mid);
    merge(left, right, arr, mid, size - mid);
    delete[] left;
    delete[] right;
}

int binarySearch(int* arr, int size, int target) {
    std::cout << "Бинарный поиск элемента " << target << " в массиве: ";
    for (int i = 0; i < size; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    int left = 0, right = size - 1;
    while (left <= right) {
        int mid = (left + right) / 2;
        if (arr[mid] == target) {
            std::cout << "Элемент " << target << " найден на позиции " << mid << std::endl;
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    std::cout << "Элемент " << target << " не найден" << std::endl;
    return -1;
}

int main() {
    srand(time(0));
    int size = 10;
    int* arr = new int[size];
    for (int i = 0; i < size; i++) {
        arr[i] = rand() % 100 + 1;
    }
    std::cout << "Исходный массив: ";
    for (int i = 0; i < size; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    mergeSort(arr, size);
    std::cout << "Отсортированный массив: ";
    for (int i = 0; i < size; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    int target = rand() % 100 + 1;
    binarySearch(arr, size, target);
    delete[] arr;
    return 0;
}
