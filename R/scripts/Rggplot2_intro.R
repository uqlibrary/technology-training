# Description: Simple commands to introduce ggplot2
# Date: Oct 09, 2017
# Author: Paula Andrea Martinez

# This is a short introduction to the package ggplot2
#install.packages("ggplot2")
library(ggplot2)

# Story line
?economics
str(economics)

# Do you think that the rate of enemployment is stable over the years?
?ggplot

# ggplot(data = <dataset>, mapping = aes( <x, y, fill, colour>)) + 
#  <geom_function>()

ggplot(data = economics, mapping = aes(x = date, y = unemploy)) + 
  geom_point()


## Do you think that cars with big engines use more fuel than cars with small engines?
?mpg
#  miles per gallon (mpg).
str(mpg)
# displ, a car’s engine size, in litres.
# hwy, a car’s fuel efficiency on the highway, in miles per gallon (mpg). 
# A car with a low fuel efficiency consumes more fuel than a car with a high fuel efficiency
# when they travel the same distance.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point()

# The plot shows a negative relationship between engine size (displ) and fuel efficiency (hwy).
# In other words, cars with big engines use more fuel. Does this confirm or refute your 
# hypothesis about fuel efficiency and engine size?

# We now know how to create a simple dotplot
# what is the last plot showing us?
last_plot()
# A trend will be best displayed as: 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth()

# Do you think is possible to combine both plots?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()

# also different geoms can have their own mappings
# If you place mappings in a geom function, ggplot2 will treat them as local mappings for 
# the layer. It will use these mappings to extend or overwrite the global mappings for that 
# layer only. This makes it possible to display different aesthetics in different layers.

# Introducing colour and legend
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(colour = class)) + 
  geom_smooth()

str(economics)
# exercise do a similar approach to the economics data
economics$year<-as.numeric(format(economics$date, "%Y")) 

ggplot(data = economics, mapping = aes(x = date, y = unemploy)) + 
  geom_point(mapping = aes(colour = year)) +
  geom_smooth()

# Next, let’s take a look at a bar chart. Bar charts seem simple, but they are interesting 
# because they reveal something subtle about plots. Consider a basic bar chart, as drawn with 
# geom_bar(). The following chart displays the total number of diamonds in the diamonds 
# dataset, grouped by cut. The diamonds dataset comes in ggplot2 and contains information 
# about ~54,000 diamonds, including the price, carat, color, clarity, and cut of each diamond.
# The chart shows that more diamonds are available with high quality cuts than with low 
# quality cuts.

?diamonds
str(diamonds)

ggplot(data = diamonds, mapping = aes(x = cut)) + 
  geom_bar()

ggplot(data = diamonds, mapping = aes(x = cut)) + 
  geom_bar(fill = "tomato") +
  labs(title = "How many diamonds have good or better quality?",
       x = "Quality", y = " Counts") 
  
?labs
# title, subtitle, x, y, caption

ggplot(data = diamonds, mapping = aes(x = cut)) + 
  geom_bar(fill = "tomato") +
  labs(title = "How many diamonds have good or better quality?",
       x = "Quality", y = " Counts") +
  coord_flip()

ggplot(data = diamonds, mapping = aes(x = cut)) + 
  geom_bar(fill = "tomato") +
  labs(title = "How many diamonds have good or better quality?",
       x = "Quality", y = " Counts") +
  coord_flip() +
  theme_bw()
ggsave(filename = "plots/horizontalbarplot.png")
