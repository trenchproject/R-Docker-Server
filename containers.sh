#!/bin/bash

# Parse command line args
while getopts u:p: flag
do
    case "${flag}" in
        u) uname=${OPTARG};;
        p) passwd=${OPTARG};;
    esac
done
echo "###   Preparing reverse proxy, https, and certification for secure container deployment"
docker run --detach --name nginx-proxy --publish 80:80 --publish 443:443 --volume /etc/nginx/certs --volume /etc/nginx/vhost.d --volume /usr/share/nginx/html --volume /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
sudo docker run --detach --name nginx-proxy-letsencrypt --volumes-from nginx-proxy --volume /var/run/docker.sock:/var/run/docker.sock:ro --volume /etc/acme.sh --env "DEFAULT_EMAIL=icaruso21@amherst.edu" jrcs/letsencrypt-nginx-proxy-companion

echo "###   Creating shared volume"
#docker volume create --name RShared
#sudo mkdir /RShared


#cd ./R-Docker-Server/dat/
#docker build -t data .
#docker run --name r-data data true
#cd ..

#echo "###   Spinning up RStudio server"
#sudo docker run -e PASSWORD=$passwd -e USER=$uname -d -p 8787:8787 -v /home/ec2-user/rstudio_shared/:/home/rstudio/rstudio_docker rocker/tidyverse
sudo docker run  --name rstudio -e PASSWORD=$passwd -e USER=$uname -d --expose 8787 --env "VIRTUAL_HOST=studio.trenchproject.com" --env "VIRTUAL_PORT=8787" --env "LETSENCRYPT_HOST=studio.trenchproject.com" --env "LETSENCRYPT_EMAIL=icaruso21@amherst.edu" -v /srv/shinyapps/:/home/rstudio/shiny_apps/ rocker/tidyverse

echo "###   RStudio server is now online, connect in a browser at rstudio.trenchproject.com"
echo "Shared filesystem is located at /srv/shinyapps"

ls
if [ -d "~/R-Docker-Server" ]; then 
    git clone https://github.com/trenchproject/R-Docker-Server.git
fi

cd ~/R-Docker-Server
echo "###   Building RShiny server"
ls
docker build -t shiny-server .
echo "###   Running RShiny server"
#sudo docker run -d -p 3838:3838 -v /srv/shinyapps/:/srv/shiny-server/ -v /srv/shinylog/:/var/log/shiny-server/ shiny-server
sudo docker run --name shiny -d --expose 3838 --env "VIRTUAL_HOST=apps.trenchproject.com" --env "VIRTUAL_PORT=3838" --env "LETSENCRYPT_HOST=apps.trenchproject.com" --env "LETSENCRYPT_EMAIL=icaruso21@amherst.edu" -v /srv/shinyapps/:/srv/shiny-server/ -v /srv/shinylog/:/var/log/shiny-server/ shiny-server # --volumes-from r-data

# Pull apps from github (TO ADD MORE APPS: add a git pull line below for any additional repositories)
cd /srv/shinyapps/
sudo git clone https://github.com/trenchproject/Climate-Change-Metabolism.git
sudo git clone https://github.com/icaruso21/Insect-Phenology-Forecaster.git
sudo git clone https://github.com/trenchproject/RShiny_robomussels.git
sudo git clone https://github.com/trenchproject/RShiny_Lizards.git
sudo git clone https://github.com/trenchproject/RShiny_BiophysicalModelMap.git
sudo git clone https://github.com/trenchproject/RShiny_PlantPhenology
cd ~/

echo "###   The following apps have been pulled to the shiny server"
ls -l
echo "###   Debug logs are available at ~/shinylog/"
echo "###   The following images are ready to be ran"
docker images 
echo "###   The following containers are currently running"
docker ps 
echo "###    More commands can be found using docker --help"

sudo chmod +x /home/ec2-user/R-Docker-Server/*.sh
sudo cp /home/ec2-user/R-Docker-Server/refreshServer.sh /etc/cron.hourly/

