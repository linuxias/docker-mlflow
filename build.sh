#!/bin/bash

# Install environment package
apt install -y software-properties-common build-essential zlib1g-dev libncurses5-dev \
			   libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
			   wget curl git python-is-python3 python3-distutils liblzma-dev \
			   libbz2-dev libsqlite3-dev

# Install database using by mlflow
#apt install -y postgresql postgresql-contrib postgresql-server-dev-all

# Install python 3.10.5
wget https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tar.xz
tar xvf Python-3.10.5.tar.xz
cd Python-3.10.5
./configure
make -j16
make install
ln -s /usr/local/bin/python3 /usr/bin/python

# Setup python virtual environment using pyenv + poetry
apt upgrade -y
git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
$PYENV_ROOT/plugins/python-build/install.sh
/usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT
#rm -rf $PYENV_ROOT
curl -sSL https://install.python-poetry.org | python -

# Setup mlflow virtual environment
export PATH="/root/.local/bin:$PATH"
poetry config virtualenvs.create false
apt remove -y python3-distro-info
poetry install
poetry add "mlflow==${mlflow_version}"
