File test parameter
===================

### -u

* set-user-id (suid) flag set on file

A binary owned by root with set-user-id flag set runs with root privileges, even when an ordinary user invokes it. [2] This is useful for executables (such as pppd and cdrecord) that need to access system hardware. Lacking the suid flag, these binaries could not be invoked by a non-root user.

              -rwsr-xr-t    1 root       178236 Oct  2  2000 /usr/sbin/pppd

A file with the suid flag set shows an s in its permissions.

### -k

* sticky bit set

Commonly known as the sticky bit, the save-text-mode flag is a special type of file permission. If a file has this flag set, that file will be kept in cache memory, for quicker access. [3] If set on a directory, it restricts write permission. Setting the sticky bit adds a t to the permissions on the file or directory listing. This restricts altering or deleting specific files in that directory to the owner of those files.

              drwxrwxrwt    7 root         1024 May 19 21:26 tmp/

If a user does not own a directory that has the sticky bit set, but has write permission in that directory, she can only delete those files that she owns in it. This keeps users from inadvertently overwriting or deleting each other's files in a publicly accessible directory, such as /tmp. (The owner of the directory or root can, of course, delete or rename files there.)
