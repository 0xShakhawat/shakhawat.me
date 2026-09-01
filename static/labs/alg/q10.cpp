#include <bits/stdc++.h>
using namespace std;

bool isSafe(int node, int color[], bool graph[101][101], int n, int col) {
    for (int k = 0; k < n; k++) {
        // Check if an adjacent node already has the same color
        if (k != node && graph[k][node] == 1 && color[k] == col) {
            return false;
        }
    }
    return true;
}

bool solve(int node, int color[], int m, int N, bool graph[101][101]) {
    if (node == N) return true; // Successfully colored all nodes

    for (int i = 1; i <= m; i++) {
        if (isSafe(node, color, graph, N, i)) {
            color[node] = i;
            if (solve(node + 1, color, m, N, graph)) return true;
            color[node] = 0; // Backtrack
        }
    }
    return false;
}

bool graphColoring(bool graph[101][101], int m, int N, int color[]) {
    for (int i = 0; i < N; i++) color[i] = 0;
    return solve(0, color, m, N, graph);
}

int main() {
    int N, E;
    cout << "Enter number of vertices: ";
    cin >> N;

    static bool graph[101][101] = {false};

    cout << "Enter number of edges: ";
    cin >> E;

    cout << "Enter each edge as: u v (0-indexed vertices)" << endl;
    for (int i = 0; i < E; i++) {
        int u, v;
        cin >> u >> v;
        graph[u][v] = true;
        graph[v][u] = true;
    }

    int m;
    cout << "Enter number of colors (m): ";
    cin >> m;

    int color[N];
    if (graphColoring(graph, m, N, color)) {
        cout << "Solution exists. Coloring:" << endl;
        for (int i = 0; i < N; i++) {
            cout << "Vertex " << i << " -> Color " << color[i] << endl;
        }
    } else {
        cout << "No solution exists with " << m << " colors." << endl;
    }

    return 0;
}
