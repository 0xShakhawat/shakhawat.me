#include <iostream>
using namespace std;

struct Pair {
    int min;
    int max;
};

Pair getMinMax(int arr[], int low, int high) {
    Pair minmax, leftMinMax, rightMinMax;

    // Base Case 1: only one element
    if (low == high) {
        minmax.min = arr[low];
        minmax.max = arr[low];
        return minmax;
    }

    // Base Case 2: only two elements
    if (high == low + 1) {
        if (arr[low] > arr[high]) {
            minmax.max = arr[low];
            minmax.min = arr[high];
        } else {
            minmax.max = arr[high];
            minmax.min = arr[low];
        }
        return minmax;
    }

    // Divide the array into halves
    int mid = low + (high - low) / 2;
    leftMinMax = getMinMax(arr, low, mid);
    rightMinMax = getMinMax(arr, mid + 1, high);

    // Compare results of the two halves to get overall min and max
    minmax.min = min(leftMinMax.min, rightMinMax.min);
    minmax.max = max(leftMinMax.max, rightMinMax.max);

    return minmax;
}

int main() {
    int n;
    cout << "Enter number of elements: ";
    cin >> n;

    int arr[n];
    cout << "Enter " << n << " elements: ";
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    Pair result = getMinMax(arr, 0, n - 1);

    cout << "Minimum element is: " << result.min << endl;
    cout << "Maximum element is: " << result.max << endl;

    return 0;
}
