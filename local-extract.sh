#!/bin/bash

# 本地解压测试脚本
# 使用方法: ./local-extract.sh

echo "=== 本地压缩包解压测试 ==="

# 检查必要的工具
echo "检查解压工具..."

if ! command -v unzip &> /dev/null; then
    echo "错误: 未安装 unzip，请先安装: brew install unzip"
    exit 1
fi

if ! command -v tar &> /dev/null; then
    echo "错误: 未安装 tar"
    exit 1
fi

# 在 macOS 上安装其他工具
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v unrar &> /dev/null; then
        echo "提示: 要解压 RAR 文件，请安装: brew install unrar"
    fi
    
    if ! command -v 7z &> /dev/null; then
        echo "提示: 要解压 7Z 文件，请安装: brew install p7zip"
    fi
fi

echo "工具检查完成，开始解压..."

# 运行解压脚本
chmod +x extract-scripts.sh
./extract-scripts.sh

echo "=== 解压测试完成 ==="
