source("utils.R")

clean_data <- read_csv("clean_data/clean_data.csv");

my_first_plot <- ggplot(clean_data, aes(racial_diversity_index, median_rent)) + geom_point()

ggsave("figures/my_first_plot.png", my_first_plot)
