.PHONY: clean

clean:
	rm -f clean_data/*
	rm -f figures/*
	rm -f report.pdf

clean_data/clean_data.csv: utils.R source_data/NYC_Housing_Data.csv clean_data.R
	mkdir -p clean_data
	Rscript clean_data.R

figures/my_first_plot.png: clean_data/clean_data.csv utils.R R_analysis.R
	mkdir -p figures
	Rscript R_analysis.R

/tmp/tinytex_installed:
	rm -f /tmp/tinytex_installed
	Rscript install_tinytext.R
	touch /tmp/tinytex_installed
	
report.pdf: /tmp/tinytex_installed figures/my_first_plot.png clean_data.R utils.R 
	Rscript -e "rmarkdown::render('report.Rmd')"
	
