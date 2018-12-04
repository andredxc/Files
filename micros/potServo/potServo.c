#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <libgalileo2.h>
/*
    Operates the position of a servo according to the voltage read from potentiometer

    Servo - PWM1 (D3)
    Potentiometer - ADC A0 (A0)
*/

#define ADC_VOLTAGE "/sys/bus/iio/devices/iio:device0/in_voltage0_raw"
#define MAX_RAW_VOLTAGE 2728
#define MAX_SERVO_ANGLES 160
#define ANGLE_DEADZONE 2

int main(){

    int fdVoltage, angle, flag_done=0, newAngle;
    char buffer[20];
    double ratio;

    fdVoltage = open(ADC_VOLTAGE, O_RDONLY);

    if(fdVoltage < 0){
        printf("Error reading file %s\n", ADC_VOLTAGE);
        return -1;
    }


    angle = 0;
    newAngle = 0;
    while(!flag_done){
        // Reed ratio from potentiometer
        lseek(fdVoltage, 0, SEEK_SET);
        read(fdVoltage, buffer, sizeof(buffer));
        ratio = atof(buffer)/MAX_RAW_VOLTAGE;

        // Apply ratio to servo angle
        newAngle = ratio*MAX_SERVO_ANGLES - MAX_SERVO_ANGLES/2; // Returns a number between -MAX_SERVO_ANGLES/2 and +MAX_SERVO_ANGLES/2
        if(newAngle >= angle+ANGLE_DEADZONE || newAngle <= angle-ANGLE_DEADZONE){
            // Applies deadzone to angle variation
            angle = newAngle;
            if(angle > 90){
                angle = 0;
            }
            else if(angle < -90){
                angle = -90;
            }
            if(setServoAngle(1, angle) < 1){
                flag_done = 1;
            }
        }
        fprintf(stderr, "Anggle: %d\n", angle);
    }

    close(fdVoltage);
    return 1;
}
