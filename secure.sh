#!/bin/bash

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
