FROM rocker/shiny-verse

MAINTAINER Isaac Caruso <icaruso21@amherst.edu>

RUN R -e "install.packages(pkgs=c('shiny', 'tidyverse', 'rnoaa', 'plotly', 'lubridate', 'zoo', 'shinyWidgets', 'shinycssloaders', 'shinytoastr', 'mathjaxr', 'leaflet', 'mosaic', 'taxize', 'raster', 'rasterVis', 'hash', 'rgdal', 'shinyalert', 'shinyglide', 'cicerone'), repos='https://cran.rstudio.com/')" 
RUN R -e "install.packages(pkgs=c('aws.s3', 'reshape2', 'tidyr', 'ggplot2', 'pdftools', 'ggridges', 'magrittr', 'shinyBS', 'data.table', 'shinyjs', 'shinysky', 'shinythemes', 'shinyWidgets', 'maps'), repos='https://cran.rstudio.com/')"

RUN R -e "devtools::install_github("ColinFay/glouton")"
RUN R -e "devtools::install_github("carlganz/shinyCleave")"
RUN R -e "devtools::install_github("dreamRs/shinypop")"
RUN R -e "devtools::install_github("JohnCoene/shinyscroll")"
RUN R -e "devtools::install_github("mikejohnson51/AOI")"
RUN R -e "devtools::install_github("mikejohnson51/climateR")"
