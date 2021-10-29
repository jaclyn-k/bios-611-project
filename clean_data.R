library(tidyverse);
source("~/work/utils.R");

rawdata <- read.csv("~/work/NYC_Housing_Data.csv");

onlyboros <- rawdata %>% 
  select(-sub_boro_names)

collapsed <- 
  onlyboros %>%
  group_by(boro_names) %>%
  summarize_all(mean);
collapsed

aggregate(poverty_rate ~ boro_names, data = rawdata, mean)

just_brooklyn <- filter(rawdata, boro_names=="Brooklyn");

just_brooklyn %>%
  group_by(unemployment) %>%
  tally() %>%
  arrange(n);

v_unemployed <- filter(just_brooklyn, unemployment>0.1)

# ensure_directory("clean_data")
write_csv(collapsed, "clean_data.csv")
