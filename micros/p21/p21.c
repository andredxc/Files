#include <byteswap.h>
#include <fcntl.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "libgalileo2.h"

#define DATA_POINTS 100
#define SAMPLING_PERIOD 1e-3
#define BUFFER_ENABLE "/sys/bus/iio/devices/iio:device0/buffer/enable"

void printEveryChar(char* charArray, int size);

/*
    ADC0
    PWM1
*/

/* Assumes the data format for Galileo Gen2 */
struct sensors
{
        uint16_t a0;		/* be:u12/16>>0 */
        // uint16_t a1;		/* be:u12/16>>0 */
        // uint16_t a2;		/* be:u12/16>>0 */
        // uint16_t a3;		/* be:u12/16>>0 */
        // int64_t timestamp;	/* le:s64/64>>0 */
};

int main(int argc,char * argv[])
{
        char data_str[80];
        double scale, meanVoltage;
        int fd;
        static struct sensors data[DATA_POINTS];
        int i, done, samples, sum;
        int angle;
        int fd_buffer_enable;


        // Set up continuous ADC ----------------------------------------------------
        if((fd_buffer_enable = open(BUFFER_ENABLE, O_WRONLY)) < 0){
            fprintf(stderr, "%s - Error opening %s\n", __FUNCTION__, BUFFER_ENABLE);
            return -1;
        }
        snprintf(data_str, sizeof(data_str), "0");
        write(fd_buffer_enable, data_str, strlen(data_str));
        // Scale for adc0
        pgets(data_str, sizeof(data_str), "/sys/bus/iio/devices/iio:device0/in_voltage0_scale");
        scale = atof(data_str)/1000.0;
        // Enable channel 0
        if(pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en", "1") < 0){
            fprintf(stderr, "Error in_voltage0_en\n");
        }
        // Disable timestamp
        if(pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en", "0") < 0){
            fprintf(stderr, "Error in_timestamp_en\n");
        }
        // Set buffer length
        snprintf(data_str, sizeof(data_str), "%d", DATA_POINTS*sizeof(struct sensors));
        if(pputs("/sys/bus/iio/devices/iio:device0/buffer/length", data_str) < 0){
            fprintf(stderr, "Error length\n");
        }
        // Enable trigger1
        pgets(data_str, sizeof(data_str), "/sys/bus/iio/devices/trigger1/name");
        if(pputs("/sys/bus/iio/devices/iio:device0/trigger/current_trigger", data_str) < 0){
            fprintf(stderr, "Error current_trigger\n");
        }
        // Set sampling frequency
        snprintf(data_str, sizeof(data_str), "%d", (int)round(1.0/SAMPLING_PERIOD));
        if(pputs("/sys/bus/iio/devices/trigger1/frequency", data_str) < 0){
            fprintf(stderr, "Error frequency\n");
        }

        done = 0;
        while(!done){

            // Start conversion
            snprintf(data_str, sizeof(data_str), "1");
            if(write(fd_buffer_enable, data_str, strlen(data_str)) < 0){
                fprintf(stderr, "%s - Error enabling buffer\n", __FUNCTION__);
            }

            sleep(ceil(DATA_POINTS*SAMPLING_PERIOD));

            snprintf(data_str, sizeof(data_str), "0");
            if(write(fd_buffer_enable, data_str, strlen(data_str)) < 0){
                fprintf(stderr, "%s - Error disabling buffer\n", __FUNCTION__);
            }

            // Read values
            if((fd = open("/dev/iio:device0", O_RDONLY)) < 0)
            {
                    fprintf(stderr, "Error opening /dev/iio:device0\n");
                    return -1;
            }
            samples = read(fd, data, sizeof(data))/sizeof(struct sensors);
            close(fd);

            // Calculate mean
            sum = 0;
            for(i = 0; i < samples; i++)
            {
                    data[i].a0 = bswap_16(data[i].a0);
                    sum += data[i].a0;
            }
            meanVoltage = ((float)sum/(float)samples)*scale;
            fprintf(stderr, "Mean voltage: %.3f V\n", meanVoltage);

            // Determine angle
            // (0V = -90deg, 2.16V = +90) - 3.3V
            // (0V = -90deg, 3.29V = +90) - 5V
            if(meanVoltage >= 3.29){
                angle = 90;
            }
            else{
                angle = (meanVoltage/3.29)*180.0 - 90.0;
            }

            // Set servo angle based on mean voltage
            fprintf(stderr, "Angle: %d\n", angle);
            // setServoAngle(1, angle);
        }

        pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en", "0");
        pputs("/sys/bus/iio/devices/iio:device0/trigger/current_trigger","\n");

        return 1;
}

void printEveryChar(char* charArray, int size){

    int i;

    for(i = 0; i < size; i++){
        fprintf(stderr, "N. %d: %d (%c)\n", i, charArray[i], (char)charArray[i]);
    }
}
