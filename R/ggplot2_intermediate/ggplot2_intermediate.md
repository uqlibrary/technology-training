R visualisations using ggplot2 – intermediate
================
2018-08-30

> This document is written as an .Rmd document, and then knitted into a GitHub-flavoured markdown document. The source code is available at: <https://gitlab.com/stragu/CDS/blob/master/R/ggplot2_intermediate/ggplot2_intermediate.Rmd>
> The published document is available at: <https://gitlab.com/stragu/CDS/blob/master/R/ggplot2_intermediate/ggplot2_intermediate.md>

If you need to review the installation instructions: <https://gitlab.com/stragu/CDS/blob/master/R/Installation.md>

Keep in mind
------------

-   Case sensitive
-   No spaces in names
-   You can use <kbd>Ctrl</kbd>+<kbd>Shift</kbd> to space out your code and <kbd>Ctrl</kbd>+<kbd>Enter</kbd> to run a command.

Open RStudio
------------

On library computers:

-   Log in with your UQ username and password
-   Make sure you have a working internet connection
-   Go to search the magnifying glass (bottom left)
-   Open the ZENworks application
-   Look for the letter R
-   Double click on RStudio which will install both R and RStudio

If you are using your own laptop:

-   Make sure you have a working internet connection
-   Open RStudio

Disclaimer
----------

We will assume you are an R intermediate user and that you have used `ggplot2` before.

What are we going to learn?
---------------------------

During this hands-on session, you will:

-   install a tool for picking colours
-   customise scales and ranges
-   divide a visualisation in facets
-   explore new geometries
-   modify statistical transformations
-   adjust a geometry's position
-   further modify themes

Material
--------

### Setting up

*Exercise 1 - New RStudio Project*

-   Click the "Create a project" button (top left cube icon)
-   Click "New Directory"
-   Click "New Project" ("Empty project" if you have an older version of RStudio)
-   In "Directory name", type the name of your project, e.g. "ggplot2\_inter"
-   Select the folder where to locate your project: the `Documents/RProjects` folder, which you can create if it doesn't exist yet
-   Click the "Create Project" button
-   Create two folders: "scripts" and "plots".

``` r
dir.create("scripts")
dir.create("plots")
```

*Exercise 2 - Setting up: packages and scripts*

-   Install and load the package `ggplot2`
-   Install only if you haven't yet done so using: `install.packages("ggplot2")`
-   Load the package using:

``` r
library(ggplot2)
```

-   In the "scripts" folder create (and open) a new R script file called "gapminder\_example.R":

``` r
file.create("scripts/gapminder_example.R")  # create
file.edit("scripts/gapminder_example.R")    # open
```

Don't forget to add some comments to your header:

    # Description : ggplot2 intermediate with gapminder data
    # Author: <your name>
    # Date: <today's date>

### Import data

*Exercise 3 – Read the online data into an R object*

Using the following syntax, how can you read the online CSV data into an R object?

    gapminder <- ...

You have to use the `read.csv()` function, which can take a URL:

``` r
gapminder <- read.csv(
  file = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")
```

*Exercise 4 - Explore the dataset*

You can use `dim()`, `str()`, `head()`, `tail()`, `View()` and `summary()` to explore your dataset.

``` r
dim(gapminder)     # what size is the data frame?
str(gapminder)     # how is it structured?
head(gapminder)    # have a look at the first few observations
tail(gapminder)    # have a look at the last few observations
View(gapminder)    # view as a separate spreadsheet
summary(gapminder) # summary statistics for each variable
```

Familiarise yourself with the variable names:

``` r
colnames(gapminder)
```

    ## [1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"

### Explore data visually

Let's start with a question: Does population grow over the years?

We can make a simple plot with the basics of `ggplot2`:

``` r
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop)) +
  geom_point()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-7-1.png)

Remember that only the *data*, the *geometry* and the *aesthetic mappings* always need to be specified.

### Aesthetics available

To change the *shape* based on a variable, use `shape = <discrete variable>` inside the `aes()` call.

Similarly, to change the *colour* based on a variable, use `colour = <variable>` and `fill = <variable>` inside the `aes()` call.

Finally, if you want to change the size of the geometric object, you can use the `size = <variable>` argument.

#### More control over colours

*Exercise 5 – Choosing colours*

The `colourpicker` package is a handy addin for RStudio. Install it and use the new "Addins &gt; Colour Picker" menu to pick a different colour for your geometry.

For example, to colour all the points in my geometry (regardless of data):

``` r
# install the package if you don't have it already:
# install.packages("colourpicker")
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop)) +
  geom_point(colour = "chartreuse3") # change the default colour
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-8-1.png)

