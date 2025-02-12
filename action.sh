#!/system/bin/sh

# 检查FBO状态
function check_fbo {
    # 获取并输出与FBO相关的系统属性
    echo -e "getprop | grep fbo 命令执行结果:"
    getprop | grep fbo
    echo ""
    
    # 检查FBO是否已启用
    local fbo_enabled=$(getprop persist.sys.stability.miui_fbo_enable)
    local fbo_ctrl=$(getprop persist.sys.fboservice.ctrl)

    if [[ "$fbo_enabled" == "true" && "$fbo_ctrl" == "true" ]]; then
        echo -e "[Y]FBO启用成功"
        return 0
    else
        echo -e "[N]FBO启用失败"
        return 1
    fi
}

# 启用FBO并检查FBO状态
function enable_and_check_fbo {
    echo "尝试启用FBO…"
    echo ""
    
    # 尝试启用FBO
    setprop persist.sys.stability.miui_fbo_enable true
    setprop persist.sys.fboservice.ctrl true
    
    # 检查FBO状态
    check_fbo
}

# 监听按键事件
function key_events {
    while :; do
        # 获取最新的按键事件，最多只获取 1 个事件
        event_info=$(getevent -qlc 1)

        # 检查按键事件
        case "$event_info" in
            *KEY_VOLUMEUP*) 
                echo "0"  # 音量调高按键
                break
                ;;
            *KEY_VOLUMEDOWN*) 
                echo "1"  # 音量调低按键
                break
                ;;
            *)
                continue
                ;;
        esac
    done
}

echo "—————————————————————————————————————"
echo "按音量键 ＋:  检测FBO是否开启"
echo "按音量键 －:  启动FBO并检测状态"
echo "—————————————————————————————————————"

# 根据按键选择执行操作
user_choice=$(key_events)

if [[ "$user_choice" == "0" ]]; then
    check_fbo
fi

if [[ "$user_choice" == "1" ]]; then
    enable_and_check_fbo
fi