# Description: Introduction to dplyr manipulating data
# Author: Paula Andrea Martinez
# Date: Nov 30th, 2017

#install.packages("dplyr")
library(dplyr)

# 1. download the data from the internet
# https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv

?download.file

destfile = "data/gapminder.csv"
download.file(url ="https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
              destfile = "data/gapminder.csv")

# 2. read the data into a an object called gapminder
gapminder <- read.csv("data/gapminder.csv")

# 3. Explore the gapminder using
dim(gapminder)
str(gapminder)

names(gapminder)
colnames(gapminder)


# How to select one column
gapminder$year

# list one by one each of the columns
gapminder$country

?nlevels
nlevels(gapminder$country)
class(gapminder$country)

# filter() to filter rows
Australia <- gapminder %>%
                filter(country == "Australia")

Australia


# filter the rows that have life Expectation lifeExp greater than 80 years
life80 <- gapminder %>%
             filter(lifeExp > 80)
dim(life80)

# Using select to 
?select

# exercise in the object Eritrea_2002 select columns year and country
# for rows in Eritrea
# for rows in 2002
Eritrea_2002 <- gapminder %>%
                  select(year, country) %>%
                  filter(country == "Eritrea", year == 2002)
Eritrea_2002


# group_by
# summarize

# Exercise
?group_by
?summarize

# Exercise group by continent
continents_gapminder <- gapminder %>%
                          group_by(continent)
  
head(continents_gapminder)


# Exercise group by continent and find out the mean lifeExp
continents_gapminder_LE <- gapminder %>% 
                              group_by(continent) %>%
                              summarize(meanLE = mean(lifeExp))
continents_gapminder_LE

  # little tip: mean of all the column lifeExp
gapminder %>%
  summarize( meanLE = mean(lifeExp))


# Exercise group by continent and country
# and find out the max lifeExp

continents_country_gapminder_LE <- gapminder %>% 
  group_by(continent, country) %>%
  summarize(meaxLE = max(lifeExp))
continents_country_gapminder_LE

# new verb
?mutate

head(gapminder$gdpPercap)
head(gapminder$pop)

# exercise use mutate to add a column called gdp
# the two columns that you need are gdpPercap
# and pop
# the results should have 
# dim(gapminder_gdp)
# 1704 7
gapminder_gdp <- gapminder %>%
                  mutate(gdp = gdpPercap * pop)
dim(gapminder_gdp)
head(gapminder_gdp)


# Suggestion

#use tidyr package for changing the format
