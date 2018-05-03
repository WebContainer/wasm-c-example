#include "mylib.h"

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    
    char buffer[1024] = {0};
    char *hello = "Hello from server";
      
    server_fd = socket(AF_INET, SOCK_STREAM, 0);
      
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons( 8080 );
    
    bind(server_fd, (struct sockaddr *)&address, addrlen);

    listen(server_fd, 3);

    int valread;
    while((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) > 0) {
        valread = read( new_socket , buffer, 1024);
        printf("%s\n", buffer);
        send(new_socket , hello , strlen(hello) , 0 );
        printf("Hello message sent\n");
    }

    return address.sin_port;
}
