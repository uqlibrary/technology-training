# An intermediate session to R visualisations using ggplot2 - hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving http://tiny.cc/CDS_feedback_R

If you want to review the installation instructions: https://github.com/orchid00/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you used the University computers.
Manuals, commands and more information on how to continue your R learning are provided in our community resource in this etherpad [https://etherpad.wikimedia.org/p/cds](https://etherpad.wikimedia.org/p/cds).

## Keep in mind

* Case sensitive
* No spaces in names
* Be ready to learn a new language, lots of new vocabulary

## Open RStudio

* If you are using your own laptop please open RStudio
  * Make sure you have a working internet connection
  * Make sure you have ggplot2 installed

* On CDS computers:
  * Log in with your UQ username and password
  * Make sure you have a working internet connection
  * Go to search the magnifying glass (bottom left)
  * Open the ZENworks application
  * Look for the letter R 
  * Double click on RStudio which will install both R and RStudio 
  * Make sure you have ggplot2 installed

## What are we going to learn?

At the end of this session you will be able to:

   * know about the layers used in ggplot2
   * Select your own colours
   * Change labels
   * Save your plots in different formats and resolutions
   * Be able to modify plots quickly
   
## Disclaimer

We will assume you are an R intermediate user and that you have used ggplot2 before.
   
## Attendees   

* Full name / email (optional)
* Paula Andrea Martinez / p.martinez at uq.edu.au 
* 

Introduce yourself to one other person in the session. We will try to work in pairs.

## Material

### Location
Please create a folder called "RProjects" under "Documents"
This is important for our project structure

### Rstudio Project
Exercise 1 - New Rstudio Project (3 min) 

    * Click the "File" menu button (top left corner), then "New Project"
    * Click "New Directory"
    * Click "Empty Project"
    * Type in the name of your project, e.g. "Rggplot2" 
    (Browse and select a folder where to locate your project, e.g. the RProjects folder)
    * Click the "Create Project" button
    * create three folders
      * scripts
      * data
      * plots

### Make sure you have ggplot2 installed and loaded
Exercise 2 - setting up (1 min)

  * In the "scripts" folder create a new R script file called "gapminder_example.R" 
  * install and load the package ggplot2
    * install only if you haven't yet done so using install.packages("ggplot2")
    * load the package using library(ggplot2)

### Import files

Downloading data to your project in your R script gapminder_example.R

Don't forget to add some comments to your header
        # Description : We are going to create many plots 
        # using ggplot2
        # Author: Paula A. Martinez
        # Date: today's date, 2017




     download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
     
Exercise 3 - read the data in an R object (1 min)

      gapminder <- ...

Explore the dataset 
  
      str()
  
Exercise 4 - check if your country is in the dataset (2 min)

To be able to plot we should be familiar with the column names

     colnames(gapminder)
   
### Layers used in ggplot2

?ggplot

Check the Details section

     ggplot(data = <dataset>, mapping = aes( x, y, fill, colour, shape, size)) + 
      geom_function() +
      facet_function(~ class) +
      theme_function() +
      scale_function() +
      coord_function() +
 
 
Does population grow over the years?

Let's make a simple plot with the basics of ggplot2

     ggplot(data = gapminder, mapping = aes(x = year, y = pop)) +
       geom_point()
  
 ## Colour, Size, Shape and Other Aesthetic Attributes

To change the shape based on a category use 

    shape = 
    
To change the color based on a category use

    colour = 
    fill = 

Exercise - 5 Pick one color from: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf and modify your plot
    
Exercise - 6 How would you know all the years in this study with out repetitives?

    unique_years <- 

## Limits and scales

Exercise 7 - Modify the x label of the plot by adding a layer

     scale_x_continuous(breaks = unique_years)


To change the scale use breaks and labels

     scale_y_continuous(breaks = c(0, 100000000, 200000000, 500000000, 1000000000),
                        labels = c(0, "100 mi", "200 mi", "500 mi", "1 billio"))

Exercise 9 - Modify your y scale


To restrict the range use xlim or ylim

      ylim(c(0, 360000000))
      
Let's talk about the warning message

### histograms

Exercise 10 - Create a histogram of life expectation

How to you modify the bars?


## facet and theme

ggplot(data = gapminder, mapping = aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) 
  
  
 How do you remove the legend?
 
 Try different themes
 
 
## Labels

how does life Expectation relates to GDP per capita?

add labels using
labs(title = "" , x = "", y = "")

## Save your plots in different formats and resolutions

Use 

?ggsave

## Play time!

* Create a a boxplot of continent vs pop
     * Colour and fill by continent
     * try to limit the y axis to see the boxes better
     * let's see if you are able to move the legend to the bottom 
  
## Modify your plots


## Close Rproject

- File
- close project
- then close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links
* RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
* RStudio online learning https://www.rstudio.com/online-learning/
* Basic and advanced manuals https://cran.r-project.org/manuals.html
* Ask about any function or package http://www.rdocumentation.org/
* If you are looking how-to's or how to fix an error http://stackoverflow.com/questions/tagged/r
* Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in with your organisational portal, https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
* R colours http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
* Book: Hadley Wickham. ggplot2 Elegant Graphics for Data Analysis Second  Edition. 2016 
https://link-springer-com.ezproxy.library.uq.edu.au/content/pdf/10.1007%2F978-3-319-24277-4.pdf
* R gapminder csv https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv"
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me p.martinez at uq.edu.au 
