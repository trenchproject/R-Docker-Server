#!/bin/bash

# Parse command line args
while getopts p: flag
do
    case "${flag}" in
        p) passwd=${OPTARG};;
    esac
done

# Install, Build and Run Docker
echo "Updating ec2 instance"
sudo yum update

echo "Installing Docker" 
sudo amazon-linux-extras install docker
sudo service docker start 
sudo usermod -a -G docker ec2-user

echo "Setting up Docker
mkdir rstudio_container
cd rstudio_container
sudo chmod 777 rstudio_container/

echo "Spinning up RStudio server"
sudo docker run -e PASSWORD=$passwd -d -p 8787:8787 -v /home/ec2-user/rstudio_docker/:/home/rstudio/rstudio_docker rocker/tidyverse
echo "RStudio server is now online, connect in a browser at my_public_ip:8787"
echo "Shared filesystem is located at /home/ec2-user/rstudio_docker/"
