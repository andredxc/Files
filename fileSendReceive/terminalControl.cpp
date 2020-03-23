#include <stdio.h>
#include <stdlib.h>

#define N_MAXLINE_LENGTH       256

#define STR_LINE_START         "cmd>"
#define STR_COMMAND_FILESEND   "send"


char** readLine(int* nArgs);
void parseAndRun(char** ppArgs, int nArgs);
void runFileSend(char** ppArgs, int nArgs);


int main(int argc, char **argv){

    bool bRun;
    int nArgs;
    char **ppArgs;

    bRun = true;
    while(bRun){
        ppArgs = readLine(&nArgs);

        parseAndRun(ppArgs, nArgs);
    }
}


char** readLine(int* nArgs){

    char strLine[N_MAXLINE_LENGTH];
    char strLineFormat[N_MAXLINE_LENGTH];
    char** ppArgs;
    char* pArg;

    // Build string for scanf guidelines
    strcat(strLineFormat, STR_LINE_START);
    strcat(strLineFormat, "%s");
    printf(STR_LINE_START);
    scanf(strLineFormat, strLine):

    // Parse each word into a string



    ppArgs = parseLine(strLine, );

}


void parseAndRun(char** ppArgs, int nArgs){

    char* strCommand;

    // Command is always the first element
    strCommand = ppArgs[0];
    if(strcmp(strCommand, STR_COMMAND_FILESEND)){
        // Run command for sending files
        runFileSend()
    }
}
