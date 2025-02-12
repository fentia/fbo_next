# FBO NEXT
### 介绍
一个重新开启小米焕新存储(FBO)的Magisk模块，该模块会在每次开机120s后启动FBO，并且会在每天凌晨00:30再次启动FBO。

### 测试环境
__手机型号:__ XIAOMI 13  
__系统版本:__ 2.0.100.0  
理论支持 __Hyper OS 1.0__ 和 __Hyper OS 2.0__ 

### 使用方法
下载Releases中的压缩包后，在Magisk中刷入即可
![images](imgs/demo.jpg)

### 部分疑问
##### 1.如何修改开机后的等待时间？
修改```service.sh```的第5行代码```sleep 120s```
##### 2.如何修改定时任务？
修改```cron\crontabs\root```中的```30 0 * * *```，相关语法可以看[crond定时任务](https://blog.csdn.net/qq_22172133/article/details/81263736)