#!/bin/bash

cd /srv/shinyapps/

#find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
ls | xargs -I{} sudo git -C {} pull
# Github Repositories (of shiny apps) to pull 
#sudo git pull https://github.com/trenchproject/Climate-Change-Metabolism.git
#sudo git pull https://github.com/icaruso21/Insect-Phenology-Forecaster.git
#sudo git pull https://github.com/trenchproject/RShiny_robomussels.git
#sudo git pull https://github.com/trenchproject/RShiny_Lizards.git
#sudo git pull https://github.com/trenchproject/RShiny_BiophysicalModelMap.git
#sudo git pull https://github.com/trenchproject/RShiny_PlantPhenology
aws s3 sync /srv/shinyapps/Insect-Phenology-Forecaster/dat/ s3://insect-phenology-map-shiny/ 

touch mario.txt
