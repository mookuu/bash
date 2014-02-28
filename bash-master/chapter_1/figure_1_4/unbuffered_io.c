#include "apue.h"

#define BUFFSIZE    1024

int
main(int argc, char *argv[])
{
        int    n;
        int    buf[BUFFSIZE];

        /*
         * read from the standard input and write to the standard output,
         * using Unbuffered I/O
         */
        while ((n = read(STDIN_FILENO, buf, BUFFSIZE)) > 0)
                if (write(STDOUT_FILENO, buf, n) != n)
                        err_sys("write error");
        if (n < 0)
                err_sys("read error");

        exit(0);
}
