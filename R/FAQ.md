# R Frequently Asked Questions

This is a compilation of questions and answers that have been asked during R sessions at the CDS.

## general


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
