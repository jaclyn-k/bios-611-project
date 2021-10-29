NYC Housing Data Analysis
==========================
Welcome to my term project for BIOS 611. In this project, I am exploring social determinants of health variables from an NYC Housing dataset broken down by boro and sub-boro. Here are the steps to get started working with this project: 

1. Visit the terminal and build the docker container:

```
docker build . -t nychousing
```

2. Initialize an Rstudio session by visiting the terminal and running this code:

```
docker run -e PASSWORD=yourpassword \
  -v $(pwd):/home/rstudio/work\
  -p 8787:8787 --rm\
  nychousing
```
3. Access the Rstudio session by going to http://localhost:8787 in any internet browser. Log in with user `rstudio` and password `yourpassword`. Enter the following code to set the working directory:

```
setwd("~/work")
```

4. To build the final report, type into your terminal:
```
make report.pdf
```

Explanation of Components of the project
=========================

Shiny Visualization:
The Shiny visualization will allow you to explore a simple histogram of median rent price data and control how many bins are in the histogram with the slider.

To view this visualization, you can open the file 'R_Shiny.R' and run the full code. The Shiny viz should automatically launch. 

References
----------
Data courtesy of ted8080 via kaggle. Original dataset available here:
https://www.kaggle.com/ted8080/nyc-housing-dataset-extrinsic-factors

