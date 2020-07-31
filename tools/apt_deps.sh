#!/bin/bash
## Installs all package manager dependencies
## FROM ubuntu:14.04 ##update below for ubuntu:18.04
## install latest python-dev(not 2.7.0)
## python-gobject-2 is removed in this script file

sudo add-apt-repository universe
sudo add-apt-repository main
apt-get update

ln -s -f bash /bin/sh
ln -s /usr/bin/pip3 /usr/local/bin/pip

apt-get install -y libblas3

apt install -y vim

apt install libc6

apt install -y zlib1g-dev \
                   libatlas3-base \
                   python-dev \
                   libatlas-base-dev \
                   liblapack3 \
                   liblapack-dev \
                   libblas-dev                   
                   
apt install -y     software-properties-common \
                   gfortran \
                   make \
                   ant \
                   gcc \
                   g++ \
                   wget \
                   automake \
                   git \
                   curl 

apt install -y     libboost-dev \
                   libboost-all-dev \
                   libevent-dev \
                   libdouble-conversion-dev \
                   libtool \
                   liblz4-dev \
                   liblzma-dev \
                   binutils-dev 

apt install -y     libjemalloc-dev \
                   pkg-config \
                   libtesseract-dev \
                   libopenblas-dev \
                   libblas-dev \
                   libatlas-base-dev \
                   libiberty-dev \
                   liblapack-dev \
                   cmake \
                   zip \
                   unzip \
                   sox \
                   libsox-dev \
                   autoconf \
                   autoconf-archive \
                   bison \
                   swig \
                   python-pip \
                   subversion \
                   libssl-dev \
                   libprotoc-dev \
                   supervisor \
                   flac \
                   gawk \
                   imagemagick \
                   libgflags-dev libgoogle-glog-dev liblmdb-dev \
                   libleveldb-dev libsnappy-dev libhdf5-serial-dev \
                   bc \
                   python-numpy \
                   flex \
                   libkrb5-dev \
                   libsasl2-dev \
                   libnuma-dev \
                   scons \
                   python-gi \
                   python-gobject \
                   memcached \
                   libyaml-dev \
                   libffi-dev \
                   libbz2-dev \
                   python-yaml \
&& pip install virtualenv ws4py
