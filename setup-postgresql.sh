#!/bin/bash

postgresql-client postgresql-contrib postgresql-server-dev-13 postgresql unixodbc-dev unixodbc 


su - postgres
createuser -P -d -D asterisk
createdb asterisk
\q   = sair

/etc/postgresql/13/main/pg_hba.conf
local all asterisk trust
systemctl restart postgresql@13-main.service
GRANT ALL ON TABLE queue_table TO asterisk;




cd contrib/ast-db-manage
mv config.ini.sample config.ini


apt install python3-pip
pip install alembic
pip install psycopg2-binary

pip install mysql-connector-python

apt install python3-pymysql/stable python3-mysqldb/stable
pip install mysqlclient
pip install "importlib_metadata==1.5.2"
pip install "zipp==1.2.0"
pip install "configparser==3.8.1"

mysql -u root 
/usr/bin/mysql_secure_installation
CREATE USER 'asterisk'@'%' IDENTIFIED BY '123456';
CREATE DATABASE asterisk;
GRANT ALL privileges on asterisk.* to 'asterisk'@'localhost' identified by '123456';
FLUSH privileges;

alembic -c config.ini upgrade head

##check tables
use asterisk;
show tables;

##testar conexão --- isql DSN [UID [PWD]] [options]
isql asterisk asterisk 123456


