#!/bin/bash

version="0.1"
# 相关文件设置
soft="$HOME/soft" # /usr/local
goroot="$soft/go"
gobin="$goroot/bin"
path="$PATH:$gobin"
gopath="$HOME/goPath"
profile="$HOME/.profile"

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'

sys_bit=$(uname -m)
if [[ $sys_bit == "i386" || $sys_bit == "i686" ]]; then
	os_name="linux-386.tar.gz"
elif [[ $sys_bit == "x86_64" ]]; then
	os_name="linux-amd64.tar.gz"
else
	echo -e " 哈哈……这个 ${red}辣鸡脚本${none} 不支持你的系统:$sys_bit。 ${yellow}(-_-) ${none}" && exit 1
fi

# file path is not exist
if [ -d "$goroot" ];then
	local_install=true
fi

# 安装函数
install(){
	cd $HOME

	if [[ $local_install ]]; then
		echo -e "$yellow 温馨提示.. 本地已安装 ..$none"
		return
	else
		read -t 30 -p "请要安装的版本号:" version
		golang_version=$version
		golang_path="go$golang_version"
		golang_file_name="go$golang_version.$os_name"

		# file is not exist
		if [ ! -f "$HOME/$golang_file_name" ];then
			golang_down_url="https://dl.google.com/go/$golang_file_name"
			wget $golang_down_url
		fi
		
		# 判断目录是否存在
		if [ ! -d "$goroot" ];then
			mkdir -p $soft
		fi
		tar -xzvf $golang_file_name -C $soft
		echo "export GOROOT=${goroot}" >> $profile
		echo "export GOBIN=${gobin}" >>  $profile
		echo "export PATH=${path}" >>  $profile
		echo "export GOPATH=${gopath}" >>  $profile
		source $profile
		echo "\n${red}安装成功!${none}\n"
		return
	fi
}

# 卸载函数
uninstall(){
	if [ -d "$goroot" ];then
		rm -rf "$goroot"
		sed -i "export GOROOT=${goroot}" $profile
		sed -i '/GOROOT/'d $profile
		sed -i '/GOBIN/'d $profile
		sed -i '/GOPATH/'d $profile
		echo -e "\n$red 卸载成功！$none\n"
	else
		echo -e "\n$red 未安装$none\n"
	fi
}

error() {
	echo -e "\n$red 输入错误！$none\n"
}

main(){
	clear
	while :; do
	printf "
#######################################################################
#           Golang 一键安装/卸载脚本 & 支持32/64位Linux系统           #
#    作者:cnbattle 脚步地址：https://github.com/cnbattle/dotfiles     #
#######################################################################
"
		echo
		echo " 1. 安装"
		echo
		echo " 2. 卸载"
		echo
		echo "版本：$version"
		echo
		if [[ $local_install ]]; then
			echo -e "$yellow 温馨提示.. 本地已安装 ..$none"
			echo
		fi
		read -p "$(echo -e "请选择 [${magenta}1-2$none]:")" choose
		case $choose in
		1)
			install
			break
			;;
		2)
			uninstall
			break
			;;
		*)
			error
			;;
		esac
	done
}
main
