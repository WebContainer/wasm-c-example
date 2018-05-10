#include "mylib.h"

void uppercase(char * str);

PLEASE_KEEP_THIS_METHOD
int main() {
    int fd = open("HELLOWORLD");

    if (fd <= 0) {
        return 1;
    }

    char buf[200];

    int size = read(fd, buf, 200);

    if (size <= 0) {
        return 2;
    }

    buf[size] = '\0';

    print(buf);

    uppercase(buf);

    print(buf);

    close(fd);

    return 0;
}
