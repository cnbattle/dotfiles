#!/bin/bash

golang_version="1.10.2"

golang_path="go$golang_version"

golang_file_name="go$golang_version.linux-amd64.tar.gz"

golang_down_url="https://dl.google.com/go/$golang_file_name" 

wget $golang_down_url 

tar -xzvf $golang_file_name -C /usr/local/

goroot="export GOROOT=/usr/local/go"
gobin="export GOBIN=$goroot/bin"
path="export PATH=$PATH:$gobin"
gopath="export GOPATH=$HOME/goPath"

echo ${goroot} >> $HOME/.profile
echo ${gobin} >>  $HOME/.profile
echo ${path} >>  $HOME/.profile
echo ${gopath} >>  $HOME/.profile

sources $HOME/.profile
