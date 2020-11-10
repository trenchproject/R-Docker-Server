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
sudo amazon-linux-extras install docker -y
sudo service docker start 
sudo usermod -a -G docker ec2-user

echo "Setting up Docker"
cd ~/
mkdir rstudio_shared
sudo chmod 777 ./rstudio_shared/

echo "Spinning up RStudio server"
sudo docker run -e PASSWORD=$passwd -d -p 8787:8787 -v /home/ec2-user/rstudio_shared/:/home/rstudio/rstudio_docker rocker/tidyverse
echo "RStudio server is now online, connect in a browser at my_public_ip:8787"
echo "Shared filesystem is located at /home/ec2-user/rstudio_docker/"

if [ -d "~/R-Docker-Server" ] 
then
    echo "R-Docker-Server has been cloned " 
else
    echo "Warning: R-Docker-Server does not exist where expected, attempting to pull."
    git clone https://github.com/trenchproject/R-Docker-Server.git
fi

cd R-Docker-Server
echo "Building RShiny server"
docker build -t shiny-server .
echo "Running RShiny server"
sudo docker run -d -p 80:3838 -v /srv/shinyapps/:/srv/shiny-server/ -v /srv/shinylog/:/var/log/shiny-server/ shiny-server

# Pull apps from github (TO ADD MORE APPS: add a git pull line below for any additional repositories)
cd /srv/shinyapps/
git clone https://github.com/trenchproject/Climate-Change-Metabolism.git
git clone https://github.com/icaruso21/Insect-Phenology-Forecaster.git
git clone https://github.com/trenchproject/RShiny_robomussels.git
git clone https://github.com/trenchproject/RShiny_Lizards.git
echo "The following apps have been pulled to the shiny server"
ls -l
echo "Debug logs are available at /srv/shinylog/"
echo "The following images are ready to be ran"
docker images 
echo "The following containers are currently running"
docker ps 
echo "more commands can be found using docker --help"