*Exercise 6 – Colour according to continent*

Modify your plot to colour the points according to the continent variable.

``` r
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop,
                     colour = continent)) +
  geom_point()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-9-1.png)

We can also use different palettes. You can see the ones available in `ggplot2` by looking at the help page of, for example, `scale_colour_brewer()`.

If you want a visual overview of the Brewer palettes, install the `RColorBrewer` package and try the following functions:

``` r
library(RColorBrewer)
display.brewer.all() # all palettes
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-10-1.png)

``` r
display.brewer.all(colorblindFriendly = TRUE) # only colourblind-friendly palettes
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-10-2.png)

Now, try a different palette for your continents:

``` r
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop,
                     colour = continent)) +
  geom_point() +
  scale_colour_brewer(palette = "Set2")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-11-1.png)

### Scales and limits

We could further modify our plot to use a different y axis scale to space out the data:

``` r
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop,
                     colour = continent)) +
  geom_point() +
  scale_y_log10()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-12-1.png)

> Being explicit about the **argument names** is useful when learning the ins and outs of a function, but as you get more familiar with ggplot2, you can do away with the obvious ones, like `data =` and `mapping =` (as long as they are used in the right order!).

To reuse the constant base of our plot (the `ggplot()` call and the point geometry), we can create an object:

``` r
gg_scatter <- ggplot(gapminder,
                     aes(x = year,
                         y = pop,
                         colour = continent)) +
  geom_point()
```

*Exercise 7 - Modify the axis breaks*

Our x axis is not detailed enough.

We can create a list of all the years when data was collected with the `unique()` function, and modify our plot to add more breaks to our x axis with the `scale_x_continuous()` function. How would you use them?

``` r
# list all the unique values for year
unique_years <- unique(gapminder$year)
# modify the x axis scale
gg_scatter +
  scale_y_log10() +
  scale_x_continuous(breaks = unique_years)
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-14-1.png)

We can further customise a scale with breaks and labels:

``` r
gg_scatter +
  scale_x_continuous(breaks = unique_years) +
  scale_y_continuous(breaks = c(0, 100000000, 200000000, 500000000, 1000000000),
                     labels = c(0, "100 m", "200 m", "500 m", "1 b"))
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-15-1.png)

*Exercise 8 - Modify your y scale range*

To zoom in, we might want to restrict the range by using `ylim()`.

``` r
gg_scatter +
  ylim(c(0, 360000000))
```

    ## Warning: Removed 24 rows containing missing values (geom_point).

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-16-1.png)

Let's talk about that warning message. We could use the `subset()` function to avoid that.

### Histograms

*Exercise 9 – Create a histogram of life expectancy*

Search for the histogram geometry function, and plot the life expectancy. How can we modify the bars?

``` r
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram() # by default, bins = 30
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-17-1.png)

Let's change the bin width:

``` r
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram(binwidth = 15)
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-18-1.png)

We can also change the number of bins:

``` r
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram(bins = 10)
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-19-1.png)

And colour by continent:

``` r
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(bins = 10)
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-20-1.png)

The histogram geometry uses the "stack" **position** by default. It might be more readable if we change it so it uses ratios instead, using `position = "fill"` argument:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 10,
                 position = "fill")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-21-1.png)

We can also make the bars "dodge"" each other:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 10,
                 position = "dodge")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-22-1.png)

### Faceting

An even more readable representation could use **facetting**:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) 
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-23-1.png)

### Theming

The legend is probably superfluous. We want to keep the colours, but we use the `theme()` function to customise the look of our plot:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) +
  theme(legend.position = "none")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-24-1.png)

A pre-built theme function can overwrite some defaults:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) +
  theme_minimal() + # before customising the legend
  theme(legend.position = "none")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-25-1.png)

Try other pre-built themes, like `theme_bw()` and `theme_light()`. You can also start with an empty theme thanks to `theme_void()`, and even install extras with the package `ggthemes`.

### Labels

We can make our plot better with descriptive **labels**:

``` r
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ continent) +
  theme_minimal() + # before customising the legend
  theme(legend.position = "none") +
  xlab("life expectancy") +
  ylab("count")
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-26-1.png)

