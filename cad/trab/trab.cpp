#include "trab.h"

std::vector<EDGE> _edgeVector;
std::vector<NODE> _nodeVector;

// -----------------------------------------------------------------------------
void prim(){

    if(readGraph() < 0){
        return;
    }
    printStructs();
}

// -----------------------------------------------------------------------------
int readGraph(){

    FILE* inputFile;
    int src, dest, dist;

    // Open file
    if(!(inputFile = fopen(INPUT_FILE, "r"))){
        fprintf(stderr, "%s - Error opening input file %s\n", __FUNCTION__, INPUT_FILE);
        return -1;
    }

    while(!feof(inputFile)){
        // Read line from file
        if(fscanf(inputFile, "%d %d %d\n", &src, &dest, &dist) != 3){
            fprintf(stderr, "%s - Error on input file's format\n", __FUNCTION__);
            fclose(inputFile);
            return -1;
        }

        if(src < 0 || dest < 0 || dist < 0){
            fprintf(stderr, "%s - Error graph values must be > 0\n", __FUNCTION__);
            fclose(inputFile);
            return -1;
        }

        // Fill data structures with info
        addEdge(dist, src, dest);
    }

    return 1;
}

// -----------------------------------------------------------------------------
void addEdge(uint value, uint src, uint dest){

    uint i;
    int srcIndex, destIndex;
    NODE nodeBuf;
    EDGE edgeBuf;

    // Find nodes in structures
    srcIndex = -1;
    destIndex = -1;
    for(i = 0; i < _nodeVector.size(); i++){
        if(_nodeVector.at(i).code == src){
            srcIndex = i;
        }
        else if(_nodeVector.at(i).code == dest){
            destIndex = i;
        }
    }

    if(srcIndex == -1){
        // Add new src node
        nodeBuf.code = src;
        nodeBuf.edges.push_back(_edgeVector.size());
        _nodeVector.push_back(nodeBuf);
        srcIndex = _nodeVector.size() - 1;
    }

    if(destIndex == -1){
        // Add new dest node
        nodeBuf.code = dest;
        nodeBuf.edges.push_back(_edgeVector.size());
        _nodeVector.push_back(nodeBuf);
        destIndex = _nodeVector.size() - 1;
    }

    edgeBuf.value = value;
    edgeBuf.srcNode = srcIndex;
    edgeBuf.destNode = destIndex;
    _edgeVector.push_back(edgeBuf);
}

// -----------------------------------------------------------------------------
void printStructs(){

    uint i;

    for(i = 0; i < _edgeVector.size(); i++){
        fprintf(stderr, "%d ------> %d (value: %d)\n", _nodeVector.at(_edgeVector.at(i).srcNode).code,
            _nodeVector.at(_edgeVector.at(i).destNode).code, _edgeVector.at(i).value);
    }
}
