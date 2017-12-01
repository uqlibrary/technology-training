# Open session for graphics using R  and ggplot2 - hands-on session

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
  * Look for the letter R and then click RStudio
  * Double click on RStudio which will install both R and RStudio 
  
     
## Attendees   

* Full name / email (optional)


## What are we going to do?

Exercise 1 (2 min each)
1. Please introduce yourself (Name and school)
2. Introduce your data set
3. Introduce your question


# before you raise your hand with a question, please show me the structure of your data

Exercise 2 
mydata <- read.csv(...)
dim(mydata)
str(mydata)

   
## Disclaimer

We will assume you are an R beginner, who has used R before.


# Suggested 
## Introductions

Introduce yourself to one other person in the session. We will try to work in pairs.

# Suggested to create an RStudio Project
## Material

### Location
Please create a folder called "RProjects" under "Documents". 
This is important for our project structure

### Rstudio Project
Exercise 1 - New Rstudio Project (3 min) 

    * Click the "File" menu button (top left corner), then "New Project"
    * Click "New Directory"
    * Click "New Project" ("Empty project" if you have an older version of RStudio)
    * Type in the name of your project, e.g. "MyProject" 
    (Select a folder where to locate your project the RProjects folder)
    * Click the "Create Project" button
    * create three folders in your new project
      * scripts
      * data
      * plots
      
      
      - How to create a folder or directory
      dir.create("data") or files (right bottom layout)
      Files > New Folder
      
# Suggested to create an R script
### Introducing ggplot2
Exercise 2 - ggplot2 setup (4 min)

  * Menu: Top left corner, click the green "plus" symbol, or press the shortcut
(for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N
This will open an "Untitled1" file remember the console is temporary so put any notes in the script
  * Go to file "Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S 
 This will ask where you cant to save your file and the name of the new file
  * Call your file "ggplot2_intro.R" located 
  in the "scripts" folder
  * install and load the package ggplot2
    * install.packages("ggplot2")
    * While you wait for ggplot2 to be installed, check Rdocumentation.org and type ggplot2 in the search
    * library(ggplot2)
    
The R package ggplot2 was developed by Hadley Wickham with the objective of creating a grammar of
graphics for categorical data (in 2007). It is based on the book the Grammar of Graphics Developed by Leland Wilkinson 1999/2005. 

You only need to install a package once, and reload it every time you start a new R session.  you do this by using library()

### Explore data

We are going to work with different datasets that come with the ggplot2 package. For any dataset or function doubts that you might have. Don't forget the three ways of getting help from R

1. ?functionname
2. help(functionname)
3. functionname + F1


### Cleaning your data
1. Make a copy of your spread sheet
2. Each column name should be a word with no spaces in the name you can use _ or -
3. Independence of values

        Each variable has its own column
        Each observation has its own row
        Each value must have its own cell

4. remove any white rows
5. Export sheeat as csv

### Basic ggplot2 layers

The idea that you can build every graph from the same few components: 

 ggplot(data = <dataset>, mapping = aes( <x, y, fill, colour>)) + 
 <geom_function>()

aes = aesthetics - gives the look and feel of the plot

 ?ggplot

ggplot() initializes a ggplot object. It can be used to declare the input data frame for a graphic and to specify the set of plot aesthetics intended to be common throughout all subsequent layers unless specifically overridden.

## Play time!

Tricks
         
- https://stackoverflow.com/questions/36048033/manually-colouring-plots-with-scale-fill-manual-in-ggplot2-not-working
- https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2                    
- https://stackoverflow.com/questions/1330989/rotating-and-spacing-axis-labels-in-ggplot2                    
 # theme(axis.text.x = element_text(angle = 90, hjust = 1))


## Close Rproject
If you want to close R Studio, you should save your project first.

- File
- close project (It will ask you if you want to save your history)
- then, close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links

* R ggplot2 Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf
* RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
* RStudio online learning https://www.rstudio.com/online-learning/
* Basic and advanced manuals https://cran.r-project.org/manuals.html
* Ask about any function or package http://www.rdocumentation.org/
* If you are looking how-to's or how to fix an error http://stackoverflow.com/questions/tagged/r
* Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in from UQ, https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
* ANOVA in R http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me 
