PHONY: clean

clean:
	rm clean_data.csv/*
	rm my_first_plot.png/*
	rm report.pdf/*

clean_data.csv: utils.R NYC_Housing_Data.csv
	RScript clean_data.R

my_first_plot.png: clean_data.R utils.R
	R_analysis.R

report.pdf: my_first_plot.png clean_data.R utils.R 
	report.Rmd