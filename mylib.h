#define AF_INET		2	/* Internet IP Protocol 	*/
#define SOCK_STREAM	1		/* stream (connection) socket	*/
#define INADDR_ANY	((unsigned long int) 0x00000000)

#define socklen_t int

struct sockaddr {
	unsigned short	sa_family;	/* address family, AF_xxx	*/
	char		sa_data[14];	/* 14 bytes of protocol address	*/
};

struct in_addr {
    unsigned long s_addr;          // load with inet_pton()
};

struct sockaddr_in {
    short            sin_family;   // e.g. AF_INET, AF_INET6
    unsigned short   sin_port;     // e.g. htons(3490)
    struct in_addr   sin_addr;     // see struct in_addr, below
    char             sin_zero[8];  // zero this if you want to
};

int socket(int, int, int);
unsigned short htons(int);
int bind(int socket, const struct sockaddr *address, socklen_t address_len);
int listen(int, int);
int accept(int, struct sockaddr *, socklen_t *);
int read(int fd, void *buf, int count);
int printf(const char *, ...);
int send(int, const void *, int, int);
unsigned int strlen(const char *);
