# Base image https://hub.docker.com/u/rocker/
FROM rocker/r-base:latest

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libpoppler-cpp-dev \
    libgdal-dev \
    libproj-dev
    
RUN install2.r --error \
    remotes \
    rgdal \
    stringr \ 
    sp \
    raster \
    sf

RUN R -e "remotes::install_github('mikejohnson51/AOI')"
RUN R -e "remotes::install_github('mikejohnson51/climateR')"

## create directories
RUN mkdir -p /code
RUN mkdir -p /code/Forecasts/

#RUN mkdir -p /code/dat
# RUN mkdir -p /code/dat/species-overviews
# RUN mkdir -p /code/dat/npn_phenometrics

## copy files
COPY ./Forecasts/ /code/Forecasts/
COPY ./updates.R /code/updates.R
COPY ./LastDate /code/LastDate

#COPY /srv/shinyapps/Insect-Phenology-Forecaster/dat/ /dat/

RUN ls -la /code/*

## install R-packages
# RUN Rscript /code/updatePhenologyHeatmap.R

CMD Rscript /code/updates.R
