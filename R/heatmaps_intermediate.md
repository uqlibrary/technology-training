# Heatmaps in R - for intermediate users - hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving http://tiny.cc/CDS_feedback_R.

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

* On CDS computers:
  * Log in with your UQ username and password
  * Make sure you have a working internet connection
  * Open the ZENworks application
  * Look for the letter R 
  * Double click on RStudio which will install both R and RStudio 

## What are we going to learn?

At the end of this session you will be able to:

   * Produce a simple heatmap
   * Know other options to produce heatmaps
   
## Disclaimer

We will assume you are an R intermediate user and that you have used RStudio before.
   
## Attendees   

* Full name / email 
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
    * Type in the name of your project, e.g. "Heatmaps" 
    (Browse and select a folder where to locate your project, e.g. the "RProjects" folder)
    * Click the "Create Project" button
    * create three folders
      * scripts
      * data
      * plots

### Make sure you have ggplot2 installed and loaded
Exercise 2 - setting up (1 min)

  * create a new R script file called "ggplot2_intermediate.R" 
  in the "scripts" folder
  * install and load the package ggplot2
    * install only if you haven't yet done so. install.packages("ggplot2")
    * load the package using library(ggplot2)

### Import files

Downloading data to your project

     download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
     
Exercise 3 - read the data in an R object (1 min)

      gapminder <- ...

Explore the dataset
  str()
  
  Exercise 4 - check if your country is in the dataset
  
### Layers used in ggplot2

 ggplot(data = <dataset>, mapping = aes( <x, y, fill, colour, shape, size>)) + 
 <geom_function>() +
  facet_function( ̃class) +
  theme_function() +
  scale_function() +
  coord_function() +
  
 ## Colour, Size, Shape and Other Aesthetic Attributes

colour

shape

fill

## facet and theme

##  Labels

## Limits and scales

## Save your plots in different formats and resolutions

## Play time!

* Create a dotplot of gdpPercap vs lifeExp

    use the shape for continent

    label the plot


* Create a a boxplot of continent vs pop
     Colour and fill by continent
     try to limit the y axis to see the boxes better
     let's see if you are able to move the legend to the bottom 
  
## Modify your plots


## Close Rproject

- File
- close project
- then close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links
* RStudio Cheatsheet [https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf)
* RStudio online learning [https://www.rstudio.com/online-learning/](https://www.rstudio.com/online-learning/)
* Basic and advanced manuals [https://cran.r-project.org/manuals.html](https://cran.r-project.org/manuals.html)
* Ask about any function or package [http://www.rdocumentation.org/](http://www.rdocumentation.org/)
* If you are looking how-to's or how to fix an error [http://stackoverflow.com/questions/tagged/r](http://stackoverflow.com/questions/tagged/r) 
* Lynda.com R training and tutorials [https://www.lynda.com/R-training-tutorials/1570-0.html](https://www.lynda.com/R-training-tutorials/1570-0.html) remember to sign in with your organisational portal, [for example](https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses)
* R colours http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
* Book: Hadley Wickham. ggplot2 Elegant Graphics for Data Analysis Second  Edition. 2016 
https://link-springer-com.ezproxy.library.uq.edu.au/content/pdf/10.1007%2F978-3-319-24277-4.pdf
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me p.martinez at uq.edu.au 
