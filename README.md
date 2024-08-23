# Repositório das Aulas de Asterisk do YouTube - @9LEVEL_TI
> Git dedicado as aulas do YouTube.

[![Canal Youtube @analistabash](https://www.youtube.com/channel/UCR7T-wjzHUF6g78pUN-c6JQ/videos)


- [DUMP Database](sql/dump-mysql.sql)


## Aula 1:
- Customização Terminal - **terminal_custom.sh** - [Revisão instalação customização terminal](terminal_custom.sh)
- Aula 1 - **install.sh** - Instalação do Asterisk 20 LTS - [Instalação do Asterisk 20 LTS via script](install.sh)
## Aula 2 
- [Revisão instalação customização terminal](terminal_custom.sh)<br>
- [Revisão instalação do Asterisk 20 LTS via script](install.sh)<br>

###### Instalação Asterisk - Material Extra
``` cd /tmp/ && curl -fsSL https://github.com/julianol1berato/asterisk-yt/releases/download/filesconfig/asterisk.tar -o asterisk.tar && tar xvf asterisk.tar ```

**-> config**<br /> 
```
/etc/odbc.ini
/etc/odbcinst.ini
/etc/asterisk/res_odbc.conf
/etc/asterisk/res_pgsql.conf
/etc/asterisk/sorcery.conf
/etc/asterisk/extconfig.conf
/etc/asterisk/cdr.conf
/etc/asterisk/cdr_adaptive_odbc.conf
/etc/asterisk/cel_odbc.conf
/etc/asterisk/cel.conf
/etc/asterisk/cel_pgsql.conf
/etc/asterisk/pjsip.conf

```
- [Limpeza de arquivos não usados no Asterisk](cleanfiles-asterisk.sh)<br>
- [Instalação do MySql e bibliotecas para utilizar com o Asterisk](setup-mysqlasterisk.sh)<br>

###### MySQL - Material Extra
```
vim /usr/src/asterisk/contrib/ast-db-manage/config.ini
/usr/bin/mysql_secure_installation
mysql -u root
CREATE USER 'asterisk'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE asterisk;
GRANT ALL privileges on asterisk.* to 'asterisk'@'localhost' identified by '123456';
FLUSH privileges;

alembic -c config.ini upgrade head

show databases;
use asterisk;
show tables;
```

- [Download Release asterisk-configfiles.tar](https://github.com/julianol1berato/asterisk-yt/releases/tag/filesconfig)
## Aula 3
- Criação de Tronco no Asterisk
- Criar conta em operadora DID
- Montar dialplan para teste
- Criar URA
- Criar fila de atendimento

*Video:* [![Canal Youtube @analistabash](https://www.bashtech.com.br/youtube_button_icon_151827_96x.png)](https://www.youtube.com/watch?v=2otkd-7HGk0&list=PLk0v4L7lcjDfcKUxIDybvuKTgDuaR31Kn)

