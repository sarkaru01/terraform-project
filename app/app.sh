#!/bin/sh
sudo apt-get update -y
sudo apt install -y apache2
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to My Web-VM  - VM Hostname: $(hostname)" > /var/www/html/index.html