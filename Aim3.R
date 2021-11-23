source("utils.R")
library(tidyverse)
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

# 3. Aim 3: Examine social determinants of health in relation to COVID-19 cases. 
# Aim 3 -------------------------------------------------------------------

# What social determinants are associated with neighborhoods with higher covid rates?
# 1 - collapse neighborhoods
# 2- plot neighborhoods with covid data and SDOH data 
# (leave out ones that are missing/mis-matched)

# Info how to map in NY counties with this: https://rpubs.com/jhofman/nycmaps
ny_counties <- map_data("county", "new york") %>% 
  select(lon = long, lat, group, id = subregion)
head(ny_counties)

ggplot(ny_counties, aes(lon, lat, group = group)) +
  geom_polygon(fill = "white", colour = "grey50") + 
  coord_quickmap()


r <- GET('http://data.beta.nyc//dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson')
nyc_neighborhoods <- readOGR(content(r,'text'), 'OGRGeoJSON', verbose = F)
