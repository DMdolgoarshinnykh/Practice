#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <ctime>

using namespace std;

const int MIN_RUN = 5; // для наглядности маленькое число

void insertionSort(vector<int>& arr, int left, int right) {
    for (int i = left + 1; i <= right; ++i) {
        int temp = arr[i];
        int j = i - 1;
        while (j >= left && arr[j] > temp) {
            arr[j + 1] = arr[j];
            --j;
        }
        arr[j + 1] = temp;
        cout << "Сортировка вставками, текущий подмассив [" << left << ", " << right << "]: ";
        for (int i = left; i <= right; ++i) {
            cout << arr[i] << " ";
        }
        cout << endl;
    }
}


void merge(vector<int>& arr, int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    vector<int> leftArr(arr.begin() + left, arr.begin() + left + n1);
    vector<int> rightArr(arr.begin() + mid + 1, arr.begin() + mid + 1 + n2);

    int i = 0, j = 0, k = left;

    while (i < n1 && j < n2) {
        if (leftArr[i] <= rightArr[j]) {
            arr[k] = leftArr[i];
            ++i;
        } else {
            arr[k] = rightArr[j];
            ++j;
        }
        ++k;
    }

    while (i < n1) {
        arr[k] = leftArr[i];
        ++i;
        ++k;
    }

    while (j < n2) {
        arr[k] = rightArr[j];
        ++j;
        ++k;
    }

    cout << "Слияние, текущий массив: ";
    for (int num : arr) {
        cout << num << " ";
    }
    cout << endl;
}

void timsort(vector<int>& arr) {
    int n = arr.size();

    for (int i = 0; i < n; i += MIN_RUN) {
        insertionSort(arr, i, min((i + MIN_RUN - 1), (n - 1)));
    }

    for (int size = MIN_RUN; size < n; size *= 2) {
        for (int left = 0; left < n; left += 2 * size) {
            int mid = min((left + size - 1), (n - 1));
            int right = min((left + 2 * size - 1), (n - 1));

            if (mid < right) {
                merge(arr, left, mid, right);
            }
        }
    }
}

int binarySearch(const vector<int>& arr, int target) {
    int left = 0, right = arr.size() - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
}

vector<int> generateRandomArray(int size) {
    vector<int> arr(size);
    srand(time(0));
    for (int i = 0; i < size; ++i) {
        arr[i] = rand() % 1000;
    }
    return arr;
}

void printArray(const vector<int>& arr) {
    for (int num : arr) {
        cout << num << " ";
    }
    cout << endl;
}

int main() {
    vector<int> arr = generateRandomArray(60);
    cout << "Исходный массив: ";
    printArray(arr);

    timsort(arr);

    cout << "Отсортированный массив: ";
    printArray(arr);

    int target = arr[rand() % arr.size()];
    int index = binarySearch(arr, target);

    if (index != -1) {
        cout << "Элемент " << target << " найден по индексу " << index << endl;
    } else {
        cout << "Элемент " << target << " не найден" << endl;
    }

    return 0;
}
