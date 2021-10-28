FROM rocker/verse
RUN R -e "install.packages(\"tidyverse\")"
RUN R -e "install.packages(\"shiny\")"
