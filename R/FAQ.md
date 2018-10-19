# R Frequently Asked Questions

This is a compilation of questions and answers that have been asked during R sessions at the CDS.

## General

### Importing data

You can use `read.table()` to read delimited data file, or the more specific `read.csv()` for CSV files. Look at the help page to overwrite defaults like delimiter or headings.

Basic operation:

```
read.csv("path/to/file.csv")

```

You can also use the graphical user interface: "File > Import dataset > From text (base)"

There are also options to import Excel files directly (with the package `readxl`) and other formats (ODS, Stata, SPSS, SAS...).

### Exporting data

You can use `write.table()`. There are a few arguments that you can overwrite to get the output you want.
For example, to export the object `australia` and save it as "data.csv" in the working directory, but removing the row names (i.e. the numbers at the beginning of each observation) and removing the quotes around character strings:

```
write.table(australia,
            file = "data.csv",
            row.names = FALSE,
            quote = FALSE)
```

### Switch from long to wide format

The package `tidyr`, also part of the Tidyverse, can be used for that. The `spread()` function will take a dataset, a `key` that is used to spread (i.e. what variable will move to the new column headers) and a `value` that defines what data will be spread.

### Remove a directory

The `unlink()` function can do that.


### Rename a directory

`file.rename()` works on firectories too. You can use it like so:

```
file.rename("oldName", "newName")
```

### Different vector classes with `seq()` and `c()`

`seq()` creates int and num vectors, whereas `c()` creates only num sequences with same parameters. For example, compare `seq(1,3)` to `c(1,2,3)`.

I had to ask about this one: https://stackoverflow.com/questions/52739502

`c()` concatenates what we give it, and R happens to interpret non-decimal numbers like `1` as num (see for example `class(1)`). `seq()` on the other hand will create a sequence from the parameters, and will use integral numbers if there isn't any decimals, like the `:` operator would do.

To create an int vector with `c()`, we'd have to use the notation `c(1L, 2L, 3L)`.

### Difference between `require()` and `library()`?

From the great answers on this page: https://stackoverflow.com/questions/5595512/what-is-the-difference-between-require-and-library

`require()` is useful when programming as it returns `TRUE` or `FALSE` depending on if R managed to load the packages, which for example would allow to check for a package's availability in an `if` statement.


`library()` is useful interactively as it throws an error if it didn't manage to load the package (whereas `require()` only gives a warning).

So, in short: `require()` is more used programmatically, whereas `library()` is better for interactive use.

## dplyr

### Excel's VLOOKUP equivalent


