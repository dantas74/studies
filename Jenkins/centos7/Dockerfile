FROM centos:7

RUN yum update -y  \
    && yum install -y openssh-server \
    && useradd remote-user

WORKDIR /home/remote-user

COPY remote-key.pub ./.ssh/authorized_keys

RUN chmod 700 ./.ssh \
    && chown -R remote-user:remote-user ./.ssh \
    && chmod 600 ./.ssh/authorized_keys \
    && /usr/sbin/sshd-keygen

CMD [ "/usr/sbin/sshd", "-D" ]
