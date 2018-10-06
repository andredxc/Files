#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <libgalileo2.h>

int pputs(const char *path, const char *string){

    int fd;
    int n;

    fd = open(path, O_WRONLY);

    if(fd < 0){
        return -1;
    }

    n = write(fd, string, strlen(string));
    close(fd);
    return n;
}
