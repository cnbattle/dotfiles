#!/bin/bash

echo "hi cnbattle."
sudo echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
sudo yes | sudo pacman -Syyu -y
sudo yes | sudo pacman -S git vim docker go

# Docker
sudo systemctl enable docker && sudo systemctl start docker

sudo echo {\"registry-mirrors\": [\"https://n3kgoynn.mirror.aliyuncs.com\"] } >  /etc/docker/daemon.json
sudo systemctl daemon-reload && sudo systemctl restart docker

# Golang
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
# go env -w GOPROXY=https://proxy.golang.com.cn,direct
# go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct

echo "success."