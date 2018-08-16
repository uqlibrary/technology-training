---
Title: Introduction to R data manipulation using dplyr
---

`last revision: 2018-08-16`

If you want to review the installation instructions: https://gitlab.com/stragu/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you are using Library computers.

Useful links, exercises and more information on how to continue your R learning are provided in our community resource in this Etherpad: https://etherpad.wikimedia.org/p/cds-dplyr
During the session, it is the only document you need to have open.

## Keep in mind

* Case sensitive
* No spaces in names

### Help

For any dataset or function doubts that you might have, don't forget the three ways of getting help in RStudio:

1. the shortcut command: `?functionname`
2. the help function: `help(functionname)`
3. the keyboard shortcut: press F1 after writing a function name

## What are we going to learn?

In this hands-on session, you will use RStudio and the `dplyr` package to manipulate your data.

Specifically, you will learn how to **explore, filter, reorganise and process** your data with the following verbs:

```
filter() # pick observations
arrange() # reorder rows
select() # pick variables
mutate() # create new variables
summarise() # collapse to a single summary
group_by() # change the scope of function
```

## Disclaimer

We will assume you are an R beginner, who has used R before.

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

## Material

### New project

Exercise 1 - New RStudio project

* Click the "File" menu button (top left corner), then "New Project"
* Click "New Directory"
* Click "New Project" ("Empty project" if you have an older version of RStudio)
* In "Directory name", type the name of your project, e.g. "dplyr_intro"
* Select the folder where to locate your project: the `Documents/RProjects` folder, which you can create if it doesn't exist yet.
* Click the "Create Project" button

### Setting up

Exercise 2 - create a script, install `dplyr`

