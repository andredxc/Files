#include "trab.h"

std::vector<EDGE> _edgeVector;
std::vector<NODE> _nodeVector;

// -----------------------------------------------------------------------------
void prim(){

    uint curNode, done, i, count;
    std::vector<int> distVector;
    int curDist;

    if(readGraph() < 0){
        return;
    }
    printStructs();

    // Initialize distance distVector
    for(i = 0; i < _nodeVector.size(); i++){
        distVector.at(i) = -1;
    }

    // Random first node
    curNode = rand()%_nodeVector.size();

    done = 0;
    count = 0;
    while(!done){
        // A value of -1 indicates infinite distnce
        // A value of -2 indicates that the node has already been visited

        distVector.at(curNode) = -2;
        count++;

        for(i = 0; i < _nodeVector.size(); i++){
            // Calculate distance to each other node
            if(i == curNode){
                continue;
            }
            curDist = distance(curNode, i);
            if(curDist != -1 && curDist < distVector.at(i)){
                // Lower distance value
                distVector.assign(i, curDist);
            }
        }

        if(count == _nodeVector.size()){
            // All nodes have been visited
            done = 1;
        }
        else{
            // Decide next node
            curNode = findLowest(distVector);
        }
    }
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
        nodeBuf.edges.clear();
        nodeBuf.edges.push_back(_edgeVector.size());
        _nodeVector.push_back(nodeBuf);
        srcIndex = _nodeVector.size() - 1;
    }
    else{
        // Update edge list
        _nodeVector.at(srcIndex).edges.push_back(_edgeVector.size());
    }

    if(destIndex == -1){
        // Add new dest node
        nodeBuf.code = dest;
        nodeBuf.edges.clear();
        nodeBuf.edges.push_back(_edgeVector.size());
        _nodeVector.push_back(nodeBuf);
        destIndex = _nodeVector.size() - 1;
    }
    else{
        // Update edge list
        _nodeVector.at(destIndex).edges.push_back(_edgeVector.size());
    }

    edgeBuf.value = value;
    edgeBuf.srcNode = srcIndex;
    edgeBuf.destNode = destIndex;
    _edgeVector.push_back(edgeBuf);
}

// -----------------------------------------------------------------------------
void printStructs(){

    uint i, j;
    std::vector<uint> buff;
    uint srcCode, destCode, val;

    for(i = 0; i < _edgeVector.size(); i++){
        fprintf(stderr, "%d ------> %d (value: %d)\n", _nodeVector.at(_edgeVector.at(i).srcNode).code,
            _nodeVector.at(_edgeVector.at(i).destNode).code, _edgeVector.at(i).value);
    }

    for(i = 0; i < _nodeVector.size(); i++){
        // For each node
        fprintf(stderr, "\nNode %d ------\n", _nodeVector.at(i).code);

        for(j = 0; j < _nodeVector.at(i).edges.size(); j++){
            // Print all connections
            _nodeVector.at(i).edges.at(j);

            srcCode = _nodeVector.at(_edgeVector.at(_nodeVector.at(i).edges.at(j)).srcNode).code;
            destCode = _nodeVector.at(_edgeVector.at(_nodeVector.at(i).edges.at(j)).destNode).code;
            val = _edgeVector.at(_nodeVector.at(i).edges.at(j)).value;

            fprintf(stderr, "%d ----> %d (value: %d)\n", srcCode, destCode, val);
        }
    }
}

// -----------------------------------------------------------------------------
int distance(uint srcIndex, uint destIndex){

    uint i;

    for(i =0; i < _edgeVector.size(); i++){

        if(_edgeVector.at(i).srcNode == srcIndex && _edgeVector.at(i).destNode == destIndex){
            return _edgeVector.at(i).value;
        }
        else if(_edgeVector.at(i).srcNode == destIndex && _edgeVector.at(i).destNode == srcIndex){
            return _edgeVector.at(i).value;
        }
    }

    return -1;
}

// -----------------------------------------------------------------------------
int findLowest(std::vector<int> vec){

    uint i, curLowestIndex;
    int curLowest;

    curLowest = vec.at(0);
    curLowestIndex = 0;
    for(i = 0; i < vec.size(); i++){
        // Skip negative numbers
        if(vec.at(i) >= 0 && vec.at(i) < curLowest){
            curLowest = vec.at(i);
            curLowestIndex = i;
        }
    }

    return curLowestIndex;
}
