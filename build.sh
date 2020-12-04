#!/bin/bash

# Install, Build and Run Docker
echo "###   Updating ec2 instance and installing git"
sudo yum update -y
sudo yum install git -y

echo "###   Installing Docker" 
sudo amazon-linux-extras install docker -y
sudo service docker start 
sudo usermod -a -G docker ec2-user

echo "###   Setting up Docker"

sudo mkdir /srv/shinyapps
sudo mkdir /srv/shinylog
sudo mkdir /etc/nginx
sudo mkdir /etc/nginx/certs

sudo chmod 777 /srv/shinyapps/
sudo chmod 777 /srv/shinylog/
sudo chmod 777 /etc/nginx/
sudo chmod 777 /etc/nginx/certs/


#docker login -u $duser -p $dpass
sudo groupadd docker
sudo usermod -aG docker $USER

echo "###   Exit and rejoin SSH session to finish installation!"
