#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <linux/i2c-dev.h>
#include <i2cutil.h>
#include <jhdlcd.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <poll.h>

#include "libgalileo2.h"


#define CLK "/sys/class/gpio/gpio38/value" // IO7
#define DATA "/sys/class/gpio/gpio0/value" // IO5
#define ACK "/sys/class/gpio/gpio1/value" // IO6

int stringToBinary(char* a) {

    int ascii[25]={};
    int i=0;
    int j;

    while(a[i]!='\0')
    {
      ascii[i]=a[i];
      i++;
    }
    return ascii;
}

int main(){

    unsigned char c;
    struct pollfd pfdAck;
    int cont, timedOut, clock_period;
    int fd_clock, fd_data, done, data[25];
    char buffer[20];

    data = stringToBinary("A");

    // Abre DATA
    if((fd_data = open(DATA, O_WRONLY)) < 0){
            perror("Opening data:");
            return -1;
    }

    // Abre CLK
    if((fd_clock = open(CLK, O_WRONLY)) < 0){
            perror("Opening clock:");
            return -1;
    }

    // Abre ACK
    if((pfdAck.fd = open(ACK, O_RDONLY)) < 0){
            perror("Opening ack:");
            return -1;
    }

    pputs("/sys/class/gpio/gpio1/edge","both");

    cont = 0;
    clock_period = 10; //ms
    while(!done){

        // /* Clear old values */
        read(pfdAck.fd, &c, 1);
        pfdAck.events = POLLPRI;
        puts("Waiting for interrupt...");
        if(poll(&pfdAck, 1, clock_period) == 0){
            // Retornou por timeout
            writeGPIO(fd_clock, cont%2);
            cont++;
            continue;
        }

        if(c == '1'){
            // Enviar dados
            writeGPIO(fd_data, data[cont]);
        }
        else{
            // Descida, ler dado
            writeGPIO(fd_data, 0);
        }

        lseek(pfdAck.fd,0,SEEK_SET);
        read(pfdAck.fd,&c,1);

        // Gera clock
        writeGPIO(fd_clock, cont%2);
        usleep(1000*clock_period); // 10 ms
        cont++;
    }

    pputs("/sys/class/gpio/gpio6/edge","none");
    close(pfdAck.fd);
    close(fd_clock);
    close(fd_data);
    return 0;
}
