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

### Large datasets (for merge / joins for example)

It looks like the package `data.table` might provide a more efficient way than base `merge()` or the `plyr` package. This Stack Overflow QA has some pointers, and a comparison of how much time it takes to `merge()` two data.frames vs two data.tables: https://stackoverflow.com/questions/11146967/efficient-alternatives-to-merge-for-larger-data-frames-r

The help page for `data.tables::merge` should give you enough information on how to use it.

This article might be of interest: https://freakonometrics.hypotheses.org/19645

Again, the author concludes that data.tables are the way to go.

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

### Colourblind-friendly palettes?

Mentionned in this cookbook: http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

Many choices on the Colour Brewer website: http://colorbrewer2.org

You can visual a list with:

```
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
```

### Colour the bars in a bar chart according to a continuous variable

Looks like it is not supported by `ggplot2`, which makes sense as it would be hard to guess how to do it best (for example: divide the bars in how many sections?). There is one exception: if your `fill` uses the same data as your `y` aesthetic (which results in one single colour for each bar).

An alternative would be to create ranges in order to have a categorical variable (and add a `scale_fill_*()` function to use sequential colour palette).

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

Note how we can build one single command to process and visualise data using the pipe operator (provided by `dplyr`).

An alternative is to use the `stat_summary()` function to directly access summarised y values in `ggplot2`:

```
ggplot(diamonds, aes(x = cut, y = carat)) +
	stat_summary(geom = "bar", fun.y = mean)
```

### Add error bars

Error bars with stat_summary() : https://stackoverflow.com/questions/44872951/how-do-i-add-se-error-bars-to-my-barplot-in-ggplot2?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

Cookbook for error bars: http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/

### Plot several densities

To stack several density plots, the data has to be "grouped" by mapping the differenciating discrete variable to an aesthetic. The colour aesthetic is probably most suited.

You can try the following code as an example, which uses the `diamonds` dataset included in the `ggplot2` package:


```
library(ggplot2)
ggplot(diamonds) +
	geom_density(aes(x = price, colour = cut))
```

If you don't want to use different colours, you can use the `group` aesthetic instead of `colour`. Here are some examples: http://ggplot2.tidyverse.org/reference/aes_group_order.html

### Modify order of legend

This blog details a couple of methods: https://learnr.wordpress.com/2010/03/23/ggplot2-changing-the-default-order-of-legend-labels-and-stacking-of-data/

### Modify names of levels in a legend

You could either modify the original data, i.e. change the strings in your dataset, or you could replace the values by hand using a scale function (that corresponds to the easthetic associated to the labels):

```
... +
	scale_colour_manual(labels = c("blah", "bleh", "blih"))
```

### Plot geographical data

An interesting package to investigate, for slippy maps: leaflet for R -> https://rstudio.github.io/leaflet

Geographical data can be represented with ggplot2 too. An example: http://zevross.com/blog/2014/07/16/mapping-in-r-using-the-ggplot2-package/

Since version 3 of `ggplot2`, there is some `sf` integration which makes it easier to create maps: https://www.tidyverse.org/articles/2018/07/ggplot2-3-0-0/

### 3D plots in R

`ggplot2` can't deal with 3D plots. It is recommended to try to visualise your data in 2D first, as 3D plots can be confusing and hard to interpret.

If you do find that you absolutely have to visualise your data in 3D (surface data for example), you can experiment with packages like `plot3D`, `lattice`, `plotly`, `scatterplot3d` and others.

Base R also has a `persp()` function that can represent 3D data. You can see a demonstration of its capabilities with `demo(persp)`

### Secondary y axes

It is often not recommended to superimpose two visualisations that relate to different data, which is why it was never prioritised in `ggplot2`. The reasons relate to how it adds unnecessary technical complexity, and how it can be used to mislead interpretation. See the main developper's explanation here: https://stackoverflow.com/a/3101876/1494531

