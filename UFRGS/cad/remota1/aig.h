#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <fstream>
#include <sstream>
#include <set>
#include <list>

using namespace std;

typedef enum {
    AND_NODE,       // 0: AND object
    INPUT_NODE,     // 1: Input object
    OUTPUT_NODE     // 2: Ouput object
} AigNodeType;

class AigNode {
private:
    int ID;
    string name;

public:
    void setName(string);
    string getName();
    virtual AigNodeType getType() = 0;
    virtual void connectTo(AigNode*, int, int) = 0;
    virtual AigNode* getFanIn(int) = 0;
    virtual bool getInvertedFanIn(int) = 0;
    virtual vector<AigNode*> getFanOut() = 0;
    virtual vector<bool> getInvertedFanOut() = 0;
    virtual void setFanIn(int, AigNode*, bool) = 0;
};

class AndNode:public AigNode {
private:
    AigNode* in0;
    AigNode* in1;
    bool in0Inverted;
    bool in1Inverted;
    vector<AigNode*> fanOut;
    vector<bool> invertedFanout;
    //precisa de referência para as saídas do nodo (uma lista, talvez)?

public:
    AndNode();
    AigNodeType getType();
    void connectTo(AigNode*, int, int);
    AigNode* getFanIn(int);
    bool getInvertedFanIn(int);
    vector<AigNode*> getFanOut();
    vector<bool> getInvertedFanOut();
    void setFanIn(int, AigNode*, bool);
    //void imprime(ostream& saida);
};


class InputNode:public AigNode {
private:
    vector<AigNode*> fanOut;
    vector<bool> invertedFanout;

public:
    InputNode();
    AigNodeType getType();
    void connectTo(AigNode*, int, int);
    AigNode* getFanIn(int);
    bool getInvertedFanIn(int);
    vector<AigNode*> getFanOut();
    vector<bool> getInvertedFanOut();
    void setFanIn(int, AigNode*, bool);
    //void imprime(ostream& saida);
};

class OutputNode:public AigNode {
    AigNode* in0;
    bool in0Inverted;

public:
    OutputNode();
    AigNodeType getType();
    void connectTo(AigNode*, int, int);
    AigNode* getFanIn(int);
    bool getInvertedFanIn(int);
    vector<AigNode*> getFanOut();
    vector<bool> getInvertedFanOut();
    void setFanIn(int, AigNode*, bool);
    //void imprime(ostream& saida);
};



class Aig {
private:
    string name;
    vector<AigNode*> nodes; //deve conter todos os nodos (and, entradas e saídas)
    vector<AigNode*> inputs; //deve conter todas as entradas
    vector<AigNode*> outputs; //deve conter todas as saidas

public:
    Aig();
    string getName();
    vector<AigNode*> getInputs();
    vector<AigNode*> getOutputs();
    vector<AigNode*> getNodes();
    void insertNode(AigNode*);
    void insertInputNode(AigNode*);
    void insertOutputNode(AigNode*);
    void setName(string);
    int findInput(string name);
    int findOutput(string name);
    int findAnd(string name);
};
