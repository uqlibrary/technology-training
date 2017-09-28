#!/usr/bin/env Rscript
# Title: Gapminder Example
# Author: Paula A. Martinez
# Date: 28/09/2017 

# This script will be use to read the gapminder data set
# and play a little bit to produce a figure 

# Download data
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
              destfile = "data/gapminder-FiveYearData.csv")

#Generic way to read a data table
gapminder <- read.table(file = "data/gapminder-FiveYearData.csv",
                        header = TRUE, sep = ",")

#exploring data.frame
#what data structure is it?
str(gapminder)

#exploring plots for the gapminder data set
png(filename = "plots/plot_population.png")
plot(pop~year, data = gapminder, 
        main = "Population growth by year", 
        xlab = "year", ylab = "population")
dev.off()
dev.off()
#assume you have the ggplot2 package installed already 
# or 
#install.packages("ggplot2")
#call ggplot2 using library
library("ggplot2")
ggplot(data = gapminder, 
           aes(x = year, y = pop, fill = year)) +
  geom_point() +
  ggtitle("Population growth by year") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90))
ggsave("plots/plot_population_ggplot2.png")
