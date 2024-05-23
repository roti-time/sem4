#include <iostream>
#include <fstream>
#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>
//#include <sys/wait.h>
#include <ctime>
using namespace std;


int distance[5]={0,0,0,0,0};
struct Node {
    int data;
    int weight; // Weight of the edge
    Node* next;
    bool visited=false;

    Node(int value, int w) : data(value), weight(w), next(nullptr) {}
};

// Graph using adjacency list
class Graph {
private:
    int numVertices;
    Node** adjacencyList;

public:
    // Constructor
    Graph(int vertices) : numVertices(vertices) {
        adjacencyList = new Node*[numVertices](); // Initialize array of pointers to nullptr
    }

    // Destructor
    ~Graph() {
        for (int i = 0; i < numVertices; ++i) {
            Node* current = adjacencyList[i];
            while (current != nullptr) {
                Node* next = current->next;
                delete current;
                current = next;
            }
        }
        delete[] adjacencyList;
    }

    // Add an edge to the graph with weight
    void addEdge(int from, int to, int weight) {
        // Assuming the graph is undirected
        Node* newNode = new Node(to, weight);
        newNode->next = adjacencyList[from];
        adjacencyList[from] = newNode;

        // For undirected graph, add edge in both directions
        newNode = new Node(from, weight);
        newNode->next = adjacencyList[to];
        adjacencyList[to] = newNode;
    }

    

    // Print the adjacency list
    void printGraph() {
        fstream file;
        file.open("testFile.txt", ios::out);
        file<< numVertices << endl; 
        for (int i = 0; i < numVertices; ++i) {
           
            Node* current = adjacencyList[i];
            while (current != nullptr) {
                
                file << i << "-";
                file <<current->data << " " << current->weight;
                current = current->next;
                //cout<<endl<<current->data<<endl;
                file << endl;
            }
            
        }
            cout << "Adjacency List:\n";
            for (int i = 0; i < numVertices-1; ++i) {
            
            Node* current = adjacencyList[i];
            cout<<endl<<current->data<<endl;
            cout << "Vertex " << i << " --> ";
            while (current != nullptr) {
                cout << "(" << current->data << ", " << current->weight << ") ";
                current = current->next;
            }
            cout << endl;
        }
        file.close();
    }
};
void graphmaker(int pid)
{
    Graph graph(4);
    srand((pid*pid*time(0)));
    // Adding edges with weights
    graph.addEdge(0, 1,rand()%15 );
    graph.addEdge(0, 2, rand()%15);
    graph.addEdge(0, 3, rand()%15);
    graph.addEdge(1, 2, rand()%15);
    graph.addEdge(1, 3, rand()%15);
    graph.addEdge(2, 3, rand()%15);
    

    // Printing the graph
    graph.printGraph();
}
void *threadFunction(void *arg) {
    Graph* graph = (Graph*)arg;
    graphmaker(getpid());
    delete graph; 
    return nullptr;
}
// Driver code
int main() {
    int threadCount;
    cout << "Enter the number of threads: ";
    cin >> threadCount;
    pthread_t threads[threadCount];
     
    for (int i = 0; i < threadCount; ++i) {
        pthread_create(&threads[i], nullptr, threadFunction, new Graph(4));
    }
    for (int i = 0; i < threadCount; ++i) {
        pthread_join(threads[i], nullptr);
    }
    return 0;
}
