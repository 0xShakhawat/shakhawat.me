#include <bits/stdc++.h>
using namespace std;

void findSubsets(int ind, int target, int arr[], int n, int ds[], int dsSize) {
    if (target == 0) {
        cout << "{ ";
        for (int i = 0; i < dsSize; i++) cout << ds[i] << " ";
        cout << "}" << endl;
        return;
    }
    if (ind == n || target < 0) return;

    // Pick element
    ds[dsSize] = arr[ind];
    findSubsets(ind + 1, target - arr[ind], arr, n, ds, dsSize + 1);

    // Backtrack (dsSize simply not incremented on this branch, no explicit pop needed)

    // Don't pick element
    findSubsets(ind + 1, target, arr, n, ds, dsSize);
}

void subsetSum(int arr[], int n, int target) {
    int ds[n];
    findSubsets(0, target, arr, n, ds, 0);
}

int main() {
    int n;
    cout << "Enter number of elements: ";
    cin >> n;

    int arr[n];
    cout << "Enter " << n << " elements: ";
    for (int i = 0; i < n; i++) cin >> arr[i];

    int target;
    cout << "Enter target sum: ";
    cin >> target;

    cout << "Subsets with sum " << target << ":" << endl;
    subsetSum(arr, n, target);

    return 0;
}
