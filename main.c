#include "mylib.h"

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

void uppercase(char * str);

int testOpenReadClose(char * arg) {
    print("testOpenReadClose");

    int fd = open(arg, O_RDONLY);

    if (fd < 0) {
        print("OPEN FAIL");
        return 1;
    }

    char * buf = (char *) malloc(sizeof(char) * 200);

    int size = read(fd, buf, 200);

    if (size < 0) {
        print("READ FAIL");
        return 2;
    }

    buf[size] = '\0';

    printf("hi %d\n", 12);
    
    printf("HELLO AGAIN %d %d\n", 12, 100);

    uppercase(buf);

    write(1, "HI\n", 3);

    print(buf);

    close(fd);

    return 0;
}

void printFloat() {
    // THIS CURRENTLY EXPLODES
    // printf("%f", 1.2);
}

PLEASE_KEEP_THIS_METHOD
int main(int argc, char ** argv) {
    testOpenReadClose(argv[1]);
    printFloat();

    return 0;
}
