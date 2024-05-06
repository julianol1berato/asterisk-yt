#!/bin/bash

## ambiente de produção - juliano liberato

set -ueo pipefail

echo "Update System"
DEBIAN_FRONTEND=noninteractive \
apt-get update -qq


echo "installing postgres base"

apt-get install --yes -qq --no-install-recommends --no-install-suggests \
  postgresql-client \
  postgresql-contrib \
  postgresql-server-dev-15 \
  postgresql \
  unixodbc-dev unixodbc  \
> /dev/null

echo "Install packages"
DEBIAN_FRONTEND=noninteractive \
apt-get install --yes -qq --no-install-recommends --no-install-suggests \
  odbc-postgresql \
  aptitude \
  mpg123 \
  sox \
  make \
  gcc \
  g++ \
  unixodbc \
  unixodbc-dev \
  wget \
  iputils-ping \
  vim \
  autoconf \
  binutils-dev \
  build-essential \
  ca-certificates \
  curl \
  ffmpeg \
  figlet \
  automake \
  sudo \
  file \
  libcurl4-openssl-dev \
  libedit-dev \
  libgsm1-dev \
  libogg-dev \
  libpopt-dev \
  libresample1-dev \
  libspandsp-dev \
  libspeex-dev \
  libspeexdsp-dev \
  libsqlite3-dev \
  libsrtp2-dev \
  libssl-dev \
  libvorbis-dev \
  libxml2-dev \
  libxslt1-dev \
  lsof \
  tcpdump \
  iftop \
  odbcinst \
  portaudio19-dev \
  procps \
  unixodbc \
  unixodbc-dev \
  uuid \
  uuid-dev \
  xmlstarlet \
  bzip2 \
  subversion \
  git \
  cmake \
  libtool \
  libpcap-dev \
> /dev/null

