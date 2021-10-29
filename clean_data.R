library(tidyverse);
source("utils.R");

rawdata <- read.csv("source_data/NYC_Housing_Data.csv");

# Creat data by boros
onlyboros <- rawdata %>% 
  select(-sub_boro_names)

collapsed <- 
  onlyboros %>%
  group_by(boro_names) %>%
  summarize_all(mean);
collapsed

#Exploratory: Just looking at Brooklyn-based sub-boros
aggregate(poverty_rate ~ boro_names, data = rawdata, mean)

just_brooklyn <- filter(rawdata, boro_names=="Brooklyn");

just_brooklyn %>%
  group_by(unemployment) %>%
  tally() %>%
  arrange(n);

v_unemployed <- filter(just_brooklyn, unemployment>0.1)

# Just making target of collapsed data by boro
ensure_directory("clean_data")
write_csv(collapsed, "clean_data/clean_data.csv")
