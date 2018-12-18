#ifndef TRAB_H
#define TRAB_H

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include <time.h>

#define INPUT_FILE "graph.txt"

typedef struct edge{
    uint value;
    uint srcNode, destNode;
}EDGE;

typedef struct node{
    uint code;
    std::vector<uint> edges;
}NODE;

void prim();
int dijkstra(int srcNode, int destNode);

int readGraph();
void addEdge(uint value, uint src, uint dest);
void printStructs();
int uDistance(uint srcIndex, uint destIndex);
int dDistance(uint srcIndex, uint destIndex);
uint pathDistance(std::vector<int> edgeIndexVec);
int findShortestEdge(std::vector<int> vec);
int findNodeIndex(uint code);
void printEdgeVector(std::vector<EDGE> vec);
void printUEdgeVector(std::vector<EDGE> vec);
void printEdge(EDGE edge);
void printUEdge(EDGE edge);
void printDijVector(std::vector<int> vec);

#endif
