# asterisk-yt
Git dedicado as aulas do YT.

[![Canal Youtube @analistabash](https://www.bashtech.com.br/youtube_button_icon_151827_96x.png)](https://www.youtube.com/@analistabash)


- [DUMP Database](sql/dump-mysql.sql)


## Aula 1:
- Customização Terminal - **terminal_custom.sh** - [Revisão instalação customização terminal](terminal_custom.sh)
- Aula 1 - **install.sh** - Instalação do Asterisk 20 LTS - [Instalação do Asterisk 20 LTS via script](install.sh)
## Aula 2 
- [Revisão instalação customização terminal](terminal_custom.sh)<br /> 
curl -L https://ln.bashtech.com.br/setup-terminal.sh | bash
- [Revisão instalação do Asterisk 20 LTS via script](install.sh)<br /> 
###### Instalação Asterisk - Material Extra
> curl -fsSL https://github.com/julianol1berato/asterisk-yt/releases/download/filesconfig/asterisk.tar -o asterisk.tar && \\
> tar xvf asterisk.tar

**-> config**<br /> 
/etc/odbc.ini<br /> 
/etc/odbcinst.ini<br /> 
/etc/asterisk/res_odbc.conf<br /> 
/etc/asterisk/res_pgsql.conf<br /> 
/etc/asterisk/sorcery.conf<br /> 
/etc/asterisk/extconfig.conf<br /> 
/etc/asterisk/cdr.conf<br /> 
/etc/asterisk/cdr_adaptive_odbc.conf<br /> 
/etc/asterisk/cel_odbc.conf<br /> 
/etc/asterisk/cel.conf<br /> 
/etc/asterisk/cel_pgsql.conf<br /> 

- [Limpeza de arquivos não usados no Asterisk](cleanfiles-asterisk.sh)<br />  
curl -L https://ln.bashtech.com.br/clean-asterisk.sh | bash
- [Instalação do MySql e bibliotecas para utilizar com o Asterisk](setup-mysqlasterisk.sh)<br /> 
curl -L https://ln.bashtech.com.br/setup-mysqlasterisk.sh | bash
###### MySQL - Material Extra
vim /usr/src/asterisk/contrib/ast-db-manage/config.ini<br /> 
/usr/bin/mysql_secure_installation<br /> 
mysql -u root <br /> 
CREATE USER 'asterisk'@'localhost' IDENTIFIED BY '123456';<br /> 
CREATE DATABASE asterisk;<br /> 
GRANT ALL privileges on asterisk.* to 'asterisk'@'localhost' identified by '123456';<br /> 
FLUSH privileges;<br /> 

alembic -c config.ini upgrade head

show databases;<br /> 
use asterisk;<br /> 
show tables;<br /> 

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

