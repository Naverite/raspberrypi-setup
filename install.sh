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
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-armv7.tar.gz
tar -xvzf node_exporter-1.7.0.linux-armv7.tar.gz
sudo cp node_exporter-1.7.0.linux-armv7/node_exporter /usr/local/bin
sudo chmod +x /usr/local/bin/node_exporter
sudo useradd -m -s /bin/bash node_exporter
sudo mkdir /var/lib/node_exporter
sudo chown -R node_exporter:node_exporter /var/lib/node_exporter
sudo echo "[Unit]
Description=Node Exporter

[Service]
# Provide a text file location for https://github.com/fahlke/raspberrypi_exporter data with the
# --collector.textfile.directory parameter.
ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory /var/lib/node_exporter/textfile_collector

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload 
sudo systemctl enable node_exporter.service
sudo systemctl restart node_exporter.service

