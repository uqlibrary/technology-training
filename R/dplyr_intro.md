Introduction to R data manipulation using dplyr
===

[]

Thank you for attending this session at the UQ library Centre for Digital Scholarship (CDS). Please complete the following feedback form before leaving https://framaforms.org/cds-sessions-feedback-1521148191.

If you want to review the installation instructions: https://github.com/stragu/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you are using Library computers.

Useful links, exercises and more information on how to continue your R learning are provided in our community resource in this Etherpad: https://etherpad.wikimedia.org/p/cds-dplyr
During the session, it is the only document you need to have open.

## Keep in mind

* Case sensitive
* No spaces in names
* Be ready to learn a new language, lots of new vocabulary

## What are we going to learn?

In this hands-on session, you will use RStudio and the `dplyr` package to manipulate your data.

Specifically, you will learn how to **explore, filter, reorganise and process** your data with the following verbs:

```
filter()
arrange()
select()
group_by()
summarise()
mutate()
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

### Project and folders

Exercise 1 - New RStudio project

* Click the "File" menu button (top left corner), then "New Project"
* Click "New Directory"
* Click "New Project" ("Empty project" if you have an older version of RStudio)
* In "Directory name", type the name of your project, e.g. "dplyr_intro"
* Select the folder where to locate your project: the `Documents/RProjects` folder, which you can create if it doesn't exist yet.
* Click the "Create Project" button
* create three folders in your new project
    * `dir.create("scripts") `
    * `dir.create("data")`
    * `dir.create("plots")`

### Setting up

Exercise 2 - create a script, install `dplyr`

* Menu: Top left corner, click the green "plus" symbol, or press the shortcut (for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N. This will open an "Untitled1" file.
* Go to "File > Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S. This will ask where you want to save your file and the name of the new file.
* Call your file "dplyr_intro.R" located in the "scripts" folder

We can add a sequence of useful commands to our script as we go.

* Install and load the `dplyr` package:
    * in the console, install the package: `install.packages("dplyr")`
    * While you wait for dplyr to be installed, check https://www.rdocumentation.org and type "dplyr" in the search
    * load the package: `library(dplyr)`

:::info
At home, you can install the whole "[tidyverse](https://www.tidyverse.org/)", a meta-package of useful packages for data science: 

```
install.packages("tidyverse")
```

(It takes a few minutes depending on your internet connection but installs many useful packages)
:::

You only need to install a package once (with `install.packages()`), but you need to reload it every time you start a new R session (with `library()`).

### Introducing our data

Exercise 3 – import and explore data

1. import the data from the internet
    * the file is located at https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv
    * read about the `download.file()` function with: `?download.file`
    * `download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", destfile = "data/gapminder.csv")`
2. read the data into a an object called "gapminder", using `read.csv()`:
```
gapminder <- read.csv("data/gapminder.csv")
```
3. Explore the gapminder dataset using `dim()` and `str()`

How can we get the dataframe's variable names? There are two ways: `names(gapminder)` returns the names regardless of the object type, such as list, vector, data.frame etc., whereas `colnames(gapminder)` returns the variable names for matrix-like objects, such as matrix, data.frame

To select one specific column in the dataframe, you can use the dollar sign as in: `gapminder$year`. For example, try these:

```
nlevels(gapminder$country)
class(gapminder$country)
```

:::info
If we want nicer printing, we can convert our dataframe to a "tibble":

```
install.packages(tibble)
library(tibble)
gapminder <- as_tibble(gapminder)
```
:::

### Help

For any dataset or function doubts that you might have, don't forget the three ways of getting help in RStudio:

1. ?functionname
2. help(functionname) 
3. functionname + F1

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

To use the verbs to their full extent, we will need **pipes** and **conditionals**.

We can use a pipe symbol `%>%` (Similar to "+" in ggplot2) to **string commands together**.

Conditionals allow us to **check for a condition**. Remember: `=` is to give a value to the variable, `==` is to set a condition 

* `==` equal
* `!=` different 
* `>` greater than
* `<` smaller than
* `>=` greater or equal
* `<=` smaller or equal


#### Pick observations with `filter()`

Filter the observations for Australia, using `filter()` and a conditional:

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

We can make our code more readable and avoid creating useless objects by **piping** commands into each other. To do what we just did in one command:

```
gapminder_small_1997 <- gapminder %>%
    select(year, country, gdpPercap) %>%
    filter(year == 1997)
```

Use Shift + Enter to go to the next line without executing the command.

Probably a good time to copy our code to our script!

Exercise 4 – Select the 2002 life expectancy observation for Eritrea

```
eritrea_2002 <- gapminder %>%
    select(year, country, lifeExp) %>%
    filter(country == "Eritrea", year == 2002)
```

#### `group_by()` and `summarise()`

Exercise 5 – Understand `group_by()` and `summarise()`

```
?group_by
?summarise
```

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

Associating the two functions makes it more interesting. To find out the mean life expectancyfor each continent in 2007, we can do the following:

```
gapminder_continents_LE2007 <- gapminder %>% 
    filter(year == 2007) %>%
    group_by(continent) %>%
    summarise(meanLE = mean(lifeExp))
gapminder_continents_LE2007
```

Exercise 6 – group by continent and country, and find out the max life expectancy ever recorded

Hint: `?max`

```
gapminder_continents_country_LE <- gapminder %>% 
    group_by(continent, country) %>%
    summarise(maxLE = max(lifeExp))
gapminder_continents_country_LE
```

#### Create new variables with `mutate()`

Have a look at what the verb `mutate()` can do with `?mutate`.

Let's see what the two following variables can be used for:

```
gapminder %>%
    select(gdpPercap, pop)
```

Exercise 7 – use `mutate()` to create a `gdp` variable

Name your new dataset `gapminder_gdp`. When finished, `dim(gapminder_gdp)` should result in `1704 7`.

Hint: use the `*` operator within `mutate()`.

```
gapminder_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop)
dim(gapminder_gdp)
head(gapminder_gdp)
```

#### More

Explore the variation `transmute()`:

```
(gapminder_gdp <- gapminder %>%
    transmute(gdp = gdpPercap * pop))
```

Reuse a variable computed by 'mutate()':

```
(gapminder_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop, gdpMil = gdp / 10^6))
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

## After the workshop

Please fill in the feedback form before leaving: [https://framaforms.org/cds-sessions-feedback-1521148191](https://framaforms.org/cds-sessions-feedback-1521148191)

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