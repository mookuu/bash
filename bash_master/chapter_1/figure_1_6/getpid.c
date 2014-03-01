#include "apue.h"

int
main(int argc, char *argv[])
{
        /* get the process ID of the calling process */
        printf("the calling process id: %d\n", getpid());

        exit(0);
}
