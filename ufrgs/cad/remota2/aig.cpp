//copyright Prof. Andre Reis - UFRGS


#include "aig.h"

//------------------AigNode------------------
AigNode::AigNode(){
    setDepth(-1);
}

int AigNode::getDepth(){
    return this->depth;
}

void AigNode::setDepth(int value){
    depth = value;
}

//------------------AndNode------------------
AndNode::AndNode(){}

AigNodeType AndNode::getType(){
    return AND_NODE;
}

void AndNode::connectTo(AigNode * dest, int pin, int isInverted){
    this->fanOut.push_back(dest);
    this->invertedFanout.push_back(isInverted);

    dest->setFanIn(pin,this,isInverted);
}

AigNode* AndNode::getFanIn(int index){
    if(index == 0) return this->in0;
    else if(index == 1) return this->in1;
    else {
        cout << "Index out of bounds!";
        return NULL;
    }
}

bool AndNode::getInvertedFanIn(int index){
    if(index == 0) return this->in0Inverted;
    else if(index == 1) return this->in1Inverted;
    else {
        cout << "Index out of bounds!";
        return -1;
    }
}

vector<AigNode*> AndNode::getFanOut(){
    return this->fanOut;
}

vector<bool> AndNode::getInvertedFanOut(){
    return this->invertedFanout;
}

void AndNode::setFanIn(int index, AigNode * node, bool isInverted){
    if(index == 0){
        this->in0 = node;
        this->in0Inverted = isInverted;
    }
    else if(index == 1){
        this->in1 = node;
        this->in1Inverted = isInverted;
    }
    else {
        cout << "Index out of bounds!";
    }
}

//------------------InputNode------------------
InputNode::InputNode(){}

void InputNode::setName(string newName){
    this->name = newName;
}

string InputNode::getName(){
    return this->name;
}

AigNodeType InputNode::getType(){
    return INPUT_NODE;
}

void InputNode::connectTo(AigNode * dest, int pin, int isInverted){
    this->fanOut.push_back(dest);
    this->invertedFanout.push_back(isInverted);

    dest->setFanIn(pin,this,isInverted);
}

AigNode* InputNode::getFanIn(int){
    cout << "Wrong type of node! InputNode can not getFanIn";
    return NULL;
}

bool InputNode::getInvertedFanIn(int){
    cout << "Wrong type of node! InputNode can not setFanIn";
    return NULL;
}

vector<AigNode*> InputNode::getFanOut(){
    return this->fanOut;
}

vector<bool> InputNode::getInvertedFanOut(){
    return this->invertedFanout;
}

void InputNode::setFanIn(int, AigNode *, bool){
    cout << "Wrong type of node! InputNode can not setFanIn";
}

//------------------OutputNode------------------

OutputNode::OutputNode(){}

void OutputNode::setName(string newName){
    this->name = newName;
}

string OutputNode::getName(){
    return this->name;
}

AigNodeType OutputNode::getType(){
    return OUTPUT_NODE;
}

void OutputNode::connectTo(AigNode*, int, int){
    cout << "Wrong type of node! OutputNode can not connectTo";
}

AigNode* OutputNode::getFanIn(int index){
    if(index != 0){
        cout << "Index out of bounds!";
        return NULL;
    }
    else{
        return this->in0;
    }
}

bool OutputNode::getInvertedFanIn(int index){
    if(index != 0){
        cout << "Index out of bounds!";
        return NULL;
    }
    else{
        return this->in0Inverted;
    }
}

vector<AigNode*> OutputNode::getFanOut(){
    cout << "Wrong type of node! OutputNode has not FanOut";
    return vector<AigNode*>();
}

vector<bool> OutputNode::getInvertedFanOut(){
    cout << "Wrong type of node! OutputNode has not FanOut";
    return vector<bool>();
}

void OutputNode::setFanIn(int index, AigNode * node, bool isInverted){
    if(index != 0) cout << "Index out of bounds!";
    else{
        this->in0 = node;
        this->in0Inverted = isInverted;
    }
}

//------------------AIG------------------

Aig::Aig(){}

string Aig::getName(){
    return this->name;
}

list<AigNode*> Aig::getInputs(){
    return this->inputs;
}

list<AigNode*> Aig::getOutputs(){
    return this->outputs;
}

list<AigNode*> Aig::getNodes(){
    return this->nodes;
}

void Aig::insertNode(AigNode* node) {
	nodes.push_back(node);
}

void Aig::insertInputNode(AigNode* inputNode) {
	inputs.push_back(inputNode);
}

void Aig::insertOutputNode(AigNode* outputNode) {
	outputs.push_back(outputNode);
}

void Aig::setName(string newName){
    this->name = newName;
}

int Aig::computeDepth(AigNode* node){

    int depth0 = -1;
    int depth1 = -1;

    if(!node){
        return 0;
    }

    if(node->getType() == INPUT_NODE){
        // Primary node, depth=0
        node->setDepth(0);
        return 0;
    }
    else{
        if(node->getFanIn(0) != NULL && node->getFanIn(0)->getDepth() > -1){
            depth0 = node->getFanIn(0)->getDepth();
        }
        else{
            depth0 = Aig::computeDepth(node->getFanIn(0));
        }

        if(node->getType() == AND_NODE){
            // Only ANDs have the second input
            if(node->getFanIn(1) != NULL && node->getFanIn(1)->getDepth() > -1){
                depth1 = node->getFanIn(1)->getDepth();
            }
            else{
                depth1 = Aig::computeDepth(node->getFanIn(1));
            }
        }

        return (depth0 >= depth1) ? depth0+1 : depth1+1;
    }
}
