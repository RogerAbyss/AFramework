#!/bin/sh
# 🚀 bootstrap
# 启动脚本
# 建议每次git pull/CI 的时候调用

# 第一次进入 检查安装环境
if [ "$1" == "--init" ]; then
    sh ./env.sh
    # bundle 安装依赖
    bundle install
    # carthage 下载开发证书
    bundle exec fastlane match enterprise --readonly
    # carthage 安装依赖
    carthage bootstrap $CARTHAGE_VERBOSE --platform ios --color auto --cache-builds
    # xcodegen 生成工程
    xcodegen
    # Xcode 10 系统错误日志
    xcrun simctl spawn booted log config --mode "level:off"  --subsystem com.apple.CoreTelephony
    # Xcode 10 统计编译时间
    defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES
fi

# 清除Carthage缓存
if [ "$1" == "--force" ]; then
    rm -rf Carthage/*
fi

# Xcode Server 会打印信息
CARTHAGE_VERBOSE=""
if [ ! -z "$XCS_BOT_ID"  ]; then
  CARTHAGE_VERBOSE="--verbose"
fi

# cocoapod 安装依赖
pod install --verbose --no-repo-update

# npm 安装依赖
# npm install
# npm run build
