#ifndef TRAB_H
#define TRAB_H

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>

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

int readGraph();
void addEdge(uint value, uint src, uint dest);
void printStructs();

#endif
