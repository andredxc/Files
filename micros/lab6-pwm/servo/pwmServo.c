#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include "libgalileo2.h"

#define PWM_SERVO_DUTYCYCLE "/sys/class/pwm/pwmchip0/pwm1/duty_cycle"
// #define PWM_LED_DUTYCYCLE "/dev/stdout"
#define PWM_SERVO_ENABLE "/sys/class/pwm/pwmchip0/pwm1/enable"
#define PWM_PERIOD "/sys/class/pwm/pwmchip0/device/pwm_period"



int main(int argc, char** argv){

    int count, fdServo, intBuffer, endLoop;
    char buffer[20];

    // 20ms -> 20*10^6 ns -> 20 000 000
    pputs(PWM_PERIOD, "20000000");

    fdServo = open(PWM_SERVO_DUTYCYCLE, O_WRONLY);
    if(fdServo < 0){
        printf("Error opening %s\n", PWM_SERVO_DUTYCYCLE);
        return -1;
    }

    lseek(fdServo, 0, SEEK_SET);
    write(fdServo, "0", 2);
    pputs(PWM_SERVO_ENABLE, "1");

    count = 0;
    endLoop = 0;
    while(!endLoop){

        // Reads current duty_cycle
        read(fdServo, &buffer, sizeof(buffer));
        count = atoi(buffer);

        // Prints current duty_cycle in micro seconds
        printf("\nPWM duty cycle at %f us\nIncrement by (us): ", (float)count/1000);
        scanf("%d", &intBuffer);

        if(intBuffer == -1){
            // End program
            endLoop = 1;
        }
        else{
            // Change PWM duty cycle
            count += intBuffer*1000;
            if(count > 20000000){
                // Exceeds limit at a 20ms period
                count = 20000000;
            }
            snprintf(buffer, sizeof(buffer), "%d\n", count);
            lseek(fdServo, 0, SEEK_SET);
            write(fdServo, buffer, strlen(buffer));
        }
    }

    pputs(PWM_SERVO_ENABLE, "0");
    close(fdServo);
    return 0;
}
