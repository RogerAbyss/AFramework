#!/bin/sh
# 🚀 安装项目依赖环境

#
# Check if XCode Command Line Tools are installed
#
which -s xcode-select
if [[ $? != 0 ]] ; then
	echo "Installing XCode Command Line Tools"
	# Install XCode Command Line Tools
	xcode-select --install
else
	echo "XCode Command Line Tools already installed"
fi

#
# Check if Homebrew is installed
#
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
	echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already installed"
fi

#
# Check if python is installed
#
if [ ! -e $(python -c 'from distutils.sysconfig import get_makefile_filename as m; print m()') ]; then
	# Install python
	echo "Installing python"
	brew install python
else
	echo "python already installed"
fi

if [ ! -d /usr/local/Cellar/imagemagick ] ; then
	echo "installing imagemagick"
	brew install imagemagick
else
	echo "imagemagick already installed"
fi

#
# Check if Carthage is installed
#
which -s carthage
if [[ $? != 0 ]] ; then
    # Install Carthage
    echo "Installing Carthage"
    brew install carthage
else
	echo "Carthage already installed"
fi

#
# Check if Node is installed
#
which -s node
if [[ $? != 0 ]] ; then
    # Install Node
    echo "Installing Node.js"
    brew install node
else
	echo "Node.js already installed"
fi

#
# Check if fastlane is installed
#
which -s fastlane
if [[ $? != 0 ]] ; then
    # Install fastlane
	echo "Installing fastlane."
    gem install fastlane
    fastlane init
else
	echo "fastlane already installed"
fi

#
# Check if xcodegen is installed
#
which -s xcodegen
if [[ $? != 0 ]] ; then
    # Install xcodegen
	echo "Installing xcodegen."
    brew install xcodegen
else
	echo "xcodegen already installed"
fi

#
# Check if cocoapods is installed
#
which -s pod
if [[ $? != 0 ]] ; then
    # Install cocoapods
	echo "Installing cocoapods."
    gem install cocoapods
else
	echo "cocoapods already installed"
fi