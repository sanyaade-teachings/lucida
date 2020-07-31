#!/bin/bash

#export JAVA_VERSION=11.0.8
export JAVA_VERSION=8.0.8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8

#echo oracle-java$JAVA_VERSION-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#  add-apt-repository -y ppa:webupd8team/java && \
#  apt-get update && \
#  apt-get install -y oracle-java$JAVA_VERSION-installer && \
#  rm -rf /var/lib/apt/lists/* && \
#  rm -rf /var/cache/oracle-jdk$JAVA_VERSION-installer

sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt-get update
# sudo apt install openjdk-11-jdk
# or problems with openjdk-11-jdk then install openjdk-8-jdk
sudo apt install openjdk-8-jdk

