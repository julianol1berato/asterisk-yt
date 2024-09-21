#!/bin/bash

apt install mpg123 sox libjsonld-perl libjson-perl libio-socket-ip-perl libio-socket-ssl-perl libio-socket-timeout-perl perl flac libencode-perl libfile-temp-perl libfile-path-perl libdigest-md5-perl
cpan LWP::UserAgent && cpan JSON

apt install python3
apt install pip3
pip3 install groq elevenlabs --break-system-packages

apt install python3.11-venv
python3 -m venv myenv
source myenv/bin/activate
