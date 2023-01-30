FROM jenkins/jenkins

USER root

RUN apt install python3 \
    && python3 -m pip install ansible

USER jenkins
