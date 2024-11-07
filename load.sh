#!/bin/bash

# 定义配置文件数组
config_files=(".gitconfig" ".vimrc" ".zshrc" ".tmux.conf")

# 显示菜单函数
show_menu() {
    echo "请选择要替换的配置文件:"
    echo "0) 替换所有配置文件"
    for i in "${!config_files[@]}"; do
        echo "$((i+1))) ${config_files[$i]}"
    done
    echo "q) 退出"
}

# 替换单个配置文件函数
replace_config() {
    local file=$1
    if [ -f "$file" ]; then
        cp "$file" "$HOME/$file"
        echo "已替换 $file 到 $HOME/$file"
    else
        echo "错误: $file 不存在"
    fi
}

# 替换所有配置文件函数
replace_all_configs() {
    for file in "${config_files[@]}"; do
        replace_config "$file"
    done
}

# 主循环
while true; do
    show_menu
    read -p "请输入选项: " choice
    
    case $choice in
        0)
            replace_all_configs
            break
            ;;
        [1-9])
            if [ $choice -le ${#config_files[@]} ]; then
                replace_config "${config_files[$((choice-1))]}"
                break
            else
                echo "无效选项"
            fi
            ;;
        q|Q)
            echo "退出程序"
            exit 0
            ;;
        *)
            echo "无效选项"
            ;;
    esac
done

