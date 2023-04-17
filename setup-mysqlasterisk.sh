#!/bin/bash
##julianol1berato install mysql for asterisk20lts, auto-configure.

apt update
apt install -y unixodbc odbcinst mariadb-client mariadb-server odbc-mariadb
systemctl enable mariadb
systemctl start mariadb

apt install python3-pip -y
pip install alembic
pip install psycopg2-binary
pip install mysql-connector-python
apt install python3-pymysql/stable python3-mysqldb/stable -y
pip install mysqlclient
pip install "importlib_metadata==1.5.2"
pip install "zipp==1.2.0"
pip install "configparser==3.8.1"

cd /usr/src/asterisk/contrib/ast-db-manage
mv config.ini.sample config.ini