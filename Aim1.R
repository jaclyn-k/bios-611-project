source("utils.R")
library(tidyverse)
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

setwd("~/work")

clean_data <- read_csv("clean_data/clean_data.csv")

# Aim 1:  -------------------------------------------------------------------
# Visualize neighborhoods plotted by poverty rate x SDOH

sdohfactors <- select(clean_data, c("poverty_rate",
                 "public_housing", 
                 "park", 
                 "median_income", 
                 "median_rent", 
                 "population_density", 
                 "car_free_commute",
                 "mean_travel_time_to_work",
                 "subway"))

sdoh_exploratory<- sdohfactors  %>%
  gather(-poverty_rate, -median_income, key = "var", value = "value") %>%
  ggplot(
    aes(x = value, 
        y = poverty_rate, 
        color = median_income
        )) +
  geom_point() +
  stat_smooth() +
  facet_wrap(~ var, scales = "free") +
  labs(title = "Figure 1a: Social Determinants vs. Poverty")

ggsave("figures/sdoh_exploratory.png", sdoh_exploratory)

# Notes: Would like to look more closely access to subway and poverty rate

#PCA

sdoh.pca <- prcomp(sdohfactors, center = TRUE, scale. = TRUE)
summary(sdoh.pca)

sdoh.pca.graph <-
  ggbiplot(sdoh.pca, ellipse=TRUE, obs.scale = 1, var.scale = 1, groups = clean_data$boro_names) +
  ggtitle("Principal Component Analyses: Social Determinants of Health") +
  theme(legend.position = "bottom") +
  labs(title = "Figure 1b: PCA of Social Determinants, Grouped by Boro")

ggsave("figures/sdoh_pca.png", sdoh.pca.graph)

#Manhattan seems to have the most different set of SDOH's, whereas factors in Brooklyn and Bronx are a bit more similar. Queens and Staten Island also seem to face similar factors. 

#Let's remove poverty from the PCA and use that as the groups instead of boro. 

# I will add a new variable for neighborhoods that are in the bottom 25% for poorest neighborhoods. 

cat_pov <- sdohfactors %>% 
  mutate(quartile = ntile(poverty_rate, 4))

cat_pov$quartile <- factor(cat_pov$quartile,
                    levels = c(1,2,3,4),
                    labels = c("Lowest Poverty", "Middle 50%", "Middle 50%", "Highest Poverty")) 

sdohfactors_nopov_noincome <- select(clean_data, c("public_housing", 
                                    "park", 
                                    "median_rent", 
                                    "population_density", 
                                    "car_free_commute",
                                    "mean_travel_time_to_work",
                                    "subway"))

sdoh.pca.pov <- prcomp(sdohfactors_nopov_noincome, center = TRUE, scale. = TRUE)
summary(sdoh.pca.pov)

sdoh.pca.pov <- 
  ggbiplot(sdoh.pca.pov, 
         ellipse=TRUE, 
         obs.scale = 1, 
         var.scale = 1, 
         groups = cat_pov$quartile) +
  theme(legend.position = "bottom") +
  labs(title = "Figure 1c: PCA of Social Determinants, Grouped by Boro")

ggsave("figures/sdoh_pov_pca.png", sdoh.pca.pov)

