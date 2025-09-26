#!/bin/bash

# 压缩包解压脚本
# 支持多种压缩格式：zip, tar.gz, tar, rar, 7z

set -e  # 遇到错误时退出

# 创建解压目录
EXTRACT_DIR="extracted"
mkdir -p "$EXTRACT_DIR"

echo "开始扫描压缩包文件..."

# 计数器
extracted_count=0

# 解压 ZIP 文件
echo "处理 ZIP 文件..."
for file in $(find . -name "*.zip" -type f); do
    echo "解压: $file"
    unzip -o "$file" -d "$EXTRACT_DIR/$(basename "$file" .zip)/"
    ((extracted_count++))
done

# 解压 TAR.GZ 文件
echo "处理 TAR.GZ 文件..."
for file in $(find . -name "*.tar.gz" -type f); do
    echo "解压: $file"
    mkdir -p "$EXTRACT_DIR/$(basename "$file" .tar.gz)/"
    tar -xzf "$file" -C "$EXTRACT_DIR/$(basename "$file" .tar.gz)/"
    ((extracted_count++))
done

# 解压 TAR 文件
echo "处理 TAR 文件..."
for file in $(find . -name "*.tar" -type f); do
    echo "解压: $file"
    mkdir -p "$EXTRACT_DIR/$(basename "$file" .tar)/"
    tar -xf "$file" -C "$EXTRACT_DIR/$(basename "$file" .tar)/"
    ((extracted_count++))
done

# 解压 RAR 文件 (需要安装 unrar)
echo "处理 RAR 文件..."
if command -v unrar &> /dev/null; then
    for file in $(find . -name "*.rar" -type f); do
        echo "解压: $file"
        mkdir -p "$EXTRACT_DIR/$(basename "$file" .rar)/"
        unrar x "$file" "$EXTRACT_DIR/$(basename "$file" .rar)/"
        ((extracted_count++))
    done
else
    echo "警告: 未安装 unrar，跳过 RAR 文件"
fi

# 解压 7Z 文件 (需要安装 p7zip)
echo "处理 7Z 文件..."
if command -v 7z &> /dev/null; then
    for file in $(find . -name "*.7z" -type f); do
        echo "解压: $file"
        mkdir -p "$EXTRACT_DIR/$(basename "$file" .7z)/"
        7z x "$file" -o"$EXTRACT_DIR/$(basename "$file" .7z)/"
        ((extracted_count++))
    done
else
    echo "警告: 未安装 p7zip，跳过 7Z 文件"
fi

# 显示结果
echo "=========================================="
echo "解压完成！"
echo "共处理了 $extracted_count 个压缩包"

if [ -d "$EXTRACT_DIR" ] && [ "$(ls -A $EXTRACT_DIR)" ]; then
    echo "解压后的文件结构："
    tree "$EXTRACT_DIR" || ls -la "$EXTRACT_DIR"
else
    echo "未找到任何压缩包文件"
fi

echo "=========================================="
