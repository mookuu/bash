立刻关机：
sudo halt
sudo init 0 （我最常用的）
sudo shutdown -h now
sudo shutdown -h 0
....
定时/延时关机：
sudo shutdown -h 19:30
19:30关机
sudo shutdown -h +30
（延时30分钟关机）
.....
重启：
sudo reboot
sudo init 6 (我最常用，同上)
sudo shutdown -r now

其他：
休眠： sudo pm-hibernate
待机（10.04叫挂起）：
sudo pm-suspend
sudo pm-suspend-hybrid
省电模式： sudo pm-powersave
