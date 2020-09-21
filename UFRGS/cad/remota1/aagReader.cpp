#include "aagReader.h"
#include <string.h>
#include <cstring>

AAGReader::AAGReader(string sourcePath)
{
    source.open(sourcePath.c_str());
    debug.open("aagComentado.txt");
}

Aig* AAGReader::readFile()
{
    Aig* aig = new Aig();
    aig->setName("out");
    //treating header
    source.getline(buf, 250, '\n');
    string s=buf;
    istringstream line;
    line.str(s);
    line >> word;
    string stringBuffer;

    if(strcmp("aag",word.c_str())!=0)
    {
        cout << "the file is not an AAG file!";
        return NULL;
    }

    int nNodes, nInputs, nFFs, nOutputs, nAnds;
    line >> word;
    nNodes = atoi(word.c_str());
    line >> word;
    nInputs = atoi(word.c_str());
    line >> word;
    nFFs = atoi(word.c_str());
    line >> word;
    nOutputs = atoi(word.c_str());
    line >> word;
    nAnds = atoi(word.c_str());

    if (nNodes != nInputs + nFFs + nAnds) {
        cout << "Wrong file header";
        return NULL;
    }

    if (nFFs != 0) {
        cout << "FF not supported yet";
        return NULL;
    }

    debug << s << "\nThe file header is ok!\n\n";

    AigNode** nodes = new AigNode*[nNodes + 1];
    OutputNode* outs = new OutputNode[nOutputs];
    InputNode* ins = new InputNode[nInputs];

    //treating inputs
    for (int i = 0; i < nInputs; i++) {
        debug << "read the input" << i << " from the file\n";
        debug << "   create in" << i << " and add it to an input list and the all nodes list\n";

        source.getline(buf, 250, '\n');
        snprintf(buf, sizeof(buf), "pi%d", atoi(buf));
        InputNode* in = new InputNode(); in->setName(buf);
        aig->insertInputNode(in); aig->insertNode(in);
    }

    //treating outputs
    debug << "\n";
    for (int i = 0; i < nOutputs; i++) {
        debug << "read the output" << i << " from the file\n";
        debug << "   create out" << i << " and add it to an output list and the all nodes list\n";

        source.getline(buf, 250, '\n');
        snprintf(buf, sizeof(buf), "po%d", atoi(buf));
        OutputNode* out = new OutputNode(); out->setName(buf);
        aig->insertOutputNode(out); aig->insertNode(out);
    }

    //connecting ands
    debug << "\n";
    for (int i = 0; i < nAnds; i++) {
        debug << "read the and" << i << " output and inputs\n";
        debug << "   connect the and" << i << " and set the inversion of this pins\n";

        source.getline(buf, 250, '\n');
        string s=buf;
        istringstream line;
        line.str(s);

        line >> word;
        snprintf(buf, sizeof(buf), "and%d", atoi(word.c_str()));
        AndNode* andNode = new AndNode(); andNode->setName(buf);
        // Input 0
        line >> word;
        snprintf(buf, sizeof(buf), "and%d", atoi(word.c_str()));
        stringBuffer = buf;
        vector<AigNode*> vectorBuffer = aig->getNodes();
        AigNode* curNode = vectorBuffer.at(aig->findAnd(stringBuffer));
        if(atoi(word.c_str())%2 != 0){
            // Inverted
            curNode->connectTo(andNode, 0, 1);
        }
        else{
            curNode->connectTo(andNode, 0, 0);
        }
        // Input 1
        line >> word;
        snprintf(buf, sizeof(buf), "and%d", atoi(word.c_str()));
        stringBuffer = buf;
        vectorBuffer = aig->getNodes();
        curNode = vectorBuffer.at(aig->findAnd(stringBuffer));
        if(atoi(word.c_str())%2 != 0){
            // Inverted
            curNode->connectTo(andNode, 1, 1);
        }
        else{
            curNode->connectTo(andNode, 1, 0);
        }

        aig->insertNode(andNode);
    }

    debug << "\n";
    string aigName;
    while(source)
    {
        source.getline(buf, 250, '\n');
        string s=buf;
        istringstream line;
        line.seekg(0);line.str(s);
        line >> word;

        if(strcmp("c",word.substr(0).c_str())==0){
            debug << "the comments began. Ignore the file from here!\n";
            break;
        } else if(strcmp(word.substr(0).c_str(),"i")==0){

        } else if(strcmp(word.substr(0).c_str(),"o")==0){

        } else if(strcmp(word.substr(0).c_str(),"l")==0){

        }
    }

    debug << "\ncreate the AIG and add all nodes\n";
    debug << "return the AIG";

    return aig;
}
