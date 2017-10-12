#!/usr/bin/env Rscript
# Title: Gapminder Example
# Author: Paula A. Martinez
# Date: 12/102017 

# This script will be use to read the gapminder data set
# and play a little bit to produce a figure 

library("ggplot2")

# Download data
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
              destfile = "data/gapminder-FiveYearData.csv")

#Generic way to read a data table
gapminder <- read.table(file = "data/gapminder-FiveYearData.csv",
                        header = TRUE, sep = ",")

head(gapminder)
tail(gapminder)



# How is the population trend over the years?
ggplot(data = gapminder, mapping = aes(x = year, y = pop, colour = year)) +
  geom_point() 

ggplot(data = gapminder, mapping = aes(x = year, y = pop, 
                                      shape = continent)) +
  geom_point() 

ggplot(data = gapminder, mapping = aes(x = continent, y = pop,
                                       fill = continent)) +
  geom_boxplot() 

ggplot(data = gapminder, mapping = aes(x = continent, y = pop,
                                       fill = continent)) +
  geom_violin() 

summary(gapminder$lifeExp)


ggplot(data = gapminder, mapping = aes(x = lifeExp)) +
  geom_histogram(binwidth = 5)

ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(binwidth = 5)

ggplot(data = gapminder, mapping = aes(x = lifeExp)) +
  geom_histogram(binwidth = 5) +
  facet_wrap(~ continent)

ggplot(data = gapminder, mapping = aes(x = lifeExp, colour = continent)) +
  geom_freqpoly() +
  facet_wrap(~ continent, ncol = 2) +
  theme(legend.position = "none")


ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap)) +
  geom_point() +
  ggtitle("Population growth by year") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90)) 

# 
summary(gapminder$year)

ggplot(data = gapminder, mapping = aes(x = continent, y = gdpPercap)) +
  geom_point() +
  ggtitle("GDP per Continent") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90)) +
  ylim(0, 100000)

# scale
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life Expectation",
       title = "How does GDP relates to Life Expectation?") +
  theme_bw()

# Colours theme
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, colour = continent)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life Expectation",
       title = "How does GDP relates to Life Expectation?") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) 
  
  

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, )) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life Expectation",
       title = "How does GDP relates to Life Expectation?") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip() +
  geom_smooth()

ggsave(filename = "plots/mysuperplot.PDF", dpi = 400)

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, shape = continent)) +
  geom_point(alpha = 0.5) +
  labs(x = "GDP per capita", y = "Life Expectation",
       title = "How does GDP relates to Life Expectation?") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) 

ggplot(data = gapminder, mapping = aes(x = continent, y = pop,
                                       fill = continent, colour = continent)) +
  geom_boxplot() +
  ylim(0, 100000000) +
  theme_light() +
  theme(panel.grid.minor = element_blank(),
        legend.position = "bottom")


# Hide axis label    
# labs(x = NULL, y=NULL)

# Shrink plot title
#theme(plot.title = element_text (size = 12)) 
# title
#ggtitle("title")

