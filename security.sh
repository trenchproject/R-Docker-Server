#!/bin/bash

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Change for relative path
chmod +x init-letsencrypt.sh
sudo ./init-letsencrypt.sh
