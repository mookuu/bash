#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int
main(int argc, char *argv[])
{
        fprintf(stderr, "%s\n", strerror(EACCES)); /* man strerror */
        errno = ENOENT;
        perror(argv[0]);        /* man perror */

        exit(0);                /* stdlib.h */
}
