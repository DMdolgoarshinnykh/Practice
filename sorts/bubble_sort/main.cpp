#include <iostream>
#include <stdio.h>

using namespace std;

int main()
{
    cout << "Enter n\n" << endl;
    int n;
    cin >> n;
    cout << "Enter integers\n" << endl;

    int mas[n];

    for (int i = 0; i < n; i++)
    {
        cin >> mas[i];
    }

    for (int i = 0; i < n-1; i++)
    {
        for (int j = 0; j < n-1; j++)
        {
            if (mas[j] > mas[j+1])
            {
                int buf = mas[j];
                mas[j] = mas[j+1];
                mas[j+1] = buf;
            }
        }
    }

    for (int i = 0; i < n; i++)
    {
        cout << mas[i] << "   ";
    }

    return 0;
}
