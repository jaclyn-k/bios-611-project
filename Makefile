.PHONY: clean

clean:
	rm -f clean_data/*
	rm -f figures/*
	rm -f report.pdf
	rm -f Rplots.pdf

clean_data/clean_data.csv: utils.R source_data/NYC_Housing_Data.csv clean_data.R
	mkdir -p clean_data
	Rscript clean_data.R
	
figures/sdoh_exploratory.png: clean_data/clean_data.csv utils.R aim1.R 
	mkdir -p figures
	Rscript aim1.R
	
figures/sdoh_pca.png: clean_data/clean_data.csv utils.R aim1.R 
	mkdir -p figures
	Rscript aim1.R
	
figures/sdoh_pov_pca.png: clean_data/clean_data.csv utils.R aim1.R 
	mkdir -p figures
	Rscript aim1.R
	
figures/access_dis_pca.png: clean_data/clean_data.csv utils.R aim2.R 
	mkdir -p figures
	Rscript aim2.R

figures/access_factors.png: clean_data/clean_data.csv utils.R aim2.R 
	mkdir -p figures
	Rscript aim2.R

figures/access_pca.png: clean_data/clean_data.csv utils.R aim2.R 
	mkdir -p figures
	Rscript aim2.R 

	
report.pdf: clean_data/clean_data.csv figures/sdoh_exploratory.png figures/sdoh_pca.png figures/sdoh_pov_pca.png figures/access_dis_pca.png figures/access_factors.png figures/access_pca.png clean_data.R utils.R 
	Rscript -e "tinytex::install_tinytex"
	Rscript -e "tinytex::use_tinytex"
	Rscript -e "rmarkdown::render('report.Rmd')"
	
