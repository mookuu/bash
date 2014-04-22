#!/bin/bash

＃sudo fdisk /dev/sdb    /*进入fdisk命令操作空间*/

 

＃Command (m for help): m     /*命令查看*/

Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition                                               /*删除分区*/
   l   list known partition types
   m   print this menu
   n   add a new partition                                           /*增加分区*/ 
   o   create a new empty DOS partition table
   p   print the partition table                                     /*输出分区表*/
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit                              /*写分区表，在对盘操作完需要此步才能生效*/
   x   extra functionality (experts only)

 

＃Command (m for help): p

Disk /dev/sdb: 2055 MB, 2055208960 bytes
64 heads, 62 sectors/track, 1011 cylinders
Units = cylinders of 3968 * 512 = 2031616 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         133      263871+   6  FAT16
/dev/sdb2   *         134         200      132928   83  Linux          /*boot 分区*/

 

＃Command (m for help): d
＃Partition number (1-4): 1

Command (m for help): p

Disk /dev/sdb: 2055 MB, 2055208960 bytes
64 heads, 62 sectors/track, 1011 cylinders
Units = cylinders of 3968 * 512 = 2031616 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb2   *         134         200      132928   83  Linu

 

＃Command (m for help): d
Selected partition 2

＃Command (m for help): p                                           /*查看此时已无分区*/

Disk /dev/sdb: 2055 MB, 2055208960 bytes
64 heads, 62 sectors/track, 1011 cylinders
Units = cylinders of 3968 * 512 = 2031616 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System

＃Command (m for help): w                                      /*最后写入分区表*/
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table.
The new table will be used at the next reboot.
Syncing disks.

/*下边给磁盘增加一分区并格式化*/

＃ls /dev/sd*

＃/dev/sda  /dev/sda1  /dev/sda2  /dev/sdb

＃Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
＃p                                                                                                  /*增加主分区*/
＃Partition number (1-4): 1
＃First cylinder (1-1011, default 1):                                         /*回车默认*/
Using default value 1
＃Last cylinder, +cylinders or +size{K,M,G} (1-1011, default 1011):                       /*回车默认*/
Using default value 1011

＃Command (m for help): p                                            /*此时有sdb1分区*/

Disk /dev/sdb: 2055 MB, 2055208960 bytes
64 heads, 62 sectors/track, 1011 cylinders
Units = cylinders of 3968 * 512 = 2031616 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        1011     2005793   83  Linux

＃Command (m for help): w                                   /*最后写入分区表*/
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.

 

＃sudo mkfs.vfat -F 32 -n disk /dev/sdb1           /*格式化*/

