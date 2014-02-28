/*
 * This function read commands from standard input and execute them
 */

#include "apue.h"

#define BUFFSIZE    1024

int
main(int argc, char *argv[])
{
        char    buf[MAXLINE];
        pid_t   pid;
        int     status;

        printf("%% ");          /* printf requires %% to print % */
        while (fgets(buf, MAXLINE, stdin) != NULL) {
                if (buf[strlen(buf) - 1] == '\n')
                        buf[strlen(buf) - 1] = 0; /* replace new line with null */

                if ((pid = fork()) < 0) {
                        err_sys("fork error");
                } else if (pid == 0){ /* child */
                  execlp(buf, buf, (char *)0);
                  err_ret("couldn't execute %s", buf);
                  exit(127);
                }

                /* parent */
                if ((pid = waitpid(pid, &status, 0)) < 0)
                        err_sys("waitpid error");
                printf("%%");
        }

        exit(0);
}
