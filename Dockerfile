FROM centos:latest
MAINTAINER Jonathan Mainguy <jon@soh.re>
RUN yum install -y git ruby rubygem-bundler && \
    yum clean all
RUN chmod 777 /opt
USER 1337:1337
RUN mkdir -p /opt/statuscode
ADD . /opt/statuscode
WORKDIR /opt/statuscode
ENV HOME=/opt/statuscode
RUN bundler
EXPOSE 4567
CMD ["ruby", "/opt/statuscode/app.rb"]
