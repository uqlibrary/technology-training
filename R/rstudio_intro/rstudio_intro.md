R with RStudio: getting started
===

`version: 2019-02-15`

> These notes are available on GitLab: https://gitlab.com/stragu/CDS/blob/master/R/rstudio_intro/rstudio_intro.md

If you want to review the installation instructions: https://gitlab.com/stragu/CDS/blob/master/R/Installation.md

## RStudio

RStudio is an open source IDE (Integrated Development Interface) for the R programming language.
We can use R for calculations and visualisations.

## Open RStudio

* If you are using your own laptop please open RStudio
  * Make sure you have a working internet connection
* On CDS computers:
  * Log in with your UQ username and password
  * Make sure you have a working internet connection
  * Go to search at bottom left corner (magnifiying glass) 
  * Open the ZENworks application
  * Look for the letter R 
  * Double click on RStudio which will install both R and RStudio 

## What are we going to learn?

This session is designed to get straight into using R in a short amount of time, which is why we won't spend too much time on the smaller details that make the language.

At the end of this session you will be able to:

* Create a project for data analysis
* Create a folder structure
* Know where to find help
* Use a script
* Import files/datasets
* Understand the different RStudio pannels
* Use a few shortcuts
* Know where packages are

## Material

### Rstudio Project

Let's first create a new RStudio project:

* Click the "File" menu button (top left corner), then "New Project"
* Click "New Directory"
* Click "New Project"
* In "Directory name", type the name of your project, e.g. "rstudio_intro" (Browse and select a folder where to locate your project, if you want to keep them all in one spot. For example, a folder called "r_projects".)
* Click the "Create Project" button

> R Projects make your work with R more straight forward, as they allow you to segregate your different projects in separate folders. You can create a .Rproj file in a new directory or an existing directory that already has R code and data. The .Rproj file stores information about your project options, and allows you to go straight back to your work.

### Maths and objects

In the **console**, we can use R interactively. We write a **command** and then **execute** it by pressing <kbd>Enter</kbd>.

R can be used like a calculator. Try the following commands:

``` r
3 * 4
10 / 2
11^6
```

We can store data by creating **objects**, and assigning values to them with the **assignment operator** `<-`:

``` r
num1 <- 42
num2 <- num1 / 9
sentence <- "Hello World!"
```

> You can use the shortcut <kbd>Alt</kbd>+<kbd>-</kbd> to type the assignement operator quicker.

### Using functions

An R function usually looks like this:

```
<functionname>(<argument(s)>)
```

For example, try running the following command:

``` r
log10(x = num1)
```

#### Help

There are two main ways to find help about a function in RStudio:

1. the shortcut command: `?functionname`
1. the keyboard shortcut: press <kbd>F1</kbd> with your cursor in a function name

**Challenge 1** - Use the help pages to find out what these functions do, and try executing commands with them:

* `c()`
* `class()`
* `rm()`
* `citation()`

`c()` concatenates the arguments into a vector. For example:

``` r
vect1 <- c(4, 7, 2, 3)
```

> The argument `...` means we can pass on any number of values.

`class()` shows you what the class of an object is. For example:

``` r
class(vect1)
```

> We don't need to specify the names of the arguments if we use them in order.

`rm()` removes an object from your environment. For example:

``` r
rm(num1)
```

`citation()` outputs the proper way to cite R, or a different package if we overwrite the default value for the `package` argument. For example:

``` r
citation("MASS")
```

Let's do some more complex operations by combining two functions:

`ls()` lists the objects in the current R environment.
For example, try running the `ls()` function after executing the command `a <- 42`.

You can remove *all* the objects in the environment by using `ls()` as the value for the `list` argument:

``` r
rm(list = ls())
```

### Creating a folder structure

To keep it tidy, we are creating 3 folders in our project directory:

* scripts
* data
* plots

For that, we use the function `dir.create()`:

``` r
dir.create("scripts")
dir.create("data")
dir.create("plots")
```

> You can recall your recent commands with the up arrow, which is especially useful to correct typos or slightly modify a long command.

### Scripts

Scripts are simple text files that contain R code. They are useful for:

* saving a set of commands for later use (and executing it in one click)
* making research reproducible
* documenting some code, and
* sharing your work with peers

Let's create a new R script with a command:

``` r
file.create("scripts/process.R")
```

> All the file paths are **relative** to our current working directory, i.e. the project directory. To use an **absolute** file path, we can start with `/`.

To edit the new script, use the `file.edit()` function. Try using the <kbd>Tab</kbd> key to autocomplete your function name and your file path!

