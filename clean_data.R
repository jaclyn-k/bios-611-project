library(tidyverse);
library(stringr);
source("utils.R");
library(devtools)

housing <- read.csv("source_data/NYC_Housing_Data.csv")
covid <- read.csv("source_data/covidcases_nov15.csv")
setwd("~/work")


# COVID Data Clean --------------------------------------------------------

covid <- covid %>%
  mutate_at("neighborhood", str_replace, "Bronx ", "") %>%
  mutate_at("neighborhood", str_replace, "Manhattan ", "") %>%
  mutate_at("neighborhood", str_replace, "Brooklyn ", "") %>%
  mutate_at("neighborhood", str_replace, "Queens ", "") %>%
  mutate_at("neighborhood", str_replace, "Staten Island ", "") %>%
  mutate_at("totalcases", str_replace, ",", "") %>%
  mutate_at("cases_per100k", str_replace, ",", "") %>%
  transform(totalcases = as.numeric(totalcases), 
            cases_per100k = as.numeric(cases_per100k)) %>%
  mutate_at("neighborhood", str_trim, side = "both")

covid_ag <- 
  aggregate(totalcases ~ neighborhood, data = covid, sum) %>%
  mutate(aggregate(cases_per100k ~ neighborhood, data = covid, sum))

# cleanstats <- rename(rawdata, neighborhood = sub_boro_names)
# write_csv(covid_ag, "clippedboro.csv")

# joined <- full_join(cleanstats, covid_ag, by = "neighborhood", copy=T,  suffix=c(".house",".cov")) 

# Targets -----------------------------------------------------------------

ensure_directory("clean_data")
write_csv(housing, "clean_data/clean_data.csv")
