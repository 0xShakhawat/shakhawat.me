#include <bits/stdc++.h>
using namespace std;
using namespace std::chrono;

// Bubble Sort
void bubbleSort(int arr[], int n) {
    for (int i = n - 1; i >= 0; i--) {
        int didSwap = 0;
        for (int j = 0; j < i; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                didSwap = 1;
            }
        }
        if (didSwap == 0) break;
    }
}

// Quick Sort
int partition(int arr[], int low, int high) {
    int pivot = arr[low];
    int i = low;
    int j = high;

    while (i < j) {
        while (arr[i] <= pivot && i <= high - 1) i++;
        while (arr[j] > pivot && j >= low + 1) j--;
        if (i < j) swap(arr[i], arr[j]);
    }
    swap(arr[low], arr[j]);
    return j;
}

void quickSortUtil(int arr[], int low, int high) {
    if (low < high) {
        int pIndex = partition(arr, low, high);
        quickSortUtil(arr, low, pIndex - 1);
        quickSortUtil(arr, pIndex + 1, high);
    }
}

void quickSort(int arr[], int n) {
    quickSortUtil(arr, 0, n - 1);
}


int main() {
    int size = 20000;
    int original[size];

    // Fill the array with random values
    for (int i = 0; i < size; i++) {
        original[i] = rand() % 10000;
    }

    int arr2[size];
    int arr4[size];
    for (int i = 0; i < size; i++) {
        arr2[i] = original[i];
        arr4[i] = original[i];
    }

    high_resolution_clock::time_point start, stop;

    // Measure Bubble Sort
    start = high_resolution_clock::now();
    bubbleSort(arr2, size);
    stop = high_resolution_clock::now();
    cout << "Bubble Sort Time:    " << duration_cast<microseconds>(stop - start).count() << " ms" << endl;

    // Measure Quick Sort
    start = high_resolution_clock::now();
    quickSort(arr4, size);
    stop = high_resolution_clock::now();
    cout << "Quick Sort Time:     " << duration_cast<microseconds>(stop - start).count() << " ms" << endl;

    return 0;
}
