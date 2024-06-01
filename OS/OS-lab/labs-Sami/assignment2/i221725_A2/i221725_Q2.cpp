#include <iostream>
#include <fstream>
#include <cmath>
#include <ctime>
#include <thread>
#include <mutex>
#include <algorithm>
#include <random>

using namespace std;

struct City {
    int id;
    int x;
    int y;
};

int** distanceMatrix;
int* shortestTour;
int shortestCost = __INT_MAX__;
int minCostThreadId;
mutex mtx;

// Function to calculate the distance between two cities
int calculateDistance(const City& city1, const City& city2) {
    int dx = city1.x - city2.x;
    int dy = city1.y - city2.y;
    return sqrt(dx * dx + dy * dy);
}

// Function to generate a random permutation of cities
void generateRandomTour(int* tour, int numCities) {
    for (int i = 0; i < numCities; i++) {
        tour[i] = i + 1;
    }
    random_device rd;
    mt19937 gen(rd());
    shuffle(tour, tour + numCities, gen);
}

// Function to calculate the cost of a tour
int calculateTourCost(const int* tour, int numCities) {
    int cost = 0;
    for (int i = 0; i < numCities - 1; i++) {
        cost += distanceMatrix[tour[i]][tour[i + 1]];
    }
    cost += distanceMatrix[tour[numCities - 1]][tour[0]];
    return cost;
}

// Function to find the shortest tour
void findShortestTour(int threadId, int numCities) {
    int* tour = new int[numCities];
    generateRandomTour(tour, numCities);

    int cost = calculateTourCost(tour, numCities);

    cout << "Thread " << threadId << " - Tour cost: " << cost << endl;

    mtx.lock();
    if (cost < shortestCost) {
        shortestCost = cost;
        if (shortestTour != nullptr) {
            delete[] shortestTour;
        }
        shortestTour = new int[numCities];
        for (int i = 0; i < numCities; i++) {
            shortestTour[i] = tour[i];
        }
    }
    else if (cost == shortestCost && threadId < minCostThreadId) {
        minCostThreadId = threadId;
    }
    mtx.unlock();

    delete[] tour;
}

int main() {
    ifstream inputFile("testFile.txt");
    int numCities;
    inputFile >> numCities;

    distanceMatrix = new int*[numCities + 1];
    for (int i = 0; i <= numCities; i++) {
        distanceMatrix[i] = new int[numCities + 1];
        for (int j = 0; j <= numCities; j++) {
            distanceMatrix[i][j] = 0;
        }
    }

    int city1, city2, distance;
    while (inputFile >> city1 >> city2 >> distance) {
        distanceMatrix[city1][city2] = distance;
        distanceMatrix[city2][city1] = distance;
    }

    inputFile.close();

    int numThreads;
    cout << "Enter the number of threads: ";
    cin >> numThreads;

    shortestTour = nullptr;
    minCostThreadId = 0;

    srand(time(NULL));

    thread* threads = new thread[numThreads];
    for (int i = 0; i < numThreads; i++) {
        threads[i] = thread(findShortestTour, i + 1, numCities);
    }

    for (int i = 0; i < numThreads; i++) {
        threads[i].join();
    }

    cout << "Shortest Tour Found - Cost: " << shortestCost << endl;
    cout << "Tour: ";
    for (int i = 0; i < numCities; i++) {
        cout << shortestTour[i] << " ";
    }
    cout << endl;

    delete[] shortestTour;
    delete[] threads;
    for (int i = 0; i <= numCities; i++) {
        delete[] distanceMatrix[i];
    }
    delete[] distanceMatrix;

    return 0;
}