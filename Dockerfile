FROM rocker/verse
RUN R -e "install.packages(\"tidyverse\")"
RUN R -e "install.packages(\"shiny\")"
RUN R -e "install.packages(\"tinytex\")"
RUN R -e "tinytex::install_tinytex()"
RUN R -e "install.packages(\"devtools\")"
RUN R -e "install.packages(\"ggbiplot\")"