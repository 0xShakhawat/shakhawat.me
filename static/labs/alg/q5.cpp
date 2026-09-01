#include <bits/stdc++.h>
using namespace std;

int knapSack(int W, int wt[], int val[], int n) {
    int dp[n + 1][W + 1];

    // Base case: 0 items or 0 capacity means 0 value
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= W; j++) {
            if (i == 0 || j == 0) {
                dp[i][j] = 0;
            }
        }
    }

    // Fill the table bottom-up
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= W; j++) {
            if (wt[i - 1] <= j) {
                // Either take item (i-1) or don't take it, whichever is better
                int take = val[i - 1] + dp[i - 1][j - wt[i - 1]];
                int notTake = dp[i - 1][j];
                dp[i][j] = max(take, notTake);
            } else {
                // Item doesn't fit, so skip it
                dp[i][j] = dp[i - 1][j];
            }
        }
    }

    return dp[n][W];
}

int main() {
    int n;
    cout << "Enter number of items: ";
    cin >> n;

    int wt[n], val[n];
    for (int i = 0; i < n; i++) {
        cout << "Enter weight and value of item " << i + 1 << ": ";
        cin >> wt[i] >> val[i];
    }

    int W;
    cout << "Enter capacity of knapsack: ";
    cin >> W;

    int maxValue = knapSack(W, wt, val, n);
    cout << "Maximum value in knapsack = " << maxValue << endl;

    return 0;
}
