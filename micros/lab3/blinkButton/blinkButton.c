#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define BUTTON_FILE_NAME "/sys/class/gpio/gpio13/value"
#define LED_FILE_NAME "/sys/class/gpio/gpio62/value"

int main(){

    int fdButton, fdLed;
    char buffer;

    fdButton = open(BUTTON_FILE_NAME, O_RDONLY);
    fdLed = open(LED_FILE_NAME, O_WRONLY);

    if(fdButton < 0 || fdLed < 0){
        printf("Unable to open files");
        return -1;
    }

    while(1){
        lseek(fdButton, 0, SEEK_SET);
        read(fdButton, &buffer, sizeof(buffer));

        lseek(fdLed, 0, SEEK_SET);
        write(fdLed, &buffer, sizeof(buffer));
    }

    close(fdButton);
    close(fdLed);
    return 0;
}
