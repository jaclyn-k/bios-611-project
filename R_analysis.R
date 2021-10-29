# Exploratory analysis --------------------------------------------------
source("~/work/clean_data.R")
source("~/work/utils.R")

my_first_plot <- ggplot(rawdata, aes(racial_diversity_index, median_rent)) + geom_point()


ggsave("~/work/my_first_plot.png", my_first_plot)
