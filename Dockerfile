FROM centos:latest
MAINTAINER Jonathan Mainguy <jon@soh.re>
RUN yum install -y git ruby rubygem-bundler && \
    yum clean all
RUN chmod 777 /opt
RUN mkdir -p /opt/statuscode
ADD . /opt/statuscode
WORKDIR /opt/statuscode
ENV HOME=/opt/statuscode
RUN gem install bundler
RUN bundle update --bundler
RUN bundler
EXPOSE 4567
USER 1337:1337
CMD ["ruby", "/opt/statuscode/app.rb"]
