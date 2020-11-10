#!/bin/bash

# Parse command line args
while getopts p: flag
do
    case "${flag}" in
        p) passwd=${OPTARG};;
    esac
done

# Install, Build and Run Docker
echo "Updating ec2 instance and installing git"
sudo yum update -y
sudo yum install git -y

echo "Installing Docker" 
sudo amazon-linux-extras install docker
sudo service docker start 
sudo usermod -a -G docker ec2-user

echo "Setting up Docker
mkdir rstudio_container
cd ~/rstudio_container
sudo chmod 777 rstudio_container/

echo "Spinning up RStudio server"
sudo docker run -e PASSWORD=$passwd -d -p 8787:8787 -v /home/ec2-user/rstudio_docker/:/home/rstudio/rstudio_docker rocker/tidyverse
echo "RStudio server is now online, connect in a browser at my_public_ip:8787"
echo "Shared filesystem is located at /home/ec2-user/rstudio_docker/"

cd ~/
git pull https://github.com/trenchproject/Shiny-Docker-Server.git
cd Shiny-Docker-Server
docker build -t shiny-server .

cd /srv/shinyapps/
git pull https://github.com/trenchproject/Climate-Change-Metabolism.git
git pull https://github.com/icaruso21/Insect-Phenology-Forecaster.git
git pull https://github.com/trenchproject/RShiny_robomussels.git
git pull https://github.com/trenchproject/RShiny_Lizards.git
