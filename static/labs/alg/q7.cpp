#include <bits/stdc++.h>
using namespace std;

void shortest_distance(int matrix[][20], int n) {
    // Convert -1 placeholders to infinity for logic processing
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == -1) {
                matrix[i][j] = 1e9;
            }
            if (i == j) matrix[i][j] = 0;
        }
    }

    // Try every vertex k as an intermediate transition point
    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                matrix[i][j] = min(matrix[i][j], matrix[i][k] + matrix[k][j]);
            }
        }
    }

    // Revert infinity values back to -1 before returning
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 1e9) {
                matrix[i][j] = -1;
            }
        }
    }
}

int main() {
    int n;
    cout << "Enter number of vertices: ";
    cin >> n;

    int matrix[20][20];
    cout << "Enter the adjacency matrix (use -1 for no direct edge):" << endl;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> matrix[i][j];
        }
    }

    shortest_distance(matrix, n);

    cout << "Shortest distance matrix:" << endl;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << matrix[i][j] << "  ";
        }
        cout << endl;
    }

    return 0;
}
