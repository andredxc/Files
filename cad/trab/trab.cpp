#include "trab.h"

std::vector<EDGE> _edgeVector;
std::vector<NODE> _nodeVector;

// -----------------------------------------------------------------------------
void prim(){

    uint curNode, done, i, count;
    std::vector<int> primVector;
    std::vector<EDGE> selectedEdges;
    int edgeIndex;

    if(readGraph() < 0){
        return;
    }
    // printStructs();

    // Initialize distance distVector
    primVector.assign(_nodeVector.size(), -1);

    // Random first node
    // curNode = rand()%_nodeVector.size();
    curNode = 4;
    fprintf(stderr, "Prim starting with node %d\n", _nodeVector.at(curNode).code);

    done = 0;
    count = 0;
    while(!done){
        // A value of -1 indicates infinite distnce
        // A value of -2 indicates that the node has already been visited

        primVector.at(curNode) = -2;
        count++;

        for(i = 0; i < _nodeVector.size(); i++){
            // Calculate distance to each other node
            if(primVector.at(i) == -2){
                continue;
            }
            edgeIndex = distance(curNode, i);
            if(edgeIndex >= 0){
                // Valid distance found
                if(primVector.at(i) == -1){
                    // Previously infinite distance
                    primVector.at(i) = edgeIndex;
                }
                else if(_edgeVector.at(edgeIndex).value < _edgeVector.at(primVector.at(i)).value){
                    // New distance is lower
                    primVector.at(i) = edgeIndex;
                }
            }
        }

        if(count == _nodeVector.size()){
            // All nodes have been visited
            done = 1;
        }
        else{
            // Decide next node
            curNode = findLowest(primVector);
            selectedEdges.push_back(_edgeVector.at(primVector.at(curNode)));
        }
    }

    fprintf(stderr, "RESULT:\n");
    printEdgeVector(selectedEdges);
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
// Returns the index to the edge corresponding to the distance
int distance(uint srcIndex, uint destIndex){

    uint i;

    for(i =0; i < _edgeVector.size(); i++){

        if(_edgeVector.at(i).srcNode == srcIndex && _edgeVector.at(i).destNode == destIndex){
            return i;
        }
        else if(_edgeVector.at(i).srcNode == destIndex && _edgeVector.at(i).destNode == srcIndex){
            return i;
        }
    }

    return -1;
}

// -----------------------------------------------------------------------------
int findLowest(std::vector<int> vec){

    uint i, curLowestIndex;

    // curLowestIndex receives first positive value in vector
    i = 0;
    while(vec.at(i) < 0){
        i++;
    }
    curLowestIndex = i;

    // fprintf(stderr, "\n\nNEW CALL\n");

    for(i = 0; i < vec.size(); i++){
        // Skip negative numbers
        if(vec.at(i) >= 0 && _edgeVector.at(vec.at(i)).value < _edgeVector.at(vec.at(curLowestIndex)).value){
            // fprintf(stderr, "OLD\n");
            // printEdge(_edgeVector.at(vec.at(curLowestIndex)));
            // fprintf(stderr, "NEW\n");
            // printEdge(_edgeVector.at(vec.at(i)));
            curLowestIndex = i;
        }
    }

    return curLowestIndex;
}

// -----------------------------------------------------------------------------
void printEdgeVector(std::vector<EDGE> vec){

    uint i;

    for(i = 0; i < vec.size(); i++){
        printEdge(vec.at(i));
    }
}

// -----------------------------------------------------------------------------
void printEdge(EDGE edge){

    fprintf(stderr, "%d ------> %d (value: %d)\n", _nodeVector.at(edge.srcNode).code,
        _nodeVector.at(edge.destNode).code, edge.value);
}
