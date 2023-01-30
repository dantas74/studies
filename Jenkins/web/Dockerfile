FROM centos:7

RUN yum update -y  \
    && yum install -y openssh-server mysql python3 \
    && useradd remote-user

WORKDIR /home/remote-user

COPY remote-key.pub ./.ssh/authorized_keys
COPY --chmod=755 scripts/backup-db-remote-host.sh /opt/scripts/backup-db.sh
COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo

RUN chmod 700 ./.ssh \
    && chown -R remote-user:remote-user ./.ssh \
    && chmod 600 ./.ssh/authorized_keys \
    && /usr/sbin/sshd-keygen \
    && python3 -m pip install awscli --upgrade \
    && yum install -y nginx-1.12.2 openssl --enablerepo=nginx \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y  \
    php71u-fpm \
    php71u-cli \
    php71u-mysqlnd \
    php71u-soap \
    php71u-xml \
    php71u-zip \
    php71u-json \
    php71u-mcrypt \
    php71u-mbstring \
    php71u-gd \
    --enablerepo=ius \
    && yum clean all

EXPOSE 80 443

VOLUME [ "/var/www/html", "/var/log/nginx", "/var/log/php-fpm", "/var/lib/php-fpm" ]

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY bin/start.sh /start.sh

CMD [ "/start.sh" ]
