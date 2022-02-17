Time series data in R and RStudio
================
2022-02-17

## Essential shortcuts

-   function or dataset help: press <kbd>F1</kbd> with your cursor
    anywhere in a function name.
-   execute from script: <kbd>Ctrl</kbd> + <kbd>Enter</kbd>
-   assignment operator (`<-`): <kbd>Alt</kbd> + <kbd>-</kbd>

## Open RStudio

On library computers:

-   Log in with your UQ username and password (use your student
    credentials if you are both staff and student)
-   Make sure you have a working internet connection
-   Go to search the magnifying glass (bottom left)
-   Open the ZENworks application
-   Look for the letter R
-   Double click on RStudio which will install both R and RStudio

If you are using your own laptop:

-   Make sure you have a working internet connection
-   Open RStudio

## Disclaimer

We will assume basic knowledge of R and RStudio for this course
including installing and loading packages, reading in data, creating
objects in R, tranforming data frames and tibbles with `dplyr` package.

## What are we going to learn?

During this hands-on session, you will:

-   read in data from multiple excel sheets
-   clean the data and extract information
-   use different date/time data formats
-   visualize time series data, “rolling” operations
-   conduct trend analyses with seasonal components

## Material

### Setting up

**Install tidyverse, readxl, plotly, and RcppRoll** if you don’t already
have them, with: `install.packages("ggplot2")`
`install.packages("ggplot2")` `install.packages("ggplot2")`
`install.packages("ggplot2")`

**Create a new project** to keep everything nicely contained in one
directory:

-   Click the “Create a project” button (top left cube icon)
-   Click “New Directory”
-   Click “New Project” (“Empty project” if you have an older version of
    RStudio)
-   In “Directory name”, type the name of your project,
    e.g. “ggplot2_intermediate”
-   Select the folder where to locate your project:
    e.g. `Documents/RProjects`, which you can create if it doesn’t exist
    yet. You can use your H drive at UQ to make sure you can find it
    again.
-   Click the “Create Project” button

Let’s also create a “data” and “images” folder to store exports:

``` r
dir.create("data")
dir.create("data")
```

## About the data

Our dataset describes atmospheric samples of a compound which were
collected each day during seven consecutive days for different month in
the year. Some years and months had less samples due to technical
issues.

### Download the data

Let’s download our dataset form the web:

``` r
download.file("https://github.com/uqlibrary/technology-training/blob/master/R/timeseries/data/analytes_data.xlsx"
              destfile = "data/analytes_data.xlsx",
              mode = 'wb')
```

> The `mode = 'wb'` is binary and necessary for `download.file()` to
> work on Windows OS.

### Read in the data

We have an XLSX workbook that contains several sheets. The first one is
only documenting what the data is about, whereas the two other ones
contain the data we are interested in.

