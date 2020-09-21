#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "libgalileo2.h"

// Read ADC 0 voltage
int main(){

    double voltage;

    while(1){
        voltage = readAdcVoltage(0);
        fprintf(stderr, "Voltage: %f\n", voltage);
        usleep(20000);
    }

    return 0;
}
