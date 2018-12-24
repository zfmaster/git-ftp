FROM ubuntu:18.04
MAINTAINER ZF Master <office@zfmaster.com>

# install git and git-ftp
RUN apt-get -y update 
RUN apt-get -y install git git-ftp libssh-dev build-essential libssh2-1-dev wget ansible
RUN apt-get clean
WORKDIR /opt 
RUN ls
RUN wget http://curl.haxx.se/download/curl-7.59.0.tar.gz
RUN tar -xzf curl-7.59.0.tar.gz
WORKDIR curl-7.59.0
RUN ./configure --with-ssl --with-libssh2=/usr/local --disable-shared
RUN make
RUN make install
WORKDIR ~
RUN ansible-galaxy install ansistrano.deploy ansistrano.rollback