### Customise a scatterplot

New research question: *How does life expectancy relate to GDP per capita?*

``` r
ggplot(gapminder,
       aes(x = gdpPercap,
           y = lifeExp)) +
  geom_point() +
  labs(x = "GDP per capita",
       y = "Life expectancy",
       title = "How does GDP relate to life expectancy?") +
  theme_bw()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-27-1.png)

The `labs()` function allows you to group all the labels in one call.

Now, let's make it better: spread the data with a modified **scale**, add a **linear regression**, **colour** the continents and add some **transparency**.

``` r
ggplot(gapminder,
       aes(x = gdpPercap,
           y = lifeExp)) +
  geom_point(aes(colour = continent),
             alpha = 0.5) +
  geom_smooth(method = "lm") +
  scale_x_log10() +
  labs(x = "GDP per capita",
       y = "Life expectancy",
       title = "How does GDP relate to life expectancy?") +
  theme_bw()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-28-1.png)

### Save your plots

To Save your plots in different formats and resolutions, use

``` r
ggsave("myplot.png", width = 7, height = 5)
```

`ggsave()` allows you to specify more parameters than RStudio's "Export" menu, and is very helpful to export visualisations that will be printed on a poster (`width` and `height` also resize the font, and `DPI` will allow a bigger resolution).

### Other geometries

To count categorical data, use `geom_bar()`:

``` r
ggplot(gapminder, aes(x = continent)) +
  geom_bar()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-30-1.png)

A simple boxplot to visualise distribution in categories:

``` r
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-31-1.png)

Violin plots might be better at visualising densities:

``` r
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_violin()
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-32-1.png)

If the categories get too cramped on the axis, you can rotate them:

``` r
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_violin() +
  theme(axis.text.x = element_text(angle = 90))
```

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-33-1.png)

### Another example

This extra example gives a an idea of how a complex `ggplot2` visualisation might be constructed:

``` r
ggplot(diamonds,
       aes(x = price,
           y = carat)) +
  geom_point(aes(colour = color),
             alpha = 0.5,
             size = 0.5) +
  scale_color_brewer(palette = "Spectral") +
  geom_smooth(se = FALSE,
              linetype = "dashed",
              colour = "black",
              size = 0.5) +
  facet_wrap(~cut) +
  theme_minimal() +
  labs(x = "price (USD)") +
  coord_flip()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](ggplot2_intermediate_files/figure-markdown_github/unnamed-chunk-34-1.png)

### Play time!

-   Create a a boxplot for each continent's population data
-   Colour and fill by continent
-   Try to limit the y axis to see the boxes better
-   Let's see if you are able to move the legend to the bottom

### Modify your plots

Have a look at this [ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf) and experiment customising your plots.

### Close RProject

Closing RStudio will ask you if you want to save your workspace and scripts.

Important links
---------------

-   For `ggplot2`:
-   ggplot2 cheatsheet: <https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf>
-   Official ggplot2 documentation: <http://docs.ggplot2.org/current/>
-   Official ggplot2 website: <http://ggplot2.tidyverse.org/>
-   Chapter on data visualisation in the book *R for Data Science*: <http://r4ds.had.co.nz/data-visualisation.html>
-   Coding Club's data visualisation tutorial: <https://ourcodingclub.github.io/2017/01/29/datavis.html>
-   Cookbook for R graphs: <http://www.cookbook-r.com/Graphs/>
-   STHDA's ggplot2 essentials: <http://www.sthda.com/english/wiki/ggplot2-essentials>
-   R colours <http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf>
-   Hadley Wickham's book *ggplot2: Elegant Graphics for Data Analysis*: <https://link-springer-com.ezproxy.library.uq.edu.au/content/pdf/10.1007%2F978-3-319-24277-4.pdf>
-   More ressources for R in general: <https://gitlab.com/stragu/CDS/blob/master/R/usefullinks.md>
