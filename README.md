# Repositório das Aulas de Asterisk do YouTube - @AnalistaBash
> Git dedicado as aulas do YouTube.

[![Canal Youtube @analistabash](https://www.bashtech.com.br/youtube_button_icon_151827_96x.png)](https://www.youtube.com/@analistabash)


- [DUMP Database](sql/dump-mysql.sql)


## Aula 1:
- Customização Terminal - **terminal_custom.sh** - [Revisão instalação customização terminal](terminal_custom.sh)
- Aula 1 - **install.sh** - Instalação do Asterisk 20 LTS - [Instalação do Asterisk 20 LTS via script](install.sh)
## Aula 2 
- [Revisão instalação customização terminal](terminal_custom.sh)<br /> 
``` curl -L https://ln.bashtech.com.br/setup-terminal.sh | bash ```
- [Revisão instalação do Asterisk 20 LTS via script](install.sh)<br /> 
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
```
- [Limpeza de arquivos não usados no Asterisk](cleanfiles-asterisk.sh)<br />  
``` curl -L https://ln.bashtech.com.br/clean-asterisk.sh | bash ```
- [Instalação do MySql e bibliotecas para utilizar com o Asterisk](setup-mysqlasterisk.sh)<br /> 
``` curl -L https://ln.bashtech.com.br/setup-mysqlasterisk.sh | bash ```
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
- Testar comunicação de ramal e operadora (tronco)
- Montar dialplan para teste com gravação do audio
- Criar URA de três níveis
- Criar fila de atendimento
- Apresentar relatórios CEL, CDR e QUEUE_LOG no banco.

*Video:* [![Canal Youtube @analistabash](https://www.bashtech.com.br/youtube_button_icon_151827_96x.png)](https://www.youtube.com/watch?v=2otkd-7HGk0&list=PLk0v4L7lcjDfcKUxIDybvuKTgDuaR31Kn)

