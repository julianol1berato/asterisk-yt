#!/bin/bash 
#Ubuntu 24.04.1 LTS \n \l

apt install flac ffmpeg mpg123 sox libjsonld-perl libjson-perl libio-socket-ip-perl libio-socket-ssl-perl libio-socket-timeout-perl perl flac libencode-perl libfile-temp-perl libfile-path-perl libdigest-md5-perl


cpan LWP::UserAgent && cpan JSON

sudo apt-get install perl
sudo cpan install LWP::UserAgent
sudo cpan install JSON
sudo cpan install IO::Socket::SSL
sudo apt-get install flac

apt install python3
apt install pip
pip3 install groq elevenlabs --break-system-packages

apt install python3.12-venv
python3 -m venv myenv
source myenv/bin/activate
