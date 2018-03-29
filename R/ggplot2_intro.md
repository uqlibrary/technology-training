Introduction to R data visualisation using ggplot2
===

`last revision: 2018-03-29`

:::info
This document is redacted in hackmd.io, and is best viewed at (and printed from) https://hackmd.io/s/BJjLQWYqz
The source code is available on [GitHub](https://github.com/stragu/CDS/blob/master/R/ggplot2_intro.md).
:::

Thank you for attending this session at the UQ library Centre for Digital Scholarship (CDS).

If you want to review the installation instructions: https://github.com/stragu/CDS/blob/master/R/Installation.md

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you are using Library computers.

Useful links, exercises and more information on how to continue your R learning are provided in our community resource in this Etherpad: https://etherpad.wikimedia.org/p/cds-ggplot2-intro
During the session, it is the only document you need to have open.

Please complete the feedback survey before leaving, so we can improve our services.

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

   * Have a visualisation package installed (ggplot2) 
   * Learn how to explore data
   * Learn about the basic ggplot2 layers 
   * Create different kinds of plots 
   * Be able to modify plots quickly
   
## Disclaimer

We will assume you are an R beginner, who has used R before.

## Introductions

Introduce yourself to one other person in the session. We will try to work in pairs.

## Material

### Rstudio project

**Exercise 1 - New RStudio project**

* Click the "File" menu button (top left corner), then "New Project"
* Click "New Directory"
* Click "New Project" ("Empty project" if you have an older version of RStudio)
* In "Directory name", type the name of your project, e.g. "ggplot2_intro"
* Select the folder where to locate your project: the `Documents/RProjects` folder, which you can create if it doesn't exist yet.
* Click the "Create Project" button
* create three folders in your new project
    * `dir.create("scripts")`
    * `dir.create("data")`
    * `dir.create("plots")`

### Introducing ggplot2

**Exercise 2 - create a script, ggplot2 setup**

* Menu: Top left corner, click the green "plus" symbol, or press the shortcut (for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N. This will open an "Untitled1" file.
* Go to file "Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S. This will ask where you want to save your file and the name of the new file
* Call your file "ggplot2_intro.R" located in the "scripts" folder
* install and load the package ggplot2:
    * install it with `install.packages("ggplot2")`
    * While you wait for ggplot2 to be installed, check out Rdocumentation.org and type "ggplot2" in the search
    * load the package with `library(ggplot2)`
    
Th R package ggplot2 was developed by Hadley Wickham with the objective of creating a grammar of graphics for categorical data (in 2007). It is based on the book _The Grammar of Graphics_ Developed by Leland Wilkinson (1999/2005). 

You only need to install a package once, and reload it every time you start a new R session.

### Explore data

We are going to work with different datasets that come with the ggplot2 package. For any dataset or function doubts that you might have. Don't forget the three ways of getting help from R:

1.  the shortcut command: `?functionname`
2.  the help function: `help(functionname)`
3.  the keyboard shortcut: press F1 after writing a function name

### Basic ggplot2 layers

ggplot2 is based on the idea that you can build every graph from the same few components. Here is an example in pseudo-code:

```
ggplot(data = <dataset>, mapping = aesthetics( <x, y, fill, colour>)) + 
 <geometry>()
 <modifiers>()
```

Find out more about the package:

```
?ggplot
```

The `ggplot()` function initialises a ggplot object. It can be used to declare the input data frame for a graphic and to specify the set of plot aesthetics intended to be common throughout all subsequent layers unless specifically overridden.

### Create diferent kinds of plots 

Let's have a look at our dataset:

```
?economics
str(economics)
```

Do you think that the rate of unemployment is stable over the years?

We can base our plot code on our previous pseudo-code, using a point geometry:

```
ggplot(data = economics, mapping = aes(x = date, y = unemploy)) + 
    geom_point()
```

:::info
Make sure you use "Shift + Enter" to got to the next line when adding layers, for readability and to easily recall the whole code block with the up arrow.
:::

New dataset: "mpg", which stands for "miles per gallon".

```
?mpg
str(mpg)
```

A car with a low fuel efficiency consumes more fuel than a car with a high fuel efficiency when they travel the same distance.

We can focus on two variables:

> `displ`: a car’s engine size, in litres.
> `hwy`: a car’s fuel efficiency on the highway, in miles per gallon.

Do you think that cars with big engines use fuel less efficiently than cars with small engines?

```
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point()
```

We can highlight the "class" factor to understand the data better:

```
gplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = class)) +
    geom_point()
```

The plot shows a negative relationship between engine size (displ) and fuel efficiency (hwy).
In other words, cars with big engines use more fuel. Does this confirm or refute your hypothesis about fuel efficiency and engine size?

We now know how to create a simple dotplot.

`last_plot()` allows us to recall the latest plot we created, so we can string extra functions and layers quickly.

```
last_plot()
```

A trend will be best displayed as: 

```
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_smooth()
```

Do you think it is possible to combine both plots?

```
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point() +
    geom_smooth()
```

Different geoms can also have their own mappings that overwrite the defaults.
If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer. It will use these mappings to extend or overwrite the global mappings for that layer only. This makes it possible to display different aesthetics in different layers.

Introducing **colour** and **legend**:

```
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(colour = class)) + 
    geom_smooth()
```

**Exercise 3 – where should aesthetics be defined?**

Take the last plot we created:

```
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(colour = class)) + 
    geom_smooth()
```

What would happen if you moved the `colour = class` aesthetic from the geometry function to the `ggplot()` call?

Let's use a similar approach with the `economics` data.

Let's take a look at the structure of the dataset:

```
str(economics)
```

The continuous variable `uempmed` is defined by the help page as "median duration of unemployment, in weeks".
Let's colour the data according to the duration of unemployment, and add a smoothing function on top:

```
ggplot(data = economics, mapping = aes(x = date, y = unemploy)) + 
    geom_point(mapping = aes(colour = uempmed)) +
    geom_smooth()
```

See how the legend changes depending on the type of data mapped to the `colour` aesthetic? (i.e. categorical vs continuous)

Let's use the `diamonds` dataset now.
The `diamonds` dataset comes in ggplot2 and contains information about ~54,000 diamonds, including the price, carat, color, clarity, and cut of each diamond.

```
str(diamonds)
diamonds
summary(diamonds)
?diamonds
```

Let’s take a look at a bar chart. Bar charts seem simple, but they are interesting because they reveal something subtle about plots. Consider a basic bar chart, as drawn with `geom_bar()`. The following chart displays the total number of diamonds in the `diamonds` dataset, grouped by cut.

```
ggplot(data = diamonds, mapping = aes(x = cut)) + 
    geom_bar()
```

The chart shows that more diamonds are available with high quality cuts than with low quality cuts.

**Exercise 4 – add information with `fill`**

Use the previous plot and add information about the diamonds' `clarity` with the `fill` aesthetic:

```
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
    geom_bar()
```

What is the difference with the `colour` aesthetic?

Let's modify our plot: we can pick our favourite colour in `geom_bar()`, and modify labels with the `labs()` function to make our plot more self-explanatory:

```
ggplot(data = diamonds, mapping = aes(x = cut)) + 
    geom_bar(fill = "tomato") +
    labs(title = "How many diamonds have good or better quality?",
        x = "Quality",
        y = "Counts")
```

**Exercise 5: where should `fill` go?**

We assigned different values to the `fill` argument in previous plots. But why are they located inside or outside of the `aes()` call?

Let's have a look at what `labs()` can do:

```
?labs
```

It can edit the title, the subtitle, the x and y axes labels, and the caption. But remember that captions and titles are better sorted out in the publication itself.

`coord_flip()` can be used to quickly flip the axes around:

```
ggplot(data = diamonds, mapping = aes(x = cut)) + 
  geom_bar(fill = "tomato") +
  labs(title = "How many diamonds have good or better quality?",
       x = "Quality", y = " Counts") +
  coord_flip()
```

Some functions allow to set a bunch of theme defaults easily, like `theme_bw()`:

```
ggplot(data = diamonds, mapping = aes(x = cut)) + 
    geom_bar(fill = "tomato") +
    labs(title = "How many diamonds have good or better quality?",
        x = "Quality", y = " Counts") +
    coord_flip() +
    theme_bw()
```

To save the last plot, use `ggsave()`:

```
ggsave(filename = "plots/horizontalbarplot.png")
```

**Exercise 6: explore geometries**

When creating a new layer, start typing `geom_` and see what suggestions pop up. Are there any suggestions that sound useful or familiar to you?

## Play time!

Modify your plots, play around with different layers and functions, and ask questions!

## Close Rproject

If you want to close R Studio, you should save your project first.

* File
* close project (It will ask you if you want to save your history)
* then, close RStudio

## After the workshop

Please fill in the feedback survey before leaving!

## Useful links

* For ggplot2:
    * R ggplot2 Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf
    * Official ggplot2 documentation: http://docs.ggplot2.org/current/
    * Coding Club's data visualisation tutorial: https://ourcodingclub.github.io/2017/01/29/datavis.html
    * Cookbook for R graphs: http://www.cookbook-r.com/Graphs/
    * STHDA's ggplot2 essentials: http://www.sthda.com/english/wiki/ggplot2-essentials
* R and RStudio in general:
    * RStudio Cheatsheet https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
    * RStudio online learning https://www.rstudio.com/online-learning/
    * Basic and advanced manuals https://cran.r-project.org/manuals.html
    * Ask about any function or package http://www.rdocumentation.org/
    * If you are looking how-to's or how to fix an error http://stackoverflow.com/questions/tagged/r
    * Lynda.com R training and tutorials https://www.lynda.com/R-training-tutorials/1570-0.html remember to sign in from UQ, https://web.library.uq.edu.au/library-services/training/lyndacom-online-courses
    * ANOVA in R http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf or https://rcompanion.org/rcompanion/e_01.html
    * If you need an R and/or RStudio workshop/session, please contact the Centre for Digital Scholarship staff to organise one for you. https://web.library.uq.edu.au/locations-hours/centre-digital-scholarship
    * If you have further questions about R, please contact the CDS: cds@library.uq.edu.au
    * Ask questions to other researchers during the weekly Hacky Hour: [https://rcc.uq.edu.au/meetups](https://rcc.uq.edu.au/meetups)
    * Contact your unit's statistician (if you have one?)
