#EDA

#Installation and loading
install.packages("DataExplorer") 
library(DataExplorer)

#Dataset
dataset1<- bluebikes_tripdata_2020

#Data Cleaning
dataset1$tripduration = as.numeric(gsub('%','',dataset1$tripduration))
dataset1$`start station name`= as.character(dataset1$`start station name`)

#Variables
plot_str(dataset1)

#Search for missing values
plot_missing(dataset1)

#Continuous variables
plot_histogram(dataset1)

#Ploting density
plot_density(dataset1)

#Multivariate Analysis
plot_correlation(dataset1, type = 'continuous','Review.Date')

#Categorical Variables - Barplots
plot_bar(dataset1)

#Creating Report
create_report(dataset1)

