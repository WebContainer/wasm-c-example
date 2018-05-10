#include "mylib.h"

PLEASE_KEEP_THIS_METHOD
void uppercase(char * str);

PLEASE_KEEP_THIS_METHOD
int main() {
    int fd = open("HELLOWORLD");

    if (fd <= 0) {
        return 1;
    }

    char buf[200];

    int size = read(fd, buf, 20);

    if (size <= 0) {
        return 2;
    }

    buf[size] = '\0';

    print(buf);

    uppercase(buf);

    print(buf);
}
