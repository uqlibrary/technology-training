# Description : We are going to create many plots
# using ggplot2
# Author: Paula A. Martinez
# Date: Oct 16, 2017

?install.packages
#install.packages("ggplot2")

# load ggplot2
library(ggplot2)


# downloading a dataset
?download.file
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", 
              destfile = "data/gapminder-FiveYearData.csv")

?read.csv
# craeting a new object
gapminder <- read.csv(file = "data/gapminder-FiveYearData.csv")

# checking out the object
?str
str(gapminder)

head(gapminder)

tail(gapminder)

levels(gapminder$country)

?subset

Australia <- subset(gapminder, country == "Australia")



# playing with plots

#names of columns
colnames(gapminder)


#Does population grow over the years?

# simple plot
ggplot(data = gapminder, mapping = aes(x = year, y = pop)) +
  geom_point()

# to change the shape based on a category
ggplot(data = gapminder, mapping = aes(x = year, y = pop, shape = continent)) +
  geom_point()

# to change the color based on a category
ggplot(data = gapminder, mapping = aes(x = year, y = pop, color = "tomato")) +
  geom_point()

# to see all the years with out repetitives
unique(gapminder$year)

# to add separators use breaks on scale_x_continuos
ggplot(data = gapminder, mapping = aes(x = year, y = pop, colour = continent)) +
  geom_point() +
  scale_x_continuous(breaks = unique(gapminder$year))

# to change the scale use breaks and labels
ggplot(data = gapminder, mapping = aes(x = year, y = pop, colour = continent)) +
  geom_point() +
  scale_x_continuous(breaks = unique(gapminder$year)) +
  scale_y_continuous(breaks = c(0, 100000000, 200000000, 500000000, 1000000000),
                     labels = c(0, "100 mi", "200 mi", "500 mi", "1 billio"))
  

# to restrict the range use xlim or ylim
ggplot(data = gapminder, mapping = aes(x = year, y = pop, colour = continent)) +
  geom_point() +
  scale_x_continuous(breaks = unique(gapminder$year)) +
  scale_y_continuous() +
  ylim(c(0, 360000000))
                    

# grouping with box plot and violin
colnames(gapminder)

# simple plot
ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp)) +
  geom_boxplot()

# Exercise add colour to the box plots
ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot()

ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, color = continent)) +
  geom_boxplot() + 
  theme_minimal()

# let's do a violin plot
ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, colour = continent)) +
  geom_violin()


# histograms
ggplot(data = gapminder, mapping = aes(x = lifeExp)) +
  geom_histogram() # by default bins = 30

ggplot(data = gapminder, mapping = aes(x = lifeExp)) +
  geom_histogram(bins = 40)  

ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 40)
    
ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 40, position = "dodge") 
  

# facet and themes
ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) 

# remove or move the label
ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) +
  theme(legend.position = "none")

#########################################
# Not exactly what we want
ggplot(data = gapminder, mapping = aes(x = lifeExp, y = continent)) +
  geom_bar(stat = "identity")
    
ggplot(data = gapminder, mapping = aes(x = lifeExp)) +
  geom_bar( position = "identity")


ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_bar(..count..) 
########################################

# if you have categories that you want to count use geom_bar
ggplot(data = gapminder, mapping = aes(x = continent, fill = continent)) +
  geom_bar() 

colnames(gapminder)
# how does life Expectation relates to GDP per capita?

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  labs(x = "GDP per capita", y = "Life Expectation", 
       title = "Population by year") +
  theme_bw()

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp,
                                       colour = continent)) +
  geom_point(alpha = 0.5) +
  labs(x = "GDP per Capita", y = "Life Expectation",
       title = "How does GDP relates to life Expectation") +
  scale_x_log10() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(filename = "plots/Myscatterplot.PDF", dpi = 400)

ggsave(filename = "plots/Myscatterplot.png", dpi = 200)

# Hide axis label    
# labs(x = NULL, y=NULL)

# Shrink plot title
#theme(plot.title = element_text (size = 12)) 


ggplot(data = gapminder, mapping = aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  ggtitle("GDP per Continent") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90)) +
  ylim(0, 100000)
