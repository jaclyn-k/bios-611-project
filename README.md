NYC Housing Data Analysis
==========================

In order to run this project, first you must build the docker container:

```
docker build . -t nychousing
```

Start an Rstudio session in any browser by running this code in  terminal:

```
docker run -e PASSWORD=yourpassword \
  -v $(pwd):/home/rstudio/work\
  -p 8787:8787 --rm\
  nychousing
```
Go to http://localhost:8787 in your browser. Log in with user `rstudio` and password `yourpassword`.

Components of the project
=========================

Shiny Visualization:
The Shiny visualization will allow you to explore a simple histogram of median rent price data and control how many bins are in the histogram with the slider.

To view this visualization, you can open the file 'R_Shiny.R' and run the full code. The Shiny viz should automatically launch. 

