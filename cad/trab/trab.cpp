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

    // Initialize distance distVector
    primVector.assign(_nodeVector.size(), -1);

    // Random first node
    srand (time(NULL));
    curNode = rand()%_nodeVector.size();
    // curNode = 0;
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
            edgeIndex = uDistance(curNode, i);
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
            curNode = findShortestEdge(primVector);
            selectedEdges.push_back(_edgeVector.at(primVector.at(curNode)));
        }
    }

    fprintf(stderr, "RESULT:\n");
    printUEdgeVector(selectedEdges);
}

// -----------------------------------------------------------------------------
int dijkstra(int srcNode, int destNode){

    uint curNode, initialNode, i, count, shortestDist;
    std::vector<int> curPath;
    int edgeIndex, lowest, shortestPathIndex;

    if(readGraph() < 0){
        return -1;
    }

    std::vector<int> dijVector[_nodeVector.size()];
    initialNode = findNodeIndex((uint)srcNode);
    // Marks initial node as visited
    dijVector[initialNode].push_back(-2);

    // Find distance from source to every other directly connected node
    for(i = 0; i < _nodeVector.size(); i++){
        if(dijVector[i].size() > 0 && dijVector[i].at(0) == -2){
            // Skip initial node
            continue;
        }
        edgeIndex = dDistance(initialNode, i);
        if(edgeIndex >= 0){
            // Found edge with corresponding src and dest
            dijVector[i].push_back(edgeIndex);
        }
        else{
            // Didn't find corresponding edge
            dijVector[i].push_back(-1);
        }
    }
    // Select closest node as next
    lowest = -1;
    curPath.push_back(0);
    shortestPathIndex = -1;
    for(i = 0; i < _nodeVector.size(); i++){
        if(lowest == -1 && dijVector[i].at(0) > 0){
            // First possible edge
            lowest = _edgeVector.at(dijVector[i].at(0)).value;
            curNode = _edgeVector.at(dijVector[i].at(0)).destNode;
            curPath.at(0) = dijVector[i].at(0);
            shortestPathIndex = i;
        }
        else if(dijVector[i].at(0) > 0 && (_edgeVector.at(dijVector[i].at(0)).value < (uint)lowest)){
            // Better edge
            lowest = _edgeVector.at(dijVector[i].at(0)).value;
            curNode = _edgeVector.at(dijVector[i].at(0)).destNode;
            curPath.at(0) = dijVector[i].at(0);
            shortestPathIndex = i;
        }
    }
    // Couldn't find path
    if(shortestPathIndex == -1){
        fprintf(stderr, "%s - No path\n", __FUNCTION__);
        return 0;
    }
    // Prints chosen path
    fprintf(stderr, "Chosen path:\n");
    printDijVector(dijVector[shortestPathIndex]);
    // Retiurns path distance
    if(shortestPathIndex == findNodeIndex(destNode)){
        return pathDistance(dijVector[shortestPathIndex]);
    }

    // Marks second node as visited
    dijVector[shortestPathIndex].at(0) = -2;

    if(lowest == -1){
        fprintf(stderr, "%s - Error, bad graph\n", __FUNCTION__);
        return -1;
    }

    count = 2;
    while(count < _nodeVector.size()){

        // Find distance to every other node
        for(i = 0; i < _nodeVector.size(); i++){
            if(dijVector[i].at(0) == -2){
                // Skips visited nodes
                continue;
            }
            edgeIndex = dDistance(curNode, i);
            if(edgeIndex < 0){
                // Non existent path
                continue;
            }
            if(pathDistance(dijVector[i]) == 0 && (_edgeVector.at(edgeIndex).value + pathDistance(curPath) > 0)){
                // New path found
                dijVector[i] = curPath;
                dijVector[i].push_back(edgeIndex);
            }
            else if(_edgeVector.at(edgeIndex).value + pathDistance(curPath) < pathDistance(dijVector[i])){
                // Found better path
                dijVector[i] = curPath;
                dijVector[i].push_back(edgeIndex);
            }
        }

        // Determine shortest path
        shortestDist = 0;
        shortestPathIndex = -1;
        fprintf(stderr, "\n\n");
        for(i = 0; i < _nodeVector.size(); i++){
            if(dijVector[i].at(0) < 0){
                // Skips visited nodes and infinite paths
                continue;
            }
            if(shortestPathIndex == -1){
                shortestPathIndex = i;
                shortestDist = pathDistance(dijVector[i]);
            }
            else if(pathDistance(dijVector[i]) < shortestDist){
                shortestPathIndex = i;
                shortestDist = pathDistance(dijVector[i]);
            }
        }

        // Prints chosen path
        fprintf(stderr, "Chosen path:\n");
        printDijVector(dijVector[shortestPathIndex]);

        // Returns path distance
        if(shortestPathIndex == findNodeIndex(destNode)){
            return pathDistance(dijVector[shortestPathIndex]);
        }

        // Update current path
        if(_edgeVector.at(dijVector[shortestPathIndex].at(dijVector[shortestPathIndex].size()-1)).srcNode == curNode){
            curPath = dijVector[shortestPathIndex];
        }
        curNode = _edgeVector.at(dijVector[shortestPathIndex].at(dijVector[shortestPathIndex].size()-1)).destNode;
        dijVector[shortestPathIndex].at(0) = -2;

        // Update node counter
        count++;
    }
    return -1;
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
// Distance in UNDIRECTED graphs
int uDistance(uint srcIndex, uint destIndex){

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
// Distance in DIRECTED graphs
int dDistance(uint srcIndex, uint destIndex){

    uint i;

    for(i =0; i < _edgeVector.size(); i++){

        if(_edgeVector.at(i).srcNode == srcIndex && _edgeVector.at(i).destNode == destIndex){
            return i;
        }
    }

    return -1;
}

// -----------------------------------------------------------------------------
uint pathDistance(std::vector<int> edgeIndexVec){

    uint i;
    int sum;

    sum = 0;
    for(i = 0; i < edgeIndexVec.size(); i++){
        if(edgeIndexVec.at(i) < 0){
            return 0;
        }
        sum += _edgeVector.at(edgeIndexVec.at(i)).value;
    }

    return sum;
}

// -----------------------------------------------------------------------------
int findShortestEdge(std::vector<int> vec){

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
int findNodeIndex(uint code){

    uint i;

    for(i = 0; i < _nodeVector.size(); i++){
        if(_nodeVector.at(i).code == code){
            return i;
        }
    }

    return -1;
}

// -----------------------------------------------------------------------------
void printEdgeVector(std::vector<EDGE> vec){

    uint i;

    for(i = 0; i < vec.size(); i++){
        printEdge(vec.at(i));
    }
}

// -----------------------------------------------------------------------------
void printUEdgeVector(std::vector<EDGE> vec){

    uint i;

    for(i = 0; i < vec.size(); i++){
        printUEdge(vec.at(i));
    }
}

// -----------------------------------------------------------------------------
void printEdge(EDGE edge){

    fprintf(stderr, "%d ------> %d (value: %d)\n", _nodeVector.at(edge.srcNode).code,
        _nodeVector.at(edge.destNode).code, edge.value);
}

// -----------------------------------------------------------------------------
void printUEdge(EDGE edge){

    fprintf(stderr, "%d <------> %d (value: %d)\n", _nodeVector.at(edge.srcNode).code,
        _nodeVector.at(edge.destNode).code, edge.value);
}

// -----------------------------------------------------------------------------
void printDijVector(std::vector<int> vec){

    uint i;

    for(i = 0; i < vec.size(); i++){
        if(vec.at(i) < 0){
            fprintf(stderr, "-1\n");
        }
        else{
            printEdge(_edgeVector.at(vec.at(i)));
        }
    }
}
