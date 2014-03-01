#include <stdio.h>
#include <stdlib.h>

int
main(int argc, char *argv[])
{
        fprintf(stdout, "uid = %d, pid = %d \n", getuid(), getpid()); /* man strerror */

        exit(0);                /* stdlib.h */
}
