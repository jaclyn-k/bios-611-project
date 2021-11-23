source("utils.R")
library(tidyverse)
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

setwd("~/work")

# Aim 2 -------------------------------------------------------------------
# Do neighborhoods with higher rates of people with disabilities 
# have less access to mobility? 

clean_data <- read.csv("clean_data/clean_data.csv")

access_factors <- clean_data %>%
  select(c("disabled_population",
           "subway",
           "park", 
           "car_free_commute",
           "mean_travel_time_to_work"))


access_exploratory <- access_factors  %>%
  gather(-disabled_population, key = "var", value = "value") %>%
  ggplot(
    aes(x = value, 
        y = disabled_population, 
    )) +
  geom_point() +
  stat_smooth() +
  facet_wrap(~ var, scales = "free") +
  labs(title = "Figure 2a: Exploratory Plot of Access Factors and % Disabled Population")

ggsave("figures/access_factors.png", access_exploratory)

#Places with more disabled populations don't have better access to transportation or parks. 

#PCA
access.pca <- prcomp(access_factors, center = TRUE, scale. = TRUE)
summary(access.pca)

access.pca.plot <-
  ggbiplot(access.pca, ellipse=TRUE, obs.scale = 1, var.scale = 1, groups = clean_data$boro_names) +
  ggtitle("Principal Component Analyses: Disabilities Access") +
  theme_minimal() +
  labs(title = "Figure 2b: PCA Plot of Access Factors, Grouped by Boro")

ggsave("figures/access_pca.png", access.pca.plot)

#Let's remove disabled population from the PCA and use that as the groups instead of boro. 

# I will add a new variable for neighborhoods that are in the top quartile for highest proportion of people with disabilities

cat_dis <- access_factors %>% 
  mutate(quartile = ntile(disabled_population, 4))

cat_dis$quartile <- factor(cat_dis$quartile,
                           levels = c(1,2,3,4),
                           labels = c("Lowest % Disabled", "Middle 50%", "Middle 50%", "Highest % Disabled")) 

access.dis.pca.plot <- 
  ggbiplot(access.pca, 
           ellipse=TRUE, 
           obs.scale = 1, 
           var.scale = 1, 
           groups = cat_dis$quartile) +
  theme(legend.position = "bottom") +
  labs(title = "Figure 2c: PCA Plot of Access Factors, Grouped by % of Population Disabled")


ggsave("figures/access_dis_pca.png", access.dis.pca.plot)

