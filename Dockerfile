FROM alpine:3.3

COPY ./jenkins_home /var/rancher/jenkins_home
COPY ./cpjenkins.sh /

COPY ./jenkins2.sh /usr/share/jenkins/rancher/jenkins.sh
COPY ./plugins.txt /usr/share/jenkins/rancher/plugins.txt

RUN mkdir /var/jenkins_home
VOLUME /usr/share/jenkins/rancher
VOLUME /var/jenkins_home

CMD ["sh", "./cpjenkins.sh"]
