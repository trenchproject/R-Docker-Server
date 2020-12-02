#!/bin/bash

cd ~/shinyapps/

# Github Repositories (of shiny apps) to pull 
sudo git pull https://github.com/trenchproject/Climate-Change-Metabolism.git
sudo git pull https://github.com/icaruso21/Insect-Phenology-Forecaster.git
sudo git pull https://github.com/trenchproject/RShiny_robomussels.git
sudo git pull https://github.com/trenchproject/RShiny_Lizards.git
sudo git pull https://github.com/trenchproject/RShiny_BiophysicalModelMap.git
sudo git pull https://github.com/trenchproject/RShiny_PlantPhenology

touch mario.txt