* Menu: Top left corner, click the green "plus" symbol, or press the shortcut (for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N. This will open an "Untitled1" file.
* Go to "File > Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S. This will ask where you want to save your file and the name of the new file.
* Call your file "dplyr_intro.R"

We can add a sequence of useful commands to our script as we go.

* Install and load the `dplyr` package:
    * in the console, install the package: `install.packages("dplyr")`
    * While you wait for dplyr to be installed, check https://www.rdocumentation.org and type "dplyr" in the search
    * load the package: `library(dplyr)`

> At home, you can install the whole "[tidyverse](https://www.tidyverse.org/)", a meta-package of useful packages for data science: 

You only need to install a package once (with `install.packages()`), but you need to reload it every time you start a new R session (with `library()`).

### Introducing our data

Exercise 3 – import and explore data

1. read the data into an object called "gapminder", using `read.csv()`:

```
gapminder <- read.csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")
```

2. Explore the gapminder dataset using `dim()` and `str()`

How can we get the dataframe's variable names? There are two ways: `names(gapminder)` returns the names regardless of the object type, such as list, vector, data.frame etc., whereas `colnames(gapminder)` returns the variable names for matrix-like objects, such as matrices, dataframes...

To select one specific column in the dataframe, you can use the dollar sign in: `gapminder$year`. For example, try these:

```
nlevels(gapminder$country)
class(gapminder$country)
```

If we want nicer printing, we can convert our dataframe to a "tibble":

```
install.packages(tibble)
library(tibble)
gapminder <- as_tibble(gapminder)
```

### Basic dplyr verbs

The R package `dplyr` was developed by Hadley Wickham for data manipulation.

The book _[R for Data Science](http://r4ds.had.co.nz)_ introduces the package as follows:

> You are going to learn the five key dplyr functions that allow you to solve the vast majority of your data manipulation challenges:
> 
> * Pick observations by their values with `filter()`.
> * Reorder the rows with `arrange()`.
> * Pick variables by their names with `select()`.
> * Create new variables with functions of existing variables with `mutate()`.
> * Collapse many values down to a single summary with `summarise()`.
> 
> These can all be used in conjunction with `group_by()` which changes the scope of each function from operating on the entire dataset to operating on it group-by-group. These six functions provide the **verbs for a language of data manipulation**.

To use the verbs to their full extent, we will need **pipes** and **logical operators**, which we will introduce as we go.

#### Pick observations with `filter()`

The `filter()` function allows use to pick observations depending on one ore several conditions.

**Logical operators** allow us to **check for a condition**. Remember: `=` is to assign a value to a variable, `==` is to check for a condition.

* `==` equal
* `!=` different 
* `>` greater than
* `<` smaller than
* `>=` greater or equal
* `<=` smaller or equal

Filter the observations for Australia, using `filter()` and a logical operator:

```
australia <- filter(gapminder, country == "Australia")
australia
```

Filter the rows that have a life expectancy `lifeExp` greater than 80 years:

```
life80 <- filter(gapminder, lifeExp > 80)
dim(life80)
```

#### Reorder rows with `arrange()`

If we want to have a look at the entries with highest GDP per capita:

```
arrange(gapminder, desc(gdpPercap))
```

#### Pick variables with `select()`

Select allows use to pick variable (i.e. columns) from the dataset. For example, to only keep the data about year, country and GDP per capita:

```
(gapminder_small <- select(gapminder, year, country, gdpPercap))
```

We wrap it in parentheses so it also prints to screen.

If we only want this data for 1997, we can associate `select()` to `filter()`:

```
gapminder_small_1997 <- filter(gapminder_small, year == 1997)
```

We can make our code more readable and avoid creating useless intermediate objects by **piping** commands into each other. The pipe symbol `%>%` **strings commands together**, using the left-side output as the first argument of the right-side function.

For example, this command:

```
gapminder %>%
  filter(country != "France")
```

... becomes:

```
filter(gapminder, country != "France")
```

To do what we did previously in one single command:

```
gapminder_small_1997 <- gapminder %>%
    select(year, country, gdpPercap) %>%
    filter(year == 1997)
```

The pipe operator can be read as "then" and makes the code a lot more readable than when nesting functions into each other.

From now on, we'll use this syntax.

> When in the console, use <kbd>Shift</kbd> + <kbd>Enter</kbd> to go to the next line without executing the command.

Exercise 4 – Select the 2002 life expectancy observation for Eritrea (and remove the rest of the variables)

```
eritrea_2002 <- gapminder %>%
    select(year, country, lifeExp) %>%
    filter(country == "Eritrea", year == 2002)
```

#### Create new variables with `mutate()`

Have a look at what the verb `mutate()` can do with `?mutate`.

Let's see what the two following variables can be used for:

```
gapminder %>%
    select(gdpPercap, pop)
```

Exercise 5 – use `mutate()` to create a `gdp` variable

Name your new dataset `gapminder_gdp`. When finished, `dim(gapminder_gdp)` should result in `1704 7`.

Hint: use the `*` operator within `mutate()`.

```
gapminder_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop)
dim(gapminder_gdp)
head(gapminder_gdp)
```

Reuse a variable computed by 'mutate()' straight away:

```
(gapminder_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop, gdpMil = gdp / 10^6))
```

#### `group_by()` and `summarise()`

`group_by()` changes the scope of each function from operating on the entire dataset to operating on it group-by-group. For example, to group by continents:

```
gapminder_continents <- gapminder %>%
    group_by(continent)
head(gapminder_continents)
```

`summarise()` collapses many values down to a single summary. For example, to find the mean life expectancy for the whole dataset:

```
gapminder %>%
  summarise(meanLE = mean(lifeExp))
```

Associating the two functions makes it more interesting. To find out the mean life expectancy for each continent in 2007, we can do the following:

```
gapminder %>% 
    filter(year == 2007) %>%
    group_by(continent) %>%
    summarise(meanLE = mean(lifeExp))
```

Exercise 6 – group by country, and find out the maximum life expectancy ever recorded

Hint: `?max`

```
gapminder %>% 
    group_by(country) %>%
    summarise(maxLE = max(lifeExp))
```

#### More examples

Explore the function `transmute()`:

```
gapminder %>%
    transmute(gdp = gdpPercap * pop)
```

Another example of new variable with `mutate()`:

```
starwars %>% 
  mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, bmi)
```

And a more complex processing of a dataset:

```
starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1)
```

## Close Rproject

If you want to close RStudio, you should save your project first.

* File
* close project (It will ask you if you want to save your history) 
* then, close RStudio

## Important links

* R ggplot2 Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf
* R dplyr cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf
* RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
* RStudio online learning: https://www.rstudio.com/online-learning/
* Basic and advanced manuals: https://cran.r-project.org/manuals.html
* Ask about any function or package: http://www.rdocumentation.org/
* If you are looking how-to's or how to fix an error: http://stackoverflow.com/questions/tagged/r
* Lynda.com R training and tutorials: https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in from UQ,
 https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
* ANOVA in R: http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
* If you need an R and/or RStudio workshop/session, please contact Centre for Digital Scholarship staff to organise one for you: https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
