#include "mylib.h"

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

void trace(int);
void uppercase(char * str);

int testOpenReadClose(char * arg) {
    printf("testOpenReadClose\n");

    int fd = open(arg, O_RDONLY);

    if (fd < 0) {
        print("OPEN FAIL");
        return 1;
    }

    char buf[200];

    int size = read(fd, buf, 200);

    printf("Got %d bytes\n", size);

    if (size < 0) {
        print("READ FAIL");
        return 2;
    }

    buf[size] = '\0';

    printf("%s\n", buf);

    close(fd);

    return 0;
}

void printfTypes() {
    printf("char: %c\n", 'a');

    printf("unsigned int: %u\n", 123123U);
    printf("unsigned long: %lu\n", 123123UL);

    printf("int: %d\n", 123);
    printf("long: %ld\n", 1223424343L);
    printf("long: %lld\n", 24234323LL);
    
    printf("float: %f\n", 123.234f);
    printf("double: %f\n", 123.234);
    printf("long double: %Lf\n", 123412341.2341234L);

    printf("hex: %x\n", 255);

    printf("string: %s\n", "Hello World");
}

void testFork() {
    // none of this works

    int pid = fork();
    if (pid < 0) {
        print("FORK FAILED");
        return;
    }

    if (pid > 0) {
        print("CHILD");

        exit(0);
    } else {
        print("PARENT");
    }
}

PLEASE_KEEP_THIS_METHOD
int main(int argc, char ** argv) {
    testOpenReadClose(argv[1]);
    printfTypes();
    testFork();

    return 0;
}
