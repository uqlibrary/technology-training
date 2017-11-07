# RStudio Intro hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving http://tiny.cc/CDS_feedback_R

If you want to review the installation instructions: https://github.com/orchid00/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. If you use the University computers, please remember to save your files in your H drive or USB.

Manuals, commands and more information on how to continue your R learning are provided in our community resource in this etherpad https://etherpad.wikimedia.org/p/cds
After the workshop you can save this etherpad with the important links and information (top right double arrow, export).

## RStudio

RStudio is an open source interface for the R programming language.
We can use R for calculations and visualisations.

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
  * Go to search 
  * Open the ZENworks application
  * Look for the letter R 
  * Double click on RStudio which will install both R and RStudio 

## What are we going to learn?

At the end of this session you will be able to:

   * Create a project for data analysis
   * Create a folder structure
   * Know where to find help
   * Import files/datasets
   * Understand and move around layouts 
   * Use a few shortcuts
   * Know where packages are

   
## Attendees   

* Full name / email (optional)
* Paula Andrea Martinez / p.martinez at uq.edu.au


## Material

### Location
Please create a folder called "RProjects" under "Documents"
This is important for our project structure

### Rstudio Project
Exercise 1 - New Rstudio Project (2 min)

    * Click the "File" menu button (top left corner), then "New Project"
    * Click "New Directory"
    * Click "New Project" ("New empty project" if you have an older version of RStudio)
    * In Directory name type the name of your project, e.g. "RStudio_Intro" 
      (Browse and select a folder where to locate your project, for example the RProjects folder)
    * Click the "Create Project" button
    
FYI: Projects make managing multiple directories straightforward. You can create a .Rproj file in a new directory or an existing directory that already has R code and data. The .Rproj stores information about our folder structure and the objects in the project (hence, manages history and .RData)

### Help

There are 3 ways to find help in R

1.
2.
3.


Exercise 2 - Check what the description of these functions

    sessionInfo()
    list.files()
    ls()
  
### Creating a folder structure

We are creating 2 folders:
    * scripts
    * data
    
Exercise 3 - create a folder called "plots"

Exercise 4 - Create a new R script file

    - click the button (+) located at the top left corner of your RStudio  (or Shift + cmd + n or Shift + ctrl + n)
    - click on R script
    - Save the file File > Save (or ctrl + s or command + s)
    - name the file "myscript.R"
    - locate this file under the "scripts" folder

Exercise 5 - Add comments to your new R script file

Comments start with #

             # Description:
             # Author:
             # Date:

To add comments to many lines: Shift + cmd + c or Shift + ctrl + c

### Import files

Exercise 6 - Read the description of these functions:
    
    ?download.file
    ?read.table
    ?read.csv


    download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", destfile = "data/gapminderdata.csv")

    mydata <- read.csv("data/gapminderdata.csv")

    ?str
    str(mydata)

    ?ls
    ?rm


#### Layouts

    Move focus to Source Editor Ctrl+1 Ctrl+1
    Move focus to Console Ctrl+2 Ctrl+2
    Move focus to Help Ctrl+3 Ctrl+3
    Show History Ctrl+4 Ctrl+4
    Show Files Ctrl+5 Ctrl+5
    Show Plots Ctrl+6 Ctrl+6
    Show Packages Ctrl+7 Ctrl+7
    Show Environment Ctrl+8 Ctrl+8
    Show Git/SVN or viewer Ctrl+9 Ctrl+9


### Packages

    install.packages()


### demo

A real life example to use R graphics 
demo(graphics)

# Close Rproject

File
close project
then close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links
* RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
* RStudio online learning https://www.rstudio.com/online-learning/
* Basic and advanced manuals https://cran.r-project.org/manuals.html
* Ask about any function or package http://www.rdocumentation.org/
* If you are looking how-to's or how to fix an error http://stackoverflow.com/questions/tagged/r
* Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in with your organisational portal, https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses)
* ANOVA in R http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
* R gapminder csv https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv"
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. 
https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me p.martinez at uq.edu.au 
