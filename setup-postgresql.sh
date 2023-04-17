#!/bin/bash

postgresql-client postgresql-contrib postgresql-server-dev-13 postgresql unixodbc-dev unixodbc 

##
##su - postgres
##createuser -P -d -D asterisk
##createdb asterisk
##\q   = sair

##/etc/postgresql/13/main/pg_hba.conf
##local all asterisk trust
##systemctl restart postgresql@13-main.service
##GRANT ALL ON TABLE queue_table TO asterisk;

##cd contrib/ast-db-manage
##mv config.ini.sample config.ini
##vim contrib/ast-db-manage/config.ini
##alembic -c config.ini upgrade head