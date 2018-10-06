#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <libgalileo2.h>

char* pgets(char* string, int size, const char* path){

    int fd;

    fd = open(path, O_RDONLY);

    if(fd < 0){
        return NULL;
    }

    if(read(fd, string, size) < 0) {
        return NULL;
    }

    return string;
}
