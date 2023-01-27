FROM centos:7

RUN yum update -y  \
    && yum install -y openssh-server mysql python3 \
    && useradd remote-user

WORKDIR /home/remote-user

COPY remote-key.pub ./.ssh/authorized_keys
COPY --chmod=755 scripts/backup-db-remote-host.sh /opt/scripts/backup-db.sh

RUN chmod 700 ./.ssh \
    && chown -R remote-user:remote-user ./.ssh \
    && chmod 600 ./.ssh/authorized_keys \
    && /usr/sbin/sshd-keygen \
    && python3 -m pip install awscli --upgrade

CMD [ "/usr/sbin/sshd", "-D" ]
