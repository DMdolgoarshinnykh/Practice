#include <iostream>

using namespace std;

void insertionSort(int arr[], int n) {
  for (int i = 1; i < n; i++) {
    int key = arr[i];
    int j = i - 1;
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
    }
    arr[j + 1] = key;
    for (int k = 0; k < n; k++ )
    {
        cout << arr[k] << " ";
    }
    cout << "\n ";
  }
}

int main() {
    srand(time(0));

    int n = 10;
    int arr[n];

    cout << "Случайный массив: \n ";
    for (int i = 0; i < n; i++) {
      arr[i] = rand() % 100;
      cout << arr[i] << " ";
    }
    cout << endl;

  insertionSort(arr, n);
  for (int i = 0; i < n; i++) {
    std::cout << arr[i] << " ";
  }
  return 0;
}
