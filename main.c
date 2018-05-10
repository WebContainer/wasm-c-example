#include "mylib.h"

void hello(char * ret);

WASM_EXPORT
int main() {
    int fd = open("README.md");

    char buf[1000];

    char * hw;
    hello(hw);

    // Copy Hello into array
    int i = 0;
    while(hw[i++] != '\0') {
        buf[i] = hw[i];
    }

    int size = read(fd, buf, 1000);

    buf[size] = '\0';
    
    printf(buf);
}
