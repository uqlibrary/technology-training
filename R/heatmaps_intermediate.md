# Heatmaps in R - for intermediate users - hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving http://tiny.cc/CDS_feedback_R

If you want to review the installation instructions: https://github.com/orchid00/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you used the University computers.
Manuals, commands and more information on how to continue your R learning are provided in our community resource in this etherpad https://etherpad.wikimedia.org/p/cds.

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
   * Learn other options to produce heatmaps
   * Examples of other packages
   
## Disclaimer

We will assume you are an R intermediate user and that you have used RStudio before.
   
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
    * Click "New Project" ("Empty project" if you have an older version of RStudio)
    * Type in the name of your project, e.g. "Heatmaps" 
    (Browse and select a folder where to locate your project, e.g. the "RProjects" folder)
    * Click the "Create Project" button
    * create three folders
      * scripts
      * data
      * plots

### Make sure you have ggplot2 installed and loaded
Exercise 2 - setting up (1 min)

  * create a new R script file called "heatmaps.R" 
  in the "scripts" folder

### Steps to create a simple heatmap

Step 1 data 

    ?read.csv
    nba <- read.csv(file = "http://datasets.flowingdata.com/ppg2008.csv")

Step 2 - exercise explore the data (2 min)

     dim(nba)

Step 3 - exercise - update the dataset (2 min)

1. assign the Name column to rownames(nba)

2. delete the column Name

Step 4 - Prepare data, again

exercise convert the nba data into a matrix (1 min) - discuss

Step 5 - Make a heatmap

Exercise (2 min) look for the heatmap help
read the scale atribute

     ?heatmap
     

## Play time!

* remove dendrograms

* Add labels


Clean my environment
rm(list = ls())
  
## Example 2 

     install.packages("gplots")
     library(gplots)
     install.packages("RColorBrewer")
     library(RColorBrewer)

Step 1 data

observations for 63 proteins for three control experiments and three experiments
where cells are treated with a growth factor.

    rawdata <- read.csv("https://raw.githubusercontent.com/ab604/heatmap/master/leanne_testdata.csv")

    ?heatmap.2

## Example 3

    install.packages("grid")
    library(grid)    
    install.packages("pheatmap")
    library(pheatmap)

    ?pheatmap

## Example 4

    source("https://bioconductor.org/biocLite.R")
    biocLite("ComplexHeatmap") 
    library(ComplexHeatmap)
    install.packages("circlize")
    library(circlize)

    ?Heatmap

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
* Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in with your organisational portal,https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
* R colours http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
* Book: Hadley Wickham. ggplot2 Elegant Graphics for Data Analysis Second  Edition. 2016 
https://link-springer-com.ezproxy.library.uq.edu.au/content/pdf/10.1007%2F978-3-319-24277-4.pdf
* Examples of heatmaps: https://flowingdata.com/2010/01/21/how-to-make-a-heatmap-a-quick-and-easy-solution/
 https://rpubs.com/ab604/98032  https://stackoverflow.com/questions/15505607/diagonal-labels-orientation-on-x-axis-in-heatmaps  https://www.bioconductor.org/packages/devel/bioc/vignettes/ComplexHeatmap/inst/doc/s2.single_heatmap.html

* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me p.martinez at uq.edu.au 
