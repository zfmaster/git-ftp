FROM ubuntu:18.04
MAINTAINER ZF Master <office@zfmaster.com>

# install git and git-ftp
RUN apt-get -y update && apt-get -y install git git-ftp && apt-get clean