FROM jenkins/jenkins

USER root

RUN apt update  \
    && apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    && python3 -m pip install ansible \
    && curl -fsSL https://download.docker.com/linux$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey \
    && apt-key add /tmp/dkey \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux$(. /etc/os-release; echo "$ID")/gpg \
    $(lsb_release -cs) \
    stable" \
    && apt install -y docker-ce \
    && usermod -aG docker jenkins \
    && curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

USER jenkins
