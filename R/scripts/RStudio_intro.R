# Description: My first R script
# Author: Paula A. Martinez
# Date: Nov 6th, 2017

# Exploring new functions in RStudio
?download.file
?read.table
?read.csv

# Downloading a public file from the internet
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
              destfile = "data/gapminderdata.csv")

# list my objects
ls()

# Add an object to RStudio to work with
mydata <- read.csv(file = "data/gapminderdata.csv")

# Explore the dataset
?str
str(mydata)
# how to list objects
ls() 

# how to delete objects
?rm

#rm(mydata)

# how to install packages?
?install.packages
install.packages("ggplot2")
library(ggplot2)


# Extra demo
# exploring a demo for graphics
demo(graphics)
