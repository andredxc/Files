#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "libgalileo2.h"

#define ADC0_VOLTAGE_PATH "/sys/bus/iio/devices/iio:device0/in_voltage0_raw"
#define ADC0_SCALE_PATH "/sys/bus/iio/devices/iio:device0/in_voltage0_scale"

int main(){

    int fdVoltage;
    char buffer[20];
    double scale;

    fdVoltage = open(ADC0_VOLTAGE_PATH, O_RDONLY);

    if(fdVoltage < 0){
        printf("Error reading file %s\n", ADC0_VOLTAGE_PATH);
        return -1;
    }

    pgets(buffer, sizeof(buffer), ADC0_SCALE_PATH);
    scale = atof(buffer)/1000.0;     // Scale used to convert voltage value to Volts

    while(1){
        lseek(fdVoltage, 0, SEEK_SET);
        read(fdVoltage, buffer, sizeof(buffer));
        printf("Read: %d, Scale: %f, Value: %fV\n", atoi(buffer), scale, scale*atof(buffer));
    }

    close(fdVoltage);
    return 0;
}
