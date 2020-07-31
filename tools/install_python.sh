#!/bin/bash
if [ ! -d Python-3.8.5 ]; then
  wget -c http://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz && tar -zxvf Python-3.8.5.tgz
  if [ $? -ne 0 ]; then
    echo "Could not download Python!!! Please try again later..."
    exit 1
  fi
fi
mkdir -p localpython3_8_5
cd Python-3.8.5
./configure --prefix="$(pwd)"/../localpython3_8_5
make
make install
cd ../
virtualenv python_3_8_5 -p localpython3_8_5/bin/python3.8
source python_3_8_5/bin/activate
pip3 install --upgrade distribute
pip3 install --upgrade pip
pip3 install -r python_requirements.txt
source python_3_8_5/bin/activate
deactivate
