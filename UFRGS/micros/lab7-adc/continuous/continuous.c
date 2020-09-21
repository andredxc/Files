#include <byteswap.h>
#include <fcntl.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "libgalileo2.h"

#define DATA_POINTS 1000
#define SAMPLING_PERIOD 1e-3

/* Assumes the data format for Galileo Gen2 */
struct sensors
{
        uint16_t a0;		/* be:u12/16>>0 */
        uint16_t a1;		/* be:u12/16>>0 */
        uint16_t a2;		/* be:u12/16>>0 */
        uint16_t a3;		/* be:u12/16>>0 */
        int64_t timestamp;	/* le:s64/64>>0 */
};

int main(int argc,char * argv[])
{
        char data_str[80];
        double scale, meanVoltage;
        int fd;
        static struct sensors data[DATA_POINTS];
        int i;
        int samples;
        int angle, sum;

        pputs("/sys/bus/iio/devices/iio:device0/buffer/enable","0");

        // Scale for adc0
        pgets(data_str, sizeof(data_str), "/sys/bus/iio/devices/iio:device0/in_voltage0_scale");
        scale = atof(data_str)/1000.0;
        // Enable channel 0
        pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en", "1");
        // Enable timestamp
        pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en", "1");
        // Set buffer length
        snprintf(data_str, sizeof(data_str), "%d", DATA_POINTS);
        pputs("/sys/bus/iio/devices/iio:device0/buffer/length", data_str);
        // Enable trigger1
        pgets(data_str, sizeof(data_str), "/sys/bus/iio/devices/trigger1/name");
        pputs("/sys/bus/iio/devices/iio:device0/trigger/current_trigger", data_str);
        // Set sampling frequency
        snprintf(data_str,sizeof(data_str), "%d", (int)round(1.0/SAMPLING_PERIOD));
        pputs("/sys/bus/iio/devices/trigger1/frequency", data_str);

        // Start conversion
        pputs("/sys/bus/iio/devices/iio:device0/buffer/enable","1");
        sleep(ceil(DATA_POINTS*SAMPLING_PERIOD));
        pputs("/sys/bus/iio/devices/iio:device0/buffer/enable","0");
        pputs("/sys/bus/iio/devices/iio:device0/trigger/current_trigger","\n");

        if((fd = open("/dev/iio:device0", O_RDONLY)) < 0)
        {
                fprintf(stderr, "Error opening /dev/iio:device0\n");
                return -1;
        }

        samples = read(fd, data, sizeof(data))/sizeof(struct sensors);
        close(fd);

        pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en", "0");
        pputs("/sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en","0");

        sum = 0;
        for(i = 0; i < samples; i++)
        {
                data[i].a0 = bswap_16(data[i].a0);
                fprintf(stderr,"%f\t%f\n", data[i].a0*scale, (data[i].timestamp-data[0].timestamp)*1e-9);
                sum += data[i].a0;
        }

        meanVoltage = ((float)sum/(float)samples)*scale;
        fprintf(stderr, "Mean voltage: %.3f V\n", meanVoltage);

        // Determine angle
        // (0V = -90deg, 2.16V = +90) - 3.3V
        // (0V = -90deg, 3.29V = +90) - 5V
        if(meanVoltage > 3.29){
            angle = 90;
        }
        else{
            angle = (meanVoltage/3.29)*180.0 - 90.0;
        }

        // Set servo angle based on mean voltage
        // fprintf(stderr, "Angle: %d\n", angle);
        // setServoAngle(1, angle);

        return 0;
}
