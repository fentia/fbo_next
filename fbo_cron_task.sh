#!/system/bin/sh

MODDIR=${0%/*}

# 日志地址
log_file="$MODDIR/log.txt"

# 如果日志文件不存在，则创建它
if [ ! -f "$log_file" ]; then
    touch "$log_file"
    # 设置文件权限为可读写
    chmod 666 "$log_file"
fi

# 获取当前时间并写入日志
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "$current_time 尝试[定时]启动FBO..." >>  $log_file

# 启用 FBO
setprop persist.sys.stability.miui_fbo_enable true
setprop persist.sys.fboservice.ctrl true

# 检查FBO是否已启用并打印日志
fbo_enabled=$(getprop persist.sys.stability.miui_fbo_enable)
fbo_ctrl=$(getprop persist.sys.fboservice.ctrl)

if [[ "$fbo_enabled" == "true" && "$fbo_ctrl" == "true" ]]; then
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$current_time [Y] FBO启用成功" >>  $log_file
else
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$current_time [N] FBO启用失败" >>  $log_file
fi