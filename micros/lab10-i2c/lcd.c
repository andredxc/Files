#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/i2c-dev.h>
#include <i2cutil.h>
#include <jhdlcd.h>
#include "libgalileo2.h"

int main(int argc,char *argv[]){

    char string[50] = {"Show"};

    initLCD();

    writeLCD(2, string, strlen(string));
    setLCDBacklight(rand()%256, rand()%256, rand()%256);

    // while(1){
    //
    //     usleep(1000000);
    // }


	return 1;
}
