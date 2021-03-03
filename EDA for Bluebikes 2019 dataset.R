#EDA

#Installation and loading
install.packages("DataExplorer") 
library(DataExplorer)

#Dataset
dataset<- bluebikes_tripdata_2019

#Data Cleaning
dataset$tripduration = as.numeric(gsub('%','',dataset$tripduration))
dataset$`start station name`= as.character(dataset$`start station name`)

#Variables
plot_str(dataset)

#Search for missing values
plot_missing(dataset)

#Continuous variables
plot_histogram(dataset)

#Ploting density
plot_density(dataset)

#Multivariate Analysis
plot_correlation(dataset, type = 'continuous','Review.Date')

#Categorical Variables - Barplots
plot_bar(dataset)

#Creating Report
create_report(dataset)

