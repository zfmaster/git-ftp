FROM ubuntu:18.04
MAINTAINER ZF Master <office@zfmaster.com>

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install git and git-ftp
RUN apt-get -y update 
RUN apt-get -y install git git-ftp libssh-dev build-essential libssh2-1-dev wget ansible rsync unzip openjdk-8-jdk ant software-properties-common ca-certificates-java git

RUN apt-get clean
RUN update-ca-certificates -f

RUN apt-get -y install nodejs npm 

RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get -y install php5.6-cli
RUN apt-get clean

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install CURL
WORKDIR /opt 
RUN wget http://curl.haxx.se/download/curl-7.59.0.tar.gz
RUN tar -xzf curl-7.59.0.tar.gz
WORKDIR curl-7.59.0
RUN ./configure --with-ssl --with-libssh2=/usr/local --disable-shared
RUN make
RUN make install

WORKDIR ~
RUN ansible-galaxy install ansistrano.deploy ansistrano.rollback

# Install Sencha CMD
RUN wget http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN unzip SenchaCmd-6.7.0.63-linux-amd64.sh.zip 
RUN ./SenchaCmd-6.7.0.63-linux-amd64.sh -Dall=true -q -dir /opt/Sencha/Cmd/6.7.0
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh.zip SenchaCmd-6.7.0.63-linux-amd64.sh