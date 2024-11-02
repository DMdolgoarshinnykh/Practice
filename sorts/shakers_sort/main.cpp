#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int main()
{
    srand(time(0));

    int n = rand() % 11 + 10;
    cout << "Размер массива: " << n << endl;

    int mas[n];
    for (int i = 0; i < n; i++)
    {
        mas[i] = rand() % 101;
    }

    cout << "Исходный массив: ";
    for (int i = 0; i < n; i++)
    {
        cout << mas[i] << " ";
    }
    cout << "\n";

    int left = 0;
    int right = n - 1;
    bool swapped = true;
    while (swapped == true)
    {
        swapped = false;


        for (int i = left; i < right; i++)
        {
            if (mas[i] > mas[i + 1])
            {
                int buf = mas[i];
                mas[i] = mas[i + 1];
                mas[i + 1] = buf;
                swapped = true;
            }
        }
        if (swapped == false)
            break;
        right--;
        cout << "Промежуточный массив: ";
        for (int i = 0; i < n; i++)
        {
            cout << mas[i] << "  ";
        }
        cout << "\n";
        for (int i = right; i > left; i--)
        {
            if (mas[i] < mas[i - 1])
            {
                int buf = mas[i];
                mas[i] = mas[i - 1];
                mas[i - 1] = buf;
                swapped = true;
            }
        }
        left++;

        cout << "Промежуточный массив: ";
        for (int i = 0; i < n; i++)
        {
            cout << mas[i] << "  ";
        }
        cout << "\n";
    };
    cout << "Отсортированный массив: ";
    for (int i = 0; i < n; i++)
    {
        cout << mas[i] << "  ";
    }
    return 0;
}
