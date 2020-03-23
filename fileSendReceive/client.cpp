#include <stdio.h>
#include "ConnectionManager.h"

/*
    Headers
*/
bool readParameters(int argc, char** argv, ConnectionManager ConnManager);

/*
    main()
*/
int main(int argc, char** argv){

    int result = -1;
    ConnectionManager ConnManager;

    if(!readParameters(argc, argv, ConnManager))
        result = 1;

    if(!ConnManager.Connect())
        result = 2;

    if(ConnManager.IsClient()){
        fprintf(stderr, "CLIENT - Done with code %d\n", result);
    }
    else if(ConnManager.IsServer()){
        result = ConnManager.Close();
        fprintf(stderr, "SERVER - Done with code %d\n", result);
    }
    else
        result = 3;

    return result;
}

/*
    readParameters()
*/
bool readParameters(int argc, char** argv, ConnectionManager ConnManager){

    bool result = true;

    // Decide between client or server mode
    if(argc > 1){
        if(strcmp(argv[1], "-s") == 0){
            ConnManager.SetServer();
        }
        else if(strcmp(argv[1], "-c") == 0){
            ConnManager.SetClient();
        }
        else{
            result = false;
        }
    }

    // Decide Port and IP
    ConnManager.Ip4((char*)"127.0.0.1", 9);
    ConnManager.Port(4000);
    return result;
}
