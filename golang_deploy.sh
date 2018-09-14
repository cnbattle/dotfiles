#!/bin/bash

# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

cd $HOME
read -t 30 -p "请要安装的版本号:" version
golang_version=$version
golang_path="go$golang_version"
golang_file_name="go$golang_version.linux-amd64.tar.gz"

# file is not exist
if [ ! -f "$HOME/$golang_file_name" ];then
	golang_down_url="https://dl.google.com/go/$golang_file_name"
	wget $golang_down_url
fi

# file path is not exist
if [ ! -d "/usr/local/go" ];then
	tar -xzvf $golang_file_name -C /usr/local/
    rm -rf $golang_file_name
else
	echo "installed!"
	exit 1
fi

goroot="/usr/local/go"
gobin="$goroot/bin"
path="$PATH:$gobin"
gopath="$HOME/goPath"

echo "export GOROOT=${goroot}" >> /etc/profile
echo "export GOBIN=${gobin}" >>  /etc/profile
echo "export PATH=${path}" >>  /etc/profile
echo "export GOPATH=${gopath}" >>  /etc/profile
source /etc/profile
echo "End of execution...."