As expected, `dplyr` has useful verbs for that. As hinted in [this Stack Exchange QA](https://stackoverflow.com/questions/24012636/r-excel-vlookup-equivalent-lookup-replace):

```
library(dplyr)
inner_join(data1, data2)
```

... will merge the two datasets according to common variables, and will drop rows with no match. `full_join()` will keep everything (and add "NA" where necessary).
The argument `by =` allows you to specify which variables you want to join by.

You can text the different joins provided in `dplyr` with the examples at the bottom of the help page (`?join`). They are great to illustrate the effect of each one with simple built-in tables.

If that is not what you were hoping for, there are more options in this other QA: https://stackoverflow.com/questions/15303283/how-to-do-vlookup-and-fill-down-like-in-excel-in-r

Find the `dplyr` cheatsheet on the RStudio website to have a handy reference to the different "mutating joins": https://www.rstudio.com/resources/cheatsheets/


### Keep single records instead of repeated levels of a factor

In the example, cadastral records are repeated in a dataset because of multiple dwellings on one single property.
You can use the `dplyr` function `distinct()` to output a dataset that only has one record of each level of a variable, like so:
    
```
distinct(mpg, manufacturer, .keep_all = TRUE)
```

This command will take the `mpg` dataset (from the `ggplot2` package) and only keep the first row when a level of the variable `manufacturer` is repeated across a number of rows. The argument `.keep_all = TRUE` keeps all other variables in the output.


### Filter for several values in a variable

Create a list of values:

```
target <- c("Eritrea", "France") 
```

And then use the `%in%` operator in the condition:

```
eritrea_france_2002 <- gapminder %>%
  select(year, country, lifeExp) %>%
  filter(year == 2002, country %in% target)
```

### Why does a subset keep all the factor levels?

This is the default behaviour with data stored as a factor: levels are kept even if further operations remove all occurences. This allows to keep this information for further operations, for example checking for the following condition:

```
ordered_factor[1] > ordered_factor[4]
```

If you want to drop the unused factor levels, you can use the `droplevels()` function.

For example, to remove all levels in the `australia$country` variable:

```
australia$country <- droplevels(australia$country)
```

If you want to avoid those issues, you can use the Tidyverse way of interpreting data, which conserves character vectors and does not create factors with levels automatically (by using the `read_csv()` function from the `readr` package to import data for example).

Relevant StackExchange Q&A: https://stackoverflow.com/questions/1195826/drop-factor-levels-in-a-subsetted-data-frame

## ggplot2

### Are there other functions (other than `aes`) that can be used for the `mapping` argument?

From what I can see, no other functions are used for the `mapping` argument. `aes()` is systematically used. One reason to use a function here is that it allows us to group the mapping arguments together.

### Several plots in single view

After saving your plots as objects, you can use the `grid.arrange()` function like so: `grid.arrange(plot1, plot2, plot3, plot4, ncol = 2)`

More examples here: https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html

### Using symbols

The aesthetic `shape` can assign different symbols to categorical data. You can also specify what shapes you want to use by specifying a list of shapes in `scale_shape_manual()` (find the integers and names associated to shapes with `vignette("ggplot2-specs")`).

### Custom colour scales

The cheatsheet details a few methods: https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf

A few examples of customisation are listed in this Cookbook: http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

You can change the colour palette with `scale_` functions. For example, if you want to replace the default colour palette for a `colour` aesthetic in a scatterplot:

```
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, colour = Species)) +
	geom_point() +
	scale_colour_brewer(palette = "Greens")
```

Note: brewer colours were mainly designed for discrete data.

If you know how many levels you have, and want to specify a falue for each one, use a concatenated list of the values in the function `scale_<aes>_manual()` (this is when `ColourPicker` is extra useful).

If you want to create your own custom continuous palette:

```
ggplot(ChickWeight, aes(x = Diet,  y = weight, colour = Time)) +
	geom_point() +
	scale_colour_continuous(low = "#36C288", high = "#CF3030")
```

### Colour the bars in a bar chart according to a continuous variable

Looks like it is not supported by `ggplot2`, which makes sense as it would be hard to guess how to do it best (for example: divide the bars in how many sections?). One way to deal with that could be to create ranges in order to have a categorical variable (and add a `scale_fill_*()` function to use sequential colour palette).

### Extract equation from a drawn `geom_smooth()`

This answer looks at printing a known equation on the plot: https://stackoverflow.com/questions/7549694/adding-regression-line-equation-and-r2-on-graph/7549819

This answer looks at extracting the function from the `geom_smooth()` function: https://stackoverflow.com/questions/9789871/method-to-extract-stat-smooth-line-fit#9790803


### Change the font size and family

Usually defined in the `element_text()` functions for each theme element (or element groups):

```
element_text(size = 20, family = "serif")
```

In base R, you can use "serif", "sans" and "mono", and the Hershey font families (see `?Hershey` and `demo(Hershey)`).

### Use a transparent background

You can use the following theme option to remove all rectangle elements:

```
theme(rect = element_blank())
```

However, you will need to use the `ggsave()` function as RStudio's plot export menu does not support transparency:

```
ggsave(filename = "plot.png", bg = "transparent")
```

### Remove the grid?

There is something better than `colour = "white"` or `size = 0`:

You can use the following syntax:

```
theme(panel.grid = element_blank())
```

### Barchart of means

Sometimes, we need to do some data-processing before plotting. Here, we can use functions from the `dplyr` package, and we overwrite the default geom statistic in order to plot means of grouped data as a bar chart:

```
library(dplyr)
library(ggplot2)
diamonds %>%
	group_by(cut) %>% 
	summarise(caratMean = mean(carat)) %>%
	ggplot(aes(x = cut, y = caratMean)) +
	geom_bar(stat = "identity")
```

Note how we can build one single command to process and visualise data using the pipe operator.



