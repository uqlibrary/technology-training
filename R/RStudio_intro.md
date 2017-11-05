# RStudio Intro hands-on session

Thanks for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving [http://tiny.cc/CDS_feedback_R](http://tiny.cc/CDS_feedback_R).

If you want to review the installation instructions: https://github.com/orchid00/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. If you use the University computers, please remember to save your files in your H drive or USB.

Manuals, commands and more information on how to continue your R learning are provided in our community resource in this etherpad [https://etherpad.wikimedia.org/p/cds](https://etherpad.wikimedia.org/p/cds).

## RStudio

RStudio is an open source interface for the R programming language.
We can use R for calculations and visualisation.

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
  * Look for RStudio
  * Double click on RStudio which will install both R and RStudio 
  
* Go to http://coesra.org.au
  * click on login
  * Search for your organisation, type "The University of Queensland"
  * click on the name and press "continue to your organisation"
  * Accept that your information will be sent
  * Register (you might change your area of research)
  * click OK, and close the window
  * go back to Login, you should have access now
  * once you are in the page: Launch Virtual Desktops
  * press "Virtual desktops" and "Launch desktop"
  * then, press "show desktop"
  * clik on the RStudio icon
  

## What are we going to learn?

At the end of this session you will be able to:

   * Create a project for data analysis
   * Create a folder structure
   * Know where to find help
   * Understand and move around layouts 
   * Use a few shortcuts
   * Know where packages are
   * Import files/datasets
   
## Attendees   

* Full name / email / twitter 
* Paula Andrea Martinez / p.martinez at uq.edu.au / orchid00
* 


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

Exercise 2 - Check what the description of these functions

    ls()
    demo()
    dir()
  
### Creating a folder structure

We are creating 2 folders:
    * scripts
    * plots
    
Exercise 3 - create a folder called "data"

Exercise 4 - Create a new R script file

    - click the button (+) located at the top left corner of your RStudio
    - click on R script
    - Save the file (ctrl + s or command + s)
    - called "myscript.R"
    - locate this file under the "scripts" folder

Exercise 5 - Add comments to your new R script file

Comments start with #
             # Description:
             # Author
             # Date:

## Playing with objects

Example: We are creating 2 objects

    a_number <- 123
    a_character <- "this is a text"

Exercise 6 - after creating two objects
- list them by using ls()
- remove them or delete them using rm()
- check your objects again using ls()


Exercise 7 - Discuss 
- how can you delete more than one object at the time? (2 min)


***

If we have time

### Shortcuts and Layouts

tab completion
arrow keys

#### Layouts

    Move focus to Source Editor Ctrl+1 Ctrl+1
    Move focus to Console Ctrl+2 Ctrl+2
    Move focus to Help Ctrl+3 Ctrl+3
    Show History Ctrl+4 Ctrl+4
    Show Files Ctrl+5 Ctrl+5
    Show Plots Ctrl+6 Ctrl+6
    Show Packages Ctrl+7 Ctrl+7
    Show Environment Ctrl+8 Ctrl+8
    Show Git/SVN Ctrl+9 Ctrl+9


### Packages

install.packages()


### Import files

download.file()
read.table()
read.csv()

### demo

A real life example to use R for linear models and anova 
demo(lm.glm)

# Close Rproject

File
close project
then close RStudio


## After the workshop

Please fill in the feedback form before leaving: http://tiny.cc/CDS_feedback_R

## Important links
* RStudio Cheatsheet [https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf)
* RStudio online learning [https://www.rstudio.com/online-learning/](https://www.rstudio.com/online-learning/)
* Basic and advanced manuals [https://cran.r-project.org/manuals.html](https://cran.r-project.org/manuals.html)
* Ask about any function or package [http://www.rdocumentation.org/](http://www.rdocumentation.org/)
* If you are looking how-to's or how to fix an error [http://stackoverflow.com/questions/tagged/r](http://stackoverflow.com/questions/tagged/r) 
* Lynda.com R training and tutorials [https://www.lynda.com/R-training-tutorials/1570-0.html](https://www.lynda.com/R-training-tutorials/1570-0.html) remember to sign in with your organisational portal, [for example](https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses)
* ANOVA in R http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
* If you have further questions, please contact me p.martinez at uq.edu.au 
