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


#include "libgalileo2.h"

#define VOLTAGE_RAW "/sys/bus/iio/devices/iio:device0/in_voltage0_raw"
#define VOLTAGE_SCALE "/sys/bus/iio/devices/iio:device0/in_voltage0_scale"
#define PWM_ENABLE "/sys/class/pwm/pwmchip0/pwm1/enable"
#define PWM_PERIOD "/sys/class/pwm/pwmchip0/device/pwm_period"
#define PWM_DUTYCYCLE "/sys/class/pwm/pwmchip0/pwm1/duty_cycle"
#define BUTTON "/sys/class/gpio/gpio13/value"

int main(){

    int fdVoltage, fd_duty_cycle, fd_period, fd_lcd, fd_button;
    int done, degAngle;
    char buffer[20];
    double scale, curVoltage, radAngle, storedRadAngle;

    // Initialize ADC0 as one-shot
    fdVoltage = open(VOLTAGE_RAW, O_RDONLY);

    if(fdVoltage < 0){
        printf("%s - Error reading file %s\n", __FUNCTION__, VOLTAGE_RAW);
        return -1;
    }
    if(pgets(buffer, sizeof(buffer), VOLTAGE_SCALE) < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, VOLTAGE_SCALE);
    }
    scale = atof(buffer)/1000.0;     // Scale used to convert voltage value to Volts

    // Initialize pwm1
    if(pputs(PWM_PERIOD,"20000000") < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, PWM_PERIOD);
        return -1;
    }
    if((fd_period = open(PWM_PERIOD, O_WRONLY)) < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, PWM_PERIOD);
        return -1;
    }
    if((fd_duty_cycle = open(PWM_DUTYCYCLE, O_WRONLY)) < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, PWM_DUTYCYCLE);
        return -1;
    }
    if(pputs(PWM_ENABLE, "1") < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, PWM_ENABLE);
        return -1;
    }

    // Initialize LCD
    if((fd_lcd = initLCD()) < 0){
        fprintf(stderr, "%s - Error initializing LCD\n", __FUNCTION__);
        return -1;
    }

    // Initialize button (gpio13)
    if((fd_button = open(BUTTON, O_RDONLY)) < 0){
        fprintf(stderr, "%s - Error opening %s\n", __FUNCTION__, BUTTON);
        return -1;
    }

    done = 0;
    storedRadAngle = 0;
    while(!done){
        // Read voltage from ADC0
        lseek(fdVoltage, 0, SEEK_SET);
        read(fdVoltage, buffer, sizeof(buffer));
        curVoltage = atof(buffer)*scale;

        // Determine angle based on voltage
        // (0V = -90deg, 2.16V = +90) - 3.3V
        // (0V = -90deg, 3.29V = +90) - 5V
        if(curVoltage >= 3.29){
            degAngle = 90;
        }
        else{
            degAngle = (curVoltage/3.29)*180.0 - 90.0;
        }

        // Set servo angle based on mean voltage
        setServoAngle(fd_duty_cycle, fd_period, degAngle);
        radAngle = (float) degAngle * M_PI/180.0;
        fprintf(stderr, "Angle: %.2f rad -- Stored angle: %.2f\n", radAngle, storedRadAngle);

        // Write servo position to LCD
        snprintf(buffer, sizeof(buffer), "%d degrees  ", degAngle);
        writeLCD(fd_lcd, 1, buffer, strlen(buffer));
        snprintf(buffer, sizeof(buffer), "%.2f radians  ", radAngle);
        writeLCD(fd_lcd, 2, buffer, strlen(buffer));

        // Check for button activation
        if(readButton(fd_button)){
            // Button activated
            storedRadAngle = radAngle;
        }

        // Change backlight according to current angle
        if(storedRadAngle >= 0){
            if(radAngle >= storedRadAngle-storedRadAngle*0.1 && radAngle <= storedRadAngle+storedRadAngle*0.1){
                // Within 10% -> green backlight
                setLCDBacklight(fd_lcd, 0, 255, 0);
            }
            else if(radAngle > (storedRadAngle+storedRadAngle*0.1)){
                // Above 10% -> red backlight
                setLCDBacklight(fd_lcd, 255, 0, 0);
            }
            else if(radAngle < (storedRadAngle-storedRadAngle*0.1)){
                // Under 10% -> yellow backlight
                setLCDBacklight(fd_lcd, 255, 255, 0);
            }
        }
        else{
            if(radAngle <= storedRadAngle-storedRadAngle*0.1 && radAngle >= storedRadAngle+storedRadAngle*0.1){
                // Within 10% -> green backlight
                setLCDBacklight(fd_lcd, 0, 255, 0);
            }
            else if(radAngle > (storedRadAngle+storedRadAngle*0.1)){
                // Above 10% -> red backlight
                setLCDBacklight(fd_lcd, 255, 0, 0);
            }
            else if(radAngle < (storedRadAngle-storedRadAngle*0.1)){
                // Under 10% -> yellow backlight
                setLCDBacklight(fd_lcd, 255, 255, 0);
            }
        }
    }

    // Disable PWM1
    if(pputs(PWM_ENABLE, "0") < 0){
        fprintf(stderr, "%s - Error accessing %s\n", __FUNCTION__, PWM_ENABLE);
        return -1;
    }

    close(fd_duty_cycle);
    close(fdVoltage);
    close(fd_lcd);
    close(fd_button);

    return 1;
}
