#!/bin/bash

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir data
cd data
mkdir nginx
cd ..
cp ./R-Docker-Server/app.conf ./data/nginx/
cp ./R-Docker-Server/docker-compose.yml ./data/nginx/
cp ./R-Docker-Server/init-letsencrypt.sh ./data/nginx/
cd ./data/nginx/

# Change for relative path
chmod +x init-letsencrypt.sh
sudo ./init-letsencrypt.sh

# Run NGINX and Let's Encrypt
docker-compose up