apt-get purge --yes -qq --auto-remove > /dev/null
rm -rf /var/lib/apt/lists/*
mkdir -p /usr/src/asterisk
cd /usr/src/asterisk
curl -sL http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz | tar --strip-components 1 -xz
echo "Install source mp3"
./contrib/scripts/get_mp3_source.sh && \
contrib/scripts/install_prereq install && \
./configure --prefix=/usr --libdir=/usr/lib --with-pjproject-bundled --with-jansson-bundled --with-resample --with-ssl=ssl --with-srtp > /dev/null
: ${JOBS:=$(( $(nproc) + $(nproc) / 2 ))}

make menuselect/menuselect menuselect-tree menuselect.makeopts && \
  menuselect/menuselect \
    --enable-category MENUSELECT_ADDONS \
    --enable-category MENUSELECT_CHANNELS \
    --enable-category MENUSELECT_APPS \
    --enable-category MENUSELECT_CDR \
    --enable-category MENUSELECT_FORMATS \
    --enable-category MENUSELECT_FUNCS \
    --enable-category MENUSELECT_PBX \
    --enable-category MENUSELECT_RES \
    --enable-category MENUSELECT_CEL \
    --enable-category MENUSELECT_CORE_SOUNDS \
    --enable-category MENUSELECT_EXTRA_SOUNDS \
    --enable-category MENUSELECT_MOH \
&& \
menuselect/menuselect \
    --enable BETTER_BACKTRACES \
    --enable DONT_OPTIMIZE \
    --enable app_confbridge \
    --enable cdr_pgsql \
    --enable cel_pgsql \
    --enable res_config_pgsql \
    --enable app_macro \
    --enable app_page \
    --enable binaural_rendering_in_bridge_softmix \
    --enable chan_motif \
    --enable codec_silk \
    --enable codec_opus \
    --enable format_mp3 \
    --enable res_ari \
    --enable res_chan_stats \
    --enable res_calendar \
    --enable res_calendar_caldav \
    --enable res_calendar_icalendar \
    --enable res_endpoint_stats \
    --enable res_fax \
    --enable res_fax_spandsp \
    --enable res_pktccops \
    --enable res_snmp \
    --enable res_srtp \
    --enable res_xmpp \
    --disable BUILD_NATIVE \
    --disable app_meetme \
    --disable app_ivrdemo \
    --disable app_saycounted \
    --disable app_skel \
    --disable cdr_sqlite3_custom \
    --disable cel_sqlite3_custom \
    --disable cdr_tds \
    --disable cel_tds \
    --disable cdr_radius \
    --disable cel_radius \
    --disable chan_alsa \
    --disable chan_console \
    --disable chan_mgcp \
    --disable chan_skinny \
    --disable chan_ooh323 \
    --disable chan_mobile \
    --disable chan_unistim \
    --disable res_ari_mailboxes \
    --disable res_digium_phone \
    --disable res_calendar_ews \
    --disable res_calendar_exchange \
    --disable res_stasis_mailbox \
    --disable res_mwi_external \
    --disable res_mwi_external_ami \
    --disable res_config_mysql \
    --disable res_config_ldap \
    --disable res_config_sqlite3 \
    --disable res_phoneprov \
    --disable res_pjsip_phoneprov_provider
make -j ${JOBS} all > /dev/null || make -j ${JOBS} all
make install > /dev/null
make install-headers > /dev/null
make config > /dev/null
ldconfig
echo "---------- END build ----------" 

  cd /usr/src && \
  mkdir bcg729 && \
  curl -fSL --connect-timeout 30 https://github.com/BelledonneCommunications/bcg729/archive/1.1.1.tar.gz | tar xz --strip 1 -C bcg729 && \
  cd bcg729 && \
  cmake . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_PREFIX_PATH=/usr && \
  make && \
  make install && \
  ldconfig && \
  cd /usr/src && \
  mkdir asterisk-g72x && \
  curl -fSL --connect-timeout 30 https://bitbucket.org/arkadi/asterisk-g72x/get/master.tar.gz | tar xz --strip 1 -C asterisk-g72x && \
  cd asterisk-g72x && \
  ./autogen.sh && \
  ./configure --prefix=/usr --with-bcg729 --enable-penryn && \
  make && \
  make install && \
  ldconfig && \
  cd /usr/src && \
  mkdir sngrep && \
  curl -fSL --connect-timeout 30 https://github.com/irontec/sngrep/archive/v1.6.0.tar.gz | tar xz --strip 1 -C sngrep && \
  cd sngrep && \
  apt install libpcap0.8 libpcap0.8-dev libpcap-dev -y && \
  ./bootstrap.sh && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  ldconfig

sed -i -E 's/^;(run)(user|group)/\1\2/' /etc/asterisk/asterisk.conf

mkdir -p /usr/src/codecs/opus
cd /usr/src/codecs/opus
curl -sL http://downloads.digium.com/pub/telephony/codec_opus/asterisk-16.0/x86-64/codec_opus-16.0_current-x86_64.tar.gz | tar xz --strip 1 
cp *.so /usr/lib/asterisk/modules/
cp codec_opus_config-en_US.xml /var/lib/asterisk/documentation/

mkdir -p /etc/asterisk/ \
         /var/spool/asterisk/fax

sudo groupadd asterisk
sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
sudo usermod -aG audio,dialout asterisk
sudo chown -R asterisk.asterisk /etc/asterisk
sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
sudo chown -R asterisk.asterisk /usr/lib/asterisk
chmod -R 750 /var/spool/asterisk

cd /
rm -rf /usr/src/codecs

DEVPKGS="$(dpkg -l | grep '\-dev' | awk '{print $2}' | xargs)"
DEBIAN_FRONTEND=noninteractive apt-get --yes -qq purge \
  autoconf \
  build-essential \
  bzip2 \
  cpp \
  m4 \
  make \
  patch \
  perl \
  perl-modules \
  pkg-config \
  xz-utils \
  ${DEVPKGS} \
> /dev/null
rm -rf /var/lib/apt/lists/*
