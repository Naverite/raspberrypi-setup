#!/bin/sh
sudo apt update -y
sudo apt upgrade -y
wget https://github.com/azlux/log2ram/archive/master.tar.gz -O log2ram.tar.gz
tar xf log2ram.tar.gz
cd /home/pi/log2ram-master
sudo ./install.sh
cd /home/pi/
sudo rm -rf log2ram-master/
rm log2ram.tar.gz
#sudo reboot
sudo systemctl daemon-reload
sudo systemctl enable log2ram
sudo systemctl restart log2ram

