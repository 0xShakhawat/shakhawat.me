#include <bits/stdc++.h>
using namespace std;

struct Item {
    int value;
    int weight;
};

// Comparator to sort items by value per unit in descending order
bool comp(Item a, Item b) {
    double r1 = (double)a.value / (double)a.weight;
    double r2 = (double)b.value / (double)b.weight;
    return r1 > r2;
}

double fractionalKnapsack(int W, Item arr[], int n) {
    sort(arr, arr + n, comp);

    int curWeight = 0;
    double finalValue = 0.0;

    for (int i = 0; i < n; i++) {
        if (curWeight + arr[i].weight <= W) {
            curWeight += arr[i].weight;
            finalValue += arr[i].value;
        } else {
            int remain = W - curWeight;
            finalValue += (double)remain * (arr[i].value / (double)arr[i].weight);
            break;
        }
    }
    return finalValue;
}

int main() {
    int n;
    cout << "Enter number of items: ";
    cin >> n;

    Item arr[n];
    for (int i = 0; i < n; i++) {
        cout << "Enter value and weight of item " << i + 1 << ": ";
        cin >> arr[i].value >> arr[i].weight;
    }

    int W;
    cout << "Enter capacity of knapsack: ";
    cin >> W;

    double maxValue = fractionalKnapsack(W, arr, n);
    cout << "Maximum value in knapsack = " << maxValue << endl;

    return 0;
}
