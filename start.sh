#!/usr/bin/env bash

# 如有 PASSWORD 变量，即修改 ssh root 的密码
/etc/init.d/sshd stop
[ -n "$PASSWORD" ] && echo root:"$PASSWORD" | chpasswd root && sed -i "s/^#\?PermitRootLogin.*/PermitRootLogin yes/g;s/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sleep 2
/etc/init.d/sshd restart

# 如有哪吒三个参数，则安装哪吒探针；如不全则不安装
[ -n "$NEZHA_SERVER" ] && [ -n "$NEZHA_PORT" ] && [ -n "$NEZHA_KEY" ] && wget https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh -O nezha.sh && chmod +x nezha.sh && ./nezha.sh install_agent $NEZHA_SERVER $NEZHA_PORT $NEZHA_KEY