The package [readxl](https://readxl.tidyverse.org/) is useful for
importing data stored in XLS and XLSX files. For example, to have a look
at a single sheet of data, we can do the following:

``` r
# load the package
library(readxl)
# only import the second sheet
analytes <- read_excel("data/analytes_data.xlsx",
                       sheet = 2)
```

We could also point to the correct sheet by using the sheet name instead
of its index. For that, the `excel_sheets()` function is useful to find
the names:

``` r
# excel_sheets() shows the sheet names
excel_sheets("data/analytes_data.xlsx")
```

    ## [1] "infromation data " "Site_759"          "Site_1335"

``` r
analytes <- read_excel("data/analytes_data.xlsx", sheet = "Site_759")
```

Let’s have a look at the first few rows of data:

``` r
head(analytes)
```

    ## # A tibble: 6 x 4
    ##   `Site code` Analyte    `Real date`         `mg/day`
    ##         <dbl> <chr>      <dttm>                 <dbl>
    ## 1         759 Compound x 1991-11-29 00:00:00    0.334
    ## 2         759 Compound x 1991-11-30 00:00:00    0.231
    ## 3         759 Compound x 1991-12-01 00:00:00    0.216
    ## 4         759 Compound x 1991-12-02 00:00:00    0.219
    ## 5         759 Compound x 1991-12-03 00:00:00    0.203
    ## 6         759 Compound x 1991-12-04 00:00:00    0.206

### Bind several workbook sheets

Even though this workbook only has two sheets of data, we might want to
automate the reading and binding of all data sheets to avoid repeating
code. This comes in very handy if you have a workbook with a dozen
sheets of data, or if your data is split between several files.

The Tidyverse’s [purrr](https://purrr.tidyverse.org/) package allows
“mapping” a function (or a more complex command) to several elements.
Here, we will *map* the reading of the sheet to each *element* in a
vector of sheet names.

Using the `map_dfr()` function makes sure we have a single data frame as
an output.

``` r
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.7
    ## v tidyr   1.1.4     v stringr 1.4.0
    ## v readr   2.0.1     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
# only keep sheet names that contain actual data
sheets <- excel_sheets("data/analytes_data.xlsx")[2:3]
# map the reading to each sheet
analytes <- map_dfr(sheets,
                    ~ read_excel("data/analytes_data.xlsx", sheet = .x))
```

We could map a function by simply providing the name of the function.
However, because we are doing something slightly more elaborate here
(pointing to one single file, and using an extra argument to point to
the sheet itself), we need to use the `~` syntax, and point to the
element being processed with the `.x` placeholder.

> For more information on the different options the `map` family offers,
> see `?map`.

## Data cleaning

There are a few issues with the dataset. First of all, there are
variations in how the compound is named. We can replace the value in the
first column with a simpler, consistent one:

``` r
# all same compound
analytes$Analyte <- "x"
```

Our column names are not the most reusable names for R. Better names do
not contain spaces or special characters like `/`. dplyr’s `rename()`
function is very handy for that:

``` r
library(dplyr)
analytes <- rename(analytes, Site = 1, Date = 3, mg_per_day = 4)
```

Finally, the Site column is stored as numeric data. If we plot it as it
is, R will consider it to be a continuous variable, when it really
should be discrete. Let’s fix that with dplyr’s `mutate()` function:

``` r
analytes <- mutate(analytes, Site = as.character(Site))
```

> We could convert it to a factor instead, but the Tidyverse packages
> tend to be happy with categorical data stored as the character type.

### Export a clean dataset

We now have a clean dataset in a single table, which we could make a
copy of, especially to share with others, or if we want to split our
code into several scripts that can work independently.

``` r
write.csv(analytes, "data/analytes_data_clean.csv",
          row.names = FALSE)
```

> `write.csv()` will by default include a column of row names in the
> exported file, which are the row numbers if no row names have been
> assigned. That’s not usually something we want, so we can turn it off
> with `row.names = FALSE`

## Visualisation with ggplot2

At this stage, we can start exploring visually. For a lot of R users,
the go-to package for data visualisation is
[ggplot2](https://ggplot2.tidyverse.org/), which is also part of the
Tidyverse.

For a ggplot2 visualisations, remember that we usually need these three
essential elements:

-   the dataset
-   the mapping of aesthetic elements to variables in the dataset
-   the geometry used to represent the data

Let’s try a first timeline visualisation with a line plot:

``` r
library(ggplot2)
ggplot(analytes,             # data
       aes(x = Date,         # mapping of aesthetics
           y = mg_per_day,
           colour = Site)) + # (separate by site)
  geom_line()                # geometry
```

![](time_series_files/figure-gfm/simple%20viz-1.png)<!-- -->

A simple line plot is not great here, because of the periodicity: there
were bursts of sampling, several days in a row, and then nothing for a
while. Which results in a fine, daily resolution for small periods of
time, and a straight line joining these periods of time.

We might want to “smoothen” that line, hoping to get a better idea of
the trend, keeping the original data as points in the background:

``` r
ggplot(analytes, aes(x = Date, y = mg_per_day, colour = Site)) +
  geom_point() +
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](time_series_files/figure-gfm/smooth%20line-1.png)<!-- -->

The trend lines only give a very general trend. What if we make it
follow the points more closely?

``` r
ggplot(analytes, aes(x = Date, y = mg_per_day, colour = Site)) +
  geom_point(size = 0.3) + # smaller points
  geom_smooth(span = 0.05) # follow the data more closely
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](time_series_files/figure-gfm/lower%20span-1.png)<!-- -->

With the method used, we end up with an increased uncertainty (the
shaded area around the curves). It also creates artificial “dips” to fit
the data, for example close to the beginning of 2000 for the site 1335
(it even reaches negative values).

## Summarise the data

In this case, because we have sampling points for what looks like groups
of successive days, we can try to summarise them.

Operations on time-date data can be done more comfortably with extra
packages. The Tidyverse comes with the
[lubridate](https://lubridate.tidyverse.org/) package, which has been
around for a while and is very powerful. Another, more recent package
called “[clock](https://clock.r-lib.org/)” can do most of what lubridate
can, and more, but it is still being heavily developed, so we stick to
lubridate here.

Let’s start by extracting all the date components that could be useful:

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
analytes <- analytes %>% 
   mutate(year = year(Date),
          month = month(Date),
          day = day(Date),
          week = week(Date),
          weekday = weekdays(Date))
```

How many sampling days per month are there?

``` r
analytes %>% 
   group_by(Site, year, month) %>% 
   count() %>% 
   head(12)
```

    ## # A tibble: 12 x 4
    ## # Groups:   Site, year, month [12]
    ##    Site   year month     n
    ##    <chr> <dbl> <dbl> <int>
    ##  1 1335   1991    11     3
    ##  2 1335   1991    12     3
    ##  3 1335   1992     1     2
    ##  4 1335   1992     2     5
    ##  5 1335   1992     3     5
    ##  6 1335   1992     4     2
    ##  7 1335   1992     5     4
    ##  8 1335   1992     6     3
    ##  9 1335   1992     7     2
    ## 10 1335   1992     8     4
    ## 11 1335   1992    10     7
    ## 12 1335   1992    12     6

The number of samples per month is irregular, and some months have no
data.

Furthermore, the week numbers don’t align with the sampling weeks, and
some sampling weeks overlap over two months:

``` r
analytes %>%  select(year, month, day, week) %>% head(10)
```

    ## # A tibble: 10 x 4
    ##     year month   day  week
    ##    <dbl> <dbl> <int> <dbl>
    ##  1  1991    11    29    48
    ##  2  1991    11    30    48
    ##  3  1991    12     1    48
    ##  4  1991    12     2    48
    ##  5  1991    12     3    49
    ##  6  1991    12     4    49
    ##  7  1991    12     5    49
    ##  8  1992     1    31     5
    ##  9  1992     2     1     5
    ## 10  1992     2     2     5

In any case, the fact that week numbers are reset at the beginning of
the year wouldn’t help.

One way to group the sampling days together is to detect which ones are
spaced by one day, and which ones by a lot more. The `lag()` and
`lead()` functions from dplyr are very useful to compare values in a
single column:

``` r
analytes <- analytes %>%
   arrange(Site, Date) %>% # make sure it is in chronological order
   group_by(Site) %>% # deal with sites separately
   mutate(days_lapsed = as.integer(Date - lag(Date))) %>%  # compare date to previous date
   ungroup() # leftover grouping might have unintended consequences later on
```

> Grouping by site is important, otherwise we get an erroneous value at
> the row after switching to the second site. Because we grouped, it
> does not compare to the previous value in the different site, but
> instead only returns an `NA`.

How consistent are the sampling periods? Let’s investigate:

``` r
analytes %>% 
   count(days_lapsed) %>% 
   head()
```

    ## # A tibble: 6 x 2
    ##   days_lapsed     n
    ##         <int> <int>
    ## 1           1   608
    ## 2           2     4
    ## 3           3     3
    ## 4          39     1
    ## 5          42     1
    ## 6          43     5

It looks like some sampling days might have been missed, so we can
define a sampling period as “a period in which sampling times are not
spaced by more than 3 days”.

To create a grouping index, we can first assign a value of `TRUE` to the
first row of each time period, and then use the cumulative sum function
on that column (as it converts `TRUE`s to 1s and `FALSE`s to 0s):

``` r
analytes <- analytes %>% 
   group_by(Site) %>%
   mutate(sampling_period = row_number() == 1 | days_lapsed > 3,
          sampling_period = cumsum(sampling_period)) %>%
   ungroup()
```

We can now use these new group indices to summarise by time period:

``` r
analytes_summary <- analytes %>% 
   group_by(Analyte, Site, sampling_period) %>% # we are keeping Analyte
   summarise(Date = round_date(mean(Date), unit = "day"),
             mg_per_day = mean(mg_per_day)) %>% 
   ungroup()
```

    ## `summarise()` has grouped output by 'Analyte', 'Site'. You can override using the `.groups` argument.

> We chose to average and round the date for each sampling period, but
> we could opt for another option depending on what we want to do, for
> example keeping the actual time interval:
> `interval(start = min(Date), end = max(Date))`

Let’s try again our line plot with the summarised data:

``` r
ggplot(analytes_summary,
       aes(x = Date,
           y = mg_per_day,
           colour = Site)) +
  geom_line()  
```

![](time_series_files/figure-gfm/line%20plot%20summarised-1.png)<!-- -->

This is a lot cleaner than what we had originally!

## Export summarised data

We have previously exported a CSV, which is a great, simple format that
can be opened pretty much anywhere. However, if you want to save an R
object to reopen it exactly as it was, you can use an R-specific format
like RData.

``` r
save(analytes_summary, file = "data/summary.RData")
```

The file can then be imported again with the `load()` function. You
won’t need to convert the columns to the correct data type again.

## Interactive visualisation

Exploring timelines might be more comfortable with an interactive
visualisation. [Plotly](https://plotly.com/r/) is a helpful library
available for various programming languages, and the plotly package
makes it easy to use it in R.

Once a visualisation is created in R, it is trivial to convert it to a
Plotly visualisation with one single function: `ggplotly()`.

``` r
# save as an object
p <- ggplot(analytes_summary,
       aes(x = Date,
           y = mg_per_day,
           colour = Site)) +
  geom_line()
# turn it into a plotly visualisation
library(plotly)
```

    ## 
    ## Attaching package: 'plotly'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     last_plot

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following object is masked from 'package:graphics':
    ## 
    ##     layout

``` r
ggplotly(p)
```

    ## PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.

<div id="htmlwidget-13fbfde0cbeb120605b1" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-13fbfde0cbeb120605b1">{"x":{"data":[{"x":[691545600,696988800,701913600,707270400,712713600,718243200,723600000,729043200,734659200,739324800,744768000,749606400,755049600,760492800,765331200,770774400,776044800,781401600,786585600,791942400,797990400,802137600,807667200,813715200,817948800,823392000,828748800,834278400,839116800,845078400,849312000,855360000,860198400,865641600,870739200,876182400,881020800,887068800,891907200,896745600,902966400,912470400,917913600,923356800,928281600,934070400,949363200,954806400,959644800,966038400,969926400],"y":[0.212600968404053,0.264098233266516,0.19269961796989,0.215749485604517,0.269053702856392,0.188344509093252,0.0949463064249318,0.163510674899607,0.208070044896479,0.24936087095228,0.269213572913539,0.264486560569199,0.370149548926033,0.331779295272988,0.328276542520932,0.324670684704295,0.268652378778703,0.313608945535038,0.267736905121743,0.344811409092583,0.342356790274702,0.451976991428665,0.446694323908587,0.3720674476949,0.468439501884643,0.334363194275963,0.382415555384546,0.385704980315966,0.466012762586555,0.654577489229594,0.665716883611786,0.571680514672521,0.407246865737372,0.411953790844082,0.508630238281375,0.609210899199135,0.671177589549717,0.84627446475425,0.261167153171242,0.25104041758912,0.324209206396599,0.457869334439024,0.357103665788697,0.32072347010418,0.273745886060628,0.358377992714145,0.466406915721393,0.482077358364403,0.260096459565358,0.244787297581133,0.189378182414287],"text":["Date: 1991-12-01<br />mg_per_day: 0.21260097<br />Site: 1335","Date: 1992-02-02<br />mg_per_day: 0.26409823<br />Site: 1335","Date: 1992-03-30<br />mg_per_day: 0.19269962<br />Site: 1335","Date: 1992-05-31<br />mg_per_day: 0.21574949<br />Site: 1335","Date: 1992-08-02<br />mg_per_day: 0.26905370<br />Site: 1335","Date: 1992-10-05<br />mg_per_day: 0.18834451<br />Site: 1335","Date: 1992-12-06<br />mg_per_day: 0.09494631<br />Site: 1335","Date: 1993-02-07<br />mg_per_day: 0.16351067<br />Site: 1335","Date: 1993-04-13<br />mg_per_day: 0.20807004<br />Site: 1335","Date: 1993-06-06<br />mg_per_day: 0.24936087<br />Site: 1335","Date: 1993-08-08<br />mg_per_day: 0.26921357<br />Site: 1335","Date: 1993-10-03<br />mg_per_day: 0.26448656<br />Site: 1335","Date: 1993-12-05<br />mg_per_day: 0.37014955<br />Site: 1335","Date: 1994-02-06<br />mg_per_day: 0.33177930<br />Site: 1335","Date: 1994-04-03<br />mg_per_day: 0.32827654<br />Site: 1335","Date: 1994-06-05<br />mg_per_day: 0.32467068<br />Site: 1335","Date: 1994-08-05<br />mg_per_day: 0.26865238<br />Site: 1335","Date: 1994-10-06<br />mg_per_day: 0.31360895<br />Site: 1335","Date: 1994-12-05<br />mg_per_day: 0.26773691<br />Site: 1335","Date: 1995-02-05<br />mg_per_day: 0.34481141<br />Site: 1335","Date: 1995-04-16<br />mg_per_day: 0.34235679<br />Site: 1335","Date: 1995-06-03<br />mg_per_day: 0.45197699<br />Site: 1335","Date: 1995-08-06<br />mg_per_day: 0.44669432<br />Site: 1335","Date: 1995-10-15<br />mg_per_day: 0.37206745<br />Site: 1335","Date: 1995-12-03<br />mg_per_day: 0.46843950<br />Site: 1335","Date: 1996-02-04<br />mg_per_day: 0.33436319<br />Site: 1335","Date: 1996-04-06<br />mg_per_day: 0.38241556<br />Site: 1335","Date: 1996-06-09<br />mg_per_day: 0.38570498<br />Site: 1335","Date: 1996-08-04<br />mg_per_day: 0.46601276<br />Site: 1335","Date: 1996-10-12<br />mg_per_day: 0.65457749<br />Site: 1335","Date: 1996-11-30<br />mg_per_day: 0.66571688<br />Site: 1335","Date: 1997-02-08<br />mg_per_day: 0.57168051<br />Site: 1335","Date: 1997-04-05<br />mg_per_day: 0.40724687<br />Site: 1335","Date: 1997-06-07<br />mg_per_day: 0.41195379<br />Site: 1335","Date: 1997-08-05<br />mg_per_day: 0.50863024<br />Site: 1335","Date: 1997-10-07<br />mg_per_day: 0.60921090<br />Site: 1335","Date: 1997-12-02<br />mg_per_day: 0.67117759<br />Site: 1335","Date: 1998-02-10<br />mg_per_day: 0.84627446<br />Site: 1335","Date: 1998-04-07<br />mg_per_day: 0.26116715<br />Site: 1335","Date: 1998-06-02<br />mg_per_day: 0.25104042<br />Site: 1335","Date: 1998-08-13<br />mg_per_day: 0.32420921<br />Site: 1335","Date: 1998-12-01<br />mg_per_day: 0.45786933<br />Site: 1335","Date: 1999-02-02<br />mg_per_day: 0.35710367<br />Site: 1335","Date: 1999-04-06<br />mg_per_day: 0.32072347<br />Site: 1335","Date: 1999-06-02<br />mg_per_day: 0.27374589<br />Site: 1335","Date: 1999-08-08<br />mg_per_day: 0.35837799<br />Site: 1335","Date: 2000-02-01<br />mg_per_day: 0.46640692<br />Site: 1335","Date: 2000-04-04<br />mg_per_day: 0.48207736<br />Site: 1335","Date: 2000-05-30<br />mg_per_day: 0.26009646<br />Site: 1335","Date: 2000-08-12<br />mg_per_day: 0.24478730<br />Site: 1335","Date: 2000-09-26<br />mg_per_day: 0.18937818<br />Site: 1335"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)","dash":"solid"},"hoveron":"points","name":"1335","legendgroup":"1335","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[691632000,697075200,701827200,707270400,712713600,718329600,723600000,729043200,734486400,739324800,744768000,749606400,755049600,760492800,765244800,770774400,776044800,781315200,786585600,791942400,798076800,802224000,807667200,813715200,817948800,823392000,828748800,834278400,839635200,845078400,849312000,855360000,860198400,865641600,870652800,876182400,881020800,887068800,891907200,896745600,903225600,907632000,912470400,917913600,923356800,928281600,933984000,938476800,943920000,949363200,954806400,959644800,965174400,969926400],"y":[0.240643234328402,0.239866565002718,0.211103397811454,0.260162353840332,0.304296247670793,0.269262207504279,0.158852727378311,0.194866033857096,0.236929477428102,0.278617742780945,0.344656900580159,0.338663781964189,0.343149057634364,0.401927292639152,0.378457779333745,0.476518673518538,0.376610754347694,0.392942264401925,0.349698657067696,0.42331136112791,0.471299730954495,0.427908669452204,0.498963306529792,0.468227214282493,0.601436677281373,0.49164044871491,0.545712898647491,0.524188662920043,0.575373252340876,0.76791108278992,0.704379560335598,0.577035107328985,0.507615303671166,0.474351850103901,0.840092255145847,1.14889595102964,0.950474749192172,0.972511630492929,0.475151808458954,0.463213732343174,0.591410974995349,0.648980807337117,0.728667427053717,0.61270664975639,0.525029067129478,0.407787073625081,0.483586950750504,0.540148579053444,0.606263354707929,0.614667983173169,0.603191258313058,0.558189620049785,0.332048404115157,0.259511846965015],"text":["Date: 1991-12-02<br />mg_per_day: 0.24064323<br />Site: 759","Date: 1992-02-03<br />mg_per_day: 0.23986657<br />Site: 759","Date: 1992-03-29<br />mg_per_day: 0.21110340<br />Site: 759","Date: 1992-05-31<br />mg_per_day: 0.26016235<br />Site: 759","Date: 1992-08-02<br />mg_per_day: 0.30429625<br />Site: 759","Date: 1992-10-06<br />mg_per_day: 0.26926221<br />Site: 759","Date: 1992-12-06<br />mg_per_day: 0.15885273<br />Site: 759","Date: 1993-02-07<br />mg_per_day: 0.19486603<br />Site: 759","Date: 1993-04-11<br />mg_per_day: 0.23692948<br />Site: 759","Date: 1993-06-06<br />mg_per_day: 0.27861774<br />Site: 759","Date: 1993-08-08<br />mg_per_day: 0.34465690<br />Site: 759","Date: 1993-10-03<br />mg_per_day: 0.33866378<br />Site: 759","Date: 1993-12-05<br />mg_per_day: 0.34314906<br />Site: 759","Date: 1994-02-06<br />mg_per_day: 0.40192729<br />Site: 759","Date: 1994-04-02<br />mg_per_day: 0.37845778<br />Site: 759","Date: 1994-06-05<br />mg_per_day: 0.47651867<br />Site: 759","Date: 1994-08-05<br />mg_per_day: 0.37661075<br />Site: 759","Date: 1994-10-05<br />mg_per_day: 0.39294226<br />Site: 759","Date: 1994-12-05<br />mg_per_day: 0.34969866<br />Site: 759","Date: 1995-02-05<br />mg_per_day: 0.42331136<br />Site: 759","Date: 1995-04-17<br />mg_per_day: 0.47129973<br />Site: 759","Date: 1995-06-04<br />mg_per_day: 0.42790867<br />Site: 759","Date: 1995-08-06<br />mg_per_day: 0.49896331<br />Site: 759","Date: 1995-10-15<br />mg_per_day: 0.46822721<br />Site: 759","Date: 1995-12-03<br />mg_per_day: 0.60143668<br />Site: 759","Date: 1996-02-04<br />mg_per_day: 0.49164045<br />Site: 759","Date: 1996-04-06<br />mg_per_day: 0.54571290<br />Site: 759","Date: 1996-06-09<br />mg_per_day: 0.52418866<br />Site: 759","Date: 1996-08-10<br />mg_per_day: 0.57537325<br />Site: 759","Date: 1996-10-12<br />mg_per_day: 0.76791108<br />Site: 759","Date: 1996-11-30<br />mg_per_day: 0.70437956<br />Site: 759","Date: 1997-02-08<br />mg_per_day: 0.57703511<br />Site: 759","Date: 1997-04-05<br />mg_per_day: 0.50761530<br />Site: 759","Date: 1997-06-07<br />mg_per_day: 0.47435185<br />Site: 759","Date: 1997-08-04<br />mg_per_day: 0.84009226<br />Site: 759","Date: 1997-10-07<br />mg_per_day: 1.14889595<br />Site: 759","Date: 1997-12-02<br />mg_per_day: 0.95047475<br />Site: 759","Date: 1998-02-10<br />mg_per_day: 0.97251163<br />Site: 759","Date: 1998-04-07<br />mg_per_day: 0.47515181<br />Site: 759","Date: 1998-06-02<br />mg_per_day: 0.46321373<br />Site: 759","Date: 1998-08-16<br />mg_per_day: 0.59141097<br />Site: 759","Date: 1998-10-06<br />mg_per_day: 0.64898081<br />Site: 759","Date: 1998-12-01<br />mg_per_day: 0.72866743<br />Site: 759","Date: 1999-02-02<br />mg_per_day: 0.61270665<br />Site: 759","Date: 1999-04-06<br />mg_per_day: 0.52502907<br />Site: 759","Date: 1999-06-02<br />mg_per_day: 0.40778707<br />Site: 759","Date: 1999-08-07<br />mg_per_day: 0.48358695<br />Site: 759","Date: 1999-09-28<br />mg_per_day: 0.54014858<br />Site: 759","Date: 1999-11-30<br />mg_per_day: 0.60626335<br />Site: 759","Date: 2000-02-01<br />mg_per_day: 0.61466798<br />Site: 759","Date: 2000-04-04<br />mg_per_day: 0.60319126<br />Site: 759","Date: 2000-05-30<br />mg_per_day: 0.55818962<br />Site: 759","Date: 2000-08-02<br />mg_per_day: 0.33204840<br />Site: 759","Date: 2000-09-26<br />mg_per_day: 0.25951185<br />Site: 759"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,191,196,1)","dash":"solid"},"hoveron":"points","name":"759","legendgroup":"759","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":26.2283105022831,"r":7.30593607305936,"b":40.1826484018265,"l":43.1050228310502},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[677626560,983845440],"tickmode":"array","ticktext":["1992","1994","1996","1998","2000"],"tickvals":[694224000,757382400,820454400,883612800,946684800],"categoryorder":"array","categoryarray":["1992","1994","1996","1998","2000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Date","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.0422488241946963,1.20159343325988],"tickmode":"array","ticktext":["0.3","0.6","0.9","1.2"],"tickvals":[0.3,0.6,0.9,1.2],"categoryorder":"array","categoryarray":["0.3","0.6","0.9","1.2"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"mg_per_day","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.93503937007874},"annotations":[{"text":"Site","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"5a007b7b4606":{"x":{},"y":{},"colour":{},"type":"scatter"}},"cur_data":"5a007b7b4606","visdat":{"5a007b7b4606":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

To focus on a section, draw a rectangle (and double-click to reset to
the full view).

With several time series plotted, it is useful to change the hover
setting to “compare data on hover” with this button:

![“Compare data on hover” button in Plotly
visualisation](images/compare_button.png)

It is however possible to set a similar hover mode as a default:

``` r
ggplotly(p) %>% 
   layout(hovermode = "x unified")
```

<div id="htmlwidget-614b95f48781b7cb0e74" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-614b95f48781b7cb0e74">{"x":{"data":[{"x":[691545600,696988800,701913600,707270400,712713600,718243200,723600000,729043200,734659200,739324800,744768000,749606400,755049600,760492800,765331200,770774400,776044800,781401600,786585600,791942400,797990400,802137600,807667200,813715200,817948800,823392000,828748800,834278400,839116800,845078400,849312000,855360000,860198400,865641600,870739200,876182400,881020800,887068800,891907200,896745600,902966400,912470400,917913600,923356800,928281600,934070400,949363200,954806400,959644800,966038400,969926400],"y":[0.212600968404053,0.264098233266516,0.19269961796989,0.215749485604517,0.269053702856392,0.188344509093252,0.0949463064249318,0.163510674899607,0.208070044896479,0.24936087095228,0.269213572913539,0.264486560569199,0.370149548926033,0.331779295272988,0.328276542520932,0.324670684704295,0.268652378778703,0.313608945535038,0.267736905121743,0.344811409092583,0.342356790274702,0.451976991428665,0.446694323908587,0.3720674476949,0.468439501884643,0.334363194275963,0.382415555384546,0.385704980315966,0.466012762586555,0.654577489229594,0.665716883611786,0.571680514672521,0.407246865737372,0.411953790844082,0.508630238281375,0.609210899199135,0.671177589549717,0.84627446475425,0.261167153171242,0.25104041758912,0.324209206396599,0.457869334439024,0.357103665788697,0.32072347010418,0.273745886060628,0.358377992714145,0.466406915721393,0.482077358364403,0.260096459565358,0.244787297581133,0.189378182414287],"text":["Date: 1991-12-01<br />mg_per_day: 0.21260097<br />Site: 1335","Date: 1992-02-02<br />mg_per_day: 0.26409823<br />Site: 1335","Date: 1992-03-30<br />mg_per_day: 0.19269962<br />Site: 1335","Date: 1992-05-31<br />mg_per_day: 0.21574949<br />Site: 1335","Date: 1992-08-02<br />mg_per_day: 0.26905370<br />Site: 1335","Date: 1992-10-05<br />mg_per_day: 0.18834451<br />Site: 1335","Date: 1992-12-06<br />mg_per_day: 0.09494631<br />Site: 1335","Date: 1993-02-07<br />mg_per_day: 0.16351067<br />Site: 1335","Date: 1993-04-13<br />mg_per_day: 0.20807004<br />Site: 1335","Date: 1993-06-06<br />mg_per_day: 0.24936087<br />Site: 1335","Date: 1993-08-08<br />mg_per_day: 0.26921357<br />Site: 1335","Date: 1993-10-03<br />mg_per_day: 0.26448656<br />Site: 1335","Date: 1993-12-05<br />mg_per_day: 0.37014955<br />Site: 1335","Date: 1994-02-06<br />mg_per_day: 0.33177930<br />Site: 1335","Date: 1994-04-03<br />mg_per_day: 0.32827654<br />Site: 1335","Date: 1994-06-05<br />mg_per_day: 0.32467068<br />Site: 1335","Date: 1994-08-05<br />mg_per_day: 0.26865238<br />Site: 1335","Date: 1994-10-06<br />mg_per_day: 0.31360895<br />Site: 1335","Date: 1994-12-05<br />mg_per_day: 0.26773691<br />Site: 1335","Date: 1995-02-05<br />mg_per_day: 0.34481141<br />Site: 1335","Date: 1995-04-16<br />mg_per_day: 0.34235679<br />Site: 1335","Date: 1995-06-03<br />mg_per_day: 0.45197699<br />Site: 1335","Date: 1995-08-06<br />mg_per_day: 0.44669432<br />Site: 1335","Date: 1995-10-15<br />mg_per_day: 0.37206745<br />Site: 1335","Date: 1995-12-03<br />mg_per_day: 0.46843950<br />Site: 1335","Date: 1996-02-04<br />mg_per_day: 0.33436319<br />Site: 1335","Date: 1996-04-06<br />mg_per_day: 0.38241556<br />Site: 1335","Date: 1996-06-09<br />mg_per_day: 0.38570498<br />Site: 1335","Date: 1996-08-04<br />mg_per_day: 0.46601276<br />Site: 1335","Date: 1996-10-12<br />mg_per_day: 0.65457749<br />Site: 1335","Date: 1996-11-30<br />mg_per_day: 0.66571688<br />Site: 1335","Date: 1997-02-08<br />mg_per_day: 0.57168051<br />Site: 1335","Date: 1997-04-05<br />mg_per_day: 0.40724687<br />Site: 1335","Date: 1997-06-07<br />mg_per_day: 0.41195379<br />Site: 1335","Date: 1997-08-05<br />mg_per_day: 0.50863024<br />Site: 1335","Date: 1997-10-07<br />mg_per_day: 0.60921090<br />Site: 1335","Date: 1997-12-02<br />mg_per_day: 0.67117759<br />Site: 1335","Date: 1998-02-10<br />mg_per_day: 0.84627446<br />Site: 1335","Date: 1998-04-07<br />mg_per_day: 0.26116715<br />Site: 1335","Date: 1998-06-02<br />mg_per_day: 0.25104042<br />Site: 1335","Date: 1998-08-13<br />mg_per_day: 0.32420921<br />Site: 1335","Date: 1998-12-01<br />mg_per_day: 0.45786933<br />Site: 1335","Date: 1999-02-02<br />mg_per_day: 0.35710367<br />Site: 1335","Date: 1999-04-06<br />mg_per_day: 0.32072347<br />Site: 1335","Date: 1999-06-02<br />mg_per_day: 0.27374589<br />Site: 1335","Date: 1999-08-08<br />mg_per_day: 0.35837799<br />Site: 1335","Date: 2000-02-01<br />mg_per_day: 0.46640692<br />Site: 1335","Date: 2000-04-04<br />mg_per_day: 0.48207736<br />Site: 1335","Date: 2000-05-30<br />mg_per_day: 0.26009646<br />Site: 1335","Date: 2000-08-12<br />mg_per_day: 0.24478730<br />Site: 1335","Date: 2000-09-26<br />mg_per_day: 0.18937818<br />Site: 1335"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)","dash":"solid"},"hoveron":"points","name":"1335","legendgroup":"1335","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[691632000,697075200,701827200,707270400,712713600,718329600,723600000,729043200,734486400,739324800,744768000,749606400,755049600,760492800,765244800,770774400,776044800,781315200,786585600,791942400,798076800,802224000,807667200,813715200,817948800,823392000,828748800,834278400,839635200,845078400,849312000,855360000,860198400,865641600,870652800,876182400,881020800,887068800,891907200,896745600,903225600,907632000,912470400,917913600,923356800,928281600,933984000,938476800,943920000,949363200,954806400,959644800,965174400,969926400],"y":[0.240643234328402,0.239866565002718,0.211103397811454,0.260162353840332,0.304296247670793,0.269262207504279,0.158852727378311,0.194866033857096,0.236929477428102,0.278617742780945,0.344656900580159,0.338663781964189,0.343149057634364,0.401927292639152,0.378457779333745,0.476518673518538,0.376610754347694,0.392942264401925,0.349698657067696,0.42331136112791,0.471299730954495,0.427908669452204,0.498963306529792,0.468227214282493,0.601436677281373,0.49164044871491,0.545712898647491,0.524188662920043,0.575373252340876,0.76791108278992,0.704379560335598,0.577035107328985,0.507615303671166,0.474351850103901,0.840092255145847,1.14889595102964,0.950474749192172,0.972511630492929,0.475151808458954,0.463213732343174,0.591410974995349,0.648980807337117,0.728667427053717,0.61270664975639,0.525029067129478,0.407787073625081,0.483586950750504,0.540148579053444,0.606263354707929,0.614667983173169,0.603191258313058,0.558189620049785,0.332048404115157,0.259511846965015],"text":["Date: 1991-12-02<br />mg_per_day: 0.24064323<br />Site: 759","Date: 1992-02-03<br />mg_per_day: 0.23986657<br />Site: 759","Date: 1992-03-29<br />mg_per_day: 0.21110340<br />Site: 759","Date: 1992-05-31<br />mg_per_day: 0.26016235<br />Site: 759","Date: 1992-08-02<br />mg_per_day: 0.30429625<br />Site: 759","Date: 1992-10-06<br />mg_per_day: 0.26926221<br />Site: 759","Date: 1992-12-06<br />mg_per_day: 0.15885273<br />Site: 759","Date: 1993-02-07<br />mg_per_day: 0.19486603<br />Site: 759","Date: 1993-04-11<br />mg_per_day: 0.23692948<br />Site: 759","Date: 1993-06-06<br />mg_per_day: 0.27861774<br />Site: 759","Date: 1993-08-08<br />mg_per_day: 0.34465690<br />Site: 759","Date: 1993-10-03<br />mg_per_day: 0.33866378<br />Site: 759","Date: 1993-12-05<br />mg_per_day: 0.34314906<br />Site: 759","Date: 1994-02-06<br />mg_per_day: 0.40192729<br />Site: 759","Date: 1994-04-02<br />mg_per_day: 0.37845778<br />Site: 759","Date: 1994-06-05<br />mg_per_day: 0.47651867<br />Site: 759","Date: 1994-08-05<br />mg_per_day: 0.37661075<br />Site: 759","Date: 1994-10-05<br />mg_per_day: 0.39294226<br />Site: 759","Date: 1994-12-05<br />mg_per_day: 0.34969866<br />Site: 759","Date: 1995-02-05<br />mg_per_day: 0.42331136<br />Site: 759","Date: 1995-04-17<br />mg_per_day: 0.47129973<br />Site: 759","Date: 1995-06-04<br />mg_per_day: 0.42790867<br />Site: 759","Date: 1995-08-06<br />mg_per_day: 0.49896331<br />Site: 759","Date: 1995-10-15<br />mg_per_day: 0.46822721<br />Site: 759","Date: 1995-12-03<br />mg_per_day: 0.60143668<br />Site: 759","Date: 1996-02-04<br />mg_per_day: 0.49164045<br />Site: 759","Date: 1996-04-06<br />mg_per_day: 0.54571290<br />Site: 759","Date: 1996-06-09<br />mg_per_day: 0.52418866<br />Site: 759","Date: 1996-08-10<br />mg_per_day: 0.57537325<br />Site: 759","Date: 1996-10-12<br />mg_per_day: 0.76791108<br />Site: 759","Date: 1996-11-30<br />mg_per_day: 0.70437956<br />Site: 759","Date: 1997-02-08<br />mg_per_day: 0.57703511<br />Site: 759","Date: 1997-04-05<br />mg_per_day: 0.50761530<br />Site: 759","Date: 1997-06-07<br />mg_per_day: 0.47435185<br />Site: 759","Date: 1997-08-04<br />mg_per_day: 0.84009226<br />Site: 759","Date: 1997-10-07<br />mg_per_day: 1.14889595<br />Site: 759","Date: 1997-12-02<br />mg_per_day: 0.95047475<br />Site: 759","Date: 1998-02-10<br />mg_per_day: 0.97251163<br />Site: 759","Date: 1998-04-07<br />mg_per_day: 0.47515181<br />Site: 759","Date: 1998-06-02<br />mg_per_day: 0.46321373<br />Site: 759","Date: 1998-08-16<br />mg_per_day: 0.59141097<br />Site: 759","Date: 1998-10-06<br />mg_per_day: 0.64898081<br />Site: 759","Date: 1998-12-01<br />mg_per_day: 0.72866743<br />Site: 759","Date: 1999-02-02<br />mg_per_day: 0.61270665<br />Site: 759","Date: 1999-04-06<br />mg_per_day: 0.52502907<br />Site: 759","Date: 1999-06-02<br />mg_per_day: 0.40778707<br />Site: 759","Date: 1999-08-07<br />mg_per_day: 0.48358695<br />Site: 759","Date: 1999-09-28<br />mg_per_day: 0.54014858<br />Site: 759","Date: 1999-11-30<br />mg_per_day: 0.60626335<br />Site: 759","Date: 2000-02-01<br />mg_per_day: 0.61466798<br />Site: 759","Date: 2000-04-04<br />mg_per_day: 0.60319126<br />Site: 759","Date: 2000-05-30<br />mg_per_day: 0.55818962<br />Site: 759","Date: 2000-08-02<br />mg_per_day: 0.33204840<br />Site: 759","Date: 2000-09-26<br />mg_per_day: 0.25951185<br />Site: 759"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,191,196,1)","dash":"solid"},"hoveron":"points","name":"759","legendgroup":"759","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":26.2283105022831,"r":7.30593607305936,"b":40.1826484018265,"l":43.1050228310502},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[677626560,983845440],"tickmode":"array","ticktext":["1992","1994","1996","1998","2000"],"tickvals":[694224000,757382400,820454400,883612800,946684800],"categoryorder":"array","categoryarray":["1992","1994","1996","1998","2000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Date","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.0422488241946963,1.20159343325988],"tickmode":"array","ticktext":["0.3","0.6","0.9","1.2"],"tickvals":[0.3,0.6,0.9,1.2],"categoryorder":"array","categoryarray":["0.3","0.6","0.9","1.2"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"mg_per_day","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.93503937007874},"annotations":[{"text":"Site","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"x unified","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"5a001a2e7a07":{"x":{},"y":{},"colour":{},"type":"scatter"}},"cur_data":"5a001a2e7a07","visdat":{"5a001a2e7a07":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

## Rolling operations

With time series affected by seasonality, or with a lot of variation
creating visual noise, it is sometimes useful to represent long-term
trends with a rolling average.

The package [RcppRoll](https://cran.r-project.org/package=RcppRoll) is
useful for this kind of windowed operation:

``` r
library(RcppRoll)
analytes_summary %>% 
   group_by(Site) %>% 
   mutate(rolling_mean = roll_mean(mg_per_day,
                                   n = 6,          # the size of the window
                                   fill = NA)) %>% # to have same length
   ggplot(aes(x = Date,
           y = rolling_mean,
           colour = Site)) +
  geom_line()
```

    ## Warning: Removed 10 row(s) containing missing values (geom_path).

![](time_series_files/figure-gfm/rolling%20average-1.png)<!-- -->

This method might not be the best for this data, but it proves very
useful in other cases, for example for COVID-19 daily infection rates
(with a 7-day window).
