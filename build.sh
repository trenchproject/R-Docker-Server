#!/bin/bash

# Parse command line args
while getopts u:p: flag
do
    case "${flag}" in
        u) uname=${OPTARG};;
        p) passwd=${OPTARG};;
    esac
done

# Install, Build and Run Docker
echo "Updating ec2 instance and installing git"
sudo yum update -y
sudo yum install git -y

echo "Installing Docker" 
sudo amazon-linux-extras install docker -y
sudo service docker start 
sudo usermod -a -G docker ec2-user

echo "Setting up Docker"
cd ~/
mkdir rstudio_shared
sudo chmod 777 ./rstudio_shared/
#docker login -u $duser -p $dpass
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Exiting SSH session to finish installation"
exit
