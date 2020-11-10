#!/bin/bash

# Parse command line args
while getopts u:p: flag
do
    case "${flag}" in
        u) uname=${OPTARG};;
        p) passwd=${OPTARG};;
    esac
done

echo "Spinning up RStudio server"
sudo docker run -e PASSWORD=$passwd -e USER=$uname -d -p 8787:8787 -v /home/ec2-user/rstudio_shared/:/home/rstudio/rstudio_docker rocker/tidyverse
echo "RStudio server is now online, connect in a browser at my_public_ip:8787"
echo "Shared filesystem is located at /home/ec2-user/rstudio_docker/"

ls
if [ -d "~/R-Docker-Server" ]; then 
    git clone https://github.com/trenchproject/R-Docker-Server.git
fi

cd ~/R-Docker-Server
echo "Building RShiny server"
ls
docker build -t shiny-server .
echo "Running RShiny server"
sudo docker run -d -p 3838:3838 -v /srv/shinyapps/:/srv/shiny-server/ -v /srv/shinylog/:/var/log/shiny-server/ shiny-server

# Pull apps from github (TO ADD MORE APPS: add a git pull line below for any additional repositories)
cd /srv/shinyapps/
sudo git clone https://github.com/trenchproject/Climate-Change-Metabolism.git
sudo git clone https://github.com/icaruso21/Insect-Phenology-Forecaster.git
sudo git clone https://github.com/trenchproject/RShiny_robomussels.git
sudo git clone https://github.com/trenchproject/RShiny_Lizards.git
echo "The following apps have been pulled to the shiny server"
ls -l
echo "Debug logs are available at /srv/shinylog/"
echo "The following images are ready to be ran"
docker images 
echo "The following containers are currently running"
docker ps 
echo "more commands can be found using docker --help"

