#include <bits/stdc++.h>
using namespace std;

int binarySearch(int arr[], int low, int high, int key) {
    if (low > high) return -1; 

    int mid = low + (high - low) / 2;

    if (arr[mid] == key) return mid;
    else if (arr[mid] > key) return binarySearch(arr, low, mid - 1, key);
    else return binarySearch(arr, mid + 1, high, key);
}

int main() {
    int n;
    cout << "Enter number of elements: ";
    cin >> n;

    int arr[n];
    cout << "Enter " << n << " elements in sorted order: ";
    for (int i = 0; i < n; i++) cin >> arr[i];

    int key;
    cout << "Enter element to search: ";
    cin >> key;

    int result = binarySearch(arr, 0, n - 1, key);

    if (result != -1) cout << "Element found at index " << result << endl;
    else cout << "Element not found" << endl;

    return 0;
}
