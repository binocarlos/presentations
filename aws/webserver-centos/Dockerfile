FROM centos
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>
RUN yum install -y nc
ADD . /app
ENTRYPOINT ["bash", "/app/run.sh"]