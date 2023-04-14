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
echo "PS1='\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \'[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\')[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]'" >> ~/.bashrc