``` r
file.edit("scripts/process.R")
```

This opens our fourth pannel in RStudio: the **source pannel**.

### Many ways to do one thing

As in many programs, there are many ways to achieve one thing.

For example, we used commands to create and edit a script, but we could also:

* use the shortcut <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd>
* use the top left drop-down menus

Learning how to use functions rather than the graphical user interface (GUI) will allow you to integrate them in scripts, and will sometimes help you to do things faster.

#### Edit the script

We should start with a couple of **comments**, to document our script. Comments start with `#`, and will be ignored by R:

``` r
# Description:
# Author:
# Date:
```

Now, add a command to your script:

``` r
num1 <- log10(300)
```

Notice the colours? This is called **syntax highlighting**. This is one of the many ways RStudio makes it more comfortable to work with R. The code is more readable when working in a script.

> While editing your script, you can run the active line (or the selected block of lines) by using <kbd>Ctrl</kbd>+<kbd>Enter</kbd>. Remember to save your script regularly with the shortcut <kbd>Ctrl</kbd>+<kbd>S</kbd>. You can find more shortcuts with <kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>K</kbd>, or the menu "Tools > Keyboard Shortcuts Help".

### Import data

**Challenge 2** – Import data

Copy and paste the following two commands into your script:

``` r
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
  destfile = "data/gapminderdata.csv")
gapminder <- read.csv("data/gapminderdata.csv")
```

What do you think they do? Describe each one in detail, and try executing them.

### Explore data

You can type the name of your new object to print it to screen:

``` r
gapminder
```

That's a lot of lines. To have a look at the first few lines only, we can use the `head()` function:

``` r
head(gapminder)
```

Now let's use a few functions to learn more about our dataset:

``` r
class(gapminder) # what kind of object is it stored as?
nrow(gapminder) # how many rows?
ncol(gapminder) # how many columns?
dim(gapminder) # rows and columns
names(gapminder) # variable names
```

All the information we just saw is available with one single function:

``` r
str(gapminder) # general structure
```

And to explore the data in the viewer, run the following:

``` r
View(gapminder) # spreadsheet-like view (Note how the case matters in R.)
```

> Notice that RStudio's environment pannel already shows us some of that information (click on the blue arrow next to the object name). You can also click on the object to open the viewer.

Finally, to see summary statistics for each of our variables:

``` r
summary(gapminder)
```

Notice how categorical and numerical variables are handled differently?

### Plotting

R has a number of base plotting functions to visualise data in many different ways.

For example, to visualise our data:

``` r
plot(x = gapminder$gdpPercap,
     y = gapminder$lifeExp)
hist(gapminder$pop)
boxplot(gapminder$lifeExp~gapminder$continent)
```

### Packages

Packages add functionnalities to R and RStudio. There are more than 16000 available.

You can see the list of installed packages in your "Packages" tab, or by using the `library()` function without any argument.

We are going to install and load a new package called `praise`. We can do that with the GUI: click the "Install" button in the "Packages" tab, and search for "praise".

Notice how it runs an `install.packages()` command in the console? You can use that too.

If I try running the command `praise()`, I get an error. That's because, even though the package is installed, I need to **load** it every time I start a new R session. The `library()` function can do that.

``` r
library(praise) # load the package
praise() # use a function from the package
```

Even though you might need the motivation provided by this function, other packages are more useful for your work. For example, the package `ggplot2` introduces a logic that makes data visualisation more streamlined, called "Grammar of graphics". We present this package in other sessions.

### Close RStudio

You can close RStudio after making sure that you saved your script.

When you create a **project** in RStudio, it create an .Rproj file that gathers information about your project, and it allows you to save your **workspace** inside an .Rdata file. The .Rdata file is by default used to reload your workspace when you open your Rproject again (i.e. the objects in your **environment**). Rprojects also bring back whatever source file (e.g. script) you had open, and your command history. You will find your command history in the "History" tab (upper right panel): all the commands that we used should be in there.

If you have a script that contains all your work, it is a good idea _not_ to save your workspace: it makes it less likely to run into errors because of accumulating objects. The script will allow you to get back to where you left it, by executing all the clearly laid-out steps.

The console, on the other hand, only shows a brand new R **session** when you reopen RStudio. Sessions are not persistent, and a new one is started when you open your project again, which is why you have to load any extra package your work requires again with the `library()` function.

## What next?

We have a compilation of links for the rest of your R learning: https://gitlab.com/stragu/DSH/blob/master/R/usefullinks.md
