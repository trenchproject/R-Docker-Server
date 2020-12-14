#!/bin/bash

# Install, Build and Run Docker
echo "###   Updating ec2 instance and installing git"
sudo yum update -y
sudo yum install git -y

echo "###   Installing R on EC2 Instance"
sudo amazon-linux-extras enable R4
sudo yum install R -y

echo "###   Installing R packages for cron updates on EC2 Instance"
sudo amazon-linux-extras install epel -y
sudo yum install udunits2-devel -y
sudo yum install openssl-devel -y
sudo yum install libcurl-devel -y
sudo yum install libxml2-devel -y
sudo yum install libjpeg-turbo-devel -y
#sudo yum install gdal-devel -y
sudo yum install gdal* expat* proj* -y
echo "### Adding necessary C packages for R libraries (https://gist.github.com/abelcallejo/e75eb93d73db6f163b076d0232fc7d7e)" 



sudo R -e "install.packages(c('remotes', 'rgdal', 'tidyverse', 'mosaic', 'latticeExtra', 'leaflet', 'lubridate', 'sp', 'raster', 'stringr', 'sf'), repos='http://cran.us.r-project.org')"
sudo R -e "remotes::install_github('mikejohnson51/AOI')"
sudo R -e "remotes::install_github('mikejohnson51/climateR')"

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
