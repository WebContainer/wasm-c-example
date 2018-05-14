#include "mylib.h"

#include <fcntl.h>
#include <unistd.h>
#include <string.h>

void uppercase(char * str);

PLEASE_KEEP_THIS_METHOD
int main(int argc, char ** argv) {
    print(argv[1]);

    int fd = open(argv[1], O_RDONLY);

    if (fd < 0) {
        print("OPEN FAIL");
        return 1;
    }

    char buf[200];

    int size = read(fd, buf, 200);

    if (size < 0) {
        print("READ FAIL");
        return 2;
    }

    buf[size] = '\0';

    print(buf);

    uppercase(buf);

    print(buf);

    close(fd);

    return 0;
}
