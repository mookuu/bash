#include "apue.h"

#define BUFFSIZE    1024

int
main(int argc, char *argv[])
{
        int    c;

        /* copy standard input to standard output, using standard I/O */
        while ((c = getc(stdin)) != EOF)
                if (putc(c, stdout) == EOF)
                        err_sys("output error");

        if (ferror(stdin) != 0)
                err_sys("input error");

        exit(0);
}
