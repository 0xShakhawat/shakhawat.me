#include <bits/stdc++.h>
using namespace std;

void solve(int col, char board[][20], int leftRow[], int lowerDiagonal[], int upperDiagonal[], int n, int& count) {
    if (col == n) {
        count++;
        cout << "Solution " << count << ":" << endl;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                cout << board[i][j];
            }
            cout << endl;
        }
        cout << endl;
        return;
    }

    for (int row = 0; row < n; row++) {
        // Using mathematical index mapping for safe checks
        if (leftRow[row] == 0 && lowerDiagonal[row + col] == 0 && upperDiagonal[(n - 1) + (col - row)] == 0) {
            board[row][col] = 'Q';
            leftRow[row] = 1;
            lowerDiagonal[row + col] = 1;
            upperDiagonal[(n - 1) + (col - row)] = 1;

            solve(col + 1, board, leftRow, lowerDiagonal, upperDiagonal, n, count);

            // Backtrack
            board[row][col] = '.';
            leftRow[row] = 0;
            lowerDiagonal[row + col] = 0;
            upperDiagonal[(n - 1) + (col - row)] = 0;
        }
    }
}

void solveNQueens(int n) {
    char board[20][20];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            board[i][j] = '.';

    int leftRow[20] = {0};
    int lowerDiagonal[40] = {0};
    int upperDiagonal[40] = {0};

    int count = 0;
    solve(0, board, leftRow, lowerDiagonal, upperDiagonal, n, count);

    if (count == 0) cout << "No solution exists for n = " << n << endl;
    else cout << "Total solutions: " << count << endl;
}

int main() {
    int n;
    cout << "Enter value of n (board size / number of queens): ";
    cin >> n;

    solveNQueens(n);

    return 0;
}
