#include "ConnectionManager.h"

ConnectionManager::ConnectionManager(){
}

bool ConnectionManager::Connect(){

    int nSocket;
    bool result, bNoConnection;

    result = true;
    m_nSocket = socket(AF_INET, SOCK_STREAM, 0);

    if(m_Mode == server){
        // Connect as a server
        m_Socket.sin_family = AF_INET;
        m_Socket.sin_addr.s_addr = htonl(INADDR_ANY);
        m_Socket.sin_port = htons(m_nPort);
        result = bind(m_nSocket, (struct sockaddr*)&m_Socket,
                      sizeof(m_Socket)) == 0;

      listen(m_nSocket, 20);
      bNoConnection = true;
      while(bNoConnection){
          m_nClientSocket = accept(m_nSocket, (struct sockaddr*)NULL, NULL);
          fprintf(stderr, "SERVER - Client connected, socket=%d\n", m_nClientSocket);
          bNoConnection = false;
      }
    }
    else if(m_Mode == client){
        // Connect as a client
        m_Socket.sin_family = AF_INET;
        m_Socket.sin_port = htons(m_nPort);
        m_Socket.sin_addr.s_addr = inet_addr(m_sIp4);
        result = connect(m_nSocket, (struct sockaddr*)&m_Socket,
                         sizeof(m_Socket)) == 0;
    }
    else{
        // Unrecognized mode
        result = false;
    }

    return result;
}

bool ConnectionManager::Close(){
    close(m_nClientSocket);
    return true;
}

bool ConnectionManager::IsClient(){

    return true ? m_Mode == client : false;
}

bool ConnectionManager::IsServer(){

    return true ? m_Mode == server : false;
}

void ConnectionManager::SetClient(){
    m_Mode = client;
}

void ConnectionManager::SetServer(){
    m_Mode = server;
}

void ConnectionManager::Ip4(char* sIp, int nSize){
    strncpy(m_sIp4, sIp, nSize);
}

void ConnectionManager::Port(int nPort){
    m_nPort = nPort;
}
