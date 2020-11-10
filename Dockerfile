FROM rocker/shiny-verse

MAINTAINER Isaac Caruso <icaruso21@amherst.edu>

RUN R -e "install.packages(pkgs=c('shiny', 'tidyverse', 'rnoaa', 'plotly', 'lubridate', 'zoo', 'shinyWidgets', 'shinycssloaders', 'shinytoastr', 'mathjaxr', 'leaflet'), repos='https://cran.rstudio.com/')"

RUN apt-get update 

RUN apt-get install -y git

RUN cd /srv/shiny-server/ 
RUN git clone https://github.com/trenchproject/Climate-Change-Metabolism.git 

VOLUME /srv
