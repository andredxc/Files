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


#define CLK "/sys/class/gpio/gpio13/value" // IO2
#define ACK "/sys/class/gpio/gpio14/value" // IO3
#define DATA "/sys/class/gpio/gpio6/value" // IO4

int main(){

    unsigned char c;
    struct pollfd pfdClock;
    int cont, timedOut, clock_period;
    int fd_ack, fd_data, done, fd_lcd;
    int data[25];
    char buffer[50], buffer2[10];

    // Abre DATA
    if((fd_data = open(DATA, O_RDONLY)) < 0){
            perror("Opening data:");
            return -1;
    }

    // Abre CLK
    if((pfdClock.fd = open(CLK, O_RDONLY)) < 0){
            perror("Opening clock:");
            return -1;
    }

    // Abre ACK
    if((fd_ack = open(ACK, O_WRONLY)) < 0){
            perror("Opening ack:");
            return -1;
    }

    pputs("/sys/class/gpio/gpio13/edge","both");

    rising = 0;
    falling = 0;
    cont = 0;
    zeroCounter = 0;
    while(!done){

        // /* Clear old values */
        read(pfdClock.fd, &c, 1);
        pfdClock.events = POLLPRI;
        puts("Waiting for interrupt...");
        poll(&pfdClock, 1, -1);
        lseek(pfdClock.fd,0,SEEK_SET);
        read(pfdClock.fd,&c,1);

        if(c == '1'){
            // Subida, gerar ack
            writeGPIO(fd_ack, 1);
        }
        else{
            // Descida, ler dado
            write(fd_ack, 0);
            data[cont] = readGPIO(fd_data);
            if(data[cont] == 0){
                zeroCounter++;
                if(zeroCounter >= 10){
                    done = 0;
                }
            }
            else{
                zeroCounter = 0;
            }
            cont++;
        }
    }

    // Escrever no LCD
    if((fd_lcd = initLCD()) < 0){
        fprintf(stderr, "Erro abrindo LCD\n");
    }

    snprintf(buffer, sizeof(buffer), "");
    for(i = 0; i < sizeof(data), i++){
        snprintf(buffer2, sizeof(buffer2), "%d", data[i]);
        strncat(buffer, "%d", buffer2, sizeof(buffer));
    }

    writeLCD(fd_lcd, 1, buffer, strlen(buffer));

    pputs("/sys/class/gpio/gpio13/edge","none");
    close(pfdClock.fd);
    close(fd_ack);
    close(fd_data);
    return 0;
}
