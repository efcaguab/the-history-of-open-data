#!/bin/bash

apt-get update && apt-get install -y
sudo apt-get install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
sudo apt-get install python-minimal -y
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
git clone https://github.com/efcaguab/open_data_history.git
