#!/bin/bash
## julianol1berato - projects debian
## customizações de terminal e log

apt update && apt upgrade -y
apt install wget curl vim atop htop nmap whowatch mtr htop rsync acl locate rcconf ethtool screen lshw hdparm ttyrec tcpdump auditd sudo mpg123 sox make gcc g++ openssh-server libsox-fmt-base dialog unzip autoconf -y


echo 'HISTTIMEFORMAT="%d/%m/%Y - %T => "' >> ~/.bashrc
echo "HISTSIZE=50000" >> ~/.bashrc
echo "HISTFILESIZE=100000" >> ~/.bashrc
echo "shopt -s histappend" >> ~/.bashrc
echo "export HISTCONTROL=ignoredups:erasedups" >> ~/.bashrc
cp ~/.bashrc{,.orig}
echo "PS1='\[\033[00;32m\]┌─[\[\033[00;31m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00;32m\]]──[\[\033[01;33m\]\A\[\033[00;32m\]]──[\[\033[00m\]\w\[\033[00;32m\]]\n└─[\!]─>\$\[\033[00;32m\] '" >> ~/.bashrc
