#!/bin/bash

apt-get update && apt-get install -y
sudo apt-get install python-minimal -y
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install Google-Search-API
git clone https://github.com/efcaguab/open_data_history.git
