#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "libgalileo2.h"

#define PWM_SERVO_DUTYCYCLE "/sys/class/pwm/pwmchip0/pwm1/duty_cycle"
// #define PWM_LED_DUTYCYCLE "/dev/stdout"
#define PWM_SERVO_ENABLE "/sys/class/pwm/pwmchip0/pwm1/enable"
#define PWM_PERIOD "/sys/class/pwm/pwmchip0/device/pwm_period"

int main(){

    int count, fdServo;
    char buffer[20];

    // 20ms -> 20*10^6 ns -> 20 000 000
    pputs(PWM_PERIOD, "20000000");

    fdServo = open(PWM_SERVO_DUTYCYCLE, O_RDONLY);
    if(fdServo < 0){
        printf("Error opening %s\n", PWM_SERVO_DUTYCYCLE);
        return -1;
    }

    pputs(PWM_SERVO_ENABLE, "1");

    count = 0;
    while(1){

        snprintf(buffer, sizeof(buffer), "%d\n", (int)(count/100.0 * 1000000.0));
        pputs(PWM_LED_DUTYCYCLE, buffer);

        if(count == 100){
            count = 0;
        }
        else{
            count++;
        }
        usleep(70000);
    }

    pputs(PWM_LED_ENABLE, "0");
    close(fdServo);
    return 0;
}
