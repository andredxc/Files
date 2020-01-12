#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h>

#define IP_LEN 12

enum Mode {client, server};

class ConnectionManager{

    // Variables
    protected:
        char m_sIp4[IP_LEN];
        int m_nPort, m_nSocket, m_nClientSocket;
        enum Mode m_Mode;
        struct sockaddr_in m_Socket;

    // Methods
    public:
        ConnectionManager();
        bool Connect();
        bool Close();

        void Ip4(char* ip, int nSize);
        void Port(int nPort);
        void SetClient();
        void SetServer();

        bool IsClient();
        bool IsServer();
};
