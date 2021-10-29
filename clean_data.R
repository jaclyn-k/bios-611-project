library(tidyverse);
rawdata <- read.csv("~/work/NYC_Housing_Data.csv");

count(rawdata, sub_boro_names)

boros <- rawdata %>% filter(c(boro_names)) %>% tibble()

boro_tables <- function(rawdata, boro){
  rawdata %>% filter(boro_names == boro)
}

count(rawdata, boro_names)

onlyboros <- rawdata %>% 
  select(-sub_boro_names)

collapsed <- 
  onlyboros %>%
  group_by(boro_names) %>%
  summarize_all(mean);
collapsed


c(col_names(rawdata) subway + disabled_population + public_housing

aggregate(poverty_rate ~ boro_names, data = rawdata, mean)

just_brooklyn <- filter(rawdata, boro_names=="Brooklyn");
table(just_brooklyn$unemployment);

just_brooklyn %>%
  group_by(unemployment) %>%
  tally() %>%
  arrange(n);

v_unemployed <- filter(just_brooklyn, unemployment>0.1)  
