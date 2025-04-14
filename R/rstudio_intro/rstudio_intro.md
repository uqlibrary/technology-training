# R with RStudio: getting started
UQ Library
2025-04-14

- [R + RStudio](#r--rstudio)
- [Installation](#installation)
- [Open RStudio](#open-rstudio)
- [What are we going to learn?](#what-are-we-going-to-learn)
- [R Projects](#r-projects)
- [Maths and objects](#maths-and-objects)
- [Create a folder structure](#create-a-folder-structure)
- [Scripts](#scripts)
- [Functions](#functions)
- [Import data](#import-data)
- [Explore data](#explore-data)
- [Packages](#packages)
- [Closing RStudio](#closing-rstudio)
- [What next?](#what-next)

## R + RStudio

The [R programming language](https://cran.r-project.org/) is a language
used for calculations, statistics, visualisations and many more data
science tasks.

[RStudio](https://rstudio.com/products/rstudio/) is an open source
Integrated Development Environment (IDE) for R, which means it provides
many features on top of R to make it easier to write and run code.

R’s main strong points are:

- **Open Source**: you can install it anywhere and adapt it to your
  needs;
- **Reproducibility**: makes an analysis repeatable by detailing the
  process in a script;
- **Customisable**: being a programming language, you can create your
  own custom tools;
- **Large datasets**: it can handle very large datasets (certainly well
  beyond the row limitations of Excel, and even further using
  [HPCs](https://rcc.uq.edu.au/high-performance-computing) and [other
  tricks](https://rviews.rstudio.com/2019/07/17/3-big-data-strategies-for-r/));
- **Diverse ecosystem**: packages allow you to extend R for thousands of
  different analyses.

The learning curve will be steeper than point-and-click tools, but as
far as programming languages go, R is more user-friendly than others.

## Installation

For this course, you need to have both R and RStudio installed
([installation
instructions](https://github.com/uqlibrary/technology-training/blob/master/R/Installation.md#r--rstudio-installation-instructions)).

## Open RStudio

- If you are using your own laptop please open RStudio
  - Make sure you have a working Internet connection
- On Library computers:
  - Log in with your UQ username and password (if you are both staff and
    student, use your student account)
  - Make sure you have a working Internet connection
  - Go to search at bottom left corner (magnifying glass)
  - Open the ZENworks application
  - Search for “RStudio”
  - Double-click on RStudio which will install both R and RStudio

## What are we going to learn?

This session is designed to get straight into using R in a short amount
of time, which is why we won’t spend too much time on the smaller
details that make the language.

During this session, you will:

- Create a project for data analysis
- Create a folder structure
- Know where to find help
- Learn about a few useful functions
- Create a script
- Import a dataset
- Understand the different RStudio panels
- Use a few shortcuts
- Know how to extend R with packages
- Generate a data visualisation

## R Projects

Let’s first create a new project:

- Click the “File” menu button (top left corner), then “New Project”
- Click “New Directory”
- Click “New Project”
- In “Directory name”, type the name of your project, for example
  “YYYY-MM-DD_rstudio-intro”
- Browse and select a folder where to locate your project (`~` is your
  home directory). For example, a folder called “r-projects”.
- Click the “Create Project” button

> R Projects make your work with R more straight forward, as they allow
> you to segregate your different projects in separate folders. You can
> create a .Rproj file in a new directory or an existing directory that
> already has R code and data. Everything then happens by default in
> this directory. The .Rproj file stores information about your project
> options, and allows you to go straight back to your work.

## Maths and objects

The **console** (usually at the bottom left in RStudio) is where most of
the action happens. In the console, we can use R interactively. We write
a **command** and then **execute** it by pressing <kbd>Enter</kbd>.

In its most basic use, R can be a calculator. Try executing the
following commands:

``` r
10 - 2
```

    [1] 8

``` r
3 * 4
```

    [1] 12

``` r
2 + 10 / 5
```

    [1] 4

``` r
11^6
```

    [1] 1771561

Those symbols are called “binary operators”: we can use them to
multiply, divide, add, subtract and exponentiate. Once we execute the
command (the “input”), we can see the result in the console (the
“output”).

What if we want to keep reusing the same value? We can store data by
creating **objects**, and assigning values to them with the **assignment
operator** `<-`:

``` r
num1 <- 42
num2 <- num1 / 9
num2
```

    [1] 4.666667

We can also store text data:

``` r
sentence <- "Hello World!"
sentence
```

    [1] "Hello World!"

You should now see your objects listed in you **environment pane** (top
right).

As you can see, you can store different kinds of data as objects. If you
want to store text data (a “string of characters”), you have to use
quotes around them.

> You can use the shortcut <kbd>Alt</kbd>+<kbd>-</kbd> to type the
> assignement operator quicker.

## Create a folder structure

To keep it tidy, we are creating 3 folders in our project directory:

- scripts
- data
- plots

For that, we use the function `dir.create()`:

``` r
dir.create("scripts")
dir.create("data")
dir.create("plots")
```

> You can recall your recent commands with the up arrow, which is
> especially useful to correct typos or slightly modify a long command.

## Scripts

Scripts are simple text files that contain R code. They are useful for:

- saving a set of commands for later use (and executing it in one click)
- making research reproducible
- making writing and reading code more comfortable
- documenting the code with comments, and
- sharing your work with peers

Let’s create a new R script with a command:

``` r
file.create("scripts/process.R")
```

> All the file paths are **relative** to our current working directory,
> i.e. the project directory. To use an **absolute** file path, we can
> start with `/`.

To edit the new script, use the `file.edit()` function. Try using the
<kbd>Tab</kbd> key to autocomplete your function name and your file
path!

``` r
file.edit("scripts/process.R")
```

This opens our fourth panel in RStudio: the **source panel**.

### Many ways to do one thing

As in many programs, there are many ways to achieve one thing.

For example, we used commands to create and edit a script, but we could
also:

- use the shortcut <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd>
- use the top left drop-down menus

Learning how to use functions rather than the graphical interface will
allow you to integrate them in scripts, and will sometimes help you to
do things faster.

### Comments

We should start with a couple of **comments**, to document our script.
Comments start with `#`, and will be ignored by R:

``` r
# Description: Introduction to R and RStudio
# Author: <your name>
# Date: <today's date>
```

### Syntax highlighting

Now, add some commands to your script:

``` r
num1 <- 42
num2 <- num1 / 9
```

Notice the colours? This is called **syntax highlighting**. This is one
of the many ways RStudio makes it more comfortable to work with R. The
code is more readable when working in a script.

> While editing your script, you can run the current command (or the
> selected block of code) by using <kbd>Ctrl</kbd>+<kbd>Enter</kbd>.
> Remember to save your script regularly with the shortcut
> <kbd>Ctrl</kbd>+<kbd>S</kbd>. You can find more shortcuts with
> <kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>K</kbd>, or the menu “Tools \>
> Keyboard Shortcuts Help”.

## Functions

An R **function** is a little program that does a particular job. It
usually looks like this:

    <functionname>(<argument(s)>)

**Arguments** tell the function what to do. Some functions don’t need
arguments, others need one or several, but they always need the
parentheses after their name.

For example, try running the following command:

``` r
round(num2)
```

    [1] 5

The `round()` function rounds a number to the closest integer. The only
argument we give it is `num2`, the number we want to round.

> If you scroll back to the top of your console, you will now be able to
> spot functions in the text.

### Help

What if we want to learn more about a function?

There are two main ways to find **help** about a specific function in
RStudio:

1.  the shortcut command: `?functionname`
2.  the keyboard shortcut: press <kbd>F1</kbd> with your cursor in a
    function name (you can do this by simply clicking on the function
    name)

Let’s look through the documentation for the `round()` function:

``` r
?round
```

As you can see, different functions might share the same documentation
page.

There is quite a lot of information in a function’s documentation, but
the most important bits are:

- **Description**: general description of the function(s)
- **Usage**: overview of what syntax can be used
- **Arguments**: description of what each argument is
- **Examples**: some examples that demonstrate what is possible

See how the `round()` function has a second argument available? Try this
now:

``` r
round(num2, digits = 2)
```

    [1] 4.67

We can change the default behaviour of the function by telling it how
many digits we want after the decimal point, using the argument
`digits`. And if we use the arguments in order, we don’t need to name
them:

``` r
round(num2, 2)
```

    [1] 4.67

To group values together in a single object, use the `c()` function.

`c()` combines the arguments into a vector. In other words, it takes any
number of arguments (hence the `...`), and stores all those values
together, as one single object. For example, let’s store the ages of our
pet dogs in a new object:

``` r
ages <- c(4, 10, 2, NA, 3)
```

> You can store missing data as `NA`.

We can now reuse this vector, and calculate their human age:

``` r
ages * 7
```

    [1] 28 70 14 NA 21

R can create visualisations with functions too. Try a bar plot of your
dogs’ ages with the `barplot()` function:

``` r
barplot(ages)
```

![](rstudio_intro_files/figure-commonmark/unnamed-chunk-10-1.png)

We can customise the plot with a title and some colours, for example:

``` r
barplot(ages, main = "How old are my dogs?", col = "pink")
```

![](rstudio_intro_files/figure-commonmark/unnamed-chunk-11-1.png)

#### Challenge 1 – Finding help

Use the help pages to find out what these functions do, and try
executing commands with them:

1.  `rep.int()`
2.  `mean()`
3.  `rm()`
4.  `citation()`

`rep.int()` creates vectors like `c()`, but it is designed to easily
replicate values. For example, if you find something very funny:

``` r
rep.int("Ha!", 30)
```

     [1] "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!"
    [13] "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!"
    [25] "Ha!" "Ha!" "Ha!" "Ha!" "Ha!" "Ha!"

The next function, `mean()`, returns the mean of a vector of numbers:

``` r
mean(ages)
```

    [1] NA

What happened there?

We have an NA value in the vector, which means the function can’t tell
what the mean is. If we want to change this default behaviour, we can
use an extra argument: `na.rm`, which stands for “remove NAs”.

``` r
mean(ages, na.rm = TRUE)
```

    [1] 4.75

> In our last command, if we hadn’t named the `na.rm` argument, R would
> have understood `TRUE` to be the value for the `trim` argument!

`rm()` removes an object from your environment (`remove()` and `rm()`
point to the same function). For example:

``` r
rm(num1)
```

> R does not check if you are sure you want to remove something! As a
> programming language, it does what you ask it to do, which means you
> might have to be more careful. But you’ll see later on that, when
> working with scripts, this is less of a problem.

Let’s do some more complex operations by combining two functions:

`ls()` returns a character vector: it contains the names of all the
objects in the current environment (i.e. the objects we created in this
R session). Is there a way we could combine it with `rm()`?

You can remove *all* the objects in the environment by using `ls()` as
the value for the `list` argument:

``` r
rm(list = ls())
```

We are nesting a function inside another one. More precisely, we are
using the output of the `ls()` function as the value passed on to the
`list` argument in the `rm()` function.

Finally, the `citation()` function allows you to cite R or a specific
package.

### Incomplete functions

If you don’t finish a function, by leaving off the last bracket `)` for
example, the line of code won’t necessarily give you an error, but it
won’t work very well. If you forget to include that last bracket, R will
run the code, and then wait for further instructions before giving you
an output. This will appear as a `+` in the console like so:

``` r
> round(1.23
+
```

If you try to give any further instructions to R, it will likely just
continue giving you `+` symbols, and not return anything. To stop this,
click on the console and press the `Esc` key on your keyboard.

### More help

We’ve practised how to find help about functions we know the name of.
What if we don’t know what the function is called? Or if we want general
help about R?

- The function `help.start()` is a good starting point: it opens a
  browser of official R help.
- If you want to search for a word in all the documentation, you can use
  the `??` syntax. For example, try executing `??anova`.
- Finally, you will often go to your web browser and search for a
  particular question, or a specific error message: most times, there
  already is an answer somewhere on the Internet. The challenge is to
  ask the right question!

## Import data

### Challenge 2 – Import data

Copy and paste the following two commands into your script:

``` r
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv",
  destfile = "data/gapminderdata.csv")
gapminder <- read.csv("data/gapminderdata.csv")
```

What do you think they do? Describe each one in detail, and try
executing them.

## Explore data

We have downloaded a CSV file from the Internet, and read it into an
object called `gapminder`.

You can type the name of your new object to print it to screen:

``` r
gapminder
```

That’s a lot of lines printed to your console. To have a look at the
first few lines only, we can use the `head()` function:

``` r
head(gapminder)
```

          country year      pop continent lifeExp gdpPercap
    1 Afghanistan 1952  8425333      Asia  28.801  779.4453
    2 Afghanistan 1957  9240934      Asia  30.332  820.8530
    3 Afghanistan 1962 10267083      Asia  31.997  853.1007
    4 Afghanistan 1967 11537966      Asia  34.020  836.1971
    5 Afghanistan 1972 13079460      Asia  36.088  739.9811
    6 Afghanistan 1977 14880372      Asia  38.438  786.1134

Now let’s use a few functions to learn more about our dataset:

``` r
class(gapminder) # what kind of object is it stored as?
```

    [1] "data.frame"

``` r
nrow(gapminder) # how many rows?
```

    [1] 1704

``` r
ncol(gapminder) # how many columns?
```

    [1] 6

``` r
dim(gapminder) # rows and columns
```

    [1] 1704    6

``` r
names(gapminder) # variable names
```

    [1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"

All the information we just saw (and more) is available with one single
function:

``` r
str(gapminder) # general structure
```

    'data.frame':   1704 obs. of  6 variables:
     $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
     $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
     $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
     $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
     $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
     $ gdpPercap: num  779 821 853 836 740 ...

> The RStudio’s environment panel already shows us some of that
> information (click on the blue arrow next to the object name).

And to explore the data in a viewer, click on the table icon next to the
object in the Environment pane.

This viewer allows you to explore your data by scrolling through,
searching terms, filtering rows and sorting the data. Remember that it
is only a viewer: it will never modify your original object.

> Notice that RStudio actually runs the `View()` function. Feel free to
> use that instead of clicking on the button, but note that the case
> matters: using a lowercase “v” will yield an error.

To see summary statistics for each of our variables, you can use the
`summary()` function:

``` r
summary(gapminder)
```

       country               year           pop             continent        
     Length:1704        Min.   :1952   Min.   :6.001e+04   Length:1704       
     Class :character   1st Qu.:1966   1st Qu.:2.794e+06   Class :character  
     Mode  :character   Median :1980   Median :7.024e+06   Mode  :character  
                        Mean   :1980   Mean   :2.960e+07                     
                        3rd Qu.:1993   3rd Qu.:1.959e+07                     
                        Max.   :2007   Max.   :1.319e+09                     
        lifeExp        gdpPercap       
     Min.   :23.60   Min.   :   241.2  
     1st Qu.:48.20   1st Qu.:  1202.1  
     Median :60.71   Median :  3531.8  
     Mean   :59.47   Mean   :  7215.3  
     3rd Qu.:70.85   3rd Qu.:  9325.5  
     Max.   :82.60   Max.   :113523.1  

Notice how categorical and numerical variables are handled differently?

Let’s now plot the relationship between GDP per capita and life
expectancy:

``` r
plot(gapminder$gdpPercap, gapminder$lifeExp,
     xlab = "GDP per capita (USD)",
     ylab = "Life expectancy (years)")
```

![](rstudio_intro_files/figure-commonmark/unnamed-chunk-23-1.png)

> For more on visualisations, we will dive into the ggplot2 package
> during two of our other R sessions.

Finally, let’s fit a linear model to see how strongly correlated the two
variables are:

``` r
linear_model <- lm(gapminder$lifeExp ~ gapminder$gdpPercap)
summary(linear_model)
```


    Call:
    lm(formula = gapminder$lifeExp ~ gapminder$gdpPercap)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -82.754  -7.758   2.176   8.225  18.426 

    Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
    (Intercept)         5.396e+01  3.150e-01  171.29   <2e-16 ***
    gapminder$gdpPercap 7.649e-04  2.579e-05   29.66   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 10.49 on 1702 degrees of freedom
    Multiple R-squared:  0.3407,    Adjusted R-squared:  0.3403 
    F-statistic: 879.6 on 1 and 1702 DF,  p-value: < 2.2e-16

The P-value suggests that there is a strong relationship between the
two.

## Packages

Packages add functionalities to R and RStudio. There are [more than
21000](https://cran.r-project.org/web/packages/index.html) available.

You can see the list of installed packages in your “Packages” tab, or by
using the `library()` function without any argument.

We are going to install a package called “skimr”. We can do that in the
Packages tab:

1.  Open the “Packages” tab (bottom-right pane)
2.  Click the “Install” button
3.  Search for “skimr”
4.  Click “Install”

Notice how it runs an `install.packages()` command in the console? You
can use that too.

If I now try running the command `skim()`, I get an error. That’s
because, even though the package is installed, I need to **load** it
every time I start a new R session. The `library()` function does that.
Let’s load the package, and use the `skim()` function to get an
augmented summary of our `gapminder` dataset:

``` r
library(skimr) # load the package
skim(gapminder) # use a function from the package
```

|                                                  |           |
|:-------------------------------------------------|:----------|
| Name                                             | gapminder |
| Number of rows                                   | 1704      |
| Number of columns                                | 6         |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |           |
| Column type frequency:                           |           |
| character                                        | 2         |
| numeric                                          | 4         |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |           |
| Group variables                                  | None      |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| country       |         0 |             1 |   4 |  24 |     0 |      142 |          0 |
| continent     |         0 |             1 |   4 |   8 |     0 |        5 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate | mean | sd | p0 | p25 | p50 | p75 | p100 | hist |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| year | 0 | 1 | 1979.50 | 17.27 | 1952.00 | 1965.75 | 1979.50 | 1993.25 | 2007.0 | ▇▅▅▅▇ |
| pop | 0 | 1 | 29601212.33 | 106157896\.75 | 60011.00 | 2793664.00 | 7023595.50 | 19585221.75 | 1318683096.0 | ▇▁▁▁▁ |
| lifeExp | 0 | 1 | 59.47 | 12.92 | 23.60 | 48.20 | 60.71 | 70.85 | 82.6 | ▁▆▇▇▇ |
| gdpPercap | 0 | 1 | 7215.33 | 9857.45 | 241.17 | 1202.06 | 3531.85 | 9325.46 | 113523.1 | ▇▁▁▁▁ |

This function provides further summary statistics, and even displays a
small histogram for each numeric variable.

> Packages are essential to use R to its full potential, by making the
> most out of what other users have created and shared with the
> community. To get an idea of some of the most important packages
> depending on your field of study, you can start with the [CRAN Task
> Tiews](https://cran.r-project.org/web/views/).

## Closing RStudio

You can close RStudio after making sure that you saved your script.

When you create a **project** in RStudio, you create an .Rproj file that
gathers information about the state of your project. When you close
RStudio, you have the option to save your **workspace** (i.e. the
objects in your **environment**) as an .Rdata file. The .Rdata file is
used to reload your workspace when you open your project again. Projects
also bring back whatever source file (e.g. script) you had open, and
your command history. You will find your command history in the
“History” tab (upper right panel): all the commands that we used should
be in there.

If you have a script that contains all your work, it is a good idea
*not* to save your workspace: it makes it less likely to run into errors
because of accumulating objects. The script will allow you to get back
to where you left it, by executing all the clearly laid-out steps.

The console, on the other hand, only shows a brand new R **session**
when you reopen RStudio. Sessions are not persistent, and a clean one is
started when you open your project again, which is why you have to load
any extra package your work requires again with the `library()`
function.

## What next?

- You can see what is next in our [cycle of R
  lessons](../../README.md#r-sessions)
- We have a [compilation of
  resources](https://github.com/uqlibrary/technology-training/blob/master/R/usefullinks.md)
  for the rest of your R learning
- And a cheatsheet of [main terms and concepts for
  R](https://github.com/uqlibrary/technology-training/blob/master/R/terminology.md)