However, it is possible to have a second y axis that is a transformation of the first one, which is demonstrated in the same Q&A: https://stackoverflow.com/a/39805869/1494531

If you want an alternative to dual axes, and you are plotting the same kind of data, you can use `facet_wrap()` with the `scales = "free_y"` argument, which will allow the two facets to have different ordinate ranges.

For a secondary axis that shows completely different data, there are more involved solutions that either hack around the built-in secondary axis limitation, make use of dummy facetting, or play with the internals of `ggplot2` with the `gtable` package:

* https://rpubs.com/MarkusLoew/226759
* https://github.com/tidyverse/ggplot2/wiki/Align-two-plots-on-a-page
* https://rpubs.com/kohske/dual_axis_in_ggplot2

However, there are other packages that make it easy to do that. For example, the function `twoord.plot()` in the package `plotrix`.

## Heatmaps

### Use of `colorRampPalette()`

"Why do you specify the number of colours for the function `colorRampPalette()` as a separate object external to the function?"

The `colorRampPalette()` function creates another function. So, when we did this:

```
my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 25)
```

...we created a function, and directly used it with the single argument `n = 25` to create a list of colours. In a way, the whole of "colorRampPalette(c("blue", "white", "red"))" is the name of the function, followed by its arguments between parentheses.

That would be equivalent to the two separate steps here:

```
# Create the custom function:
my_palette_function <- colorRampPalette(c("blue", "white", "red"))
# `my_palette_function()` is listed under "Functions" in you environment pane. If you run `my_palette_function`, it will print the code of the function.
# Create the object, using the custom function with `n = 25`:
my_palette <- my_palette_function(n = 25)
```

### How do different packages handle NA values?

* `heatmap()` and `heatmap.2()` have a `na.rm` argument that is by default set to `TRUE`
* `heatmap.2()` has a `na.color` argument to specify a colour for NA values (background color by default)
* `pheatmap()` has a `na_col` argument to specify a colour for NA values (by default grey: #DDDDDD)


### Change the colour of dendrograms in `heatmap()`

Some potential methods here: http://www.sthda.com/english/wiki/beautiful-dendrogram-visualizations-in-r-5-must-known-methods-unsupervised-machine-learning

### Change font in `pheatmap()`

Changing fonts for R base plots (which `heatmap()` is a part of) requires to use the `par(family = "<familyname>")` function before building the plot (see the help page for `par()` for more on that).

However, for packages like `ggplot2` or `pheatmap`, the method is different.

In `ggplot2`, you can add an extra element to change the font settings, like so:

```
<previous_layers> +
	theme(text=element_text(family="mono", face="bold", size=12))
```

If the default built-in font families ("serif", "sans", "mono" and the Hershey font families) are not enough, you can import your system's fonts with the `extrafont` package.

`extrafont` needs to be setup first. Install it with `install.packages("extrafont")` and then:

```
library(extrafont)
font_import() # needs to be done only once to import the system's fonts
font() # this lists the fonts available
loadfonts() # automatically done when you load extrafont
```

The `pheatmap` does not take into account what was set by the `par()` function, and it does not seem to currently support different fonts. Only the font size can be changed, with the `fontsize` arguments.

### Scale data according to different scaling method?

The `scale()` function can already turn both the scaling and the centring on or off. For more custom "normalisation", the `sweep()` function can by default subtract the value passed on to the `STATS` argument, or can handle it accordingly to a custom formula replacing the default `FUN` argument's value.

### Colour palette / scaling method above / below zero

The `sweep()` function can be used to scale the data differently.

A custom colour palette can then be designed so the "middle" colour corresponds to a specific value, for example with the `scale_fill_gradient2()` function in ggplot2, in which the `midpoint` argument is the value where the palette diverges (i.e. 0).

For base graphics, the solution might be more involved, for example joining two palettes together. See for example this solution: https://stackoverflow.com/questions/29262824/r-center-color-palette-on-0