#!/bin/bash

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir data
cd data
mkdir nginx
mkdir certbot
cd ..
cp ./R-Docker-Server/app.conf ./data/nginx/
cp ./R-Docker-Server/docker-compose.yml ./data/nginx/
cp ./R-Docker-Server/init-letsencrypt.sh ./data/nginx/

# Change for relative path
chmod +x ./data/nginx/init-letsencrypt.sh
sudo ./data/nginx/init-letsencrypt.sh

# Run NGINX and Let's Encrypt
cd R-Docker-Server
docker-compose up 
