# An Intro to R data manipulation using dplyr - hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving http://tiny.cc/CDS_feedback_R.

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
* On CDS computers (the first time takes about 10 min): 
* Log in with your UQ username and password
* Make sure you have a working internet connection
* Go to search at bottom left corner (magnifiying glass) 
* Open the ZENworks application
* Look for RStudio
* Double click on RStudio which will install both R and RStudio


## What are we going to learn?

At the end of this session you will be able to:

* About the tidyverse umbrella of packages 
* About dplyr
* Some dplyr verbs

        select()
        filter()
        group_by()
        summarize()
        mutate()

## Disclaimer

We will assume you are an R beginner, who has used R before.

## Attendees
* Full name / email (optional)
* Paula Andrea Martinez 


## Introductions

Introduce yourself to one other person in the session. We will try to work in pairs.

## Material

### Location

Please create a folder called "RProjects" under "Documents". This is important for our project structure

### Rstudio Project

Exercise 1 - New Rstudio Project (3 min)
* Click the "File" menu button (top left corner), then "New Project"
* Click "New Directory"
* Click "New Project" ("Empty project" if you have an older version of RStudio) * Type in the name of your project, e.g. "Rdplyr_Intro"
(Select a folder where to locate your project the RProjects folder)
* Click the "Create Project" button
* create three folders in your new project
    * scripts 
    * data
    * plots

### Introducing dplyr

Exercise 2 - dplyr setup (4 min)

* Menu: Top left corner, click the green "plus" symbol, or press the shortcut (for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N
This will open an "Untitled1" file
* Go to file "Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S This will ask where you cant to save your file and the name of the new file
* Call your file "gdplyr_intro.R" located in the "scripts" folder
* install and load the package dplyr
* install.packages("dplyr")
* While you wait for dplyr to be installed, check Rdocumentation.org and type dplyr in the search * library(dplyr)


At home install:https://www.tidyverse.org/
Install the complete tidyverse with: It takes a few minutes depending on your internet conection but installs many useful
packages install.packages("tidyverse")

The R package dplyr was developed by Hadley Wickham for data manipulation
You only need to install a package once, and reload it every time you start a new R session. 

### Explore data

Exercise 3 (3 min)
1. download the data from the internet
https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv
?download.file
destfile = "data/gapminder.csv" download.file(url="https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder- FiveYearData.csv", destfile = "data/gapminder.csv")
2. read the data into a an object called gapminder mydata<-read.csv("data/gapminder.csv")
3. Explore the gapminder using dim()

str()

how to get the column names
names(gapminder) - return the names regardles of the object type, such as list, vector, data.frame etc. colnames(gapminder) - return the names for matrix-like objects, such as matrix, data.frame

select one column gapminder$year
nlevels(gapminder$country) 

### Help

For any dataset or function doubts that you might have. Don't forget the three ways of getting help from R
1. ?functionname
2. help(functionname) 
3. functionname + F1

### Basic dplyr verbs


We need a pipe symbol %>% (Similar to "+" in ggplot2)

 filter() # use "filter" to filter rows
 select() # Selecting Columns from a dataframe group_by()
 summarize()
 mutate()
 group_by() and summarize() are used together
 
### Conditionals 
= is to give the value to the name, == is to set the condition 

        == equal != different 
        >
        <
        >=
        <=

double quote: for a string, not a number

Exercise Select the observations form Eritrea on 2002

    Eritrea_2002 <- 

## Close Rproject
If you want to close R Studio, you should save your project first.
- File
- close project (It will ask you if you want to save your history) 
- then, close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links
* R ggplot2 Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf * R dplyr cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf
* RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
* RStudio online learning https://www.rstudio.com/online-learning/
* Basic and advanced manuals https://cran.r-project.org/manuals.html
* Ask about any function or package http://www.rdocumentation.org/
* If you are looking how-to's or how to fix an error http://stackoverflow.com/questions/tagged/r
* Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in from UQ,
 https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
* ANOVA in R http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship

