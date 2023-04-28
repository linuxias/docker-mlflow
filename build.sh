#!/bin/bash

# Install environment package
apt install -y software-properties-common build-essential zlib1g-dev libncurses5-dev \
			   libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
			   wget curl git python3-distutils liblzma-dev \
			   libbz2-dev libsqlite3-dev python-is-python3

# Install database using by mlflow
apt install -y sqlite3 libsqlite3-dev

# Install python 3.10.5
wget https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tar.xz
tar xvf Python-3.10.5.tar.xz
cd Python-3.10.5
./configure
make -j16
make install
ln -s /usr/local/bin/python3 /usr/bin/python

# Install mlflow
pip3 install mlflow
