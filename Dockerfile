FROM alpine:latest

WORKDIR /app

COPY start.sh .

RUN apk add --no-cache openssh-server openrc sed wget curl bash &&\
    sed -i 's/^#\?Port.*/Port 22/g;s/^#\?PermitRootLogin.*/PermitRootLogin yes/g;s/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config &&\
    rc-update add sshd &&\
    ssh-keygen -A &&\
    rc-status &&\
    touch /run/openrc/softlevel &&\
    chmod +x start.sh

ENTRYPOINT ./start.sh
