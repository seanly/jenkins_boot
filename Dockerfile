FROM busybox
COPY ./jenkins_home /var/rancher/jenkins_home
COPY ./cpjenkins.sh /
RUN mkdir /var/jenkins_home
VOLUME /var/jenkins_home
CMD ["sh", "./cpjenkins.sh"]
