R data manipulation with RStudio and dplyr: an introduction
================
Stéphane Guillou
2019-04-11

If you want to review the installation instructions: <https://gitlab.com/stragu/DSH/blob/master/R/Installation.md>

Everything we write today will be saved in your R project. Please remember to save it in your H drive or USB if you are using Library computers.

Useful links, exercises and more information on how to continue your R learning are provided in our community resource in this Etherpad: <https://frama.link/DSH-dplyr> During the session, it is the only document you need to have open.

Keep in mind
------------

-   R is case sensitive: it will tell the difference between uppercase and lowercase.
-   Respect the naming rules for objects (no spaces, does not start with a number...)

### Help

For any dataset or function doubts that you might have, don't forget the three ways of getting help in RStudio:

1.  the shortcut command: `?functionname`
2.  the help function: `help(functionname)`
3.  the keyboard shortcut: press F1 after writing a function name

What are we going to learn?
---------------------------

In this hands-on session, you will use RStudio and the `dplyr` package to manipulate your data.

Specifically, you will learn how to **explore, filter, reorganise and process** your data with the following verbs:

-   `filter()`: pick observations
-   `arrange()`: reorder rows
-   `select()`: pick variables
-   `mutate()`: create new variables
-   `summarise()`: collapse to a single summary
-   `group_by()`: change the scope of function

Open RStudio
------------

-   If you are using your own laptop please open RStudio
-   Make sure you have a working internet connection
-   On Library computers (the first time takes about 10 min.):
    -   Log in with your UQ username (student if you have two) and password
    -   Make sure you have a working internet connection
    -   Go to search at bottom left corner (magnifiying glass)
    -   Open the ZENworks application
    -   Look for RStudio
    -   Double click on RStudio which will install both R and RStudio

Material
--------

### New project

Exercise 1 - New RStudio project

-   Click the "File" menu button (top left corner), then "New Project"
-   Click "New Directory"
-   Click "New Project" ("Empty project" if you have an older version of RStudio)
-   In "Directory name", type the name of your project, e.g. "dplyr\_intro"
-   Select the folder where to locate your project: the `Documents/RProjects` folder, which you can create if it doesn't exist yet.
-   Click the "Create Project" button

### Setting up

Exercise 2 - create a script, install `dplyr`

-   Menu: Top left corner, click the green "plus" symbol, or press the shortcut (for Windows/Linux) Ctrl+Shift+N or (for Mac) Cmd+Shift+N. This will open an "Untitled1" file.
-   Go to "File &gt; Save" or press (for Windows/Linux) Ctrl+S or (for Mac) Cmd+S. This will ask where you want to save your file and the name of the new file.
-   Call your file "dplyr\_intro.R"

We can add a sequence of useful commands to our script as we go.

-   Install and load the `dplyr` package:
    -   in the console, install the package: `install.packages("dplyr")`
    -   While you wait for dplyr to be installed, check <https://www.rdocumentation.org> and type "dplyr" in the search
    -   load the package:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

> At home, you can install the whole "[tidyverse](https://www.tidyverse.org/)", a meta-package of useful packages for data science:

You only need to install a package once (with `install.packages()`), but you need to reload it every time you start a new R session (with `library()`).

### Introducing our data

Exercise 3 – import and explore data

1.  read the data into an object called "gapminder", using `read.csv()`:

``` r
gapminder <- read.csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")
```

1.  Explore the gapminder dataset using `dim()` and `str()`

How can we get the dataframe's variable names? There are two ways: `names(gapminder)` returns the names regardless of the object type, such as list, vector, data.frame etc., whereas `colnames(gapminder)` returns the variable names for matrix-like objects, such as matrices, dataframes...

To select one specific column in the dataframe, you can use the dollar sign in: `gapminder$year`. For example, try these:

``` r
nlevels(gapminder$country)
```

    ## [1] 142

``` r
class(gapminder$country)
```

    ## [1] "factor"

If we want nicer printing, we can convert our dataframe to a "tibble":

``` r
install.packages(tibble)
library(tibble)
gapminder <- as_tibble(gapminder)
```

### Basic dplyr verbs

The R package `dplyr` was developed by Hadley Wickham for data manipulation.

The book *[R for Data Science](http://r4ds.had.co.nz)* introduces the package as follows:

> You are going to learn the five key dplyr functions that allow you to solve the vast majority of your data manipulation challenges:
>
> -   Pick observations by their values with `filter()`.
> -   Reorder the rows with `arrange()`.
> -   Pick variables by their names with `select()`.
> -   Create new variables with functions of existing variables with `mutate()`.
> -   Collapse many values down to a single summary with `summarise()`.
>
> These can all be used in conjunction with `group_by()` which changes the scope of each function from operating on the entire dataset to operating on it group-by-group. These six functions provide the **verbs for a language of data manipulation**.

To use the verbs to their full extent, we will need **pipes** and **logical operators**, which we will introduce as we go.

#### Pick observations with `filter()`

The `filter()` function allows use to pick observations depending on one ore several conditions.

**Logical operators** allow us to **check for a condition**. Remember: `=` is to assign a value to a variable, `==` is to check for a condition.

-   `==` equal
-   `!=` different
-   `>` greater than
-   `<` smaller than
-   `>=` greater or equal
-   `<=` smaller or equal

Filter the observations for Australia, using `filter()` and a logical operator:

``` r
australia <- filter(gapminder, country == "Australia")
australia
```

    ##      country year      pop continent lifeExp gdpPercap
    ## 1  Australia 1952  8691212   Oceania  69.120  10039.60
    ## 2  Australia 1957  9712569   Oceania  70.330  10949.65
    ## 3  Australia 1962 10794968   Oceania  70.930  12217.23
    ## 4  Australia 1967 11872264   Oceania  71.100  14526.12
    ## 5  Australia 1972 13177000   Oceania  71.930  16788.63
    ## 6  Australia 1977 14074100   Oceania  73.490  18334.20
    ## 7  Australia 1982 15184200   Oceania  74.740  19477.01
    ## 8  Australia 1987 16257249   Oceania  76.320  21888.89
    ## 9  Australia 1992 17481977   Oceania  77.560  23424.77
    ## 10 Australia 1997 18565243   Oceania  78.830  26997.94
    ## 11 Australia 2002 19546792   Oceania  80.370  30687.75
    ## 12 Australia 2007 20434176   Oceania  81.235  34435.37

Filter the rows that have a life expectancy `lifeExp` greater than 80 years:

``` r
life80 <- filter(gapminder, lifeExp > 80)
dim(life80)
```

    ## [1] 21  6

#### Reorder rows with `arrange()`

If we want to have a look at the entries with highest GDP per capita:

``` r
arrange(gapminder, desc(gdpPercap))
```

    ##                       country year        pop continent  lifeExp
    ## 1                      Kuwait 1957     212846      Asia 58.03300
    ## 2                      Kuwait 1972     841934      Asia 67.71200
    ## 3                      Kuwait 1952     160000      Asia 55.56500
    ## 4                      Kuwait 1962     358266      Asia 60.47000
    ## 5                      Kuwait 1967     575003      Asia 64.62400
    ## 6                      Kuwait 1977    1140357      Asia 69.34300
    ## 7                      Norway 2007    4627926    Europe 80.19600
    ## 8                      Kuwait 2007    2505559      Asia 77.58800
    ## 9                   Singapore 2007    4553009      Asia 79.97200
    ## 10                     Norway 2002    4535591    Europe 79.05000
    ## 11              United States 2007  301139947  Americas 78.24200
    ## 12                     Norway 1997    4405672    Europe 78.32000
    ## 13                    Ireland 2007    4109086    Europe 78.88500
    ## 14                     Kuwait 1997    1765345      Asia 76.15600
    ## 15            Hong Kong China 2007    6980412      Asia 82.20800
    ## 16              United States 2002  287675526  Americas 77.31000
    ## 17                Switzerland 2007    7554661    Europe 81.70100
    ## 18                Netherlands 2007   16570613    Europe 79.76200
    ## 19                     Canada 2007   33390141  Americas 80.65300
    ## 20                    Iceland 2007     301931    Europe 81.75700
    ## 21                    Austria 2007    8199783    Europe 79.82900
    ## 22                  Singapore 2002    4197776      Asia 78.77000
    ## 23              United States 1997  272911760  Americas 76.81000
    ## 24                    Denmark 2007    5468120    Europe 78.33200
    ## 25                     Kuwait 2002    2111561      Asia 76.90400
    ## 26                     Kuwait 1992    1418095      Asia 75.19000
    ## 27                Switzerland 2002    7361757    Europe 80.62000
    ## 28                  Australia 2007   20434176   Oceania 81.23500
    ## 29               Saudi Arabia 1977    8128505      Asia 58.69000
    ## 30                    Ireland 2002    3879155    Europe 77.78300
    ## 31                     Norway 1992    4286357    Europe 77.32000
    ## 32                     Sweden 2007    9031088    Europe 80.88400
    ## 33                Netherlands 2002   16122830    Europe 78.53000
    ## 34               Saudi Arabia 1982   11254672      Asia 63.01200
    ## 35                    Belgium 2007   10392226    Europe 79.44100
    ## 36                  Singapore 1997    3802309      Asia 77.15800
    ## 37                     Canada 2002   31902268  Americas 79.77000
    ## 38                    Finland 2007    5238460    Europe 79.31300
    ## 39             United Kingdom 2007   60776238    Europe 79.42500
    ## 40                    Austria 2002    8148312    Europe 78.98000
    ## 41                    Germany 2007   82400996    Europe 79.40600
    ## 42                    Denmark 2002    5374693    Europe 77.18000
    ## 43                Switzerland 1997    7193761    Europe 79.37000
    ## 44              United States 1992  256894189  Americas 76.09000
    ## 45                Switzerland 1992    6995447    Europe 78.03000
    ## 46                      Japan 2007  127467972      Asia 82.60300
    ## 47                     Norway 1987    4186147    Europe 75.89000
    ## 48                     Kuwait 1982    1497494      Asia 71.30900
    ## 49                    Iceland 2002     288030    Europe 80.50000
    ## 50                  Australia 2002   19546792   Oceania 80.37000
    ## 51                    Belgium 2002   10311970    Europe 78.32000
    ## 52                     France 2007   61083916    Europe 80.65700
    ## 53                Switzerland 1987    6649942    Europe 77.41000
    ## 54                Netherlands 1997   15604464    Europe 78.03000
    ## 55            Hong Kong China 2002    6762476      Asia 81.49500
    ## 56                    Germany 2002   82350671    Europe 78.67000
    ## 57              United States 1987  242803533  Americas 75.02000
    ## 58                    Denmark 1997    5283663    Europe 76.11000
    ## 59                    Bahrain 2007     708573      Asia 75.63500
    ## 60             United Kingdom 2002   59912431    Europe 78.47100
    ## 61                     Sweden 2002    8954175    Europe 80.04000
    ## 62                    Austria 1997    8069876    Europe 77.51000
    ## 63                     Canada 1997   30305843  Americas 78.61000
    ## 64                     France 2002   59925035    Europe 79.59000
    ## 65                      Spain 2007   40448191    Europe 80.94100
    ## 66                      Japan 1997  125956499      Asia 80.69000
    ## 67                     Taiwan 2007   23174294      Asia 78.40000
    ## 68                      Japan 2002  127065841      Asia 82.00000
    ## 69                      Italy 2007   58147733    Europe 80.54600
    ## 70                Switzerland 1982    6468126    Europe 76.21000
    ## 71            Hong Kong China 1997    6495918      Asia 80.00000
    ## 72                    Finland 2002    5193039    Europe 78.37000
    ## 73                     Kuwait 1987    1891487      Asia 74.17400
    ## 74                    Iceland 1997     271192    Europe 78.95000
    ## 75                      Italy 2002   57926999    Europe 80.24000
    ## 76                    Germany 1997   82011073    Europe 77.34000
    ## 77                    Belgium 1997   10199787    Europe 77.53000
    ## 78                     Greece 2007   10706290    Europe 79.48300
    ## 79                Switzerland 1972    6401400    Europe 73.78000
    ## 80                    Austria 1992    7914969    Europe 76.04000
    ## 81                  Australia 1997   18565243   Oceania 78.83000
    ## 82                Switzerland 1977    6316424    Europe 75.39000
    ## 83                    Iceland 1987     244676    Europe 77.23000
    ## 84                      Japan 1992  124329269      Asia 79.36000
    ## 85                Netherlands 1992   15174244    Europe 77.42000
    ## 86                     Canada 1987   26549700  Americas 76.86000
    ## 87                    Germany 1992   80597764    Europe 76.07000
    ## 88                    Denmark 1992    5171393    Europe 75.33000
    ## 89                     Canada 1992   28523502  Americas 77.95000
    ## 90                     Norway 1982    4114787    Europe 75.97000
    ## 91             United Kingdom 1997   58808266    Europe 77.21800
    ## 92                     France 1997   58623428    Europe 78.64000
    ## 93                   Slovenia 2007    2009245    Europe 77.92600
    ## 94                    Belgium 1992   10045622    Europe 76.46000
    ## 95                     Israel 2007    6426679      Asia 80.74500
    ## 96                     Sweden 1997    8897619    Europe 79.39000
    ## 97                New Zealand 2007    4115771   Oceania 80.20400
    ## 98                    Iceland 1992     259012    Europe 78.77000
    ## 99                    Denmark 1987    5127024    Europe 74.80000
    ## 100             United States 1982  232187835  Americas 74.65000
    ## 101              Saudi Arabia 1992   16945857      Asia 68.76800
    ## 102              Saudi Arabia 1972    6472756      Asia 53.88600
    ## 103                     Spain 2002   40152517    Europe 79.78000
    ## 104                 Singapore 1992    3235865      Asia 75.78800
    ## 105           Hong Kong China 1992    5829696      Asia 77.60100
    ## 106                    France 1992   57374179    Europe 77.46000
    ## 107                     Italy 1997   57479469    Europe 78.82000
    ## 108                   Germany 1987   77718298    Europe 74.84700
    ## 109                   Ireland 1997    3667233    Europe 76.12200
    ## 110             United States 1977  220239000  Americas 73.38000
    ## 111                    Sweden 1992    8718867    Europe 78.16000
    ## 112                   Finland 1997    5134406    Europe 77.13000
    ## 113                   Austria 1987    7578903    Europe 74.94000
    ## 114               Netherlands 1987   14665278    Europe 76.83000
    ## 115                    Sweden 1987    8421403    Europe 77.19000
    ## 116                 Australia 1992   17481977   Oceania 77.56000
    ## 117                   Bahrain 2002     656397      Asia 74.79500
    ## 118                Korea Rep. 2007   49044790      Asia 78.62300
    ## 119                    Norway 1977    4043205    Europe 75.37000
    ## 120                   Iceland 1982     233997    Europe 76.99000
    ## 121                    Taiwan 2002   22454239      Asia 76.99000
    ## 122               New Zealand 2002    3908037   Oceania 79.11000
    ## 123               Switzerland 1967    6063000    Europe 72.77000
    ## 124                    Canada 1982   25201900  Americas 75.76000
    ## 125            Czech Republic 2007   10228744    Europe 76.48600
    ## 126            United Kingdom 1992   57866349    Europe 76.42000
    ## 127                   Belgium 1987    9870200    Europe 75.35000
    ## 128                    Greece 2002   10603863    Europe 78.25600
    ## 129                     Japan 1987  122091325      Asia 78.67000
    ## 130                      Oman 2007    3204897      Asia 75.64000
    ## 131                    Canada 1977   23796400  Americas 74.21000
    ## 132                    France 1987   55630100    Europe 76.34000
    ## 133                   Germany 1982   78335266    Europe 73.80000
    ## 134                     Italy 1992   56840847    Europe 77.44000
    ## 135                     Libya 1977    2721783    Africa 57.44200
    ## 136                    Israel 2002    6029529      Asia 79.69600
    ## 137                 Australia 1987   16257249   Oceania 76.32000
    ## 138             United States 1972  209896000  Americas 71.34000
    ## 139                     Gabon 1977     706367    Africa 52.79000
    ## 140                   Denmark 1982    5117810    Europe 74.63000
    ## 141            United Kingdom 1987   56981620    Europe 75.00700
    ## 142              Saudi Arabia 2007   27601038      Asia 72.77700
    ## 143                   Austria 1982    7574613    Europe 73.18000
    ## 144               Netherlands 1982   14310401    Europe 76.05000
    ## 145               Netherlands 1977   13852989    Europe 75.24000
    ## 146              Saudi Arabia 1987   14619745      Asia 66.29500
    ## 147                   Finland 1987    4931729    Europe 74.83000
    ## 148               New Zealand 1997    3676187   Oceania 77.55000
    ## 149                     Libya 1972    2183877    Africa 52.77300
    ## 150                   Belgium 1982    9856303    Europe 73.93000
    ## 151                    Israel 1997    5531387      Asia 78.26900
    ## 152                    Sweden 1982    8325260    Europe 76.42000
    ## 153                  Slovenia 2002    2011497    Europe 76.66000
    ## 154                   Finland 1992    5041039    Europe 75.70000
    ## 155              Saudi Arabia 1997   21229759      Asia 70.53300
    ## 156                   Germany 1977   78160773    Europe 72.50000
    ## 157                  Portugal 2007   10642836    Europe 78.09800
    ## 158                     Spain 1997   39855442    Europe 78.77000
    ## 159               Switzerland 1962    5666000    Europe 71.32000
    ## 160                   Denmark 1977    5088419    Europe 74.69000
    ## 161                    France 1982   54433565    Europe 74.89000
    ## 162                   Bahrain 1997     598561      Asia 73.92500
    ## 163                    Taiwan 1997   21628605      Asia 75.25000
    ## 164           Hong Kong China 1987    5584510      Asia 76.20000
    ## 165                  Portugal 2002   10433867    Europe 77.29000
    ## 166                      Oman 2002    2713462      Asia 74.19300
    ## 167                   Austria 1977    7568430    Europe 72.17000
    ## 168                      Oman 1997    2283635      Asia 72.49900
    ## 169                   Iceland 1977     221823    Europe 76.11000
    ## 170             United States 1967  198712000  Americas 70.76000
    ## 171                 Australia 1982   15184200   Oceania 74.74000
    ## 172                     Japan 1982  118454974      Asia 77.11000
    ## 173                   Bahrain 1977     297410      Asia 65.59300
    ## 174               Puerto Rico 2007    3942491  Americas 78.74600
    ## 175                Korea Rep. 2002   47969150      Asia 77.04500
    ## 176                   Bahrain 1982     377967      Asia 69.05200
    ## 177                     Italy 1987   56729703    Europe 76.42000
    ## 178                   Belgium 1977    9821800    Europe 72.80000
    ## 179                   Bahrain 1992     529491      Asia 72.60100
    ## 180              Saudi Arabia 2002   24501530      Asia 71.62600
    ## 181               New Zealand 1987    3317166   Oceania 74.32000
    ## 182                    Canada 1972   22284500  Americas 72.88000
    ## 183                    Norway 1972    3933004    Europe 74.34000
    ## 184                   Denmark 1972    4991596    Europe 73.47000
    ## 185                 Singapore 1987    2794552      Asia 73.56000
    ## 186                    Sweden 1977    8251648    Europe 75.44000
    ## 187               Puerto Rico 2002    3859606  Americas 77.77800
    ## 188               Netherlands 1972   13329874    Europe 73.75000
    ## 189                     Libya 1967    1759224    Africa 50.22700
    ## 190                    Greece 1997   10502372    Europe 77.86900
    ## 191                  Slovenia 1987    1945870    Europe 72.25000
    ## 192           Slovak Republic 2007    5447502    Europe 74.66300
    ## 193                      Oman 1992    1915208      Asia 71.19700
    ## 194                     Spain 1992   39549438    Europe 77.57000
    ## 195                   Finland 1982    4826933    Europe 74.55000
    ## 196                   Bahrain 1987     454612      Asia 70.75000
    ## 197               New Zealand 1992    3437674   Oceania 76.33000
    ## 198                 Australia 1977   14074100   Oceania 73.49000
    ## 199                    France 1977   53165019    Europe 73.83000
    ## 200                   Bahrain 1972     230800      Asia 63.30000
    ## 201            United Kingdom 1982   56339704    Europe 74.04000
    ## 202                      Oman 1987    1593882      Asia 67.73400
    ## 203                    Israel 1992    4936550      Asia 76.93000
    ## 204                   Germany 1972   78717088    Europe 71.00000
    ## 205                   Hungary 2007    9956108    Europe 73.33800
    ## 206       Trinidad and Tobago 2007    1056608  Americas 69.81900
    ## 207               Switzerland 1957    5126000    Europe 70.56000
    ## 208                  Slovenia 1982    1861252    Europe 71.06300
    ## 209                    Sweden 1972    8122293    Europe 74.72000
    ## 210                  Portugal 1997   10156415    Europe 75.97000
    ## 211               New Zealand 1982    3210650   Oceania 73.84000
    ## 212            Czech Republic 2002   10256295    Europe 75.51000
    ## 213                   Ireland 1992    3557761    Europe 75.46700
    ## 214                    Greece 1992   10325429    Europe 77.03000
    ## 215            United Kingdom 1977   56179000    Europe 72.76000
    ## 216                     Libya 1982    3344074    Africa 62.15500
    ## 217                  Slovenia 1997    2011612    Europe 75.13000
    ## 218                    Israel 1987    4203148      Asia 75.60000
    ## 219               Puerto Rico 1997    3759430  Americas 74.91700
    ## 220              Saudi Arabia 1967    5618198      Asia 49.90100
    ## 221                 Australia 1972   13177000   Oceania 71.93000
    ## 222                   Belgium 1972    9709100    Europe 71.44000
    ## 223                   Austria 1972    7544201    Europe 70.63000
    ## 224                     Japan 1977  113872473      Asia 75.38000
    ## 225                     Italy 1982   56535636    Europe 74.98000
    ## 226                    Norway 1967    3786019    Europe 74.08000
    ## 227            Czech Republic 1987   10311597    Europe 71.58000
    ## 228               New Zealand 1977    3164900   Oceania 72.22000
    ## 229                  Portugal 1992    9927680    Europe 74.86000
    ## 230             United States 1962  186538000  Americas 70.21000
    ## 231                    Greece 1987    9974490    Europe 76.67000
    ## 232                    France 1972   51732000    Europe 72.38000
    ## 233                    Canada 1967   20819767  Americas 72.13000
    ## 234            Czech Republic 1997   10300707    Europe 74.01000
    ## 235               New Zealand 1972    2929100   Oceania 71.89000
    ## 236                Korea Rep. 1997   46173816      Asia 74.64700
    ## 237                   Denmark 1967    4838800    Europe 72.96000
    ## 238            United Kingdom 1972   56079000    Europe 72.01000
    ## 239                    Serbia 1987    9230783    Europe 71.21800
    ## 240                   Iceland 1972     209275    Europe 74.46000
    ## 241                     Spain 1987   38880702    Europe 76.90000
    ## 242                   Finland 1977    4738902    Europe 72.52000
    ## 243                    Poland 2007   38518241    Europe 75.56300
    ## 244            Czech Republic 1982   10303704    Europe 70.96000
    ## 245                    Israel 1982    3858421      Asia 74.45000
    ## 246               Netherlands 1967   12596822    Europe 73.82000
    ## 247                  Slovenia 1977    1746919    Europe 70.97000
    ## 248                    Greece 1982    9786480    Europe 75.24000
    ## 249                    Sweden 1967    7867931    Europe 74.16000
    ## 250                    Taiwan 1992   20686918      Asia 74.26000
    ## 251                    Serbia 1982    9032824    Europe 70.16200
    ## 252                 Singapore 1982    2651869      Asia 71.76000
    ## 253                     Gabon 1982     753874    Africa 56.56400
    ## 254             United States 1957  171984000  Americas 69.49000
    ## 255                   Hungary 2002   10083313    Europe 72.59000
    ## 256                   Bahrain 1967     202182      Asia 59.92300
    ## 257            Czech Republic 1977   10161915    Europe 70.71000
    ## 258                     Japan 1972  107188273      Asia 73.42000
    ## 259                   Germany 1967   76368453    Europe 70.80000
    ## 260               Switzerland 1952    4815000    Europe 69.62000
    ## 261                     Gabon 1997    1126189    Africa 60.46100
    ## 262                      Iraq 1977   11882916      Asia 60.41300
    ## 263               Puerto Rico 1992    3585176  Americas 73.91100
    ## 264                   Croatia 2007    4493312    Europe 75.74800
    ## 265           Hong Kong China 1982    5264500      Asia 75.45000
    ## 266                 Australia 1967   11872264   Oceania 71.10000
    ## 267                      Iraq 1982   14173318      Asia 62.03800
    ## 268               New Zealand 1967    2728150   Oceania 71.52000
    ## 269                   Finland 1972    4639657    Europe 70.87000
    ## 270            Czech Republic 1992   10315702    Europe 72.40000
    ## 271                     Italy 1977   56059245    Europe 73.48000
    ## 272                  Slovenia 1992    1999210    Europe 73.64000
    ## 273                    Greece 1977    9308479    Europe 73.68000
    ## 274            United Kingdom 1967   54959000    Europe 71.36000
    ## 275             United States 1952  157553000  Americas 68.44000
    ## 276                     Spain 1982   37983310    Europe 76.30000
    ## 277                   Ireland 1987    3539900    Europe 74.36000
    ## 278                   Croatia 1987    4484310    Europe 71.52000
    ## 279           Slovak Republic 2002    5410052    Europe 73.80000
    ## 280                   Denmark 1962    4646899    Europe 72.35000
    ## 281                     Gabon 1992     985739    Africa 61.36600
    ## 282                    Canada 1962   18985849  Americas 71.30000
    ## 283                    Norway 1962    3638919    Europe 73.47000
    ## 284                   Iceland 1967     198676    Europe 73.73000
    ## 285                    Israel 1977    3495918      Asia 73.06000
    ## 286                     Spain 1977   36439000    Europe 74.39000
    ## 287                   Croatia 1982    4413368    Europe 70.46000
    ## 288                     Gabon 2007    1454867    Africa 56.73500
    ## 289               New Zealand 1962    2488550   Oceania 71.24000
    ## 290                     Chile 2007   16284741  Americas 78.55300
    ## 291                   Belgium 1967    9556500    Europe 70.94000
    ## 292                 Venezuela 1977   13503563  Americas 67.45600
    ## 293            Czech Republic 1972    9862158    Europe 70.29000
    ## 294                  Portugal 1987    9915289    Europe 74.06000
    ## 295                    France 1967   49569000    Europe 71.55000
    ## 296                   Hungary 1987   10612740    Europe 69.58000
    ## 297                    Serbia 1977    8686367    Europe 70.30000
    ## 298                      Oman 1982    1301048      Asia 62.72800
    ## 299                   Germany 1962   73739117    Europe 70.30000
    ## 300                   Austria 1967    7376998    Europe 70.14000
    ## 301               Netherlands 1962   11805689    Europe 73.23000
    ## 302                    Israel 1972    3095893      Asia 71.63000
    ## 303                 Argentina 2007   40301927  Americas 75.32000
    ## 304                   Bahrain 1962     171863      Asia 56.92300
    ## 305                    Greece 1972    8888628    Europe 72.34000
    ## 306                   Ireland 1982    3480000    Europe 73.10000
    ## 307                  Botswana 2007    1639131    Africa 50.72800
    ## 308                   Hungary 1982   10705535    Europe 69.39000
    ## 309                     Gabon 2002    1299304    Africa 56.76100
    ## 310                    Canada 1957   17010154  Americas 69.96000
    ## 311            United Kingdom 1962   53292000    Europe 70.76000
    ## 312                  Malaysia 2007   24821286      Asia 74.24100
    ## 313                  Slovenia 1972    1694510    Europe 69.82000
    ## 314                    Sweden 1962    7561588    Europe 73.37000
    ## 315               Puerto Rico 1987    3444468  Americas 74.63000
    ## 316                     Italy 1972   54365564    Europe 72.19000
    ## 317               New Zealand 1957    2229407   Oceania 70.26000
    ## 318                 Australia 1962   10794968   Oceania 70.93000
    ## 319         Equatorial Guinea 2007     551201    Africa 51.57900
    ## 320           Slovak Republic 1997    5383010    Europe 72.71000
    ## 321                Korea Rep. 1992   43805450      Asia 72.24400
    ## 322                     Libya 2007    6036914    Africa 73.95200
    ## 323           Slovak Republic 1987    5199318    Europe 71.08000
    ## 324                    Poland 2002   38625976    Europe 74.67000
    ## 325                    Mexico 2007  108700891  Americas 76.19500
    ## 326                      Iran 1977   35480679      Asia 57.70200
    ## 327                     Gabon 1987     880397    Africa 60.19000
    ## 328                      Oman 1977    1004533      Asia 57.36700
    ## 329                     Libya 1987    3799845    Africa 66.23400
    ## 330                  Portugal 1982    9859650    Europe 72.77000
    ## 331                Montenegro 1987     569473    Europe 74.86500
    ## 332                   Hungary 1997   10244684    Europe 71.04000
    ## 333                   Hungary 1977   10637171    Europe 69.95000
    ## 334                    Norway 1957    3491938    Europe 73.44000
    ## 335                      Iraq 1987   16543189      Asia 65.04400
    ## 336                   Bahrain 1957     138655      Asia 53.83200
    ## 337                   Croatia 2002    4481020    Europe 74.87600
    ## 338              Saudi Arabia 1962    4943029      Asia 45.91400
    ## 339                      Iran 2007   69453570      Asia 70.96400
    ## 340       Trinidad and Tobago 2002    1101832  Americas 68.97600
    ## 341                 Venezuela 2007   26084662  Americas 73.74700
    ## 342                     Gabon 1972     537977    Africa 48.69000
    ## 343            Czech Republic 1967    9835109    Europe 70.38000
    ## 344                    Canada 1952   14785584  Americas 68.75000
    ## 345           Slovak Republic 1982    5048043    Europe 70.80000
    ## 346                   Croatia 1977    4318673    Europe 70.64000
    ## 347            United Kingdom 1957   51430000    Europe 70.42000
    ## 348               Netherlands 1957   11026383    Europe 72.99000
    ## 349                Montenegro 1982     562548    Europe 74.10100
    ## 350                 Singapore 1977    2325300      Asia 70.79500
    ## 351           Hong Kong China 1977    4583700      Asia 73.60000
    ## 352                 Venezuela 1982   15620766  Americas 68.55700
    ## 353                   Ireland 1977    3271900    Europe 72.03000
    ## 354                   Denmark 1957    4487831    Europe 71.81000
    ## 355                    Taiwan 1987   19757799      Asia 73.40000
    ## 356                  Botswana 2002    1630347    Africa 46.63400
    ## 357                   Belgium 1962    9218400    Europe 70.25000
    ## 358                 Argentina 1997   36203463  Americas 73.27500
    ## 359                 Mauritius 2007    1250882    Africa 72.80100
    ## 360                 Australia 1957    9712569   Oceania 70.33000
    ## 361           Slovak Republic 1977    4827803    Europe 70.45000
    ## 362                   Finland 1967    4605744    Europe 69.83000
    ## 363                   Romania 2007   22276056    Europe 72.47600
    ## 364                     Chile 2002   15497046  Americas 77.86000
    ## 365                   Austria 1962    7129864    Europe 69.54000
    ## 366                    Mexico 2002  102479927  Americas 74.90200
    ## 367                 Venezuela 1992   20265563  Americas 71.15000
    ## 368                  Bulgaria 2007    7322858    Europe 73.00500
    ## 369                     Spain 1972   34513161    Europe 73.06000
    ## 370                      Oman 1972     829050      Asia 52.14300
    ## 371                   Uruguay 2007    3447496  Americas 76.38400
    ## 372                    France 1962   47124000    Europe 70.51000
    ## 373               New Zealand 1952    1994794   Oceania 69.39000
    ## 374                   Hungary 1992   10348684    Europe 69.17000
    ## 375                    Serbia 1972    8313288    Europe 68.70000
    ## 376                 Venezuela 1972   11515649  Americas 65.71200
    ## 377                   Lebanon 2007    3921278      Asia 71.99300
    ## 378                   Iceland 1962     182053    Europe 73.68000
    ## 379               Puerto Rico 1982    3279001  Americas 73.75000
    ## 380                  Malaysia 2002   22662365      Asia 73.04400
    ## 381                   Germany 1957   71019069    Europe 69.10000
    ## 382                  Portugal 1977    9662600    Europe 70.41000
    ## 383                   Hungary 1972   10394091    Europe 69.76000
    ## 384                 Venezuela 1997   22374398  Americas 72.14600
    ## 385                    Poland 1997   38654957    Europe 72.75000
    ## 386            Czech Republic 1962    9620282    Europe 69.90000
    ## 387                  Malaysia 1997   20476091      Asia 71.93800
    ## 388                     Chile 1997   14599929  Americas 75.81600
    ## 389                    Norway 1952    3327728    Europe 72.67000
    ## 390                 Argentina 1977   26983828  Americas 68.48100
    ## 391                 Australia 1952    8691212   Oceania 69.12000
    ## 392                     Italy 1967   52667100    Europe 71.06000
    ## 393            United Kingdom 1952   50430000    Europe 69.18000
    ## 394                    Sweden 1957    7363802    Europe 72.49000
    ## 395                 Venezuela 1987   17910182  Americas 70.19000
    ## 396                   Croatia 1997    4444595    Europe 73.68000
    ## 397                   Bahrain 1952     120447      Asia 50.93900
    ## 398                     Japan 1967  100825279      Asia 71.43000
    ## 399                    Panama 2007    3242173  Americas 75.53700
    ## 400                 Venezuela 1957    6702668  Americas 57.90700
    ## 401                    Serbia 2007   10150265    Europe 74.00200
    ## 402               Puerto Rico 1977    3080828  Americas 73.44000
    ## 403                    Mexico 1997   95895146  Americas 73.67000
    ## 404                   Belgium 1957    8989111    Europe 69.24000
    ## 405                   Romania 1987   22686371    Europe 69.53000
    ## 406                   Denmark 1952    4334000    Europe 70.78000
    ## 407           Slovak Republic 1972    4593433    Europe 70.35000
    ## 408                Costa Rica 2007    4133884  Americas 78.78200
    ## 409                     Libya 1992    4364501    Africa 68.75500
    ## 410                      Iran 1972   30614000      Asia 55.23400
    ## 411                    Mexico 1982   71640904  Americas 67.40500
    ## 412                   Romania 1982   22356726    Europe 69.66000
    ## 413                Montenegro 1977     560073    Europe 73.06600
    ## 414                      Iraq 1972   10061506      Asia 56.95000
    ## 415                 Venezuela 1967    9709552  Americas 63.47900
    ## 416                     Libya 2002    5368585    Africa 72.73700
    ## 417                   Ireland 1972    3024400    Europe 71.28000
    ## 418                    Poland 1977   34621254    Europe 70.67000
    ## 419           Slovak Republic 1992    5302888    Europe 71.38000
    ## 420                    Mexico 1992   88111030  Americas 71.45500
    ## 421                     Libya 1997    4759670    Africa 71.55500
    ## 422                 Argentina 1972   24779799  Americas 67.06500
    ## 423                  Slovenia 1967    1646912    Europe 69.18000
    ## 424                   Finland 1962    4491443    Europe 68.75000
    ## 425                   Romania 1977   21658597    Europe 69.46000
    ## 426                   Hungary 1967   10223422    Europe 69.50000
    ## 427                    Serbia 1992    9826397    Europe 71.65900
    ## 428                   Lebanon 2002    3677780      Asia 71.02800
    ## 429                 Argentina 1992   33958947  Americas 71.86800
    ## 430              South Africa 2007   43997828    Africa 49.33900
    ## 431                Montenegro 2007     684736    Europe 74.54300
    ## 432                   Iceland 1957     165110    Europe 73.47000
    ## 433                      Iran 2002   66907826      Asia 69.45100
    ## 434                   Uruguay 1997    3262838  Americas 74.22300
    ## 435                   Croatia 1972    4225310    Europe 69.61000
    ## 436                 Argentina 1987   31620918  Americas 70.77400
    ## 437               Puerto Rico 1972    2847132  Americas 72.16000
    ## 438       Trinidad and Tobago 1982    1116479  Americas 68.83200
    ## 439                    Poland 1987   37740710    Europe 70.98000
    ## 440                    Brazil 2007  190010647  Americas 72.39000
    ## 441                  Portugal 1972    8970450    Europe 69.26000
    ## 442                 Mauritius 2002    1200206    Africa 71.95400
    ## 443                 Argentina 1982   29341374  Americas 69.94200
    ## 444                      Cuba 2007   11416987  Americas 78.27300
    ## 445               Netherlands 1952   10381988    Europe 72.13000
    ## 446                      Iraq 1967    8519282      Asia 54.45900
    ## 447                   Austria 1957    6965860    Europe 67.48000
    ## 448                 Argentina 2002   38331121  Americas 74.34000
    ## 449       Trinidad and Tobago 1997    1138101  Americas 69.46500
    ## 450                   Lebanon 1997    3430388      Asia 70.26500
    ## 451                    Mexico 1987   80122492  Americas 69.49800
    ## 452                    France 1957   44310863    Europe 68.93000
    ## 453                   Lebanon 1977    3115787      Asia 66.09900
    ## 454                  Botswana 1997    1536536    Africa 52.55600
    ## 455                 Venezuela 2002   24287670  Americas 72.76600
    ## 456                 Singapore 1972    2152400      Asia 69.52100
    ## 457              South Africa 1982   31140029    Africa 58.16100
    ## 458                Korea Rep. 1987   41622000      Asia 69.81000
    ## 459                    Sweden 1952    7124673    Europe 71.86000
    ## 460                    Greece 1967    8716441    Europe 71.00000
    ## 461                    Turkey 2007   71158647    Europe 71.77700
    ## 462                    Poland 1982   36227381    Europe 71.32000
    ## 463                   Croatia 1992    4494013    Europe 72.52700
    ## 464                 Venezuela 1962    8143375  Americas 60.77000
    ## 465           Slovak Republic 1967    4442238    Europe 70.98000
    ## 466                    Israel 1967    2693585      Asia 70.75000
    ## 467                     Gabon 1967     489004    Africa 44.59800
    ## 468                   Belgium 1952    8730405    Europe 68.00000
    ## 469                      Iraq 1962    7240260      Asia 51.45700
    ## 470           Hong Kong China 1972    4115700      Asia 72.00000
    ## 471                      Iran 1997   63327987      Asia 68.04200
    ## 472            Czech Republic 1957    9513758    Europe 69.03000
    ## 473                     Italy 1962   50843200    Europe 69.24000
    ## 474                  Bulgaria 1987    8971958    Europe 71.34000
    ## 475                  Bulgaria 1982    8892098    Europe 71.08000
    ## 476              Saudi Arabia 1957    4419650      Asia 42.86800
    ## 477                   Uruguay 1992    3149262  Americas 72.75200
    ## 478                    Brazil 2002  179914212  Americas 71.00600
    ## 479                 Argentina 1967   22934225  Americas 65.63400
    ## 480              South Africa 1977   27129932    Africa 55.52700
    ## 481                   Romania 1972   20662648    Europe 69.21000
    ## 482                    Poland 1972   33039545    Europe 70.85000
    ## 483                     Spain 1967   32850275    Europe 71.44000
    ## 484                    Serbia 1967    7971222    Europe 66.91400
    ## 485                    Brazil 1997  168546719  Americas 69.38800
    ## 486                  Botswana 1992    1342614    Africa 62.74500
    ## 487                    Serbia 1997   10336594    Europe 72.23200
    ## 488       Trinidad and Tobago 1977    1039009  Americas 68.30000
    ## 489                   Romania 2002   22404337    Europe 71.32200
    ## 490              South Africa 1987   35933379    Africa 60.83400
    ## 491                    Brazil 1987  142938076  Americas 65.20500
    ## 492                Montenegro 1972     527678    Europe 70.63600
    ## 493              South Africa 1972   23935810    Africa 53.69600
    ## 494                    Poland 1992   38370697    Europe 70.99000
    ## 495                   Uruguay 2002    3363085  Americas 75.30700
    ## 496                Costa Rica 2002    3834934  Americas 78.12300
    ## 497              South Africa 2002   44433622    Africa 53.36500
    ## 498         Equatorial Guinea 2002     495627    Africa 49.34800
    ## 499                  Bulgaria 2002    7661799    Europe 72.14000
    ## 500                 Venezuela 1952    5439568  Americas 55.08800
    ## 501                    Mexico 1977   63759976  Americas 65.03200
    ## 502                   Reunion 2007     798094    Africa 76.44200
    ## 503                   Ireland 1967    2900100    Europe 71.08000
    ## 504                   Lebanon 1982    3086876      Asia 66.98300
    ## 505                  Bulgaria 1977    8797022    Europe 70.81000
    ## 506                      Iran 1982   43072751      Asia 59.62000
    ## 507                     Chile 1992   13572994  Americas 74.12600
    ## 508                   Hungary 1962   10063000    Europe 67.96000
    ## 509                   Finland 1957    4324000    Europe 67.49000
    ## 510                      Cuba 1987   10239839  Americas 74.17400
    ## 511                   Lebanon 1972    2680018      Asia 65.42100
    ## 512           Slovak Republic 1962    4237384    Europe 70.33000
    ## 513              South Africa 1997   42835005    Africa 60.23600
    ## 514                  Thailand 2007   65068149      Asia 70.61600
    ## 515                   Uruguay 1987    3045153  Americas 71.91800
    ## 516    Bosnia and Herzegovina 2007    4552198    Europe 74.85200
    ## 517                   Jamaica 1972    1997616  Americas 69.00000
    ## 518                   Ecuador 1997   11911819  Americas 72.31200
    ## 519                    Taiwan 1982   18501390      Asia 72.16000
    ## 520                 Mauritius 1997    1149818    Africa 70.73600
    ## 521                      Peru 2007   28674757  Americas 71.42100
    ## 522                   Jamaica 1992    2378618  Americas 71.76600
    ## 523                  Slovenia 1962    1582962    Europe 69.15000
    ## 524       Trinidad and Tobago 1987    1191336  Americas 69.58200
    ## 525       Trinidad and Tobago 1992    1183669  Americas 69.86200
    ## 526                    Panama 2002    2990875  Americas 74.71200
    ## 527                   Romania 1997   22562458    Europe 69.72000
    ## 528                   Jamaica 2007    2780132  Americas 72.56700
    ## 529                      Cuba 1982    9789224  Americas 73.71700
    ## 530                  Malaysia 1992   18319502      Asia 70.69300
    ## 531                   Iceland 1952     147962    Europe 72.49000
    ## 532                    Serbia 2002   10111559    Europe 73.21300
    ## 533                      Iran 1992   60397973      Asia 65.74200
    ## 534              South Africa 1992   39964159    Africa 61.88800
    ## 535                   Ecuador 1982    8365850  Americas 64.34200
    ## 536                   Germany 1952   69145952    Europe 67.50000
    ## 537                 Argentina 1962   21283783  Americas 65.14200
    ## 538                   Jamaica 1997    2531311  Americas 72.26200
    ## 539              South Africa 1967   20997321    Africa 51.92700
    ## 540                    Panama 1997    2734531  Americas 73.73800
    ## 541        West Bank and Gaza 1997    2826046      Asia 71.09600
    ## 542                    Israel 1962    2310904      Asia 69.39000
    ## 543                   Ecuador 1992   10748394  Americas 69.61300
    ## 544                   Tunisia 2007   10276158    Africa 73.92300
    ## 545                    Panama 1987    2253639  Americas 71.52300
    ## 546                    Brazil 1982  128962939  Americas 63.33600
    ## 547                    France 1952   42459667    Europe 67.41000
    ## 548                    Panama 1982    2036305  Americas 70.47200
    ## 549                  Colombia 2007   44227550  Americas 72.88900
    ## 550                Montenegro 1992     621621    Europe 75.43500
    ## 551                   Jamaica 2002    2664659  Americas 72.04700
    ## 552                   Croatia 1967    4174366    Europe 68.50000
    ## 553                    Brazil 1992  155975974  Americas 67.05700
    ## 554               Puerto Rico 1967    2648961  Americas 71.10000
    ## 555                   Uruguay 1982    2953997  Americas 70.80500
    ## 556                   Lebanon 1992    3219994      Asia 69.29200
    ## 557            Czech Republic 1952    9125183    Europe 66.87000
    ## 558                   Ecuador 2007   13755680  Americas 74.99400
    ## 559                 Argentina 1957   19610538  Americas 64.39900
    ## 560                    Mexico 1972   55984294  Americas 62.36100
    ## 561                     Libya 1962    1441863    Africa 47.80800
    ## 562                   Ecuador 1977    7278866  Americas 61.31000
    ## 563                Costa Rica 1997    3518107  Americas 77.26000
    ## 564                    Brazil 1977  114313951  Americas 61.48900
    ## 565                   Jamaica 1977    2156814  Americas 70.11000
    ## 566                      Iran 1987   51889696      Asia 63.04000
    ## 567                   Ireland 1962    2830000    Europe 70.29000
    ## 568                     Gabon 1962     455661    Africa 40.48900
    ## 569       Trinidad and Tobago 1972     975199  Americas 65.90000
    ## 570                    Panama 1992    2484997  Americas 72.46200
    ## 571                    Turkey 1997   63047647    Europe 68.83500
    ## 572                   Romania 1992   22797027    Europe 69.36000
    ## 573                  Bulgaria 1972    8576200    Europe 70.90000
    ## 574                     Japan 1962   95831757      Asia 68.73000
    ## 575                Montenegro 2002     720230    Europe 73.98100
    ## 576                    Poland 1967   31785378    Europe 69.61000
    ## 577                    Turkey 2002   67308928    Europe 70.84500
    ## 578                   Uruguay 1977    2873520  Americas 69.48100
    ## 579                   Ecuador 1987    9545158  Americas 67.23100
    ## 580                   Romania 1967   19284814    Europe 66.80000
    ## 581                Montenegro 1997     692651    Europe 75.44500
    ## 582              Saudi Arabia 1952    4005677      Asia 39.87500
    ## 583                      Peru 1982   18125129  Americas 61.40600
    ## 584                   Finland 1952    4090500    Europe 66.55000
    ## 585                      Cuba 1977    9537988  Americas 72.64900
    ## 586                  Portugal 1967    9103000    Europe 66.60000
    ## 587                      Peru 1987   20195924  Americas 64.13400
    ## 588                   Jamaica 1987    2326606  Americas 71.77000
    ## 589                      Cuba 2002   11226999  Americas 77.15800
    ## 590                   Reunion 2002     743981    Africa 75.74400
    ## 591                  Bulgaria 1992    8658506    Europe 71.19000
    ## 592                    Serbia 1962    7616060    Europe 64.53100
    ## 593                      Peru 1977   15990099  Americas 58.44700
    ## 594                     Italy 1957   49182000    Europe 67.81000
    ## 595                      Iraq 1957    6248643      Asia 48.43700
    ## 596                   Algeria 2007   33333216    Africa 72.30100
    ## 597                  Botswana 1987    1151184    Africa 63.62200
    ## 598           Hong Kong China 1967    3722800      Asia 70.00000
    ## 599                Costa Rica 1992    3173216  Americas 75.71300
    ## 600                   Uruguay 1957    2424959  Americas 67.04400
    ## 601                   Austria 1952    6927772    Europe 66.80000
    ## 602                   Jamaica 1967    1861096  Americas 67.51000
    ## 603                  Colombia 1997   37657830  Americas 70.31300
    ## 604                   Reunion 1992     622191    Africa 73.61500
    ## 605           Slovak Republic 1957    3844277    Europe 67.45000
    ## 606                      Cuba 1957    6640752  Americas 62.32500
    ## 607                   Lebanon 1957    1647412      Asia 59.48900
    ## 608                   Reunion 1997     684810    Africa 74.77200
    ## 609                   Jamaica 1982    2298309  Americas 71.21000
    ## 610                 Mauritius 1992    1096202    Africa 69.74500
    ## 611                   Hungary 1957    9839000    Europe 66.41000
    ## 612        Dominican Republic 2007    9319622  Americas 72.23500
    ## 613    Bosnia and Herzegovina 2002    4165416    Europe 74.09000
    ## 614        West Bank and Gaza 1992    2104779      Asia 69.71800
    ## 615                    Greece 1962    8448233    Europe 69.51000
    ## 616                   Lebanon 1967    2186894      Asia 63.87000
    ## 617                  Bulgaria 1997    8066057    Europe 70.32000
    ## 618                      Peru 1972   13954700  Americas 55.44800
    ## 619                   Albania 2007    3600523    Europe 76.42300
    ## 620                Costa Rica 1977    2108457  Americas 70.75000
    ## 621                  Thailand 2002   62806748      Asia 68.56400
    ## 622                 Argentina 1952   17876956  Americas 62.48500
    ## 623                      Peru 2002   26769436  Americas 69.90600
    ## 624                Montenegro 1967     501035    Europe 67.17800
    ## 625                      Iran 1967   26538000      Asia 52.46900
    ## 626                  Slovenia 1957    1533070    Europe 67.85000
    ## 627                  Thailand 1997   60216677      Asia 67.52100
    ## 628                      Peru 1997   24748122  Americas 68.38600
    ## 629                      Peru 1967   12132200  Americas 51.44500
    ## 630                   Ecuador 2002   12921234  Americas 74.17300
    ## 631              South Africa 1962   18356657    Africa 49.95100
    ## 632                  Colombia 2002   41008227  Americas 71.68200
    ## 633                    Mexico 1967   47995559  Americas 60.11000
    ## 634                   Algeria 1982   20033753    Africa 61.36800
    ## 635               El Salvador 2007    6939688  Americas 71.87800
    ## 636                   Tunisia 2002    9770575    Africa 73.04200
    ## 637                   Uruguay 1952    2252965  Americas 66.07100
    ## 638                   Lebanon 1962    1886848      Asia 62.09400
    ## 639                   Uruguay 1972    2829526  Americas 68.67300
    ## 640                     Spain 1962   31158061    Europe 69.69000
    ## 641                      Cuba 1967    8139332  Americas 68.29000
    ## 642                   Algeria 1987   23254956    Africa 65.79900
    ## 643                    Turkey 1992   58179144    Europe 66.14600
    ## 644                Costa Rica 1987    2799811  Americas 74.75200
    ## 645                Korea Rep. 1982   39326000      Asia 67.12300
    ## 646       Trinidad and Tobago 1967     960155  Americas 65.40000
    ## 647                   Uruguay 1962    2598466  Americas 68.25300
    ## 648                   Ireland 1957    2878220    Europe 68.90000
    ## 649                    Taiwan 1977   16785196      Asia 70.59000
    ## 650                      Cuba 1992   10723260  Americas 74.41400
    ## 651                      Cuba 1952    6007797  Americas 59.42100
    ## 652                     Egypt 2007   80264543    Africa 71.33800
    ## 653                  Bulgaria 1967    8310226    Europe 70.42000
    ## 654                     Chile 1987   12463354  Americas 72.49200
    ## 655                    Angola 1967    5247469    Africa 35.98500
    ## 656                     Chile 1972    9717524  Americas 63.44100
    ## 657              South Africa 1957   16151549    Africa 47.98500
    ## 658                 Nicaragua 1977    2554598  Americas 57.47000
    ## 659                   Croatia 1962    4076557    Europe 67.13000
    ## 660                    Angola 1972    5894858    Africa 37.92800
    ## 661                  Colombia 1992   34202721  Americas 68.42100
    ## 662                   Uruguay 1967    2748579  Americas 68.46800
    ## 663                      Cuba 1997   10983007  Americas 76.15100
    ## 664                    Israel 1957    1944401      Asia 67.84000
    ## 665                   Lebanon 1987    3089353      Asia 67.92600
    ## 666                    Panama 1972    1616384  Americas 66.21600
    ## 667                    Panama 1977    1839782  Americas 68.68100
    ## 668               El Salvador 2002    6353681  Americas 70.73400
    ## 669                    Poland 1962   30329617    Europe 67.64000
    ## 670                      Cuba 1972    8831348  Americas 70.72300
    ## 671                   Reunion 1987     562035    Africa 71.91300
    ## 672                   Algeria 2002   31287142    Africa 70.99400
    ## 673                   Ecuador 1972    6298651  Americas 58.79600
    ## 674                   Reunion 1982     517810    Africa 69.88500
    ## 675                   Hungary 1952    9504000    Europe 64.03000
    ## 676                Costa Rica 1982    2424367  Americas 73.45000
    ## 677                  Malaysia 1987   16331785      Asia 69.50000
    ## 678                   Jamaica 1962    1665128  Americas 65.61000
    ## 679                   Ireland 1952    2952156    Europe 66.91000
    ## 680                 Guatemala 2007   12572928  Americas 70.25900
    ## 681                      Cuba 1962    7254373  Americas 65.24600
    ## 682               El Salvador 1997    5783439  Americas 69.53500
    ## 683               El Salvador 1977    4282586  Americas 56.69600
    ## 684                Costa Rica 1972    1834796  Americas 67.84900
    ## 685               Puerto Rico 1962    2448046  Americas 69.62000
    ## 686        West Bank and Gaza 1987    1691210      Asia 67.04600
    ## 687                     Chile 1967    8858908  Americas 60.52300
    ## 688                     Chile 1982   11487112  Americas 70.56500
    ## 689                    Turkey 1987   52881328    Europe 63.10800
    ## 690           Slovak Republic 1952    3558137    Europe 64.36000
    ## 691                   Reunion 1972     461633    Africa 64.27400
    ## 692                   Algeria 1992   26298373    Africa 67.74400
    ## 693       Trinidad and Tobago 1962     887498  Americas 64.90000
    ## 694                    Brazil 1972  100840058  Americas 59.50400
    ## 695                    Serbia 1957    7271135    Europe 61.68500
    ## 696                 Singapore 1967    1977600      Asia 67.94600
    ## 697                     Gabon 1957     434904    Africa 38.99900
    ## 698                     China 2007 1318683096      Asia 72.96100
    ## 699                      Peru 1962   10516500  Americas 49.09600
    ## 700                     Italy 1952   47666000    Europe 65.94000
    ## 701                  Malaysia 1982   14441916      Asia 68.00000
    ## 702                    Greece 1957    8096218    Europe 67.86000
    ## 703                   Algeria 1977   17152804    Africa 58.01400
    ## 704                  Colombia 1987   30964245  Americas 67.76800
    ## 705                 Guatemala 1977    5703430  Americas 56.02900
    ## 706                Congo Rep. 1982    1774735    Africa 56.69500
    ## 707                   Tunisia 1997    9231669    Africa 71.97300
    ## 708                 Guatemala 2002   11178650  Americas 68.97800
    ## 709                   Lebanon 1952    1439529      Asia 55.92800
    ## 710                 Guatemala 1982    6395630  Americas 58.13700
    ## 711                   Namibia 2007    2055080    Africa 52.90600
    ## 712                   Algeria 1997   29072015    Africa 69.15200
    ## 713                    Angola 2007   12420476    Africa 42.73100
    ## 714                 Mauritius 1987    1042663    Africa 68.74000
    ## 715    Bosnia and Herzegovina 1997    3607000    Europe 73.24400
    ## 716                     Chile 1977   10599793  Americas 67.05200
    ## 717                   Jamaica 1957    1535090  Americas 62.61000
    ## 718                     Egypt 2002   73312559    Africa 69.80600
    ## 719                   Romania 1962   18680721    Europe 66.80000
    ## 720                    Poland 1957   28235346    Europe 65.77000
    ## 721                  Portugal 1962    9019800    Europe 64.39000
    ## 722              South Africa 1952   14264935    Africa 45.00900
    ## 723                      Oman 1967     714775      Asia 46.98800
    ## 724           Hong Kong China 1962    3305200      Asia 67.65000
    ## 725                 Nicaragua 1972    2182908  Americas 55.15100
    ## 726                 Guatemala 1997    9803875  Americas 66.32200
    ## 727                Korea Rep. 1977   36436000      Asia 64.76600
    ## 728                Montenegro 1962     474528    Europe 63.72800
    ## 729                 Nicaragua 1967    1865490  Americas 51.88400
    ## 730                  Thailand 1992   56667095      Asia 67.29800
    ## 731                   Albania 2002    3508512    Europe 75.65100
    ## 732                    Mexico 1962   41121485  Americas 58.29900
    ## 733                   Ecuador 1967    5432424  Americas 56.67800
    ## 734                     Spain 1957   29841614    Europe 66.66000
    ## 735        Dominican Republic 2002    8650322  Americas 70.84700
    ## 736                  Botswana 1982     970347    Africa 61.48400
    ## 737               El Salvador 1972    3790903  Americas 58.20700
    ## 738                    Jordan 2007    6053193      Asia 72.53500
    ## 739                     Chile 1962    7961258  Americas 57.92400
    ## 740        West Bank and Gaza 2002    3389578      Asia 72.37000
    ## 741                 Swaziland 2007    1133066    Africa 39.61300
    ## 742                      Iraq 2007   27499638      Asia 59.54500
    ## 743                    Jordan 1987    2820042      Asia 65.86900
    ## 744                      Peru 1992   22430449  Americas 66.45800
    ## 745               El Salvador 1992    5274649  Americas 66.79800
    ## 746                 Guatemala 1992    8486949  Americas 63.37300
    ## 747                    Panama 1967    1405486  Americas 64.07100
    ## 748                  Colombia 1982   27764644  Americas 66.65300
    ## 749                      Iraq 2002   24001816      Asia 57.04600
    ## 750               El Salvador 1967    3232927  Americas 55.85500
    ## 751                   Croatia 1957    3991242    Europe 64.77000
    ## 752        West Bank and Gaza 1982    1425876      Asia 64.40600
    ## 753                   Tunisia 1992    8523077    Africa 70.00100
    ## 754                   Reunion 1977     492095    Africa 67.06400
    ## 755                     Japan 1957   91563009      Asia 65.50000
    ## 756                     Chile 1957    7048426  Americas 56.07400
    ## 757    Bosnia and Herzegovina 1987    4338977    Europe 71.14000
    ## 758                     Gabon 1952     420702    Africa 37.00300
    ## 759                    Angola 1962    4826015    Africa 34.00000
    ## 760                    Turkey 1977   42404033    Europe 59.50700
    ## 761                  Paraguay 1982    3366439  Americas 66.87400
    ## 762                  Bulgaria 1962    8012946    Europe 69.51000
    ## 763                  Paraguay 1997    5154123  Americas 69.40000
    ## 764                 Guatemala 1987    7326406  Americas 60.78200
    ## 765                      Peru 1957    9146100  Americas 46.26300
    ## 766                    Turkey 1982   47328791    Europe 61.03600
    ## 767                  Slovenia 1952    1489518    Europe 65.57000
    ## 768                Congo Rep. 1987    2064095    Africa 57.47000
    ## 769                  Paraguay 1992    4483945  Americas 68.22500
    ## 770                   Namibia 1982    1099010    Africa 58.96800
    ## 771                      Iran 1962   22874000      Asia 49.32500
    ## 772                     Syria 2007   19314747      Asia 74.14300
    ## 773                   Algeria 1972   14760787    Africa 54.51800
    ## 774                     Egypt 1997   66134291    Africa 67.21700
    ## 775                  Paraguay 2007    6667147  Americas 71.75200
    ## 776                Costa Rica 1967    1588717  Americas 65.42400
    ## 777                    Jordan 1982    2347031      Asia 63.73900
    ## 778               El Salvador 1987    4842194  Americas 63.15400
    ## 779                    Mexico 1957   35015548  Americas 55.19000
    ## 780                      Iraq 1952    5441766      Asia 45.32000
    ## 781                 Swaziland 2002    1130269    Africa 43.86900
    ## 782    Bosnia and Herzegovina 1982    4172693    Europe 70.69000
    ## 783           Korea Dem. Rep. 1982   17647518      Asia 69.10000
    ## 784           Korea Dem. Rep. 1987   19067554      Asia 70.64700
    ## 785           Korea Dem. Rep. 1977   16325320      Asia 67.15900
    ## 786       Trinidad and Tobago 1957     764900  Americas 61.80000
    ## 787               El Salvador 1982    4474873  Americas 56.60400
    ## 788                     Syria 2002   17155814      Asia 73.05300
    ## 789                    Israel 1952    1620914      Asia 65.39000
    ## 790                   Ecuador 1962    4681707  Americas 54.64000
    ## 791                   Namibia 2002    1972153    Africa 51.47900
    ## 792                    Taiwan 1972   15226039      Asia 69.39000
    ## 793                 Guatemala 1972    5149581  Americas 53.73800
    ## 794                    Poland 1952   25730551    Europe 61.31000
    ## 795                   Reunion 1967     414024    Africa 60.54200
    ## 796                Congo Rep. 1992    2409073    Africa 56.43300
    ## 797                     Syria 1997   15081016      Asia 71.52700
    ## 798                  Paraguay 1987    3886512  Americas 67.37800
    ## 799                 Swaziland 1987     779348    Africa 57.67800
    ## 800                 Sri Lanka 2007   20378239      Asia 72.39600
    ## 801                   Romania 1957   17829327    Europe 64.10000
    ## 802                     Chile 1952    6377619  Americas 54.74500
    ## 803               Puerto Rico 1957    2260000  Americas 68.54000
    ## 804                   Namibia 1997    1774766    Africa 58.90900
    ## 805                 Swaziland 1982     649901    Africa 55.56100
    ## 806                     Egypt 1987   52799062    Africa 59.79700
    ## 807                 Swaziland 1997    1054486    Africa 54.28900
    ## 808                   Namibia 1977     977026    Africa 56.43700
    ## 809                    Jordan 2002    5307470      Asia 71.26300
    ## 810                     Spain 1952   28549870    Europe 64.94000
    ## 811                    Angola 1957    4561361    Africa 31.99900
    ## 812                  Malaysia 1977   12845381      Asia 65.25600
    ## 813                   Bolivia 2007    9119152  Americas 65.55400
    ## 814                   Morocco 2007   33757175    Africa 71.16400
    ## 815                  Colombia 1977   25094412  Americas 63.83700
    ## 816                   Tunisia 1987    7724976    Africa 66.89400
    ## 817                   Namibia 1992    1554253    Africa 61.99900
    ## 818                     Egypt 1992   59402198    Africa 63.67400
    ## 819                   Namibia 1967     706640    Africa 51.15900
    ## 820                  Paraguay 2002    5884491  Americas 70.75500
    ## 821                 Swaziland 1977     551425    Africa 52.53700
    ## 822                   Ecuador 1957    4058385  Americas 51.35600
    ## 823               El Salvador 1962    2747687  Americas 52.30700
    ## 824                  Portugal 1957    8817650    Europe 61.51000
    ## 825                     Syria 1982    9410494      Asia 64.59000
    ## 826                      Peru 1952    8025700  Americas 43.90200
    ## 827                   Namibia 1972     821782    Africa 53.86700
    ## 828                      Iraq 1992   17861905      Asia 59.46100
    ## 829                   Albania 1987    3075321    Europe 72.00000
    ## 830           Korea Dem. Rep. 1992   20711375      Asia 69.97800
    ## 831                 Mauritius 1977     913025    Africa 64.93000
    ## 832           Korea Dem. Rep. 1972   14781241      Asia 63.98300
    ## 833                  Djibouti 1972     178848    Africa 44.36600
    ## 834                   Namibia 1987    1278184    Africa 60.83500
    ## 835                 Mauritius 1982     992040    Africa 66.71100
    ## 836        West Bank and Gaza 1977    1261091      Asia 60.76500
    ## 837                Montenegro 1957     442829    Europe 61.44800
    ## 838                 Singapore 1962    1750200      Asia 65.79800
    ## 839                    Jordan 1997    4526235      Asia 69.77200
    ## 840                 Nicaragua 1962    1590597  Americas 48.63200
    ## 841                Congo Rep. 2007    3800610    Africa 55.32200
    ## 842                   Albania 1982    2780097    Europe 70.42000
    ## 843           Hong Kong China 1957    2736300      Asia 64.75000
    ## 844        Dominican Republic 1997    7992357  Americas 69.95700
    ## 845                    Serbia 1952    6860147    Europe 57.99600
    ## 846                   Tunisia 1982    6734098    Africa 64.04800
    ## 847                 Swaziland 1992     962344    Africa 58.47400
    ## 848                  Honduras 2007    7483763  Americas 70.19800
    ## 849                   Bolivia 1977    5079716  Americas 50.02300
    ## 850                 Indonesia 2007  223547000      Asia 70.65000
    ## 851                    Panama 1962    1215725  Americas 61.81700
    ## 852                   Albania 1977    2509048    Europe 68.93000
    ## 853                    Greece 1952    7733250    Europe 65.86000
    ## 854    Bosnia and Herzegovina 1977    4086000    Europe 69.86000
    ## 855                   Ecuador 1952    3548753  Americas 48.35700
    ## 856                    Angola 1952    4232095    Africa 30.01500
    ## 857                     Egypt 1982   45681811    Africa 56.00600
    ## 858                Congo Rep. 1997    2800947    Africa 52.96200
    ## 859                Congo Rep. 2002    3328795    Africa 52.97000
    ## 860                    Mexico 1952   30144317  Americas 50.78900
    ## 861                 Nicaragua 1982    2979423  Americas 59.29800
    ## 862                Costa Rica 1962    1345187  Americas 62.84200
    ## 863                 Nicaragua 1957    1358828  Americas 45.43200
    ## 864                    Turkey 1972   37492953    Europe 57.00500
    ## 865                     Libya 1957    1201578    Africa 45.28900
    ## 866                    Jordan 1992    3867409      Asia 68.01500
    ## 867                    Brazil 1967   88049823  Americas 57.63200
    ## 868               El Salvador 1957    2355805  Americas 48.57000
    ## 869                   Bolivia 2002    8445134  Americas 63.88300
    ## 870                 Swaziland 1972     480105    Africa 49.55200
    ## 871                     Syria 1992   13219062      Asia 69.24900
    ## 872                    Brazil 1962   76039390  Americas 55.66500
    ## 873                   Bolivia 1997    7693188  Americas 62.05000
    ## 874                   Albania 1972    2263554    Europe 67.69000
    ## 875                      Iran 1957   19792000      Asia 47.18100
    ## 876                  Colombia 1972   22542890  Americas 61.62300
    ## 877                Congo Rep. 1977    1536769    Africa 55.62500
    ## 878                   Morocco 2002   31167783    Africa 69.61500
    ## 879                  Paraguay 1977    2984494  Americas 66.35300
    ## 880                   Algeria 1967   12760499    Africa 51.40700
    ## 881                 Guatemala 1967    4690773  Americas 50.01600
    ## 882                     Japan 1952   86459025      Asia 63.03000
    ## 883                  Botswana 1977     781472    Africa 59.31900
    ## 884                Congo Rep. 1972    1340458    Africa 54.90700
    ## 885                  Honduras 1977    3055235  Americas 57.40200
    ## 886                     Syria 1977    7932503      Asia 61.19500
    ## 887                   Albania 1997    3428038    Europe 72.95000
    ## 888               Philippines 2007   91077287      Asia 71.68800
    ## 889                   Reunion 1962     358900    Africa 57.66600
    ## 890                   Namibia 1962     621392    Africa 48.38600
    ## 891                  Honduras 1997    5867957  Americas 67.65900
    ## 892                   Bolivia 1982    5642224  Americas 53.85900
    ## 893                   Romania 1952   16630000    Europe 61.05000
    ## 894        West Bank and Gaza 1972    1089572      Asia 56.53200
    ## 895                  Honduras 1982    3669448  Americas 60.90900
    ## 896                   Tunisia 1977    6005061    Africa 59.83700
    ## 897                 Indonesia 1997  199278000      Asia 66.04100
    ## 898                     China 2002 1280400000      Asia 72.02800
    ## 899                   Croatia 1952    3882229    Europe 61.21000
    ## 900                     Syria 1987   11242847      Asia 66.97400
    ## 901                 Nicaragua 1952    1165790  Americas 42.31400
    ## 902                  Honduras 2002    6677328  Americas 68.56500
    ## 903                  Mongolia 2007    2874127      Asia 66.80300
    ## 904               Puerto Rico 1952    2227000  Americas 64.28000
    ## 905                  Djibouti 1977     228694    Africa 46.51900
    ## 906                  Honduras 1992    5077347  Americas 66.39900
    ## 907                      Iraq 1997   20775703      Asia 58.81100
    ## 908                  Portugal 1952    8526050    Europe 59.82000
    ## 909           Hong Kong China 1952    2125900      Asia 60.96000
    ## 910               El Salvador 1952    2042865  Americas 45.26200
    ## 911        Dominican Republic 1992    7351181  Americas 68.45700
    ## 912                      Iran 1952   17272000      Asia 44.86900
    ## 913                Korea Rep. 1972   33505000      Asia 62.61200
    ## 914        West Bank and Gaza 2007    4018332      Asia 73.42200
    ## 915       Trinidad and Tobago 1952     662850  Americas 59.10000
    ## 916                  Honduras 1987    4372203  Americas 64.49200
    ## 917                  Djibouti 1962      89898    Africa 39.69300
    ## 918                  Djibouti 1967     127617    Africa 42.07400
    ## 919                 Sri Lanka 2002   19576783      Asia 70.81500
    ## 920                   Algeria 1957   10270856    Africa 45.68500
    ## 921                  Bulgaria 1957    7651254    Europe 66.61000
    ## 922                    Angola 1977    6162675    Africa 39.48300
    ## 923                Costa Rica 1957    1112300  Americas 60.02600
    ## 924                  Thailand 1987   52910342      Asia 66.08400
    ## 925                   Morocco 1997   28529501    Africa 67.66000
    ## 926                   Bolivia 1972    4565872  Americas 46.71400
    ## 927                    Panama 1957    1063506  Americas 59.20100
    ## 928                   Bolivia 1992    6893451  Americas 59.95700
    ## 929                 Nicaragua 1987    3344353  Americas 62.00800
    ## 930                   Morocco 1992   25798239    Africa 65.39300
    ## 931                      Oman 1962     628164      Asia 43.16500
    ## 932        Dominican Republic 1987    6655297  Americas 66.04600
    ## 933                   Jamaica 1952    1426095  Americas 58.53000
    ## 934                  Djibouti 1987     311025    Africa 50.04000
    ## 935                  Djibouti 1982     305991    Africa 48.81200
    ## 936                 Indonesia 2002  211060000      Asia 68.58800
    ## 937                  Djibouti 1957      71851    Africa 37.32800
    ## 938        Dominican Republic 1982    5968349  Americas 63.72700
    ## 939    Bosnia and Herzegovina 1972    3819000    Europe 67.45000
    ## 940                    Jordan 1977    1937652      Asia 61.13400
    ## 941                  Malaysia 1972   11441462      Asia 63.01000
    ## 942                 Singapore 1957    1445929      Asia 63.17900
    ## 943                    Turkey 1967   33411317    Europe 54.33600
    ## 944         Equatorial Guinea 1997     439971    Africa 48.24500
    ## 945                     Egypt 1977   38783863    Africa 53.31900
    ## 946                    Angola 2002   10866106    Africa 41.00300
    ## 947                   Reunion 1957     308700    Africa 55.09000
    ## 948                   Albania 1967    1984060    Europe 66.22000
    ## 949                    Angola 1982    7016384    Africa 39.94200
    ## 950                   Morocco 1987   22987397    Africa 62.67700
    ## 951                   Bolivia 1987    6156369  Americas 57.25100
    ## 952                   Tunisia 1972    5303507    Africa 55.60200
    ## 953                 Guatemala 1962    4208858  Americas 46.95400
    ## 954                 Nicaragua 2007    5675356  Americas 72.89900
    ## 955                    Jordan 1967    1255058      Asia 51.62900
    ## 956                   Reunion 1952     257700    Africa 52.72400
    ## 957                   Morocco 1982   20198730    Africa 59.65000
    ## 958        Dominican Republic 1977    5302800  Americas 61.78800
    ## 959                  Colombia 1967   19764027  Americas 59.96300
    ## 960                Congo Rep. 1967    1179760    Africa 52.04000
    ## 961                   Bolivia 1952    2883315  Americas 40.41400
    ## 962                  Djibouti 1952      63149    Africa 34.81200
    ## 963                 Sri Lanka 1997   18698655      Asia 70.45700
    ## 964               Philippines 2002   82995088      Asia 70.30300
    ## 965        West Bank and Gaza 1967    1142636      Asia 51.63100
    ## 966                Montenegro 1952     413834    Europe 59.16400
    ## 967                    Taiwan 1967   13648692      Asia 67.50000
    ## 968                    Angola 1992    8735988    Africa 40.64700
    ## 969                Costa Rica 1952     926317  Americas 57.20600
    ## 970                   Namibia 1957     548080    Africa 45.22600
    ## 971                 Guatemala 1957    3640876  Americas 44.14200
    ## 972                 Swaziland 1967     420690    Africa 46.63300
    ## 973                  Pakistan 2007  169270617      Asia 65.48300
    ## 974               Philippines 1982   53456774      Asia 62.08200
    ## 975             Cote d'Ivoire 1982    9025951    Africa 53.98300
    ## 976                  Cameroon 1987   10780667    Africa 54.98500
    ## 977                     Sudan 2007   42292929    Africa 58.55600
    ## 978                   Bolivia 1967    4040665  Americas 45.03200
    ## 979                 Mauritius 1972     851334    Africa 62.94400
    ## 980                     Syria 1972    6701172      Asia 57.29600
    ## 981                   Algeria 1962   11000948    Africa 48.30300
    ## 982    Bosnia and Herzegovina 1992    4256013    Europe 72.17800
    ## 983                  Honduras 1967    2500689  Americas 50.92400
    ## 984               Philippines 1997   75012988      Asia 68.56400
    ## 985                  Honduras 1972    2965146  Americas 53.88400
    ## 986                 Mauritius 1962     701016    Africa 60.24600
    ## 987                  Paraguay 1972    2614104  Americas 65.81500
    ## 988             Cote d'Ivoire 1977    7459574    Africa 52.37400
    ## 989                   Albania 1992    3326498    Europe 71.58100
    ## 990                  Colombia 1962   17009885  Americas 57.86300
    ## 991                    Brazil 1957   65551171  Americas 53.28500
    ## 992                    Panama 1952     940080  Americas 55.19100
    ## 993                 Mauritius 1967     789309    Africa 61.55700
    ## 994                 Nicaragua 2002    5146848  Americas 70.83600
    ## 995                Congo Rep. 1962    1047924    Africa 48.43500
    ## 996                     India 2007 1110396331      Asia 64.69800
    ## 997                   Algeria 1952    9279525    Africa 43.07700
    ## 998                  Bulgaria 1952    7274900    Europe 59.60000
    ## 999                   Vietnam 2007   85262356      Asia 74.24900
    ## 1000                   Angola 1987    7874230    Africa 39.90600
    ## 1001                Guatemala 1952    3146381  Americas 42.02300
    ## 1002                  Namibia 1952     485831    Africa 41.72500
    ## 1003                 Thailand 1982   48827160      Asia 64.59700
    ## 1004                    Libya 1952    1019729    Africa 42.72300
    ## 1005                Indonesia 1992  184816000      Asia 62.68100
    ## 1006            Cote d'Ivoire 1972    6071696    Africa 49.80100
    ## 1007                 Djibouti 1992     384156    Africa 51.60400
    ## 1008              Philippines 1977   46850962      Asia 60.06000
    ## 1009                  Morocco 1977   18396941    Africa 55.73000
    ## 1010                 Cameroon 1982    9250831    Africa 52.96100
    ## 1011                   Jordan 1962     933559      Asia 48.12600
    ## 1012                 Mongolia 1987    2015133      Asia 60.22200
    ## 1013                 Colombia 1957   14485993  Americas 55.11800
    ## 1014                   Turkey 1962   29788695    Europe 52.09800
    ## 1015                Singapore 1952    1127000      Asia 60.39600
    ## 1016               Congo Rep. 1957     940458    Africa 45.05300
    ## 1017                  Albania 1962    1728137    Europe 64.82000
    ## 1018                 Paraguay 1967    2287985  Americas 64.95100
    ## 1019                 Honduras 1962    2090162  Americas 48.04100
    ## 1020                    China 1997 1230075000      Asia 70.42600
    ## 1021               Yemen Rep. 2007   22211743      Asia 62.69800
    ## 1022              Philippines 1992   67185766      Asia 66.45800
    ## 1023                 Malaysia 1967   10154878      Asia 59.37100
    ## 1024                   Angola 1997    9875024    Africa 40.96300
    ## 1025                 Botswana 1972     619351    Africa 56.02400
    ## 1026                Nicaragua 1997    4609572  Americas 68.42600
    ## 1027                     Oman 1957     561977      Asia 40.08000
    ## 1028               Yemen Rep. 2002   18701257      Asia 60.30800
    ## 1029                 Honduras 1957    1770390  Americas 44.66500
    ## 1030                   Turkey 1957   25670939    Europe 48.07900
    ## 1031                    Sudan 1977   17104986    Africa 47.80000
    ## 1032       West Bank and Gaza 1962    1133134      Asia 48.12700
    ## 1033                 Honduras 1952    1517453  Americas 41.91200
    ## 1034                    Syria 1962    4834621      Asia 50.30500
    ## 1035       Dominican Republic 1972    4671329  Americas 59.63100
    ## 1036              Philippines 1987   60017788      Asia 64.15100
    ## 1037                  Bolivia 1962    3593918  Americas 43.42800
    ## 1038   Bosnia and Herzegovina 1967    3585000    Europe 64.79000
    ## 1039                Nicaragua 1992    4017939  Americas 65.84300
    ## 1040            Cote d'Ivoire 1987   10761098    Africa 54.65500
    ## 1041                Sri Lanka 1992   17587060      Asia 70.37900
    ## 1042                 Paraguay 1962    2009813  Americas 64.36100
    ## 1043                 Colombia 1952   12350771  Americas 50.64300
    ## 1044          Korea Dem. Rep. 1967   12617009      Asia 59.94200
    ## 1045                 Mongolia 2002    2674234      Asia 65.03300
    ## 1046                  Bolivia 1957    3211738  Americas 41.89000
    ## 1047               Congo Rep. 1952     854885    Africa 42.11100
    ## 1048               Yemen Rep. 1997   15826497      Asia 58.02000
    ## 1049                    Syria 1957    4149908      Asia 48.28400
    ## 1050                   Jordan 1972    1613551      Asia 56.52800
    ## 1051                   Brazil 1952   56602560  Americas 50.91700
    ## 1052                 Pakistan 2002  153403524      Asia 63.61000
    ## 1053                 Djibouti 2007     496374    Africa 54.79100
    ## 1054            Cote d'Ivoire 1967    4744870    Africa 47.35000
    ## 1055                 Pakistan 1997  135564834      Asia 61.81800
    ## 1056                 Paraguay 1957    1770902  Americas 63.19600
    ## 1057                 Cameroon 2007   17696293    Africa 50.43000
    ## 1058                 Malaysia 1962    8906385      Asia 55.73700
    ## 1059                Mauritius 1957     609816    Africa 58.08900
    ## 1060               Korea Rep. 1967   30131000      Asia 57.71600
    ## 1061                    Egypt 1972   34807417    Africa 51.13700
    ## 1062                  Nigeria 2007  135031164    Africa 46.85900
    ## 1063                    Haiti 1982    5198399  Americas 51.46100
    ## 1064                 Mongolia 1982    1756032      Asia 57.48900
    ## 1065                    Sudan 2002   37090298    Africa 56.36900
    ## 1066              Philippines 1972   40850141      Asia 58.06500
    ## 1067                  Nigeria 1977   62209173    Africa 44.51400
    ## 1068               Yemen Rep. 1982    9657618      Asia 49.11300
    ## 1069                 Pakistan 1992  120065004      Asia 60.83800
    ## 1070               Yemen Rep. 1987   11219340      Asia 52.92200
    ## 1071                   Turkey 1952   22235677    Europe 43.58500
    ## 1072                Mauritius 1952     516556    Africa 50.98600
    ## 1073                 Thailand 1977   44148285      Asia 62.49400
    ## 1074                    Sudan 1962   11183227    Africa 40.87000
    ## 1075                 Paraguay 1952    1555876  Americas 62.64900
    ## 1076                  Albania 1957    1476505    Europe 59.28000
    ## 1077                  Comoros 1972     250027    Africa 48.94400
    ## 1078                 Cameroon 2002   15929988    Africa 49.85600
    ## 1079                  Tunisia 1967    4786986    Africa 52.05300
    ## 1080                  Morocco 1972   16660670    Africa 52.86200
    ## 1081                 Djibouti 2002     447416    Africa 53.37300
    ## 1082                 Mongolia 1997    2494803      Asia 63.62500
    ## 1083                    Sudan 1982   20367053    Africa 50.33800
    ## 1084                 Djibouti 1997     417908    Africa 53.15700
    ## 1085    Sao Tome and Principe 1982      98593    Africa 60.35100
    ## 1086                   Jordan 1957     746559      Asia 45.66900
    ## 1087                    Syria 1967    5680812      Asia 53.65500
    ## 1088               Yemen Rep. 1992   13367997      Asia 55.59900
    ## 1089                Sri Lanka 1987   16495304      Asia 69.01100
    ## 1090                  Comoros 1967     217378    Africa 46.47200
    ## 1091                    Haiti 1977    4908554  Americas 49.92300
    ## 1092                Swaziland 1962     370006    Africa 44.99200
    ## 1093                    Haiti 1952    3201488  Americas 37.57900
    ## 1094                 Malaysia 1952    6748378      Asia 48.46300
    ## 1095               Yemen Rep. 1977    8403990      Asia 44.17500
    ## 1096                     Oman 1952     507833      Asia 37.57800
    ## 1097       West Bank and Gaza 1957    1070439      Asia 45.67100
    ## 1098                    Haiti 1987    5756203  Americas 53.63600
    ## 1099                   Taiwan 1962   11918938      Asia 65.20000
    ## 1100                    Egypt 1967   31681188    Africa 49.29300
    ## 1101              Philippines 1967   35356600      Asia 56.39300
    ## 1102                 Malaysia 1957    7739235      Asia 52.10200
    ## 1103               Mauritania 2007    3270065    Africa 64.16400
    ## 1104                    Haiti 1962    3880130  Americas 43.59000
    ## 1105                 Cameroon 1992   12467171    Africa 54.31400
    ## 1106            Cote d'Ivoire 1997   14625967    Africa 47.99100
    ## 1107                 Mongolia 1992    2312802      Asia 61.27100
    ## 1108                 Cameroon 1977    7959865    Africa 49.35500
    ## 1109                   Zambia 1967    3900000    Africa 47.76800
    ## 1110                   Zambia 1972    4506497    Africa 50.10700
    ## 1111                    Sudan 1957    9753392    Africa 39.62400
    ## 1112                  Vietnam 2002   80908147      Asia 73.01700
    ## 1113               Madagascar 1972    7082430    Africa 44.85100
    ## 1114                Indonesia 1987  169276000      Asia 60.13700
    ## 1115                    India 2002 1034172547      Asia 62.87900
    ## 1116    Sao Tome and Principe 1977      86796    Africa 58.55000
    ## 1117            Cote d'Ivoire 1962    3832408    Africa 44.93000
    ## 1118                    Haiti 1957    3507701  Americas 40.69600
    ## 1119                 Cambodia 2007   14131858      Asia 59.72300
    ## 1120                  Senegal 2007   12267493    Africa 63.06200
    ## 1121                  Morocco 1967   14770296    Africa 50.33500
    ## 1122   Bosnia and Herzegovina 1962    3349000    Europe 61.93000
    ## 1123                 Pakistan 1987  105186881      Asia 58.24500
    ## 1124                     Chad 2007   10238807    Africa 50.65100
    ## 1125                  Nigeria 1972   53740085    Africa 42.82100
    ## 1126                 Cameroon 1997   14195809    Africa 52.19900
    ## 1127                    Egypt 1962   28173309    Africa 46.99200
    ## 1128          Korea Dem. Rep. 1997   21585105      Asia 67.72700
    ## 1129                  Morocco 1952    9939217    Africa 42.87300
    ## 1130                    Sudan 1967   12716129    Africa 42.85800
    ## 1131                 Cameroon 1972    7021028    Africa 47.04900
    ## 1132       Dominican Republic 1962    3453434  Americas 53.45900
    ## 1133                  Tunisia 1962    4286552    Africa 49.57900
    ## 1134                    Sudan 1972   14597019    Africa 45.08300
    ## 1135                    China 1992 1164970000      Asia 68.69000
    ## 1136                  Senegal 1962    3430243    Africa 41.45400
    ## 1137                    Haiti 1972    4698301  Americas 48.04200
    ## 1138       Dominican Republic 1967    4049146  Americas 56.75100
    ## 1139                     Togo 1972    2056351    Africa 49.75900
    ## 1140              Philippines 1962   30325264      Asia 54.75700
    ## 1141            Cote d'Ivoire 2002   16252726    Africa 46.83200
    ## 1142                Sri Lanka 1982   15410151      Asia 68.75700
    ## 1143            Cote d'Ivoire 1992   12772596    Africa 52.04400
    ## 1144                 Mongolia 1977    1528000      Asia 55.49100
    ## 1145          Korea Dem. Rep. 2002   22215365      Asia 66.66200
    ## 1146                    Syria 1952    3661549      Asia 45.88300
    ## 1147               Madagascar 1962    5703324    Africa 40.84800
    ## 1148                  Morocco 1957   11406350    Africa 45.42300
    ## 1149               Madagascar 1967    6334556    Africa 42.88100
    ## 1150                    Sudan 1997   32160729    Africa 55.37300
    ## 1151                  Nigeria 1997  106207839    Africa 47.46400
    ## 1152          Korea Dem. Rep. 1962   10917494      Asia 56.65600
    ## 1153                  Nigeria 1992   93364244    Africa 47.47200
    ## 1154                    Sudan 1952    8504667    Africa 38.63500
    ## 1155                  Nigeria 2002  119901274    Africa 46.60800
    ## 1156                  Senegal 1967    3965841    Africa 43.56300
    ## 1157                  Albania 1952    1282697    Europe 55.23000
    ## 1158    Sao Tome and Principe 2007     199579    Africa 65.52800
    ## 1159                  Senegal 1972    4588696    Africa 45.81500
    ## 1160          Korea Dem. Rep. 2007   23301725      Asia 67.29700
    ## 1161               Madagascar 1957    5181679    Africa 38.86500
    ## 1162                   Zambia 1977    5216550    Africa 51.38600
    ## 1163               Mauritania 1972    1332786    Africa 48.43700
    ## 1164               Mauritania 2002    2828858    Africa 62.24700
    ## 1165                  Nigeria 1982   73039376    Africa 45.82600
    ## 1166          Korea Dem. Rep. 1957    9411381      Asia 54.08100
    ## 1167                  Lesotho 2007    2012649    Africa 42.59200
    ## 1168                  Senegal 1957    3054547    Africa 39.32900
    ## 1169                  Morocco 1962   13056604    Africa 47.92400
    ## 1170                  Senegal 1977    5260855    Africa 48.87900
    ## 1171              Philippines 1957   26072194      Asia 51.33400
    ## 1172                   Jordan 1952     607914      Asia 43.15800
    ## 1173            Cote d'Ivoire 2007   18013409    Africa 48.32800
    ## 1174       Dominican Republic 1957    2923186  Americas 49.82800
    ## 1175               Madagascar 1977    8007166    Africa 46.88100
    ## 1176               Korea Rep. 1962   26420307      Asia 55.29200
    ## 1177    Sao Tome and Principe 1972      76595    Africa 56.48000
    ## 1178                     Togo 1977    2308582    Africa 52.88700
    ## 1179                 Thailand 1972   39276153      Asia 60.40500
    ## 1180                  Senegal 2002   10870037    Africa 61.60000
    ## 1181                  Senegal 1982    6147783    Africa 52.37900
    ## 1182                Indonesia 1982  153343000      Asia 56.15900
    ## 1183    Sao Tome and Principe 1987     110812    Africa 61.72800
    ## 1184       West Bank and Gaza 1952    1030585      Asia 43.16000
    ## 1185                 Cameroon 1967    6335506    Africa 44.79900
    ## 1186                   Taiwan 1957   10164215      Asia 62.40000
    ## 1187                    Sudan 1987   24725960    Africa 51.74400
    ## 1188            Cote d'Ivoire 1957    3300000    Africa 42.46900
    ## 1189               Mauritania 1977    1456688    Africa 50.85200
    ## 1190                    Sudan 1992   28227588    Africa 53.55600
    ## 1191               Korea Rep. 1957   22611552      Asia 52.68100
    ## 1192               Mauritania 1997    2444741    Africa 60.43000
    ## 1193               Mauritania 1982    1622136    Africa 53.59900
    ## 1194                     Togo 1967    1735550    Africa 46.76900
    ## 1195                  Tunisia 1952    3647735    Africa 44.60000
    ## 1196             Sierra Leone 1982    3464522    Africa 38.44500
    ## 1197                    Kenya 2007   35610177    Africa 54.11000
    ## 1198                    Egypt 1957   25009741    Africa 44.44400
    ## 1199                    India 1997  959000000      Asia 61.76500
    ## 1200                    Haiti 1992    6326682  Americas 55.08900
    ## 1201                   Zambia 1962    3421000    Africa 46.02300
    ## 1202                    Haiti 1967    4318137  Americas 46.24300
    ## 1203                  Somalia 1977    4353666    Africa 41.97400
    ## 1204                  Senegal 1952    2755589    Africa 37.27800
    ## 1205                 Pakistan 1982   91462088      Asia 56.15800
    ## 1206               Madagascar 1952    4762912    Africa 36.68100
    ## 1207                  Senegal 1987    7171347    Africa 55.76900
    ## 1208                    Benin 2007    8078314    Africa 56.72800
    ## 1209    Sao Tome and Principe 1992     125911    Africa 62.74200
    ## 1210                 Mongolia 1972    1320500      Asia 53.75400
    ## 1211               Mauritania 1987    1841240    Africa 56.14500
    ## 1212               Mauritania 1967    1230542    Africa 46.28900
    ## 1213                    Egypt 1952   22223309    Africa 41.89300
    ## 1214                   Zambia 1982    6100407    Africa 51.82100
    ## 1215                  Comoros 1962     191689    Africa 44.46700
    ## 1216                 Cameroon 1962    5793633    Africa 42.64300
    ## 1217       Dominican Republic 1952    2491346  Americas 45.92800
    ## 1218                  Tunisia 1957    3950849    Africa 47.10000
    ## 1219                  Senegal 1997    9535314    Africa 60.18700
    ## 1220               Bangladesh 2007  150448339      Asia 64.06200
    ## 1221                     Chad 1962    3150417    Africa 41.71600
    ## 1222            Cote d'Ivoire 1952    2977019    Africa 40.47700
    ## 1223                  Vietnam 1997   76048996      Asia 70.67200
    ## 1224                  Nigeria 1987   81551520    Africa 46.88600
    ## 1225    Sao Tome and Principe 1967      70787    Africa 54.42500
    ## 1226                Indonesia 1977  136725000      Asia 52.70200
    ## 1227                    China 1987 1084035000      Asia 67.27400
    ## 1228                    Benin 2002    7026113    Africa 54.40600
    ## 1229                  Somalia 1962    3080153    Africa 36.98100
    ## 1230                  Senegal 1992    8307920    Africa 58.19600
    ## 1231                    Kenya 1987   21198082    Africa 59.33900
    ## 1232               Mauritania 1992    2119465    Africa 58.33300
    ## 1233                    Kenya 1997   28263827    Africa 54.40700
    ## 1234   Bosnia and Herzegovina 1957    3076000    Europe 58.45000
    ## 1235             Sierra Leone 1972    2879013    Africa 35.40000
    ## 1236    Sao Tome and Principe 2002     170372    Africa 64.33700
    ## 1237                Sri Lanka 1977   14116836      Asia 65.94900
    ## 1238             Sierra Leone 1977    3140897    Africa 36.78800
    ## 1239                    Kenya 1982   17661452    Africa 58.76600
    ## 1240                     Togo 1982    2644765    Africa 55.47100
    ## 1241                    Kenya 1992   25020539    Africa 59.28500
    ## 1242                    Haiti 1997    6913545  Americas 56.67100
    ## 1243    Sao Tome and Principe 1997     145608    Africa 63.30600
    ## 1244                    Ghana 2007   22873338    Africa 60.02200
    ## 1245                  Comoros 1987     395114    Africa 54.92600
    ## 1246                 Cameroon 1957    5359923    Africa 40.42800
    ## 1247                   Zambia 1957    3016000    Africa 44.07700
    ## 1248                     Chad 1957    2894855    Africa 39.88100
    ## 1249               Madagascar 1982    9171477    Africa 48.96900
    ## 1250                 Thailand 1967   34024249      Asia 58.28500
    ## 1251             Sierra Leone 1987    3868905    Africa 40.00600
    ## 1252                    Kenya 2002   31386842    Africa 50.99200
    ## 1253                  Somalia 1967    3428839    Africa 38.97700
    ## 1254                    Benin 1982    3641603    Africa 50.90400
    ## 1255                  Lesotho 2002    2046772    Africa 44.59300
    ## 1256              Philippines 1952   22438691      Asia 47.75200
    ## 1257                   Zambia 2007   11746035    Africa 42.38400
    ## 1258                    Haiti 2002    7607651  Americas 58.13700
    ## 1259                    Kenya 1977   14500404    Africa 56.15500
    ## 1260                  Comoros 1982     348643    Africa 52.93300
    ## 1261               Yemen Rep. 1972    7407075      Asia 39.84800
    ## 1262                  Somalia 1957    2780415    Africa 34.97700
    ## 1263                  Somalia 1972    3840161    Africa 40.97300
    ## 1264                  Comoros 1992     454429    Africa 57.93900
    ## 1265                Swaziland 1957     326741    Africa 43.42400
    ## 1266                    Benin 1997    6066080    Africa 54.77700
    ## 1267                 Mongolia 1967    1149500      Asia 51.25300
    ## 1268                    Benin 1987    4243788    Africa 52.33700
    ## 1269                    Kenya 1972   12044785    Africa 53.55900
    ## 1270             Burkina Faso 2007   14326203    Africa 52.29500
    ## 1271                 Botswana 1967     553541    Africa 53.29800
    ## 1272                Sri Lanka 1972   13016733      Asia 65.04200
    ## 1273                   Zambia 1987    7272406    Africa 50.82100
    ## 1274                  Comoros 1957     170928    Africa 42.46000
    ## 1275                   Zambia 1992    8381163    Africa 46.10000
    ## 1276                   Taiwan 1952    8550362      Asia 58.50000
    ## 1277             Sierra Leone 1967    2662190    Africa 34.11300
    ## 1278                     Togo 1987    3154264    Africa 56.94100
    ## 1279                    Haiti 2007    8502814  Americas 60.91600
    ## 1280                     Chad 1967    3495967    Africa 43.60100
    ## 1281 Central African Republic 1962    1523478    Africa 39.47500
    ## 1282                    Benin 1992    4981671    Africa 53.91900
    ## 1283 Central African Republic 1957    1392284    Africa 37.46400
    ## 1284                    Ghana 1962    7355248    Africa 46.45200
    ## 1285                  Lesotho 1997    1982823    Africa 55.55800
    ## 1286                     Chad 1952    2682462    Africa 38.09200
    ## 1287                    Ghana 1972    9354120    Africa 49.87500
    ## 1288                  Somalia 1982    5828892    Africa 42.95500
    ## 1289                 Pakistan 1977   78152686      Asia 54.04300
    ## 1290                  Comoros 1997     527982    Africa 60.66000
    ## 1291                 Cameroon 1952    5009067    Africa 38.52300
    ## 1292                  Comoros 1977     304739    Africa 50.93900
    ## 1293                    India 1992  872000000      Asia 60.22300
    ## 1294                     Chad 2002    8835739    Africa 50.52500
    ## 1295               Madagascar 1987   10568642    Africa 49.35000
    ## 1296                  Nigeria 1962   41871351    Africa 39.36000
    ## 1297                Swaziland 1952     290243    Africa 41.40700
    ## 1298                   Zambia 1952    2672000    Africa 42.03800
    ## 1299               Bangladesh 2002  135656790      Asia 62.01300
    ## 1300 Central African Republic 1967    1733638    Africa 41.47800
    ## 1301                  Somalia 1952    2526994    Africa 32.97800
    ## 1302                Sri Lanka 1967   11737396      Asia 64.26600
    ## 1303                     Chad 1977    4388260    Africa 47.38300
    ## 1304        Equatorial Guinea 1992     387838    Africa 47.54500
    ## 1305                    Ghana 1967    8490213    Africa 48.07200
    ## 1306             Sierra Leone 1962    2467895    Africa 32.76700
    ## 1307                    Ghana 2002   20550751    Africa 58.45300
    ## 1308                Indonesia 1972  121282000      Asia 49.20300
    ## 1309 Central African Republic 1977    2167533    Africa 46.77500
    ## 1310                 Tanzania 2007   38139640    Africa 52.51700
    ## 1311                     Chad 1972    3899068    Africa 45.56900
    ## 1312                  Comoros 1952     153936    Africa 40.71500
    ## 1313                  Nigeria 1957   37173340    Africa 37.80200
    ## 1314                  Somalia 1987    6921858    Africa 44.50100
    ## 1315                    Nepal 2007   28901790      Asia 63.78500
    ## 1316          Korea Dem. Rep. 1952    8865488      Asia 50.05600
    ## 1317                    Benin 1972    2761407    Africa 47.01400
    ## 1318                Sri Lanka 1952    7982342      Asia 57.59300
    ## 1319                  Nigeria 1952   33119096    Africa 36.32400
    ## 1320                  Comoros 2002     614382    Africa 62.97400
    ## 1321                Sri Lanka 1962   10421936      Asia 62.19200
    ## 1322                Sri Lanka 1957    9128546      Asia 61.45600
    ## 1323                   Zambia 2002   10595811    Africa 39.19300
    ## 1324    Sao Tome and Principe 1962      65345    Africa 51.89300
    ## 1325                   Zambia 1997    9417789    Africa 40.23800
    ## 1326 Central African Republic 1952    1291695    Africa 35.46300
    ## 1327 Central African Republic 1972    1927260    Africa 43.45700
    ## 1328             Sierra Leone 1992    4260884    Africa 38.33300
    ## 1329                     Togo 1962    1528098    Africa 43.92200
    ## 1330                    Benin 1952    1738315    Africa 38.22300
    ## 1331                     Chad 1992    6429417    Africa 51.72400
    ## 1332                    Nepal 2002   25873917      Asia 61.34000
    ## 1333                    Kenya 1967   10191512    Africa 50.65400
    ## 1334                   Uganda 2007   29170398    Africa 51.54200
    ## 1335                 Mongolia 1962    1010280      Asia 48.25100
    ## 1336               Mauritania 1962    1146757    Africa 44.24800
    ## 1337                    Niger 1967    4534062    Africa 40.11800
    ## 1338                 Pakistan 1972   69325921      Asia 51.92900
    ## 1339               Madagascar 2007   19167654    Africa 59.44300
    ## 1340                    Ghana 1957    6391288    Africa 44.77900
    ## 1341                     Mali 2007   12031795    Africa 54.46700
    ## 1342               Madagascar 1992   12210395    Africa 52.21400
    ## 1343             Burkina Faso 2002   12251209    Africa 50.65000
    ## 1344                    Benin 1967    2427334    Africa 44.88500
    ## 1345                     Togo 1992    3747553    Africa 58.06100
    ## 1346               Korea Rep. 1952   20947571      Asia 47.45300
    ## 1347                    Benin 1977    3168267    Africa 49.19000
    ## 1348                  Nigeria 1967   47287752    Africa 41.04000
    ## 1349                    Nepal 1997   23001113      Asia 59.42600
    ## 1350                    Ghana 1997   18418288    Africa 58.55600
    ## 1351                     Chad 1997    7562011    Africa 51.57300
    ## 1352             Sierra Leone 1957    2295678    Africa 31.57000
    ## 1353                 Thailand 1962   29263397      Asia 56.06100
    ## 1354                    Niger 1962    4076008    Africa 39.48700
    ## 1355                    Ghana 1977   10538093    Africa 51.75600
    ## 1356                  Vietnam 1992   69940728      Asia 67.66200
    ## 1357               Madagascar 1997   14165114    Africa 54.97800
    ## 1358                  Comoros 2007     710960    Africa 65.15200
    ## 1359                 Botswana 1962     512764    Africa 51.52000
    ## 1360                     Togo 1997    4320890    Africa 58.39000
    ## 1361              Afghanistan 1982   12881816      Asia 39.85400
    ## 1362                  Lesotho 1992    1803195    Africa 59.68500
    ## 1363                    India 1987  788000000      Asia 58.55300
    ## 1364              Afghanistan 2007   31889923      Asia 43.82800
    ## 1365   Bosnia and Herzegovina 1952    2791000    Europe 53.82000
    ## 1366               Bangladesh 1997  123315288      Asia 59.41200
    ## 1367        Equatorial Guinea 1987     341244    Africa 45.66400
    ## 1368                 Tanzania 1977   17129565    Africa 49.91900
    ## 1369                    China 1982 1000281000      Asia 65.52500
    ## 1370                    Benin 1957    1925173    Africa 40.35800
    ## 1371        Equatorial Guinea 1977     192675    Africa 42.02400
    ## 1372 Central African Republic 1982    2476971    Africa 48.29500
    ## 1373                    Niger 1972    5060262    Africa 40.54600
    ## 1374                     Chad 1987    5498955    Africa 51.05100
    ## 1375                     Mali 2002   10580176    Africa 51.81800
    ## 1376                   Uganda 1972   10190285    Africa 51.01600
    ## 1377                    Benin 1962    2151895    Africa 42.61800
    ## 1378             Burkina Faso 1997   10352843    Africa 50.32400
    ## 1379                   Guinea 2002    8807818    Africa 53.67600
    ## 1380                    Kenya 1957    7454779    Africa 44.68600
    ## 1381                  Myanmar 2007   47761980      Asia 62.06900
    ## 1382                   Guinea 2007    9947814    Africa 56.00700
    ## 1383                 Pakistan 1967   60641899      Asia 49.80000
    ## 1384             Burkina Faso 1992    8878303    Africa 50.26000
    ## 1385                  Somalia 1997    6633514    Africa 43.79500
    ## 1386        Equatorial Guinea 1982     285483    Africa 43.66200
    ## 1387                   Uganda 2002   24739869    Africa 47.81300
    ## 1388                  Somalia 1992    6099799    Africa 39.65800
    ## 1389                  Somalia 2007    9118773    Africa 48.15900
    ## 1390                     Togo 1957    1357445    Africa 41.20800
    ## 1391                    Ghana 1992   16278738    Africa 57.50100
    ## 1392                 Botswana 1957     474639    Africa 49.61800
    ## 1393                 Tanzania 1972   14706593    Africa 47.62000
    ## 1394        Equatorial Guinea 1967     259864    Africa 38.98700
    ## 1395                  Eritrea 1997    4058319    Africa 53.37800
    ## 1396                 Mongolia 1957     882134      Asia 45.24800
    ## 1397             Burkina Faso 1987    7586551    Africa 49.55700
    ## 1398                    Ghana 1952    5581001    Africa 43.14900
    ## 1399                    Niger 1982    6437188    Africa 42.59800
    ## 1400                   Uganda 1967    8900294    Africa 48.05100
    ## 1401          Congo Dem. Rep. 1957   15577932    Africa 40.65200
    ## 1402          Congo Dem. Rep. 1972   23007669    Africa 45.98900
    ## 1403                 Tanzania 2002   34593779    Africa 49.65100
    ## 1404                    Nepal 1992   20326209      Asia 55.72700
    ## 1405                    Kenya 1962    8678557    Africa 47.94900
    ## 1406          Congo Dem. Rep. 1962   17486434    Africa 42.12200
    ## 1407                 Cambodia 2002   12926707      Asia 56.75200
    ## 1408               Madagascar 2002   16473477    Africa 57.28600
    ## 1409                     Togo 2002    4977378    Africa 57.56100
    ## 1410                   Gambia 1977     608274    Africa 41.84200
    ## 1411                     Togo 2007    5701579    Africa 58.42000
    ## 1412                  Somalia 2002    7753310    Africa 45.93600
    ## 1413                   Rwanda 1982    5507565    Africa 46.21800
    ## 1414             Sierra Leone 1952    2143249    Africa 30.33100
    ## 1415    Sao Tome and Principe 1952      60011    Africa 46.47100
    ## 1416                    Ghana 1982   11400338    Africa 53.74400
    ## 1417                   Guinea 1977    4227026    Africa 40.76200
    ## 1418                 Tanzania 1982   19844382    Africa 50.60800
    ## 1419                   Guinea 1997    8048834    Africa 51.45500
    ## 1420                   Rwanda 2007    8860588    Africa 46.24200
    ## 1421             Sierra Leone 2007    6144562    Africa 42.56800
    ## 1422               Yemen Rep. 1967    6740785      Asia 36.98400
    ## 1423          Congo Dem. Rep. 1967   19941073    Africa 44.05600
    ## 1424    Sao Tome and Principe 1957      61325    Africa 48.94500
    ## 1425                     Togo 1952    1219113    Africa 38.59600
    ## 1426                Indonesia 1957   90124000      Asia 39.91800
    ## 1427                   Guinea 1982    4710497    Africa 42.89100
    ## 1428                    India 1982  708000000      Asia 56.59600
    ## 1429             Burkina Faso 1972    5433886    Africa 43.59100
    ## 1430                    Kenya 1952    6464046    Africa 42.27000
    ## 1431              Afghanistan 1962   10267083      Asia 31.99700
    ## 1432              Afghanistan 1987   13867957      Asia 40.82200
    ## 1433                 Botswana 1952     442308    Africa 47.62200
    ## 1434                Indonesia 1962   99028000      Asia 42.51800
    ## 1435                 Tanzania 1967   12607312    Africa 45.75700
    ## 1436                   Rwanda 1987    6349365    Africa 44.02000
    ## 1437                    Ghana 1987   14168101    Africa 55.72900
    ## 1438               Mauritania 1957    1076852    Africa 42.33800
    ## 1439 Central African Republic 1987    2840009    Africa 50.48500
    ## 1440                   Uganda 1977   11457758    Africa 50.35000
    ## 1441            Guinea-Bissau 1982     825987    Africa 39.32700
    ## 1442               Bangladesh 1992  113704579      Asia 56.01800
    ## 1443              Afghanistan 1967   11537966      Asia 34.02000
    ## 1444                   Gambia 1982     715523    Africa 45.58000
    ## 1445                    Niger 1957    3692184    Africa 38.59800
    ## 1446                 Tanzania 1987   23040630    Africa 51.53500
    ## 1447                 Tanzania 1992   26605473    Africa 50.44000
    ## 1448               Yemen Rep. 1962    6120081      Asia 35.18000
    ## 1449               Mozambique 2007   19951656    Africa 42.08200
    ## 1450              Afghanistan 1957    9240934      Asia 30.33200
    ## 1451                  Vietnam 1987   62826491      Asia 62.82000
    ## 1452            Guinea-Bissau 1972     625361    Africa 36.48600
    ## 1453                   Uganda 1997   21210254    Africa 44.57800
    ## 1454                    India 1977  634000000      Asia 54.20800
    ## 1455                    Niger 1977    5682086    Africa 41.29100
    ## 1456             Burkina Faso 1982    6634596    Africa 48.12200
    ## 1457                   Guinea 1987    5650262    Africa 45.55200
    ## 1458               Yemen Rep. 1957    5498090      Asia 33.97000
    ## 1459                 Pakistan 1962   53100671      Asia 47.67000
    ## 1460                  Liberia 1972    1482628    Africa 42.61400
    ## 1461                 Zimbabwe 1972    5861135    Africa 55.63500
    ## 1462                     Chad 1982    4875118    Africa 49.51700
    ## 1463                  Lesotho 1982    1411807    Africa 55.07800
    ## 1464            Guinea-Bissau 1997    1193708    Africa 44.87300
    ## 1465          Congo Dem. Rep. 1977   26480870    Africa 47.80400
    ## 1466             Burkina Faso 1967    5127935    Africa 40.69700
    ## 1467                   Guinea 1992    6990574    Africa 48.57600
    ## 1468                 Thailand 1957   25041917      Asia 53.63000
    ## 1469                 Zimbabwe 1997   11404948    Africa 46.80900
    ## 1470                     Mali 1997    9384984    Africa 49.90300
    ## 1471                 Tanzania 1997   30686889    Africa 48.46600
    ## 1472                 Zimbabwe 1982    7636524    Africa 60.36300
    ## 1473                 Mongolia 1952     800663      Asia 42.24400
    ## 1474              Afghanistan 1977   14880372      Asia 38.43800
    ## 1475                   Rwanda 2002    7852401    Africa 43.41300
    ## 1476               Yemen Rep. 1952    4963829      Asia 32.54800
    ## 1477          Congo Dem. Rep. 1952   14100005    Africa 39.14300
    ## 1478              Afghanistan 1952    8425333      Asia 28.80100
    ## 1479                    Nepal 1987   17917180      Asia 52.53700
    ## 1480                   Uganda 1957    6675501    Africa 42.57100
    ## 1481                  Lesotho 1987    1599200    Africa 57.18000
    ## 1482                  Vietnam 1962   33796140      Asia 45.36300
    ## 1483                   Uganda 1962    7688797    Africa 45.34400
    ## 1484                  Eritrea 2002    4414865    Africa 55.24000
    ## 1485            Guinea-Bissau 1977     745228    Africa 37.46500
    ## 1486                Indonesia 1967  109343000      Asia 45.96400
    ## 1487                    Niger 1952    3379468    Africa 37.44400
    ## 1488                   Malawi 2007   13327079    Africa 48.30300
    ## 1489                 Thailand 1952   21289402      Asia 50.84800
    ## 1490                   Gambia 1972     517101    Africa 38.30800
    ## 1491                   Gambia 2007    1688359    Africa 59.44800
    ## 1492               Bangladesh 1987  103764241      Asia 52.81900
    ## 1493                Indonesia 1952   82052000      Asia 37.46800
    ## 1494 Central African Republic 1992    3265124    Africa 49.39600
    ## 1495                 Pakistan 1957   46679944      Asia 45.55700
    ## 1496            Guinea-Bissau 1992    1050938    Africa 43.26600
    ## 1497                  Lesotho 1977    1251524    Africa 52.20800
    ## 1498             Burkina Faso 1977    5889574    Africa 46.13700
    ## 1499               Mauritania 1952    1022556    Africa 40.54300
    ## 1500                   Guinea 1972    3811387    Africa 38.84200
    ## 1501                    China 1977  943455000      Asia 63.96736
    ## 1502 Central African Republic 1997    3696513    Africa 46.06600
    ## 1503              Afghanistan 1972   13079460      Asia 36.08800
    ## 1504                     Mali 1992    8416215    Africa 48.38800
    ## 1505 Central African Republic 2002    4048013    Africa 43.30800
    ## 1506                   Rwanda 1992    7290203    Africa 23.59900
    ## 1507            Guinea-Bissau 1987     927524    Africa 41.24500
    ## 1508                   Gambia 1967     439593    Africa 35.85700
    ## 1509                   Uganda 1952    5824797    Africa 39.97800
    ## 1510                 Cambodia 1997   11782962      Asia 56.53400
    ## 1511              Afghanistan 2002   25268405      Asia 42.12900
    ## 1512               Mozambique 1972    9809596    Africa 40.32800
    ## 1513                    India 1972  567000000      Asia 50.65100
    ## 1514             Burkina Faso 1962    4919632    Africa 37.81400
    ## 1515                 Tanzania 1962   10863958    Africa 44.24600
    ## 1516               Bangladesh 1967   62821884      Asia 43.45300
    ## 1517                    Nepal 1982   15796314      Asia 49.59400
    ## 1518                 Tanzania 1952    8322925    Africa 41.21500
    ## 1519            Guinea-Bissau 1967     601287    Africa 35.49200
    ## 1520                  Liberia 1967    1279406    Africa 41.53600
    ## 1521                  Vietnam 1977   50533506      Asia 55.76400
    ## 1522                   Guinea 1967    3451418    Africa 37.19700
    ## 1523                  Vietnam 1982   56142181      Asia 58.81600
    ## 1524                 Zimbabwe 1987    9216418    Africa 62.35100
    ## 1525 Central African Republic 2007    4369038    Africa 44.74100
    ## 1526                    India 1967  506000000      Asia 47.19300
    ## 1527                  Vietnam 1972   44655014      Asia 50.25400
    ## 1528             Sierra Leone 2002    5359092    Africa 41.01200
    ## 1529                 Tanzania 1957    9452826    Africa 42.97400
    ## 1530                    Nepal 1977   13933198      Asia 46.74800
    ## 1531                 Zimbabwe 1992   10704340    Africa 60.37700
    ## 1532                   Malawi 1997   10419991    Africa 47.49500
    ## 1533                 Ethiopia 2007   76511887    Africa 52.94700
    ## 1534                     Mali 1977    6491649    Africa 41.71400
    ## 1535                   Guinea 1962    3140003    Africa 35.75300
    ## 1536               Bangladesh 1962   56839289      Asia 41.21600
    ## 1537                 Zimbabwe 1977    6642107    Africa 57.67400
    ## 1538                 Pakistan 1952   41346560      Asia 43.43600
    ## 1539               Bangladesh 1952   46886859      Asia 37.48400
    ## 1540                     Mali 1987    7634008    Africa 46.36400
    ## 1541                 Cambodia 1987    8371791      Asia 53.91400
    ## 1542                 Cambodia 1992   10150094      Asia 55.80300
    ## 1543                   Uganda 1982   12939400    Africa 49.84900
    ## 1544               Bangladesh 1982   93074406      Asia 50.00900
    ## 1545                    China 1972  862030000      Asia 63.11888
    ## 1546                    Nepal 1967   11261690      Asia 41.47200
    ## 1547                  Vietnam 1957   28998543      Asia 42.88700
    ## 1548                    Nepal 1972   12412593      Asia 43.97100
    ## 1549          Congo Dem. Rep. 1982   30646495    Africa 47.78400
    ## 1550          Congo Dem. Rep. 1987   35481645    Africa 47.41200
    ## 1551        Equatorial Guinea 1972     277603    Africa 40.51600
    ## 1552                 Zimbabwe 2002   11926563    Africa 39.98900
    ## 1553                   Rwanda 1977    4657072    Africa 45.00000
    ## 1554                    Niger 1987    7332638    Africa 44.55500
    ## 1555                   Gambia 1992    1025384    Africa 52.64400
    ## 1556                   Malawi 2002   11824495    Africa 45.00900
    ## 1557                   Malawi 1977    5637246    Africa 43.76700
    ## 1558               Bangladesh 1957   51365468      Asia 39.34800
    ## 1559                   Gambia 2002    1457766    Africa 58.04100
    ## 1560               Bangladesh 1977   80428306      Asia 46.92300
    ## 1561                    India 1962  454000000      Asia 43.60500
    ## 1562                   Gambia 1997    1235767    Africa 55.86100
    ## 1563                    Nepal 1962   10332057      Asia 39.39300
    ## 1564              Afghanistan 1992   16317921      Asia 41.67400
    ## 1565                   Uganda 1992   18252190    Africa 48.82500
    ## 1566                  Eritrea 2007    4906585    Africa 58.04000
    ## 1567                  Liberia 1977    1703617    Africa 43.76400
    ## 1568                  Vietnam 1967   39463910      Asia 47.83800
    ## 1569                  Liberia 1992    1912974    Africa 40.80200
    ## 1570                   Malawi 1987    7824747    Africa 47.45700
    ## 1571              Afghanistan 1997   22227415      Asia 41.76300
    ## 1572                  Liberia 1962    1112796    Africa 40.50200
    ## 1573               Mozambique 2002   18473780    Africa 44.02600
    ## 1574                   Malawi 1982    6502825    Africa 45.64200
    ## 1575                  Burundi 1992    5809236    Africa 44.73600
    ## 1576               Bangladesh 1972   70759295      Asia 45.25200
    ## 1577                 Cambodia 1982    7272485      Asia 50.95700
    ## 1578                  Burundi 1987    5126023    Africa 48.21100
    ## 1579                  Liberia 1957     975950    Africa 39.48600
    ## 1580                    Niger 2007   12894865    Africa 56.86700
    ## 1581                     Mali 1982    6998256    Africa 43.91600
    ## 1582                   Uganda 1987   15283050    Africa 51.50900
    ## 1583             Burkina Faso 1957    4713416    Africa 34.90600
    ## 1584                    China 1967  754550000      Asia 58.38112
    ## 1585                   Gambia 1987     848406    Africa 49.26500
    ## 1586                  Myanmar 2002   45598081      Asia 59.90800
    ## 1587                  Liberia 1997    2200725    Africa 42.22100
    ## 1588                  Vietnam 1952   26246839      Asia 40.41200
    ## 1589                    Niger 2002   11140655    Africa 54.49600
    ## 1590                   Gambia 1962     374020    Africa 33.89600
    ## 1591                    Nepal 1957    9682338      Asia 37.68600
    ## 1592                   Rwanda 1962    3051242    Africa 43.00000
    ## 1593                   Rwanda 1972    3992121    Africa 44.60000
    ## 1594                    India 1957  409000000      Asia 40.24900
    ## 1595                   Rwanda 1997    7212583    Africa 36.08700
    ## 1596                   Malawi 1972    4730997    Africa 41.76600
    ## 1597                  Eritrea 1992    3668440    Africa 49.99100
    ## 1598        Equatorial Guinea 1962     249220    Africa 37.48500
    ## 1599                     Mali 1972    5828158    Africa 39.97700
    ## 1600                    Niger 1992    8392818    Africa 47.39100
    ## 1601                    Niger 1997    9666252    Africa 51.31300
    ## 1602            Guinea-Bissau 2007    1472041    Africa 46.38800
    ## 1603                 Ethiopia 1982   38111756    Africa 44.91600
    ## 1604                   Guinea 1957    2876726    Africa 34.55800
    ## 1605                    China 1957  637408000      Asia 50.54896
    ## 1606            Guinea-Bissau 2002    1332459    Africa 45.50400
    ## 1607                  Liberia 1952     863308    Africa 38.48000
    ## 1608             Sierra Leone 1997    4578212    Africa 39.89700
    ## 1609                 Ethiopia 1987   42999530    Africa 46.68400
    ## 1610                  Liberia 1982    1956875    Africa 44.85200
    ## 1611                 Zimbabwe 1967    4995432    Africa 53.99500
    ## 1612               Mozambique 1967    8680909    Africa 38.11300
    ## 1613                 Ethiopia 1972   30770372    Africa 43.51500
    ## 1614                   Malawi 1992   10014249    Africa 49.42000
    ## 1615                  Burundi 1982    4580410    Africa 47.47100
    ## 1616                 Ethiopia 1977   34617799    Africa 44.51000
    ## 1617               Mozambique 1962    7788944    Africa 36.16100
    ## 1618                  Burundi 1977    3834415    Africa 45.91000
    ## 1619                    India 1952  372000000      Asia 37.37300
    ## 1620                    Nepal 1952    9182536      Asia 36.15700
    ## 1621                     Mali 1967    5212416    Africa 38.48700
    ## 1622             Burkina Faso 1952    4469979    Africa 31.97500
    ## 1623                   Rwanda 1957    2822082    Africa 41.50000
    ## 1624                  Liberia 2002    2814651    Africa 43.75300
    ## 1625                 Ethiopia 2002   67946797    Africa 50.72500
    ## 1626                 Zimbabwe 1962    4277736    Africa 52.35800
    ## 1627                 Cambodia 1977    6978607      Asia 31.22000
    ## 1628                  Eritrea 1982    2637297    Africa 43.89000
    ## 1629                 Cambodia 1967    6960067      Asia 45.41500
    ## 1630            Guinea-Bissau 1962     627820    Africa 34.48800
    ## 1631                  Eritrea 1987    2915959    Africa 46.45300
    ## 1632                   Gambia 1957     323150    Africa 32.06500
    ## 1633                 Zimbabwe 1957    3646340    Africa 50.46900
    ## 1634                 Ethiopia 1967   27860297    Africa 42.11500
    ## 1635                 Ethiopia 1997   59861301    Africa 49.40200
    ## 1636                  Eritrea 1972    2260187    Africa 44.14200
    ## 1637                   Rwanda 1967    3451079    Africa 44.10000
    ## 1638                   Guinea 1952    2664249    Africa 33.60900
    ## 1639                  Liberia 1987    2269414    Africa 46.02700
    ## 1640                  Eritrea 1977    2512642    Africa 44.53500
    ## 1641               Mozambique 1977   11127868    Africa 42.49500
    ## 1642                  Lesotho 1967     996380    Africa 48.49200
    ## 1643                 Cambodia 1962    6083619      Asia 43.41500
    ## 1644                  Lesotho 1972    1116779    Africa 49.76700
    ## 1645                     Mali 1962    4690372    Africa 36.93600
    ## 1646               Mozambique 1957    7038035    Africa 33.77900
    ## 1647                   Malawi 1967    4147252    Africa 39.48700
    ## 1648                   Rwanda 1952    2534927    Africa 40.00000
    ## 1649                     Mali 1957    4241884    Africa 35.30700
    ## 1650                    China 1962  665770000      Asia 44.50136
    ## 1651                   Gambia 1952     284320    Africa 30.00000
    ## 1652               Mozambique 1997   16603334    Africa 46.34400
    ## 1653                 Zimbabwe 2007   12311143    Africa 43.48700
    ## 1654                  Eritrea 1967    1820319    Africa 42.18900
    ## 1655               Mozambique 1952    6446316    Africa 31.28600
    ## 1656                  Burundi 1972    3529983    Africa 44.05700
    ## 1657                  Burundi 1997    6121610    Africa 45.32600
    ## 1658               Mozambique 1982   12587223    Africa 42.79500
    ## 1659          Congo Dem. Rep. 1992   41672143    Africa 45.54800
    ## 1660                     Mali 1952    3838168    Africa 33.68500
    ## 1661                  Burundi 2002    7021078    Africa 47.36000
    ## 1662                 Cambodia 1957    5322536      Asia 41.36600
    ## 1663            Guinea-Bissau 1957     601095    Africa 33.48900
    ## 1664                  Burundi 2007    8390505    Africa 49.58000
    ## 1665                   Malawi 1962    3628608    Africa 38.41000
    ## 1666        Equatorial Guinea 1957     232922    Africa 35.98300
    ## 1667                  Myanmar 1982   34680442      Asia 58.05600
    ## 1668                 Cambodia 1972    7450606      Asia 40.31700
    ## 1669                 Ethiopia 1992   52088559    Africa 48.09100
    ## 1670                 Ethiopia 1962   25145372    Africa 40.05900
    ## 1671                   Malawi 1957    3221238    Africa 37.20700
    ## 1672                  Myanmar 1997   43247867      Asia 60.32800
    ## 1673                  Liberia 2007    3193942    Africa 45.67800
    ## 1674                  Burundi 1967    3330989    Africa 43.54800
    ## 1675                  Lesotho 1962     893143    Africa 47.74700
    ## 1676               Mozambique 1992   13160731    Africa 44.28400
    ## 1677                 Zimbabwe 1952    3080907    Africa 48.45100
    ## 1678                    China 1952  556263528      Asia 44.00000
    ## 1679               Mozambique 1987   12891952    Africa 42.86100
    ## 1680                  Myanmar 1962   23634436      Asia 45.10800
    ## 1681                  Myanmar 1987   38028578      Asia 58.33900
    ## 1682                  Eritrea 1962    1666618    Africa 40.15800
    ## 1683                  Burundi 1957    2667518    Africa 40.53300
    ## 1684                 Ethiopia 1957   22815614    Africa 36.66700
    ## 1685        Equatorial Guinea 1952     216964    Africa 34.48200
    ## 1686                  Myanmar 1977   31528087      Asia 56.05900
    ## 1687                   Malawi 1952    2917802    Africa 36.25600
    ## 1688                 Cambodia 1952    4693836      Asia 39.41700
    ## 1689                 Ethiopia 1952   20860941    Africa 34.07800
    ## 1690                  Myanmar 1972   28466390      Asia 53.07000
    ## 1691                  Burundi 1962    2961915    Africa 42.04500
    ## 1692                  Myanmar 1957   21731844      Asia 41.90500
    ## 1693                  Myanmar 1967   25870271      Asia 49.37900
    ## 1694                  Myanmar 1992   40546538      Asia 59.32000
    ## 1695                  Eritrea 1957    1542611    Africa 38.04700
    ## 1696                  Burundi 1952    2445618    Africa 39.03100
    ## 1697                  Lesotho 1957     813338    Africa 45.04700
    ## 1698                  Myanmar 1952   20092996      Asia 36.31900
    ## 1699                  Eritrea 1952    1438760    Africa 35.92800
    ## 1700          Congo Dem. Rep. 1997   47798986    Africa 42.58700
    ## 1701            Guinea-Bissau 1952     580653    Africa 32.50000
    ## 1702                  Lesotho 1952     748747    Africa 42.13800
    ## 1703          Congo Dem. Rep. 2007   64606759    Africa 46.46200
    ## 1704          Congo Dem. Rep. 2002   55379852    Africa 44.96600
    ##        gdpPercap
    ## 1    113523.1329
    ## 2    109347.8670
    ## 3    108382.3529
    ## 4     95458.1118
    ## 5     80894.8833
    ## 6     59265.4771
    ## 7     49357.1902
    ## 8     47306.9898
    ## 9     47143.1796
    ## 10    44683.9753
    ## 11    42951.6531
    ## 12    41283.1643
    ## 13    40675.9964
    ## 14    40300.6200
    ## 15    39724.9787
    ## 16    39097.0995
    ## 17    37506.4191
    ## 18    36797.9333
    ## 19    36319.2350
    ## 20    36180.7892
    ## 21    36126.4927
    ## 22    36023.1054
    ## 23    35767.4330
    ## 24    35278.4187
    ## 25    35110.1057
    ## 26    34932.9196
    ## 27    34480.9577
    ## 28    34435.3674
    ## 29    34167.7626
    ## 30    34077.0494
    ## 31    33965.6611
    ## 32    33859.7484
    ## 33    33724.7578
    ## 34    33693.1753
    ## 35    33692.6051
    ## 36    33519.4766
    ## 37    33328.9651
    ## 38    33207.0844
    ## 39    33203.2613
    ## 40    32417.6077
    ## 41    32170.3744
    ## 42    32166.5001
    ## 43    32135.3230
    ## 44    32003.9322
    ## 45    31871.5303
    ## 46    31656.0681
    ## 47    31540.9748
    ## 48    31354.0357
    ## 49    31163.2020
    ## 50    30687.7547
    ## 51    30485.8838
    ## 52    30470.0167
    ## 53    30281.7046
    ## 54    30246.1306
    ## 55    30209.0152
    ## 56    30035.8020
    ## 57    29884.3504
    ## 58    29804.3457
    ## 59    29796.0483
    ## 60    29478.9992
    ## 61    29341.6309
    ## 62    29095.9207
    ## 63    28954.9259
    ## 64    28926.0323
    ## 65    28821.0637
    ## 66    28816.5850
    ## 67    28718.2768
    ## 68    28604.5919
    ## 69    28569.7197
    ## 70    28397.7151
    ## 71    28377.6322
    ## 72    28204.5906
    ## 73    28118.4300
    ## 74    28061.0997
    ## 75    27968.0982
    ## 76    27788.8842
    ## 77    27561.1966
    ## 78    27538.4119
    ## 79    27195.1130
    ## 80    27042.0187
    ## 81    26997.9366
    ## 82    26982.2905
    ## 83    26923.2063
    ## 84    26824.8951
    ## 85    26790.9496
    ## 86    26626.5150
    ## 87    26505.3032
    ## 88    26406.7399
    ## 89    26342.8843
    ## 90    26298.6353
    ## 91    26074.5314
    ## 92    25889.7849
    ## 93    25768.2576
    ## 94    25575.5707
    ## 95    25523.2771
    ## 96    25266.5950
    ## 97    25185.0091
    ## 98    25144.3920
    ## 99    25116.1758
    ## 100   25009.5591
    ## 101   24841.6178
    ## 102   24837.4287
    ## 103   24835.4717
    ## 104   24769.8912
    ## 105   24757.6030
    ## 106   24703.7961
    ## 107   24675.0245
    ## 108   24639.1857
    ## 109   24521.9471
    ## 110   24072.6321
    ## 111   23880.0168
    ## 112   23723.9502
    ## 113   23687.8261
    ## 114   23651.3236
    ## 115   23586.9293
    ## 116   23424.7668
    ## 117   23403.5593
    ## 118   23348.1397
    ## 119   23311.3494
    ## 120   23269.6075
    ## 121   23235.4233
    ## 122   23189.8014
    ## 123   22966.1443
    ## 124   22898.7921
    ## 125   22833.3085
    ## 126   22705.0925
    ## 127   22525.5631
    ## 128   22514.2548
    ## 129   22375.9419
    ## 130   22316.1929
    ## 131   22090.8831
    ## 132   22066.4421
    ## 133   22031.5327
    ## 134   22013.6449
    ## 135   21951.2118
    ## 136   21905.5951
    ## 137   21888.8890
    ## 138   21806.0359
    ## 139   21745.5733
    ## 140   21688.0405
    ## 141   21664.7877
    ## 142   21654.8319
    ## 143   21597.0836
    ## 144   21399.4605
    ## 145   21209.0592
    ## 146   21198.2614
    ## 147   21141.0122
    ## 148   21050.4138
    ## 149   21011.4972
    ## 150   20979.8459
    ## 151   20896.6092
    ## 152   20667.3812
    ## 153   20660.0194
    ## 154   20647.1650
    ## 155   20586.6902
    ## 156   20512.9212
    ## 157   20509.6478
    ## 158   20445.2990
    ## 159   20431.0927
    ## 160   20422.9015
    ## 161   20293.8975
    ## 162   20292.0168
    ## 163   20206.8210
    ## 164   20038.4727
    ## 165   19970.9079
    ## 166   19774.8369
    ## 167   19749.4223
    ## 168   19702.0558
    ## 169   19654.9625
    ## 170   19530.3656
    ## 171   19477.0093
    ## 172   19384.1057
    ## 173   19340.1020
    ## 174   19328.7090
    ## 175   19233.9882
    ## 176   19211.1473
    ## 177   19207.2348
    ## 178   19117.9745
    ## 179   19035.5792
    ## 180   19014.5412
    ## 181   19007.1913
    ## 182   18970.5709
    ## 183   18965.0555
    ## 184   18866.2072
    ## 185   18861.5308
    ## 186   18855.7252
    ## 187   18855.6062
    ## 188   18794.7457
    ## 189   18772.7517
    ## 190   18747.6981
    ## 191   18678.5349
    ## 192   18678.3144
    ## 193   18616.7069
    ## 194   18603.0645
    ## 195   18533.1576
    ## 196   18524.0241
    ## 197   18363.3249
    ## 198   18334.1975
    ## 199   18292.6351
    ## 200   18268.6584
    ## 201   18232.4245
    ## 202   18115.2231
    ## 203   18051.5225
    ## 204   18016.1803
    ## 205   18008.9444
    ## 206   18008.5092
    ## 207   17909.4897
    ## 208   17866.7218
    ## 209   17832.0246
    ## 210   17641.0316
    ## 211   17632.4104
    ## 212   17596.2102
    ## 213   17558.8155
    ## 214   17541.4963
    ## 215   17428.7485
    ## 216   17364.2754
    ## 217   17161.1073
    ## 218   17122.4799
    ## 219   16999.4333
    ## 220   16903.0489
    ## 221   16788.6295
    ## 222   16672.1436
    ## 223   16661.6256
    ## 224   16610.3770
    ## 225   16537.4835
    ## 226   16361.8765
    ## 227   16310.4434
    ## 228   16233.7177
    ## 229   16207.2666
    ## 230   16173.1459
    ## 231   16120.5284
    ## 232   16107.1917
    ## 233   16076.5880
    ## 234   16048.5142
    ## 235   16046.0373
    ## 236   15993.5280
    ## 237   15937.2112
    ## 238   15895.1164
    ## 239   15870.8785
    ## 240   15798.0636
    ## 241   15764.9831
    ## 242   15605.4228
    ## 243   15389.9247
    ## 244   15377.2285
    ## 245   15367.0292
    ## 246   15363.2514
    ## 247   15277.0302
    ## 248   15268.4209
    ## 249   15258.2970
    ## 250   15215.6579
    ## 251   15181.0927
    ## 252   15169.1611
    ## 253   15113.3619
    ## 254   14847.1271
    ## 255   14843.9356
    ## 256   14804.6727
    ## 257   14800.1606
    ## 258   14778.7864
    ## 259   14745.6256
    ## 260   14734.2327
    ## 261   14722.8419
    ## 262   14688.2351
    ## 263   14641.5871
    ## 264   14619.2227
    ## 265   14560.5305
    ## 266   14526.1246
    ## 267   14517.9071
    ## 268   14463.9189
    ## 269   14358.8759
    ## 270   14297.0212
    ## 271   14255.9847
    ## 272   14214.7168
    ## 273   14195.5243
    ## 274   14142.8509
    ## 275   13990.4821
    ## 276   13926.1700
    ## 277   13872.8665
    ## 278   13822.5839
    ## 279   13638.7784
    ## 280   13583.3135
    ## 281   13522.1575
    ## 282   13462.4855
    ## 283   13450.4015
    ## 284   13319.8957
    ## 285   13306.6192
    ## 286   13236.9212
    ## 287   13221.8218
    ## 288   13206.4845
    ## 289   13175.6780
    ## 290   13171.6388
    ## 291   13149.0412
    ## 292   13143.9510
    ## 293   13108.4536
    ## 294   13039.3088
    ## 295   12999.9177
    ## 296   12986.4800
    ## 297   12980.6696
    ## 298   12954.7910
    ## 299   12902.4629
    ## 300   12834.6024
    ## 301   12790.8496
    ## 302   12786.9322
    ## 303   12779.3796
    ## 304   12753.2751
    ## 305   12724.8296
    ## 306   12618.3214
    ## 307   12569.8518
    ## 308   12545.9907
    ## 309   12521.7139
    ## 310   12489.9501
    ## 311   12477.1771
    ## 312   12451.6558
    ## 313   12383.4862
    ## 314   12329.4419
    ## 315   12281.3419
    ## 316   12269.2738
    ## 317   12247.3953
    ## 318   12217.2269
    ## 319   12154.0897
    ## 320   12126.2306
    ## 321   12104.2787
    ## 322   12057.4993
    ## 323   12037.2676
    ## 324   12002.2391
    ## 325   11977.5750
    ## 326   11888.5951
    ## 327   11864.4084
    ## 328   11848.3439
    ## 329   11770.5898
    ## 330   11753.8429
    ## 331   11732.5102
    ## 332   11712.7768
    ## 333   11674.8374
    ## 334   11653.9730
    ## 335   11643.5727
    ## 336   11635.7995
    ## 337   11628.3890
    ## 338   11626.4197
    ## 339   11605.7145
    ## 340   11460.6002
    ## 341   11415.8057
    ## 342   11401.9484
    ## 343   11399.4449
    ## 344   11367.1611
    ## 345   11348.5459
    ## 346   11305.3852
    ## 347   11283.1779
    ## 348   11276.1934
    ## 349   11222.5876
    ## 350   11210.0895
    ## 351   11186.1413
    ## 352   11152.4101
    ## 353   11150.9811
    ## 354   11099.6593
    ## 355   11054.5618
    ## 356   11003.6051
    ## 357   10991.2068
    ## 358   10967.2820
    ## 359   10956.9911
    ## 360   10949.6496
    ## 361   10922.6640
    ## 362   10921.6363
    ## 363   10808.4756
    ## 364   10778.7838
    ## 365   10750.7211
    ## 366   10742.4405
    ## 367   10733.9263
    ## 368   10680.7928
    ## 369   10638.7513
    ## 370   10618.0385
    ## 371   10611.4630
    ## 372   10560.4855
    ## 373   10556.5757
    ## 374   10535.6285
    ## 375   10522.0675
    ## 376   10505.2597
    ## 377   10461.0587
    ## 378   10350.1591
    ## 379   10330.9891
    ## 380   10206.9779
    ## 381   10187.8267
    ## 382   10172.4857
    ## 383   10168.6561
    ## 384   10165.4952
    ## 385   10159.5837
    ## 386   10136.8671
    ## 387   10132.9096
    ## 388   10118.0532
    ## 389   10095.4217
    ## 390   10079.0267
    ## 391   10039.5956
    ## 392   10022.4013
    ## 393    9979.5085
    ## 394    9911.8782
    ## 395    9883.5846
    ## 396    9875.6045
    ## 397    9867.0848
    ## 398    9847.7886
    ## 399    9809.1856
    ## 400    9802.4665
    ## 401    9786.5347
    ## 402    9770.5249
    ## 403    9767.2975
    ## 404    9714.9606
    ## 405    9696.2733
    ## 406    9692.3852
    ## 407    9674.1676
    ## 408    9645.0614
    ## 409    9640.1385
    ## 410    9613.8186
    ## 411    9611.1475
    ## 412    9605.3141
    ## 413    9595.9299
    ## 414    9576.0376
    ## 415    9541.4742
    ## 416    9534.6775
    ## 417    9530.7729
    ## 418    9508.1415
    ## 419    9498.4677
    ## 420    9472.3843
    ## 421    9467.4461
    ## 422    9443.0385
    ## 423    9405.4894
    ## 424    9371.8426
    ## 425    9356.3972
    ## 426    9326.6447
    ## 427    9325.0682
    ## 428    9313.9388
    ## 429    9308.4187
    ## 430    9269.6578
    ## 431    9253.8961
    ## 432    9244.0014
    ## 433    9240.7620
    ## 434    9230.2407
    ## 435    9164.0901
    ## 436    9139.6714
    ## 437    9123.0417
    ## 438    9119.5286
    ## 439    9082.3512
    ## 440    9065.8008
    ## 441    9022.2474
    ## 442    9021.8159
    ## 443    8997.8974
    ## 444    8948.1029
    ## 445    8941.5719
    ## 446    8931.4598
    ## 447    8842.5980
    ## 448    8797.6407
    ## 449    8792.5731
    ## 450    8754.9639
    ## 451    8688.1560
    ## 452    8662.8349
    ## 453    8659.6968
    ## 454    8647.1423
    ## 455    8605.0478
    ## 456    8597.7562
    ## 457    8568.2662
    ## 458    8533.0888
    ## 459    8527.8447
    ## 460    8513.0970
    ## 461    8458.2764
    ## 462    8451.5310
    ## 463    8447.7949
    ## 464    8422.9742
    ## 465    8412.9024
    ## 466    8393.7414
    ## 467    8358.7620
    ## 468    8343.1051
    ## 469    8341.7378
    ## 470    8315.9281
    ## 471    8263.5903
    ## 472    8256.3439
    ## 473    8243.5823
    ## 474    8239.8548
    ## 475    8224.1916
    ## 476    8157.5912
    ## 477    8137.0048
    ## 478    8131.2128
    ## 479    8052.9530
    ## 480    8028.6514
    ## 481    8011.4144
    ## 482    8006.5070
    ## 483    7993.5123
    ## 484    7991.7071
    ## 485    7957.9808
    ## 486    7954.1116
    ## 487    7914.3203
    ## 488    7899.5542
    ## 489    7885.3601
    ## 490    7825.8234
    ## 491    7807.0958
    ## 492    7778.4140
    ## 493    7765.9626
    ## 494    7738.8812
    ## 495    7727.0020
    ## 496    7723.4472
    ## 497    7710.9464
    ## 498    7703.4959
    ## 499    7696.7777
    ## 500    7689.7998
    ## 501    7674.9291
    ## 502    7670.1226
    ## 503    7655.5690
    ## 504    7640.5195
    ## 505    7612.2404
    ## 506    7608.3346
    ## 507    7596.1260
    ## 508    7550.3599
    ## 509    7545.4154
    ## 510    7532.9248
    ## 511    7486.3843
    ## 512    7481.1076
    ## 513    7479.1882
    ## 514    7458.3963
    ## 515    7452.3990
    ## 516    7446.2988
    ## 517    7433.8893
    ## 518    7429.4559
    ## 519    7426.3548
    ## 520    7425.7053
    ## 521    7408.9056
    ## 522    7404.9237
    ## 523    7402.3034
    ## 524    7388.5978
    ## 525    7370.9909
    ## 526    7356.0319
    ## 527    7346.5476
    ## 528    7320.8803
    ## 529    7316.9181
    ## 530    7277.9128
    ## 531    7267.6884
    ## 532    7236.0753
    ## 533    7235.6532
    ## 534    7225.0693
    ## 535    7213.7913
    ## 536    7144.1144
    ## 537    7133.1660
    ## 538    7121.9247
    ## 539    7114.4780
    ## 540    7113.6923
    ## 541    7110.6676
    ## 542    7105.6307
    ## 543    7103.7026
    ## 544    7092.9230
    ## 545    7034.7792
    ## 546    7030.8359
    ## 547    7029.8093
    ## 548    7009.6016
    ## 549    7006.5804
    ## 550    7003.3390
    ## 551    6994.7749
    ## 552    6960.2979
    ## 553    6950.2830
    ## 554    6929.2777
    ## 555    6920.2231
    ## 556    6890.8069
    ## 557    6876.1403
    ## 558    6873.2623
    ## 559    6856.8562
    ## 560    6809.4067
    ## 561    6757.0308
    ## 562    6679.6233
    ## 563    6677.0453
    ## 564    6660.1187
    ## 565    6650.1956
    ## 566    6642.8814
    ## 567    6631.5973
    ## 568    6631.4592
    ## 569    6619.5514
    ## 570    6618.7431
    ## 571    6601.4299
    ## 572    6598.4099
    ## 573    6597.4944
    ## 574    6576.6495
    ## 575    6557.1943
    ## 576    6557.1528
    ## 577    6508.0857
    ## 578    6504.3397
    ## 579    6481.7770
    ## 580    6470.8665
    ## 581    6465.6133
    ## 582    6459.5548
    ## 583    6434.5018
    ## 584    6424.5191
    ## 585    6380.4950
    ## 586    6361.5180
    ## 587    6360.9434
    ## 588    6351.2375
    ## 589    6340.6467
    ## 590    6316.1652
    ## 591    6302.6234
    ## 592    6289.6292
    ## 593    6281.2909
    ## 594    6248.6562
    ## 595    6229.3336
    ## 596    6223.3675
    ## 597    6205.8839
    ## 598    6197.9628
    ## 599    6160.4163
    ## 600    6150.7730
    ## 601    6137.0765
    ## 602    6124.7035
    ## 603    6117.3617
    ## 604    6101.2558
    ## 605    6093.2630
    ## 606    6092.1744
    ## 607    6089.7869
    ## 608    6071.9414
    ## 609    6068.0513
    ## 610    6058.2538
    ## 611    6040.1800
    ## 612    6025.3748
    ## 613    6018.9752
    ## 614    6017.6548
    ## 615    6017.1907
    ## 616    6006.9830
    ## 617    5970.3888
    ## 618    5937.8273
    ## 619    5937.0295
    ## 620    5926.8770
    ## 621    5913.1875
    ## 622    5911.3151
    ## 623    5909.0201
    ## 624    5907.8509
    ## 625    5906.7318
    ## 626    5862.2766
    ## 627    5852.6255
    ## 628    5838.3477
    ## 629    5788.0933
    ## 630    5773.0445
    ## 631    5768.7297
    ## 632    5755.2600
    ## 633    5754.7339
    ## 634    5745.1602
    ## 635    5728.3535
    ## 636    5722.8957
    ## 637    5716.7667
    ## 638    5714.5606
    ## 639    5703.4089
    ## 640    5693.8439
    ## 641    5690.2680
    ## 642    5681.3585
    ## 643    5678.3483
    ## 644    5629.9153
    ## 645    5622.9425
    ## 646    5621.3685
    ## 647    5603.3577
    ## 648    5599.0779
    ## 649    5596.5198
    ## 650    5592.8440
    ## 651    5586.5388
    ## 652    5581.1810
    ## 653    5577.0028
    ## 654    5547.0638
    ## 655    5522.7764
    ## 656    5494.0244
    ## 657    5487.1042
    ## 658    5486.3711
    ## 659    5477.8900
    ## 660    5473.2880
    ## 661    5444.6486
    ## 662    5444.6196
    ## 663    5431.9904
    ## 664    5385.2785
    ## 665    5377.0913
    ## 666    5364.2497
    ## 667    5351.9121
    ## 668    5351.5687
    ## 669    5338.7521
    ## 670    5305.4453
    ## 671    5303.3775
    ## 672    5288.0404
    ## 673    5280.9947
    ## 674    5267.2194
    ## 675    5263.6738
    ## 676    5262.7348
    ## 677    5249.8027
    ## 678    5246.1075
    ## 679    5210.2803
    ## 680    5186.0500
    ## 681    5180.7559
    ## 682    5154.8255
    ## 683    5138.9224
    ## 684    5118.1469
    ## 685    5108.3446
    ## 686    5107.1974
    ## 687    5106.6543
    ## 688    5095.6657
    ## 689    5089.0437
    ## 690    5074.6591
    ## 691    5047.6586
    ## 692    5023.2166
    ## 693    4997.5240
    ## 694    4985.7115
    ## 695    4981.0909
    ## 696    4977.4185
    ## 697    4976.1981
    ## 698    4959.1149
    ## 699    4957.0380
    ## 700    4931.4042
    ## 701    4920.3560
    ## 702    4916.2999
    ## 703    4910.4168
    ## 704    4903.2191
    ## 705    4879.9927
    ## 706    4879.5075
    ## 707    4876.7986
    ## 708    4858.3475
    ## 709    4834.8041
    ## 710    4820.4948
    ## 711    4811.0604
    ## 712    4797.2951
    ## 713    4797.2313
    ## 714    4783.5869
    ## 715    4766.3559
    ## 716    4756.7638
    ## 717    4756.5258
    ## 718    4754.6044
    ## 719    4734.9976
    ## 720    4734.2530
    ## 721    4727.9549
    ## 722    4725.2955
    ## 723    4720.9427
    ## 724    4692.6483
    ## 725    4688.5933
    ## 726    4684.3138
    ## 727    4657.2210
    ## 728    4649.5938
    ## 729    4643.3935
    ## 730    4616.8965
    ## 731    4604.2117
    ## 732    4581.6094
    ## 733    4579.0742
    ## 734    4564.8024
    ## 735    4563.8082
    ## 736    4551.1421
    ## 737    4520.2460
    ## 738    4519.4612
    ## 739    4519.0943
    ## 740    4515.4876
    ## 741    4513.4806
    ## 742    4471.0619
    ## 743    4448.6799
    ## 744    4446.3809
    ## 745    4444.2317
    ## 746    4439.4508
    ## 747    4421.0091
    ## 748    4397.5757
    ## 749    4390.7173
    ## 750    4358.5954
    ## 751    4338.2316
    ## 752    4336.0321
    ## 753    4332.7202
    ## 754    4319.8041
    ## 755    4317.6944
    ## 756    4315.6227
    ## 757    4314.1148
    ## 758    4293.4765
    ## 759    4269.2767
    ## 760    4269.1223
    ## 761    4258.5036
    ## 762    4254.3378
    ## 763    4247.4003
    ## 764    4246.4860
    ## 765    4245.2567
    ## 766    4241.3563
    ## 767    4215.0417
    ## 768    4201.1949
    ## 769    4196.4111
    ## 770    4191.1005
    ## 771    4187.3298
    ## 772    4184.5481
    ## 773    4182.6638
    ## 774    4173.1818
    ## 775    4172.8385
    ## 776    4161.7278
    ## 777    4161.4160
    ## 778    4140.4421
    ## 779    4131.5466
    ## 780    4129.7661
    ## 781    4128.1169
    ## 782    4126.6132
    ## 783    4106.5253
    ## 784    4106.4923
    ## 785    4106.3012
    ## 786    4100.3934
    ## 787    4098.3442
    ## 788    4090.9253
    ## 789    4086.5221
    ## 790    4086.1141
    ## 791    4072.3248
    ## 792    4062.5239
    ## 793    4031.4083
    ## 794    4029.3297
    ## 795    4021.1757
    ## 796    4016.2395
    ## 797    4014.2390
    ## 798    3998.8757
    ## 799    3984.8398
    ## 800    3970.0954
    ## 801    3943.3702
    ## 802    3939.9788
    ## 803    3907.1562
    ## 804    3899.5243
    ## 805    3895.3840
    ## 806    3885.4607
    ## 807    3876.7685
    ## 808    3876.4860
    ## 809    3844.9172
    ## 810    3834.0347
    ## 811    3827.9405
    ## 812    3827.9216
    ## 813    3822.1371
    ## 814    3820.1752
    ## 815    3815.8079
    ## 816    3810.4193
    ## 817    3804.5380
    ## 818    3794.7552
    ## 819    3793.6948
    ## 820    3783.6742
    ## 821    3781.4106
    ## 822    3780.5467
    ## 823    3776.8036
    ## 824    3774.5717
    ## 825    3761.8377
    ## 826    3758.5234
    ## 827    3746.0809
    ## 828    3745.6407
    ## 829    3738.9327
    ## 830    3726.0635
    ## 831    3710.9830
    ## 832    3701.6215
    ## 833    3694.2124
    ## 834    3693.7313
    ## 835    3688.0377
    ## 836    3682.8315
    ## 837    3682.2599
    ## 838    3674.7356
    ## 839    3645.3796
    ## 840    3634.3644
    ## 841    3632.5578
    ## 842    3630.8807
    ## 843    3629.0765
    ## 844    3614.1013
    ## 845    3581.4594
    ## 846    3560.2332
    ## 847    3553.0224
    ## 848    3548.3308
    ## 849    3548.0978
    ## 850    3540.6516
    ## 851    3536.5403
    ## 852    3533.0039
    ## 853    3530.6901
    ## 854    3528.4813
    ## 855    3522.1107
    ## 856    3520.6103
    ## 857    3503.7296
    ## 858    3484.1644
    ## 859    3484.0620
    ## 860    3478.1255
    ## 861    3470.3382
    ## 862    3460.9370
    ## 863    3457.4159
    ## 864    3450.6964
    ## 865    3448.2844
    ## 866    3431.5936
    ## 867    3429.8644
    ## 868    3421.5232
    ## 869    3413.2627
    ## 870    3364.8366
    ## 871    3340.5428
    ## 872    3336.5858
    ## 873    3326.1432
    ## 874    3313.4222
    ## 875    3290.2576
    ## 876    3264.6600
    ## 877    3259.1790
    ## 878    3258.4956
    ## 879    3248.3733
    ## 880    3246.9918
    ## 881    3242.5311
    ## 882    3216.9563
    ## 883    3214.8578
    ## 884    3213.1527
    ## 885    3203.2081
    ## 886    3195.4846
    ## 887    3193.0546
    ## 888    3190.4810
    ## 889    3173.7233
    ## 890    3173.2156
    ## 891    3160.4549
    ## 892    3156.5105
    ## 893    3144.6132
    ## 894    3133.4093
    ## 895    3121.7608
    ## 896    3120.8768
    ## 897    3119.3356
    ## 898    3119.2809
    ## 899    3119.2365
    ## 900    3116.7743
    ## 901    3112.3639
    ## 902    3099.7287
    ## 903    3095.7723
    ## 904    3081.9598
    ## 905    3081.7610
    ## 906    3081.6946
    ## 907    3076.2398
    ## 908    3068.3199
    ## 909    3054.4212
    ## 910    3048.3029
    ## 911    3044.2142
    ## 912    3035.3260
    ## 913    3030.8767
    ## 914    3025.3498
    ## 915    3023.2719
    ## 916    3023.0967
    ## 917    3020.9893
    ## 918    3020.0505
    ## 919    3015.3788
    ## 920    3013.9760
    ## 921    3008.6707
    ## 922    3008.6474
    ## 923    2990.0108
    ## 924    2982.6538
    ## 925    2982.1019
    ## 926    2980.3313
    ## 927    2961.8009
    ## 928    2961.6997
    ## 929    2955.9844
    ## 930    2948.0473
    ## 931    2924.6381
    ## 932    2899.8422
    ## 933    2898.5309
    ## 934    2880.1026
    ## 935    2879.4681
    ## 936    2873.9129
    ## 937    2864.9691
    ## 938    2861.0924
    ## 939    2860.1698
    ## 940    2852.3516
    ## 941    2849.0948
    ## 942    2843.1044
    ## 943    2826.3564
    ## 944    2814.4808
    ## 945    2785.4936
    ## 946    2773.2873
    ## 947    2769.4518
    ## 948    2760.1969
    ## 949    2756.9537
    ## 950    2755.0470
    ## 951    2753.6915
    ## 952    2753.2860
    ## 953    2750.3644
    ## 954    2749.3210
    ## 955    2741.7963
    ## 956    2718.8853
    ## 957    2702.6204
    ## 958    2681.9889
    ## 959    2678.7298
    ## 960    2677.9396
    ## 961    2677.3263
    ## 962    2669.5295
    ## 963    2664.4773
    ## 964    2650.9211
    ## 965    2649.7150
    ## 966    2647.5856
    ## 967    2643.8587
    ## 968    2627.8457
    ## 969    2627.0095
    ## 970    2621.4481
    ## 971    2617.1560
    ## 972    2613.1017
    ## 973    2605.9476
    ## 974    2603.2738
    ## 975    2602.7102
    ## 976    2602.6642
    ## 977    2602.3950
    ## 978    2586.8861
    ## 979    2575.4842
    ## 980    2571.4230
    ## 981    2550.8169
    ## 982    2546.7814
    ## 983    2538.2694
    ## 984    2536.5349
    ## 985    2529.8423
    ## 986    2529.0675
    ## 987    2523.3380
    ## 988    2517.7365
    ## 989    2497.4379
    ## 990    2492.3511
    ## 991    2487.3660
    ## 992    2480.3803
    ## 993    2475.3876
    ## 994    2474.5488
    ## 995    2464.7832
    ## 996    2452.2104
    ## 997    2449.0082
    ## 998    2444.2866
    ## 999    2441.5764
    ## 1000   2430.2083
    ## 1001   2428.2378
    ## 1002   2423.7804
    ## 1003   2393.2198
    ## 1004   2387.5481
    ## 1005   2383.1409
    ## 1006   2378.2011
    ## 1007   2377.1562
    ## 1008   2373.2043
    ## 1009   2370.6200
    ## 1010   2367.9833
    ## 1011   2348.0092
    ## 1012   2338.0083
    ## 1013   2323.8056
    ## 1014   2322.8699
    ## 1015   2315.1382
    ## 1016   2315.0566
    ## 1017   2312.8890
    ## 1018   2299.3763
    ## 1019   2291.1568
    ## 1020   2289.2341
    ## 1021   2280.7699
    ## 1022   2279.3240
    ## 1023   2277.7424
    ## 1024   2277.1409
    ## 1025   2263.6111
    ## 1026   2253.0230
    ## 1027   2242.7466
    ## 1028   2234.8208
    ## 1029   2220.4877
    ## 1030   2218.7543
    ## 1031   2202.9884
    ## 1032   2198.9563
    ## 1033   2194.9262
    ## 1034   2193.0371
    ## 1035   2189.8745
    ## 1036   2189.6350
    ## 1037   2180.9725
    ## 1038   2172.3524
    ## 1039   2170.1517
    ## 1040   2156.9561
    ## 1041   2153.7392
    ## 1042   2148.0271
    ## 1043   2144.1151
    ## 1044   2143.5406
    ## 1045   2140.7393
    ## 1046   2127.6863
    ## 1047   2125.6214
    ## 1048   2117.4845
    ## 1049   2117.2349
    ## 1050   2110.8563
    ## 1051   2108.9444
    ## 1052   2092.7124
    ## 1053   2082.4816
    ## 1054   2052.0505
    ## 1055   2049.3505
    ## 1056   2046.1547
    ## 1057   2042.0952
    ## 1058   2036.8849
    ## 1059   2034.0380
    ## 1060   2029.2281
    ## 1061   2024.0081
    ## 1062   2013.9773
    ## 1063   2011.1595
    ## 1064   2000.6031
    ## 1065   1993.3983
    ## 1066   1989.3741
    ## 1067   1981.9518
    ## 1068   1977.5570
    ## 1069   1971.8295
    ## 1070   1971.7415
    ## 1071   1969.1010
    ## 1072   1967.9557
    ## 1073   1961.2246
    ## 1074   1959.5938
    ## 1075   1952.3087
    ## 1076   1942.2842
    ## 1077   1937.5777
    ## 1078   1934.0114
    ## 1079   1932.3602
    ## 1080   1930.1950
    ## 1081   1908.2609
    ## 1082   1902.2521
    ## 1083   1895.5441
    ## 1084   1895.0170
    ## 1085   1890.2181
    ## 1086   1886.0806
    ## 1087   1881.9236
    ## 1088   1879.4967
    ## 1089   1876.7668
    ## 1090   1876.0296
    ## 1091   1874.2989
    ## 1092   1856.1821
    ## 1093   1840.3669
    ## 1094   1831.1329
    ## 1095   1829.7652
    ## 1096   1828.2303
    ## 1097   1827.0677
    ## 1098   1823.0160
    ## 1099   1822.8790
    ## 1100   1814.8807
    ## 1101   1814.1274
    ## 1102   1810.0670
    ## 1103   1803.1515
    ## 1104   1796.5890
    ## 1105   1793.1633
    ## 1106   1786.2654
    ## 1107   1785.4020
    ## 1108   1783.4329
    ## 1109   1777.0773
    ## 1110   1773.4983
    ## 1111   1770.3371
    ## 1112   1764.4567
    ## 1113   1748.5630
    ## 1114   1748.3570
    ## 1115   1746.7695
    ## 1116   1737.5617
    ## 1117   1728.8694
    ## 1118   1726.8879
    ## 1119   1713.7787
    ## 1120   1712.4721
    ## 1121   1711.0448
    ## 1122   1709.6837
    ## 1123   1704.6866
    ## 1124   1704.0637
    ## 1125   1698.3888
    ## 1126   1694.3375
    ## 1127   1693.3359
    ## 1128   1690.7568
    ## 1129   1688.2036
    ## 1130   1687.9976
    ## 1131   1684.1465
    ## 1132   1662.1374
    ## 1133   1660.3032
    ## 1134   1659.6528
    ## 1135   1655.7842
    ## 1136   1654.9887
    ## 1137   1654.4569
    ## 1138   1653.7230
    ## 1139   1649.6602
    ## 1140   1649.5522
    ## 1141   1648.8008
    ## 1142   1648.0798
    ## 1143   1648.0738
    ## 1144   1647.5117
    ## 1145   1646.7582
    ## 1146   1643.4854
    ## 1147   1643.3871
    ## 1148   1642.0023
    ## 1149   1634.0473
    ## 1150   1632.2108
    ## 1151   1624.9413
    ## 1152   1621.6936
    ## 1153   1619.8482
    ## 1154   1615.9911
    ## 1155   1615.2864
    ## 1156   1612.4046
    ## 1157   1601.0561
    ## 1158   1598.4351
    ## 1159   1597.7121
    ## 1160   1593.0655
    ## 1161   1589.2027
    ## 1162   1588.6883
    ## 1163   1586.8518
    ## 1164   1579.0195
    ## 1165   1576.9738
    ## 1166   1571.1347
    ## 1167   1569.3314
    ## 1168   1567.6530
    ## 1169   1566.3535
    ## 1170   1561.7691
    ## 1171   1547.9448
    ## 1172   1546.9078
    ## 1173   1544.7501
    ## 1174   1544.4030
    ## 1175   1544.2286
    ## 1176   1536.3444
    ## 1177   1532.9853
    ## 1178   1532.7770
    ## 1179   1524.3589
    ## 1180   1519.6353
    ## 1181   1518.4800
    ## 1182   1516.8730
    ## 1183   1516.5255
    ## 1184   1515.5923
    ## 1185   1508.4531
    ## 1186   1507.8613
    ## 1187   1507.8192
    ## 1188   1500.8959
    ## 1189   1497.4922
    ## 1190   1492.1970
    ## 1191   1487.5935
    ## 1192   1483.1361
    ## 1193   1481.1502
    ## 1194   1477.5968
    ## 1195   1468.4756
    ## 1196   1465.0108
    ## 1197   1463.2493
    ## 1198   1458.9153
    ## 1199   1458.8174
    ## 1200   1456.3095
    ## 1201   1452.7258
    ## 1202   1452.0577
    ## 1203   1450.9925
    ## 1204   1450.3570
    ## 1205   1443.4298
    ## 1206   1443.0117
    ## 1207   1441.7207
    ## 1208   1441.2849
    ## 1209   1428.7778
    ## 1210   1421.7420
    ## 1211   1421.6036
    ## 1212   1421.1452
    ## 1213   1418.8224
    ## 1214   1408.6786
    ## 1215   1406.6483
    ## 1216   1399.6074
    ## 1217   1397.7171
    ## 1218   1395.2325
    ## 1219   1392.3683
    ## 1220   1391.2538
    ## 1221   1389.8176
    ## 1222   1388.5947
    ## 1223   1385.8968
    ## 1224   1385.0296
    ## 1225   1384.8406
    ## 1226   1382.7021
    ## 1227   1378.9040
    ## 1228   1372.8779
    ## 1229   1369.4883
    ## 1230   1367.8994
    ## 1231   1361.9369
    ## 1232   1361.3698
    ## 1233   1360.4850
    ## 1234   1353.9892
    ## 1235   1353.7598
    ## 1236   1353.0924
    ## 1237   1348.7757
    ## 1238   1348.2852
    ## 1239   1348.2258
    ## 1240   1344.5780
    ## 1241   1341.9217
    ## 1242   1341.7269
    ## 1243   1339.0760
    ## 1244   1327.6089
    ## 1245   1315.9808
    ## 1246   1313.0481
    ## 1247   1311.9568
    ## 1248   1308.4956
    ## 1249   1302.8787
    ## 1250   1295.4607
    ## 1251   1294.4478
    ## 1252   1287.5147
    ## 1253   1284.7332
    ## 1254   1277.8976
    ## 1255   1275.1846
    ## 1256   1272.8810
    ## 1257   1271.2116
    ## 1258   1270.3649
    ## 1259   1267.6132
    ## 1260   1267.1001
    ## 1261   1265.0470
    ## 1262   1258.1474
    ## 1263   1254.5761
    ## 1264   1246.9074
    ## 1265   1244.7084
    ## 1266   1232.9753
    ## 1267   1226.0411
    ## 1268   1225.8560
    ## 1269   1222.3600
    ## 1270   1217.0330
    ## 1271   1214.7093
    ## 1272   1213.3955
    ## 1273   1213.3151
    ## 1274   1211.1485
    ## 1275   1210.8846
    ## 1276   1206.9479
    ## 1277   1206.0435
    ## 1278   1202.2014
    ## 1279   1201.6372
    ## 1280   1196.8106
    ## 1281   1193.0688
    ## 1282   1191.2077
    ## 1283   1190.8443
    ## 1284   1190.0411
    ## 1285   1186.1480
    ## 1286   1178.6659
    ## 1287   1178.2237
    ## 1288   1176.8070
    ## 1289   1175.9212
    ## 1290   1173.6182
    ## 1291   1172.6677
    ## 1292   1172.6030
    ## 1293   1164.4068
    ## 1294   1156.1819
    ## 1295   1155.4419
    ## 1296   1150.9275
    ## 1297   1148.3766
    ## 1298   1147.3888
    ## 1299   1136.3904
    ## 1300   1136.0566
    ## 1301   1135.7498
    ## 1302   1135.5143
    ## 1303   1133.9850
    ## 1304   1132.0550
    ## 1305   1125.6972
    ## 1306   1116.6399
    ## 1307   1111.9846
    ## 1308   1111.1079
    ## 1309   1109.3743
    ## 1310   1107.4822
    ## 1311   1104.1040
    ## 1312   1102.9909
    ## 1313   1100.5926
    ## 1314   1093.2450
    ## 1315   1091.3598
    ## 1316   1088.2778
    ## 1317   1085.7969
    ## 1318   1083.5320
    ## 1319   1077.2819
    ## 1320   1075.8116
    ## 1321   1074.4720
    ## 1322   1072.5466
    ## 1323   1071.6139
    ## 1324   1071.5511
    ## 1325   1071.3538
    ## 1326   1071.3107
    ## 1327   1070.0133
    ## 1328   1068.6963
    ## 1329   1067.5348
    ## 1330   1062.7522
    ## 1331   1058.0643
    ## 1332   1057.2063
    ## 1333   1056.7365
    ## 1334   1056.3801
    ## 1335   1056.3540
    ## 1336   1055.8960
    ## 1337   1054.3849
    ## 1338   1049.9390
    ## 1339   1044.7701
    ## 1340   1043.5615
    ## 1341   1042.5816
    ## 1342   1040.6762
    ## 1343   1037.6452
    ## 1344   1035.8314
    ## 1345   1034.2989
    ## 1346   1030.5922
    ## 1347   1029.1613
    ## 1348   1014.5141
    ## 1349   1010.8921
    ## 1350   1005.2458
    ## 1351   1004.9614
    ## 1352   1004.4844
    ## 1353   1002.1992
    ## 1354    997.7661
    ## 1355    993.2240
    ## 1356    989.0231
    ## 1357    986.2959
    ## 1358    986.1479
    ## 1359    983.6540
    ## 1360    982.2869
    ## 1361    978.0114
    ## 1362    977.4863
    ## 1363    976.5127
    ## 1364    974.5803
    ## 1365    973.5332
    ## 1366    972.7700
    ## 1367    966.8968
    ## 1368    962.4923
    ## 1369    962.4214
    ## 1370    959.6011
    ## 1371    958.5668
    ## 1372    956.7530
    ## 1373    954.2092
    ## 1374    952.3861
    ## 1375    951.4098
    ## 1376    950.7359
    ## 1377    949.4991
    ## 1378    946.2950
    ## 1379    945.5836
    ## 1380    944.4383
    ## 1381    944.0000
    ## 1382    942.6542
    ## 1383    942.4083
    ## 1384    931.7528
    ## 1385    930.5964
    ## 1386    927.8253
    ## 1387    927.7210
    ## 1388    926.9603
    ## 1389    926.1411
    ## 1390    925.9083
    ## 1391    925.0602
    ## 1392    918.2325
    ## 1393    915.9851
    ## 1394    915.5960
    ## 1395    913.4708
    ## 1396    912.6626
    ## 1397    912.0631
    ## 1398    911.2989
    ## 1399    909.7221
    ## 1400    908.9185
    ## 1401    905.8602
    ## 1402    904.8961
    ## 1403    899.0742
    ## 1404    897.7404
    ## 1405    896.9664
    ## 1406    896.3146
    ## 1407    896.2260
    ## 1408    894.6371
    ## 1409    886.2206
    ## 1410    884.7553
    ## 1411    882.9699
    ## 1412    882.0818
    ## 1413    881.5706
    ## 1414    879.7877
    ## 1415    879.5836
    ## 1416    876.0326
    ## 1417    874.6859
    ## 1418    874.2426
    ## 1419    869.4498
    ## 1420    863.0885
    ## 1421    862.5408
    ## 1422    862.4421
    ## 1423    861.5932
    ## 1424    860.7369
    ## 1425    859.8087
    ## 1426    858.9003
    ## 1427    857.2504
    ## 1428    855.7235
    ## 1429    854.7360
    ## 1430    853.5409
    ## 1431    853.1007
    ## 1432    852.3959
    ## 1433    851.2411
    ## 1434    849.2898
    ## 1435    848.2187
    ## 1436    847.9912
    ## 1437    847.0061
    ## 1438    846.1203
    ## 1439    844.8764
    ## 1440    843.7331
    ## 1441    838.1240
    ## 1442    837.8102
    ## 1443    836.1971
    ## 1444    835.8096
    ## 1445    835.5234
    ## 1446    831.8221
    ## 1447    825.6825
    ## 1448    825.6232
    ## 1449    823.6856
    ## 1450    820.8530
    ## 1451    820.7994
    ## 1452    820.2246
    ## 1453    816.5591
    ## 1454    813.3373
    ## 1455    808.8971
    ## 1456    807.1986
    ## 1457    805.5725
    ## 1458    804.8305
    ## 1459    803.3427
    ## 1460    803.0055
    ## 1461    799.3622
    ## 1462    797.9081
    ## 1463    797.2631
    ## 1464    796.6645
    ## 1465    795.7573
    ## 1466    794.8266
    ## 1467    794.3484
    ## 1468    793.5774
    ## 1469    792.4500
    ## 1470    790.2580
    ## 1471    789.1862
    ## 1472    788.8550
    ## 1473    786.5669
    ## 1474    786.1134
    ## 1475    785.6538
    ## 1476    781.7176
    ## 1477    780.5423
    ## 1478    779.4453
    ## 1479    775.6325
    ## 1480    774.3711
    ## 1481    773.9932
    ## 1482    772.0492
    ## 1483    767.2717
    ## 1484    765.3500
    ## 1485    764.7260
    ## 1486    762.4318
    ## 1487    761.8794
    ## 1488    759.3499
    ## 1489    757.7974
    ## 1490    756.0868
    ## 1491    752.7497
    ## 1492    751.9794
    ## 1493    749.6817
    ## 1494    747.9055
    ## 1495    747.0835
    ## 1496    745.5399
    ## 1497    745.3695
    ## 1498    743.3870
    ## 1499    743.1159
    ## 1500    741.6662
    ## 1501    741.2375
    ## 1502    740.5063
    ## 1503    739.9811
    ## 1504    739.0144
    ## 1505    738.6906
    ## 1506    737.0686
    ## 1507    736.4154
    ## 1508    734.7829
    ## 1509    734.7535
    ## 1510    734.2852
    ## 1511    726.7341
    ## 1512    724.9178
    ## 1513    724.0325
    ## 1514    722.5120
    ## 1515    722.0038
    ## 1516    721.1861
    ## 1517    718.3731
    ## 1518    716.6501
    ## 1519    715.5806
    ## 1520    713.6036
    ## 1521    713.5371
    ## 1522    708.7595
    ## 1523    707.2358
    ## 1524    706.1573
    ## 1525    706.0165
    ## 1526    700.7706
    ## 1527    699.5016
    ## 1528    699.4897
    ## 1529    698.5356
    ## 1530    694.1124
    ## 1531    693.4208
    ## 1532    692.2758
    ## 1533    690.8056
    ## 1534    686.3953
    ## 1535    686.3737
    ## 1536    686.3416
    ## 1537    685.5877
    ## 1538    684.5971
    ## 1539    684.2442
    ## 1540    684.1716
    ## 1541    683.8956
    ## 1542    682.3032
    ## 1543    682.2662
    ## 1544    676.9819
    ## 1545    676.9001
    ## 1546    676.4422
    ## 1547    676.2854
    ## 1548    674.7881
    ## 1549    673.7478
    ## 1550    672.7748
    ## 1551    672.4123
    ## 1552    672.0386
    ## 1553    670.0806
    ## 1554    668.3000
    ## 1555    665.6244
    ## 1556    665.4231
    ## 1557    663.2237
    ## 1558    661.6375
    ## 1559    660.5856
    ## 1560    659.8772
    ## 1561    658.3472
    ## 1562    653.7302
    ## 1563    652.3969
    ## 1564    649.3414
    ## 1565    644.1708
    ## 1566    641.3695
    ## 1567    640.3224
    ## 1568    637.1233
    ## 1569    636.6229
    ## 1570    635.5174
    ## 1571    635.3414
    ## 1572    634.1952
    ## 1573    633.6179
    ## 1574    632.8039
    ## 1575    631.6999
    ## 1576    630.2336
    ## 1577    624.4755
    ## 1578    621.8188
    ## 1579    620.9700
    ## 1580    619.6769
    ## 1581    618.0141
    ## 1582    617.7244
    ## 1583    617.1835
    ## 1584    612.7057
    ## 1585    611.6589
    ## 1586    611.0000
    ## 1587    609.1740
    ## 1588    605.0665
    ## 1589    601.0745
    ## 1590    599.6503
    ## 1591    597.9364
    ## 1592    597.4731
    ## 1593    590.5807
    ## 1594    590.0620
    ## 1595    589.9445
    ## 1596    584.6220
    ## 1597    582.8585
    ## 1598    582.8420
    ## 1599    581.3689
    ## 1600    581.1827
    ## 1601    580.3052
    ## 1602    579.2317
    ## 1603    577.8607
    ## 1604    576.2670
    ## 1605    575.9870
    ## 1606    575.7047
    ## 1607    575.5730
    ## 1608    574.6482
    ## 1609    573.7413
    ## 1610    572.1996
    ## 1611    569.7951
    ## 1612    566.6692
    ## 1613    566.2439
    ## 1614    563.2000
    ## 1615    559.6032
    ## 1616    556.8084
    ## 1617    556.6864
    ## 1618    556.1033
    ## 1619    546.5657
    ## 1620    545.8657
    ## 1621    545.0099
    ## 1622    543.2552
    ## 1623    540.2894
    ## 1624    531.4824
    ## 1625    530.0535
    ## 1626    527.2722
    ## 1627    524.9722
    ## 1628    524.8758
    ## 1629    523.4323
    ## 1630    522.0344
    ## 1631    521.1341
    ## 1632    520.9267
    ## 1633    518.7643
    ## 1634    516.1186
    ## 1635    515.8894
    ## 1636    514.3242
    ## 1637    510.9637
    ## 1638    510.1965
    ## 1639    506.1139
    ## 1640    505.7538
    ## 1641    502.3197
    ## 1642    498.6390
    ## 1643    496.9136
    ## 1644    496.5816
    ## 1645    496.1743
    ## 1646    495.5868
    ## 1647    495.5148
    ## 1648    493.3239
    ## 1649    490.3822
    ## 1650    487.6740
    ## 1651    485.2307
    ## 1652    472.3461
    ## 1653    469.7093
    ## 1654    468.7950
    ## 1655    468.5260
    ## 1656    464.0995
    ## 1657    463.1151
    ## 1658    462.2114
    ## 1659    457.7192
    ## 1660    452.3370
    ## 1661    446.4035
    ## 1662    434.0383
    ## 1663    431.7905
    ## 1664    430.0707
    ## 1665    427.9011
    ## 1666    426.0964
    ## 1667    424.0000
    ## 1668    421.6240
    ## 1669    421.3535
    ## 1670    419.4564
    ## 1671    416.3698
    ## 1672    415.0000
    ## 1673    414.5073
    ## 1674    412.9775
    ## 1675    411.8006
    ## 1676    410.8968
    ## 1677    406.8841
    ## 1678    400.4486
    ## 1679    389.8762
    ## 1680    388.0000
    ## 1681    385.0000
    ## 1682    380.9958
    ## 1683    379.5646
    ## 1684    378.9042
    ## 1685    375.6431
    ## 1686    371.0000
    ## 1687    369.1651
    ## 1688    368.4693
    ## 1689    362.1463
    ## 1690    357.0000
    ## 1691    355.2032
    ## 1692    350.0000
    ## 1693    349.0000
    ## 1694    347.0000
    ## 1695    344.1619
    ## 1696    339.2965
    ## 1697    335.9971
    ## 1698    331.0000
    ## 1699    328.9406
    ## 1700    312.1884
    ## 1701    299.8503
    ## 1702    298.8462
    ## 1703    277.5519
    ## 1704    241.1659

#### Pick variables with `select()`

Select allows use to pick variable (i.e. columns) from the dataset. For example, to only keep the data about year, country and GDP per capita:

``` r
(gap_small <- select(gapminder, year, country, gdpPercap))
```

    ##      year                  country   gdpPercap
    ## 1    1952              Afghanistan    779.4453
    ## 2    1957              Afghanistan    820.8530
    ## 3    1962              Afghanistan    853.1007
    ## 4    1967              Afghanistan    836.1971
    ## 5    1972              Afghanistan    739.9811
    ## 6    1977              Afghanistan    786.1134
    ## 7    1982              Afghanistan    978.0114
    ## 8    1987              Afghanistan    852.3959
    ## 9    1992              Afghanistan    649.3414
    ## 10   1997              Afghanistan    635.3414
    ## 11   2002              Afghanistan    726.7341
    ## 12   2007              Afghanistan    974.5803
    ## 13   1952                  Albania   1601.0561
    ## 14   1957                  Albania   1942.2842
    ## 15   1962                  Albania   2312.8890
    ## 16   1967                  Albania   2760.1969
    ## 17   1972                  Albania   3313.4222
    ## 18   1977                  Albania   3533.0039
    ## 19   1982                  Albania   3630.8807
    ## 20   1987                  Albania   3738.9327
    ## 21   1992                  Albania   2497.4379
    ## 22   1997                  Albania   3193.0546
    ## 23   2002                  Albania   4604.2117
    ## 24   2007                  Albania   5937.0295
    ## 25   1952                  Algeria   2449.0082
    ## 26   1957                  Algeria   3013.9760
    ## 27   1962                  Algeria   2550.8169
    ## 28   1967                  Algeria   3246.9918
    ## 29   1972                  Algeria   4182.6638
    ## 30   1977                  Algeria   4910.4168
    ## 31   1982                  Algeria   5745.1602
    ## 32   1987                  Algeria   5681.3585
    ## 33   1992                  Algeria   5023.2166
    ## 34   1997                  Algeria   4797.2951
    ## 35   2002                  Algeria   5288.0404
    ## 36   2007                  Algeria   6223.3675
    ## 37   1952                   Angola   3520.6103
    ## 38   1957                   Angola   3827.9405
    ## 39   1962                   Angola   4269.2767
    ## 40   1967                   Angola   5522.7764
    ## 41   1972                   Angola   5473.2880
    ## 42   1977                   Angola   3008.6474
    ## 43   1982                   Angola   2756.9537
    ## 44   1987                   Angola   2430.2083
    ## 45   1992                   Angola   2627.8457
    ## 46   1997                   Angola   2277.1409
    ## 47   2002                   Angola   2773.2873
    ## 48   2007                   Angola   4797.2313
    ## 49   1952                Argentina   5911.3151
    ## 50   1957                Argentina   6856.8562
    ## 51   1962                Argentina   7133.1660
    ## 52   1967                Argentina   8052.9530
    ## 53   1972                Argentina   9443.0385
    ## 54   1977                Argentina  10079.0267
    ## 55   1982                Argentina   8997.8974
    ## 56   1987                Argentina   9139.6714
    ## 57   1992                Argentina   9308.4187
    ## 58   1997                Argentina  10967.2820
    ## 59   2002                Argentina   8797.6407
    ## 60   2007                Argentina  12779.3796
    ## 61   1952                Australia  10039.5956
    ## 62   1957                Australia  10949.6496
    ## 63   1962                Australia  12217.2269
    ## 64   1967                Australia  14526.1246
    ## 65   1972                Australia  16788.6295
    ## 66   1977                Australia  18334.1975
    ## 67   1982                Australia  19477.0093
    ## 68   1987                Australia  21888.8890
    ## 69   1992                Australia  23424.7668
    ## 70   1997                Australia  26997.9366
    ## 71   2002                Australia  30687.7547
    ## 72   2007                Australia  34435.3674
    ## 73   1952                  Austria   6137.0765
    ## 74   1957                  Austria   8842.5980
    ## 75   1962                  Austria  10750.7211
    ## 76   1967                  Austria  12834.6024
    ## 77   1972                  Austria  16661.6256
    ## 78   1977                  Austria  19749.4223
    ## 79   1982                  Austria  21597.0836
    ## 80   1987                  Austria  23687.8261
    ## 81   1992                  Austria  27042.0187
    ## 82   1997                  Austria  29095.9207
    ## 83   2002                  Austria  32417.6077
    ## 84   2007                  Austria  36126.4927
    ## 85   1952                  Bahrain   9867.0848
    ## 86   1957                  Bahrain  11635.7995
    ## 87   1962                  Bahrain  12753.2751
    ## 88   1967                  Bahrain  14804.6727
    ## 89   1972                  Bahrain  18268.6584
    ## 90   1977                  Bahrain  19340.1020
    ## 91   1982                  Bahrain  19211.1473
    ## 92   1987                  Bahrain  18524.0241
    ## 93   1992                  Bahrain  19035.5792
    ## 94   1997                  Bahrain  20292.0168
    ## 95   2002                  Bahrain  23403.5593
    ## 96   2007                  Bahrain  29796.0483
    ## 97   1952               Bangladesh    684.2442
    ## 98   1957               Bangladesh    661.6375
    ## 99   1962               Bangladesh    686.3416
    ## 100  1967               Bangladesh    721.1861
    ## 101  1972               Bangladesh    630.2336
    ## 102  1977               Bangladesh    659.8772
    ## 103  1982               Bangladesh    676.9819
    ## 104  1987               Bangladesh    751.9794
    ## 105  1992               Bangladesh    837.8102
    ## 106  1997               Bangladesh    972.7700
    ## 107  2002               Bangladesh   1136.3904
    ## 108  2007               Bangladesh   1391.2538
    ## 109  1952                  Belgium   8343.1051
    ## 110  1957                  Belgium   9714.9606
    ## 111  1962                  Belgium  10991.2068
    ## 112  1967                  Belgium  13149.0412
    ## 113  1972                  Belgium  16672.1436
    ## 114  1977                  Belgium  19117.9745
    ## 115  1982                  Belgium  20979.8459
    ## 116  1987                  Belgium  22525.5631
    ## 117  1992                  Belgium  25575.5707
    ## 118  1997                  Belgium  27561.1966
    ## 119  2002                  Belgium  30485.8838
    ## 120  2007                  Belgium  33692.6051
    ## 121  1952                    Benin   1062.7522
    ## 122  1957                    Benin    959.6011
    ## 123  1962                    Benin    949.4991
    ## 124  1967                    Benin   1035.8314
    ## 125  1972                    Benin   1085.7969
    ## 126  1977                    Benin   1029.1613
    ## 127  1982                    Benin   1277.8976
    ## 128  1987                    Benin   1225.8560
    ## 129  1992                    Benin   1191.2077
    ## 130  1997                    Benin   1232.9753
    ## 131  2002                    Benin   1372.8779
    ## 132  2007                    Benin   1441.2849
    ## 133  1952                  Bolivia   2677.3263
    ## 134  1957                  Bolivia   2127.6863
    ## 135  1962                  Bolivia   2180.9725
    ## 136  1967                  Bolivia   2586.8861
    ## 137  1972                  Bolivia   2980.3313
    ## 138  1977                  Bolivia   3548.0978
    ## 139  1982                  Bolivia   3156.5105
    ## 140  1987                  Bolivia   2753.6915
    ## 141  1992                  Bolivia   2961.6997
    ## 142  1997                  Bolivia   3326.1432
    ## 143  2002                  Bolivia   3413.2627
    ## 144  2007                  Bolivia   3822.1371
    ## 145  1952   Bosnia and Herzegovina    973.5332
    ## 146  1957   Bosnia and Herzegovina   1353.9892
    ## 147  1962   Bosnia and Herzegovina   1709.6837
    ## 148  1967   Bosnia and Herzegovina   2172.3524
    ## 149  1972   Bosnia and Herzegovina   2860.1698
    ## 150  1977   Bosnia and Herzegovina   3528.4813
    ## 151  1982   Bosnia and Herzegovina   4126.6132
    ## 152  1987   Bosnia and Herzegovina   4314.1148
    ## 153  1992   Bosnia and Herzegovina   2546.7814
    ## 154  1997   Bosnia and Herzegovina   4766.3559
    ## 155  2002   Bosnia and Herzegovina   6018.9752
    ## 156  2007   Bosnia and Herzegovina   7446.2988
    ## 157  1952                 Botswana    851.2411
    ## 158  1957                 Botswana    918.2325
    ## 159  1962                 Botswana    983.6540
    ## 160  1967                 Botswana   1214.7093
    ## 161  1972                 Botswana   2263.6111
    ## 162  1977                 Botswana   3214.8578
    ## 163  1982                 Botswana   4551.1421
    ## 164  1987                 Botswana   6205.8839
    ## 165  1992                 Botswana   7954.1116
    ## 166  1997                 Botswana   8647.1423
    ## 167  2002                 Botswana  11003.6051
    ## 168  2007                 Botswana  12569.8518
    ## 169  1952                   Brazil   2108.9444
    ## 170  1957                   Brazil   2487.3660
    ## 171  1962                   Brazil   3336.5858
    ## 172  1967                   Brazil   3429.8644
    ## 173  1972                   Brazil   4985.7115
    ## 174  1977                   Brazil   6660.1187
    ## 175  1982                   Brazil   7030.8359
    ## 176  1987                   Brazil   7807.0958
    ## 177  1992                   Brazil   6950.2830
    ## 178  1997                   Brazil   7957.9808
    ## 179  2002                   Brazil   8131.2128
    ## 180  2007                   Brazil   9065.8008
    ## 181  1952                 Bulgaria   2444.2866
    ## 182  1957                 Bulgaria   3008.6707
    ## 183  1962                 Bulgaria   4254.3378
    ## 184  1967                 Bulgaria   5577.0028
    ## 185  1972                 Bulgaria   6597.4944
    ## 186  1977                 Bulgaria   7612.2404
    ## 187  1982                 Bulgaria   8224.1916
    ## 188  1987                 Bulgaria   8239.8548
    ## 189  1992                 Bulgaria   6302.6234
    ## 190  1997                 Bulgaria   5970.3888
    ## 191  2002                 Bulgaria   7696.7777
    ## 192  2007                 Bulgaria  10680.7928
    ## 193  1952             Burkina Faso    543.2552
    ## 194  1957             Burkina Faso    617.1835
    ## 195  1962             Burkina Faso    722.5120
    ## 196  1967             Burkina Faso    794.8266
    ## 197  1972             Burkina Faso    854.7360
    ## 198  1977             Burkina Faso    743.3870
    ## 199  1982             Burkina Faso    807.1986
    ## 200  1987             Burkina Faso    912.0631
    ## 201  1992             Burkina Faso    931.7528
    ## 202  1997             Burkina Faso    946.2950
    ## 203  2002             Burkina Faso   1037.6452
    ## 204  2007             Burkina Faso   1217.0330
    ## 205  1952                  Burundi    339.2965
    ## 206  1957                  Burundi    379.5646
    ## 207  1962                  Burundi    355.2032
    ## 208  1967                  Burundi    412.9775
    ## 209  1972                  Burundi    464.0995
    ## 210  1977                  Burundi    556.1033
    ## 211  1982                  Burundi    559.6032
    ## 212  1987                  Burundi    621.8188
    ## 213  1992                  Burundi    631.6999
    ## 214  1997                  Burundi    463.1151
    ## 215  2002                  Burundi    446.4035
    ## 216  2007                  Burundi    430.0707
    ## 217  1952                 Cambodia    368.4693
    ## 218  1957                 Cambodia    434.0383
    ## 219  1962                 Cambodia    496.9136
    ## 220  1967                 Cambodia    523.4323
    ## 221  1972                 Cambodia    421.6240
    ## 222  1977                 Cambodia    524.9722
    ## 223  1982                 Cambodia    624.4755
    ## 224  1987                 Cambodia    683.8956
    ## 225  1992                 Cambodia    682.3032
    ## 226  1997                 Cambodia    734.2852
    ## 227  2002                 Cambodia    896.2260
    ## 228  2007                 Cambodia   1713.7787
    ## 229  1952                 Cameroon   1172.6677
    ## 230  1957                 Cameroon   1313.0481
    ## 231  1962                 Cameroon   1399.6074
    ## 232  1967                 Cameroon   1508.4531
    ## 233  1972                 Cameroon   1684.1465
    ## 234  1977                 Cameroon   1783.4329
    ## 235  1982                 Cameroon   2367.9833
    ## 236  1987                 Cameroon   2602.6642
    ## 237  1992                 Cameroon   1793.1633
    ## 238  1997                 Cameroon   1694.3375
    ## 239  2002                 Cameroon   1934.0114
    ## 240  2007                 Cameroon   2042.0952
    ## 241  1952                   Canada  11367.1611
    ## 242  1957                   Canada  12489.9501
    ## 243  1962                   Canada  13462.4855
    ## 244  1967                   Canada  16076.5880
    ## 245  1972                   Canada  18970.5709
    ## 246  1977                   Canada  22090.8831
    ## 247  1982                   Canada  22898.7921
    ## 248  1987                   Canada  26626.5150
    ## 249  1992                   Canada  26342.8843
    ## 250  1997                   Canada  28954.9259
    ## 251  2002                   Canada  33328.9651
    ## 252  2007                   Canada  36319.2350
    ## 253  1952 Central African Republic   1071.3107
    ## 254  1957 Central African Republic   1190.8443
    ## 255  1962 Central African Republic   1193.0688
    ## 256  1967 Central African Republic   1136.0566
    ## 257  1972 Central African Republic   1070.0133
    ## 258  1977 Central African Republic   1109.3743
    ## 259  1982 Central African Republic    956.7530
    ## 260  1987 Central African Republic    844.8764
    ## 261  1992 Central African Republic    747.9055
    ## 262  1997 Central African Republic    740.5063
    ## 263  2002 Central African Republic    738.6906
    ## 264  2007 Central African Republic    706.0165
    ## 265  1952                     Chad   1178.6659
    ## 266  1957                     Chad   1308.4956
    ## 267  1962                     Chad   1389.8176
    ## 268  1967                     Chad   1196.8106
    ## 269  1972                     Chad   1104.1040
    ## 270  1977                     Chad   1133.9850
    ## 271  1982                     Chad    797.9081
    ## 272  1987                     Chad    952.3861
    ## 273  1992                     Chad   1058.0643
    ## 274  1997                     Chad   1004.9614
    ## 275  2002                     Chad   1156.1819
    ## 276  2007                     Chad   1704.0637
    ## 277  1952                    Chile   3939.9788
    ## 278  1957                    Chile   4315.6227
    ## 279  1962                    Chile   4519.0943
    ## 280  1967                    Chile   5106.6543
    ## 281  1972                    Chile   5494.0244
    ## 282  1977                    Chile   4756.7638
    ## 283  1982                    Chile   5095.6657
    ## 284  1987                    Chile   5547.0638
    ## 285  1992                    Chile   7596.1260
    ## 286  1997                    Chile  10118.0532
    ## 287  2002                    Chile  10778.7838
    ## 288  2007                    Chile  13171.6388
    ## 289  1952                    China    400.4486
    ## 290  1957                    China    575.9870
    ## 291  1962                    China    487.6740
    ## 292  1967                    China    612.7057
    ## 293  1972                    China    676.9001
    ## 294  1977                    China    741.2375
    ## 295  1982                    China    962.4214
    ## 296  1987                    China   1378.9040
    ## 297  1992                    China   1655.7842
    ## 298  1997                    China   2289.2341
    ## 299  2002                    China   3119.2809
    ## 300  2007                    China   4959.1149
    ## 301  1952                 Colombia   2144.1151
    ## 302  1957                 Colombia   2323.8056
    ## 303  1962                 Colombia   2492.3511
    ## 304  1967                 Colombia   2678.7298
    ## 305  1972                 Colombia   3264.6600
    ## 306  1977                 Colombia   3815.8079
    ## 307  1982                 Colombia   4397.5757
    ## 308  1987                 Colombia   4903.2191
    ## 309  1992                 Colombia   5444.6486
    ## 310  1997                 Colombia   6117.3617
    ## 311  2002                 Colombia   5755.2600
    ## 312  2007                 Colombia   7006.5804
    ## 313  1952                  Comoros   1102.9909
    ## 314  1957                  Comoros   1211.1485
    ## 315  1962                  Comoros   1406.6483
    ## 316  1967                  Comoros   1876.0296
    ## 317  1972                  Comoros   1937.5777
    ## 318  1977                  Comoros   1172.6030
    ## 319  1982                  Comoros   1267.1001
    ## 320  1987                  Comoros   1315.9808
    ## 321  1992                  Comoros   1246.9074
    ## 322  1997                  Comoros   1173.6182
    ## 323  2002                  Comoros   1075.8116
    ## 324  2007                  Comoros    986.1479
    ## 325  1952          Congo Dem. Rep.    780.5423
    ## 326  1957          Congo Dem. Rep.    905.8602
    ## 327  1962          Congo Dem. Rep.    896.3146
    ## 328  1967          Congo Dem. Rep.    861.5932
    ## 329  1972          Congo Dem. Rep.    904.8961
    ## 330  1977          Congo Dem. Rep.    795.7573
    ## 331  1982          Congo Dem. Rep.    673.7478
    ## 332  1987          Congo Dem. Rep.    672.7748
    ## 333  1992          Congo Dem. Rep.    457.7192
    ## 334  1997          Congo Dem. Rep.    312.1884
    ## 335  2002          Congo Dem. Rep.    241.1659
    ## 336  2007          Congo Dem. Rep.    277.5519
    ## 337  1952               Congo Rep.   2125.6214
    ## 338  1957               Congo Rep.   2315.0566
    ## 339  1962               Congo Rep.   2464.7832
    ## 340  1967               Congo Rep.   2677.9396
    ## 341  1972               Congo Rep.   3213.1527
    ## 342  1977               Congo Rep.   3259.1790
    ## 343  1982               Congo Rep.   4879.5075
    ## 344  1987               Congo Rep.   4201.1949
    ## 345  1992               Congo Rep.   4016.2395
    ## 346  1997               Congo Rep.   3484.1644
    ## 347  2002               Congo Rep.   3484.0620
    ## 348  2007               Congo Rep.   3632.5578
    ## 349  1952               Costa Rica   2627.0095
    ## 350  1957               Costa Rica   2990.0108
    ## 351  1962               Costa Rica   3460.9370
    ## 352  1967               Costa Rica   4161.7278
    ## 353  1972               Costa Rica   5118.1469
    ## 354  1977               Costa Rica   5926.8770
    ## 355  1982               Costa Rica   5262.7348
    ## 356  1987               Costa Rica   5629.9153
    ## 357  1992               Costa Rica   6160.4163
    ## 358  1997               Costa Rica   6677.0453
    ## 359  2002               Costa Rica   7723.4472
    ## 360  2007               Costa Rica   9645.0614
    ## 361  1952            Cote d'Ivoire   1388.5947
    ## 362  1957            Cote d'Ivoire   1500.8959
    ## 363  1962            Cote d'Ivoire   1728.8694
    ## 364  1967            Cote d'Ivoire   2052.0505
    ## 365  1972            Cote d'Ivoire   2378.2011
    ## 366  1977            Cote d'Ivoire   2517.7365
    ## 367  1982            Cote d'Ivoire   2602.7102
    ## 368  1987            Cote d'Ivoire   2156.9561
    ## 369  1992            Cote d'Ivoire   1648.0738
    ## 370  1997            Cote d'Ivoire   1786.2654
    ## 371  2002            Cote d'Ivoire   1648.8008
    ## 372  2007            Cote d'Ivoire   1544.7501
    ## 373  1952                  Croatia   3119.2365
    ## 374  1957                  Croatia   4338.2316
    ## 375  1962                  Croatia   5477.8900
    ## 376  1967                  Croatia   6960.2979
    ## 377  1972                  Croatia   9164.0901
    ## 378  1977                  Croatia  11305.3852
    ## 379  1982                  Croatia  13221.8218
    ## 380  1987                  Croatia  13822.5839
    ## 381  1992                  Croatia   8447.7949
    ## 382  1997                  Croatia   9875.6045
    ## 383  2002                  Croatia  11628.3890
    ## 384  2007                  Croatia  14619.2227
    ## 385  1952                     Cuba   5586.5388
    ## 386  1957                     Cuba   6092.1744
    ## 387  1962                     Cuba   5180.7559
    ## 388  1967                     Cuba   5690.2680
    ## 389  1972                     Cuba   5305.4453
    ## 390  1977                     Cuba   6380.4950
    ## 391  1982                     Cuba   7316.9181
    ## 392  1987                     Cuba   7532.9248
    ## 393  1992                     Cuba   5592.8440
    ## 394  1997                     Cuba   5431.9904
    ## 395  2002                     Cuba   6340.6467
    ## 396  2007                     Cuba   8948.1029
    ## 397  1952           Czech Republic   6876.1403
    ## 398  1957           Czech Republic   8256.3439
    ## 399  1962           Czech Republic  10136.8671
    ## 400  1967           Czech Republic  11399.4449
    ## 401  1972           Czech Republic  13108.4536
    ## 402  1977           Czech Republic  14800.1606
    ## 403  1982           Czech Republic  15377.2285
    ## 404  1987           Czech Republic  16310.4434
    ## 405  1992           Czech Republic  14297.0212
    ## 406  1997           Czech Republic  16048.5142
    ## 407  2002           Czech Republic  17596.2102
    ## 408  2007           Czech Republic  22833.3085
    ## 409  1952                  Denmark   9692.3852
    ## 410  1957                  Denmark  11099.6593
    ## 411  1962                  Denmark  13583.3135
    ## 412  1967                  Denmark  15937.2112
    ## 413  1972                  Denmark  18866.2072
    ## 414  1977                  Denmark  20422.9015
    ## 415  1982                  Denmark  21688.0405
    ## 416  1987                  Denmark  25116.1758
    ## 417  1992                  Denmark  26406.7399
    ## 418  1997                  Denmark  29804.3457
    ## 419  2002                  Denmark  32166.5001
    ## 420  2007                  Denmark  35278.4187
    ## 421  1952                 Djibouti   2669.5295
    ## 422  1957                 Djibouti   2864.9691
    ## 423  1962                 Djibouti   3020.9893
    ## 424  1967                 Djibouti   3020.0505
    ## 425  1972                 Djibouti   3694.2124
    ## 426  1977                 Djibouti   3081.7610
    ## 427  1982                 Djibouti   2879.4681
    ## 428  1987                 Djibouti   2880.1026
    ## 429  1992                 Djibouti   2377.1562
    ## 430  1997                 Djibouti   1895.0170
    ## 431  2002                 Djibouti   1908.2609
    ## 432  2007                 Djibouti   2082.4816
    ## 433  1952       Dominican Republic   1397.7171
    ## 434  1957       Dominican Republic   1544.4030
    ## 435  1962       Dominican Republic   1662.1374
    ## 436  1967       Dominican Republic   1653.7230
    ## 437  1972       Dominican Republic   2189.8745
    ## 438  1977       Dominican Republic   2681.9889
    ## 439  1982       Dominican Republic   2861.0924
    ## 440  1987       Dominican Republic   2899.8422
    ## 441  1992       Dominican Republic   3044.2142
    ## 442  1997       Dominican Republic   3614.1013
    ## 443  2002       Dominican Republic   4563.8082
    ## 444  2007       Dominican Republic   6025.3748
    ## 445  1952                  Ecuador   3522.1107
    ## 446  1957                  Ecuador   3780.5467
    ## 447  1962                  Ecuador   4086.1141
    ## 448  1967                  Ecuador   4579.0742
    ## 449  1972                  Ecuador   5280.9947
    ## 450  1977                  Ecuador   6679.6233
    ## 451  1982                  Ecuador   7213.7913
    ## 452  1987                  Ecuador   6481.7770
    ## 453  1992                  Ecuador   7103.7026
    ## 454  1997                  Ecuador   7429.4559
    ## 455  2002                  Ecuador   5773.0445
    ## 456  2007                  Ecuador   6873.2623
    ## 457  1952                    Egypt   1418.8224
    ## 458  1957                    Egypt   1458.9153
    ## 459  1962                    Egypt   1693.3359
    ## 460  1967                    Egypt   1814.8807
    ## 461  1972                    Egypt   2024.0081
    ## 462  1977                    Egypt   2785.4936
    ## 463  1982                    Egypt   3503.7296
    ## 464  1987                    Egypt   3885.4607
    ## 465  1992                    Egypt   3794.7552
    ## 466  1997                    Egypt   4173.1818
    ## 467  2002                    Egypt   4754.6044
    ## 468  2007                    Egypt   5581.1810
    ## 469  1952              El Salvador   3048.3029
    ## 470  1957              El Salvador   3421.5232
    ## 471  1962              El Salvador   3776.8036
    ## 472  1967              El Salvador   4358.5954
    ## 473  1972              El Salvador   4520.2460
    ## 474  1977              El Salvador   5138.9224
    ## 475  1982              El Salvador   4098.3442
    ## 476  1987              El Salvador   4140.4421
    ## 477  1992              El Salvador   4444.2317
    ## 478  1997              El Salvador   5154.8255
    ## 479  2002              El Salvador   5351.5687
    ## 480  2007              El Salvador   5728.3535
    ## 481  1952        Equatorial Guinea    375.6431
    ## 482  1957        Equatorial Guinea    426.0964
    ## 483  1962        Equatorial Guinea    582.8420
    ## 484  1967        Equatorial Guinea    915.5960
    ## 485  1972        Equatorial Guinea    672.4123
    ## 486  1977        Equatorial Guinea    958.5668
    ## 487  1982        Equatorial Guinea    927.8253
    ## 488  1987        Equatorial Guinea    966.8968
    ## 489  1992        Equatorial Guinea   1132.0550
    ## 490  1997        Equatorial Guinea   2814.4808
    ## 491  2002        Equatorial Guinea   7703.4959
    ## 492  2007        Equatorial Guinea  12154.0897
    ## 493  1952                  Eritrea    328.9406
    ## 494  1957                  Eritrea    344.1619
    ## 495  1962                  Eritrea    380.9958
    ## 496  1967                  Eritrea    468.7950
    ## 497  1972                  Eritrea    514.3242
    ## 498  1977                  Eritrea    505.7538
    ## 499  1982                  Eritrea    524.8758
    ## 500  1987                  Eritrea    521.1341
    ## 501  1992                  Eritrea    582.8585
    ## 502  1997                  Eritrea    913.4708
    ## 503  2002                  Eritrea    765.3500
    ## 504  2007                  Eritrea    641.3695
    ## 505  1952                 Ethiopia    362.1463
    ## 506  1957                 Ethiopia    378.9042
    ## 507  1962                 Ethiopia    419.4564
    ## 508  1967                 Ethiopia    516.1186
    ## 509  1972                 Ethiopia    566.2439
    ## 510  1977                 Ethiopia    556.8084
    ## 511  1982                 Ethiopia    577.8607
    ## 512  1987                 Ethiopia    573.7413
    ## 513  1992                 Ethiopia    421.3535
    ## 514  1997                 Ethiopia    515.8894
    ## 515  2002                 Ethiopia    530.0535
    ## 516  2007                 Ethiopia    690.8056
    ## 517  1952                  Finland   6424.5191
    ## 518  1957                  Finland   7545.4154
    ## 519  1962                  Finland   9371.8426
    ## 520  1967                  Finland  10921.6363
    ## 521  1972                  Finland  14358.8759
    ## 522  1977                  Finland  15605.4228
    ## 523  1982                  Finland  18533.1576
    ## 524  1987                  Finland  21141.0122
    ## 525  1992                  Finland  20647.1650
    ## 526  1997                  Finland  23723.9502
    ## 527  2002                  Finland  28204.5906
    ## 528  2007                  Finland  33207.0844
    ## 529  1952                   France   7029.8093
    ## 530  1957                   France   8662.8349
    ## 531  1962                   France  10560.4855
    ## 532  1967                   France  12999.9177
    ## 533  1972                   France  16107.1917
    ## 534  1977                   France  18292.6351
    ## 535  1982                   France  20293.8975
    ## 536  1987                   France  22066.4421
    ## 537  1992                   France  24703.7961
    ## 538  1997                   France  25889.7849
    ## 539  2002                   France  28926.0323
    ## 540  2007                   France  30470.0167
    ## 541  1952                    Gabon   4293.4765
    ## 542  1957                    Gabon   4976.1981
    ## 543  1962                    Gabon   6631.4592
    ## 544  1967                    Gabon   8358.7620
    ## 545  1972                    Gabon  11401.9484
    ## 546  1977                    Gabon  21745.5733
    ## 547  1982                    Gabon  15113.3619
    ## 548  1987                    Gabon  11864.4084
    ## 549  1992                    Gabon  13522.1575
    ## 550  1997                    Gabon  14722.8419
    ## 551  2002                    Gabon  12521.7139
    ## 552  2007                    Gabon  13206.4845
    ## 553  1952                   Gambia    485.2307
    ## 554  1957                   Gambia    520.9267
    ## 555  1962                   Gambia    599.6503
    ## 556  1967                   Gambia    734.7829
    ## 557  1972                   Gambia    756.0868
    ## 558  1977                   Gambia    884.7553
    ## 559  1982                   Gambia    835.8096
    ## 560  1987                   Gambia    611.6589
    ## 561  1992                   Gambia    665.6244
    ## 562  1997                   Gambia    653.7302
    ## 563  2002                   Gambia    660.5856
    ## 564  2007                   Gambia    752.7497
    ## 565  1952                  Germany   7144.1144
    ## 566  1957                  Germany  10187.8267
    ## 567  1962                  Germany  12902.4629
    ## 568  1967                  Germany  14745.6256
    ## 569  1972                  Germany  18016.1803
    ## 570  1977                  Germany  20512.9212
    ## 571  1982                  Germany  22031.5327
    ## 572  1987                  Germany  24639.1857
    ## 573  1992                  Germany  26505.3032
    ## 574  1997                  Germany  27788.8842
    ## 575  2002                  Germany  30035.8020
    ## 576  2007                  Germany  32170.3744
    ## 577  1952                    Ghana    911.2989
    ## 578  1957                    Ghana   1043.5615
    ## 579  1962                    Ghana   1190.0411
    ## 580  1967                    Ghana   1125.6972
    ## 581  1972                    Ghana   1178.2237
    ## 582  1977                    Ghana    993.2240
    ## 583  1982                    Ghana    876.0326
    ## 584  1987                    Ghana    847.0061
    ## 585  1992                    Ghana    925.0602
    ## 586  1997                    Ghana   1005.2458
    ## 587  2002                    Ghana   1111.9846
    ## 588  2007                    Ghana   1327.6089
    ## 589  1952                   Greece   3530.6901
    ## 590  1957                   Greece   4916.2999
    ## 591  1962                   Greece   6017.1907
    ## 592  1967                   Greece   8513.0970
    ## 593  1972                   Greece  12724.8296
    ## 594  1977                   Greece  14195.5243
    ## 595  1982                   Greece  15268.4209
    ## 596  1987                   Greece  16120.5284
    ## 597  1992                   Greece  17541.4963
    ## 598  1997                   Greece  18747.6981
    ## 599  2002                   Greece  22514.2548
    ## 600  2007                   Greece  27538.4119
    ## 601  1952                Guatemala   2428.2378
    ## 602  1957                Guatemala   2617.1560
    ## 603  1962                Guatemala   2750.3644
    ## 604  1967                Guatemala   3242.5311
    ## 605  1972                Guatemala   4031.4083
    ## 606  1977                Guatemala   4879.9927
    ## 607  1982                Guatemala   4820.4948
    ## 608  1987                Guatemala   4246.4860
    ## 609  1992                Guatemala   4439.4508
    ## 610  1997                Guatemala   4684.3138
    ## 611  2002                Guatemala   4858.3475
    ## 612  2007                Guatemala   5186.0500
    ## 613  1952                   Guinea    510.1965
    ## 614  1957                   Guinea    576.2670
    ## 615  1962                   Guinea    686.3737
    ## 616  1967                   Guinea    708.7595
    ## 617  1972                   Guinea    741.6662
    ## 618  1977                   Guinea    874.6859
    ## 619  1982                   Guinea    857.2504
    ## 620  1987                   Guinea    805.5725
    ## 621  1992                   Guinea    794.3484
    ## 622  1997                   Guinea    869.4498
    ## 623  2002                   Guinea    945.5836
    ## 624  2007                   Guinea    942.6542
    ## 625  1952            Guinea-Bissau    299.8503
    ## 626  1957            Guinea-Bissau    431.7905
    ## 627  1962            Guinea-Bissau    522.0344
    ## 628  1967            Guinea-Bissau    715.5806
    ## 629  1972            Guinea-Bissau    820.2246
    ## 630  1977            Guinea-Bissau    764.7260
    ## 631  1982            Guinea-Bissau    838.1240
    ## 632  1987            Guinea-Bissau    736.4154
    ## 633  1992            Guinea-Bissau    745.5399
    ## 634  1997            Guinea-Bissau    796.6645
    ## 635  2002            Guinea-Bissau    575.7047
    ## 636  2007            Guinea-Bissau    579.2317
    ## 637  1952                    Haiti   1840.3669
    ## 638  1957                    Haiti   1726.8879
    ## 639  1962                    Haiti   1796.5890
    ## 640  1967                    Haiti   1452.0577
    ## 641  1972                    Haiti   1654.4569
    ## 642  1977                    Haiti   1874.2989
    ## 643  1982                    Haiti   2011.1595
    ## 644  1987                    Haiti   1823.0160
    ## 645  1992                    Haiti   1456.3095
    ## 646  1997                    Haiti   1341.7269
    ## 647  2002                    Haiti   1270.3649
    ## 648  2007                    Haiti   1201.6372
    ## 649  1952                 Honduras   2194.9262
    ## 650  1957                 Honduras   2220.4877
    ## 651  1962                 Honduras   2291.1568
    ## 652  1967                 Honduras   2538.2694
    ## 653  1972                 Honduras   2529.8423
    ## 654  1977                 Honduras   3203.2081
    ## 655  1982                 Honduras   3121.7608
    ## 656  1987                 Honduras   3023.0967
    ## 657  1992                 Honduras   3081.6946
    ## 658  1997                 Honduras   3160.4549
    ## 659  2002                 Honduras   3099.7287
    ## 660  2007                 Honduras   3548.3308
    ## 661  1952          Hong Kong China   3054.4212
    ## 662  1957          Hong Kong China   3629.0765
    ## 663  1962          Hong Kong China   4692.6483
    ## 664  1967          Hong Kong China   6197.9628
    ## 665  1972          Hong Kong China   8315.9281
    ## 666  1977          Hong Kong China  11186.1413
    ## 667  1982          Hong Kong China  14560.5305
    ## 668  1987          Hong Kong China  20038.4727
    ## 669  1992          Hong Kong China  24757.6030
    ## 670  1997          Hong Kong China  28377.6322
    ## 671  2002          Hong Kong China  30209.0152
    ## 672  2007          Hong Kong China  39724.9787
    ## 673  1952                  Hungary   5263.6738
    ## 674  1957                  Hungary   6040.1800
    ## 675  1962                  Hungary   7550.3599
    ## 676  1967                  Hungary   9326.6447
    ## 677  1972                  Hungary  10168.6561
    ## 678  1977                  Hungary  11674.8374
    ## 679  1982                  Hungary  12545.9907
    ## 680  1987                  Hungary  12986.4800
    ## 681  1992                  Hungary  10535.6285
    ## 682  1997                  Hungary  11712.7768
    ## 683  2002                  Hungary  14843.9356
    ## 684  2007                  Hungary  18008.9444
    ## 685  1952                  Iceland   7267.6884
    ## 686  1957                  Iceland   9244.0014
    ## 687  1962                  Iceland  10350.1591
    ## 688  1967                  Iceland  13319.8957
    ## 689  1972                  Iceland  15798.0636
    ## 690  1977                  Iceland  19654.9625
    ## 691  1982                  Iceland  23269.6075
    ## 692  1987                  Iceland  26923.2063
    ## 693  1992                  Iceland  25144.3920
    ## 694  1997                  Iceland  28061.0997
    ## 695  2002                  Iceland  31163.2020
    ## 696  2007                  Iceland  36180.7892
    ## 697  1952                    India    546.5657
    ## 698  1957                    India    590.0620
    ## 699  1962                    India    658.3472
    ## 700  1967                    India    700.7706
    ## 701  1972                    India    724.0325
    ## 702  1977                    India    813.3373
    ## 703  1982                    India    855.7235
    ## 704  1987                    India    976.5127
    ## 705  1992                    India   1164.4068
    ## 706  1997                    India   1458.8174
    ## 707  2002                    India   1746.7695
    ## 708  2007                    India   2452.2104
    ## 709  1952                Indonesia    749.6817
    ## 710  1957                Indonesia    858.9003
    ## 711  1962                Indonesia    849.2898
    ## 712  1967                Indonesia    762.4318
    ## 713  1972                Indonesia   1111.1079
    ## 714  1977                Indonesia   1382.7021
    ## 715  1982                Indonesia   1516.8730
    ## 716  1987                Indonesia   1748.3570
    ## 717  1992                Indonesia   2383.1409
    ## 718  1997                Indonesia   3119.3356
    ## 719  2002                Indonesia   2873.9129
    ## 720  2007                Indonesia   3540.6516
    ## 721  1952                     Iran   3035.3260
    ## 722  1957                     Iran   3290.2576
    ## 723  1962                     Iran   4187.3298
    ## 724  1967                     Iran   5906.7318
    ## 725  1972                     Iran   9613.8186
    ## 726  1977                     Iran  11888.5951
    ## 727  1982                     Iran   7608.3346
    ## 728  1987                     Iran   6642.8814
    ## 729  1992                     Iran   7235.6532
    ## 730  1997                     Iran   8263.5903
    ## 731  2002                     Iran   9240.7620
    ## 732  2007                     Iran  11605.7145
    ## 733  1952                     Iraq   4129.7661
    ## 734  1957                     Iraq   6229.3336
    ## 735  1962                     Iraq   8341.7378
    ## 736  1967                     Iraq   8931.4598
    ## 737  1972                     Iraq   9576.0376
    ## 738  1977                     Iraq  14688.2351
    ## 739  1982                     Iraq  14517.9071
    ## 740  1987                     Iraq  11643.5727
    ## 741  1992                     Iraq   3745.6407
    ## 742  1997                     Iraq   3076.2398
    ## 743  2002                     Iraq   4390.7173
    ## 744  2007                     Iraq   4471.0619
    ## 745  1952                  Ireland   5210.2803
    ## 746  1957                  Ireland   5599.0779
    ## 747  1962                  Ireland   6631.5973
    ## 748  1967                  Ireland   7655.5690
    ## 749  1972                  Ireland   9530.7729
    ## 750  1977                  Ireland  11150.9811
    ## 751  1982                  Ireland  12618.3214
    ## 752  1987                  Ireland  13872.8665
    ## 753  1992                  Ireland  17558.8155
    ## 754  1997                  Ireland  24521.9471
    ## 755  2002                  Ireland  34077.0494
    ## 756  2007                  Ireland  40675.9964
    ## 757  1952                   Israel   4086.5221
    ## 758  1957                   Israel   5385.2785
    ## 759  1962                   Israel   7105.6307
    ## 760  1967                   Israel   8393.7414
    ## 761  1972                   Israel  12786.9322
    ## 762  1977                   Israel  13306.6192
    ## 763  1982                   Israel  15367.0292
    ## 764  1987                   Israel  17122.4799
    ## 765  1992                   Israel  18051.5225
    ## 766  1997                   Israel  20896.6092
    ## 767  2002                   Israel  21905.5951
    ## 768  2007                   Israel  25523.2771
    ## 769  1952                    Italy   4931.4042
    ## 770  1957                    Italy   6248.6562
    ## 771  1962                    Italy   8243.5823
    ## 772  1967                    Italy  10022.4013
    ## 773  1972                    Italy  12269.2738
    ## 774  1977                    Italy  14255.9847
    ## 775  1982                    Italy  16537.4835
    ## 776  1987                    Italy  19207.2348
    ## 777  1992                    Italy  22013.6449
    ## 778  1997                    Italy  24675.0245
    ## 779  2002                    Italy  27968.0982
    ## 780  2007                    Italy  28569.7197
    ## 781  1952                  Jamaica   2898.5309
    ## 782  1957                  Jamaica   4756.5258
    ## 783  1962                  Jamaica   5246.1075
    ## 784  1967                  Jamaica   6124.7035
    ## 785  1972                  Jamaica   7433.8893
    ## 786  1977                  Jamaica   6650.1956
    ## 787  1982                  Jamaica   6068.0513
    ## 788  1987                  Jamaica   6351.2375
    ## 789  1992                  Jamaica   7404.9237
    ## 790  1997                  Jamaica   7121.9247
    ## 791  2002                  Jamaica   6994.7749
    ## 792  2007                  Jamaica   7320.8803
    ## 793  1952                    Japan   3216.9563
    ## 794  1957                    Japan   4317.6944
    ## 795  1962                    Japan   6576.6495
    ## 796  1967                    Japan   9847.7886
    ## 797  1972                    Japan  14778.7864
    ## 798  1977                    Japan  16610.3770
    ## 799  1982                    Japan  19384.1057
    ## 800  1987                    Japan  22375.9419
    ## 801  1992                    Japan  26824.8951
    ## 802  1997                    Japan  28816.5850
    ## 803  2002                    Japan  28604.5919
    ## 804  2007                    Japan  31656.0681
    ## 805  1952                   Jordan   1546.9078
    ## 806  1957                   Jordan   1886.0806
    ## 807  1962                   Jordan   2348.0092
    ## 808  1967                   Jordan   2741.7963
    ## 809  1972                   Jordan   2110.8563
    ## 810  1977                   Jordan   2852.3516
    ## 811  1982                   Jordan   4161.4160
    ## 812  1987                   Jordan   4448.6799
    ## 813  1992                   Jordan   3431.5936
    ## 814  1997                   Jordan   3645.3796
    ## 815  2002                   Jordan   3844.9172
    ## 816  2007                   Jordan   4519.4612
    ## 817  1952                    Kenya    853.5409
    ## 818  1957                    Kenya    944.4383
    ## 819  1962                    Kenya    896.9664
    ## 820  1967                    Kenya   1056.7365
    ## 821  1972                    Kenya   1222.3600
    ## 822  1977                    Kenya   1267.6132
    ## 823  1982                    Kenya   1348.2258
    ## 824  1987                    Kenya   1361.9369
    ## 825  1992                    Kenya   1341.9217
    ## 826  1997                    Kenya   1360.4850
    ## 827  2002                    Kenya   1287.5147
    ## 828  2007                    Kenya   1463.2493
    ## 829  1952          Korea Dem. Rep.   1088.2778
    ## 830  1957          Korea Dem. Rep.   1571.1347
    ## 831  1962          Korea Dem. Rep.   1621.6936
    ## 832  1967          Korea Dem. Rep.   2143.5406
    ## 833  1972          Korea Dem. Rep.   3701.6215
    ## 834  1977          Korea Dem. Rep.   4106.3012
    ## 835  1982          Korea Dem. Rep.   4106.5253
    ## 836  1987          Korea Dem. Rep.   4106.4923
    ## 837  1992          Korea Dem. Rep.   3726.0635
    ## 838  1997          Korea Dem. Rep.   1690.7568
    ## 839  2002          Korea Dem. Rep.   1646.7582
    ## 840  2007          Korea Dem. Rep.   1593.0655
    ## 841  1952               Korea Rep.   1030.5922
    ## 842  1957               Korea Rep.   1487.5935
    ## 843  1962               Korea Rep.   1536.3444
    ## 844  1967               Korea Rep.   2029.2281
    ## 845  1972               Korea Rep.   3030.8767
    ## 846  1977               Korea Rep.   4657.2210
    ## 847  1982               Korea Rep.   5622.9425
    ## 848  1987               Korea Rep.   8533.0888
    ## 849  1992               Korea Rep.  12104.2787
    ## 850  1997               Korea Rep.  15993.5280
    ## 851  2002               Korea Rep.  19233.9882
    ## 852  2007               Korea Rep.  23348.1397
    ## 853  1952                   Kuwait 108382.3529
    ## 854  1957                   Kuwait 113523.1329
    ## 855  1962                   Kuwait  95458.1118
    ## 856  1967                   Kuwait  80894.8833
    ## 857  1972                   Kuwait 109347.8670
    ## 858  1977                   Kuwait  59265.4771
    ## 859  1982                   Kuwait  31354.0357
    ## 860  1987                   Kuwait  28118.4300
    ## 861  1992                   Kuwait  34932.9196
    ## 862  1997                   Kuwait  40300.6200
    ## 863  2002                   Kuwait  35110.1057
    ## 864  2007                   Kuwait  47306.9898
    ## 865  1952                  Lebanon   4834.8041
    ## 866  1957                  Lebanon   6089.7869
    ## 867  1962                  Lebanon   5714.5606
    ## 868  1967                  Lebanon   6006.9830
    ## 869  1972                  Lebanon   7486.3843
    ## 870  1977                  Lebanon   8659.6968
    ## 871  1982                  Lebanon   7640.5195
    ## 872  1987                  Lebanon   5377.0913
    ## 873  1992                  Lebanon   6890.8069
    ## 874  1997                  Lebanon   8754.9639
    ## 875  2002                  Lebanon   9313.9388
    ## 876  2007                  Lebanon  10461.0587
    ## 877  1952                  Lesotho    298.8462
    ## 878  1957                  Lesotho    335.9971
    ## 879  1962                  Lesotho    411.8006
    ## 880  1967                  Lesotho    498.6390
    ## 881  1972                  Lesotho    496.5816
    ## 882  1977                  Lesotho    745.3695
    ## 883  1982                  Lesotho    797.2631
    ## 884  1987                  Lesotho    773.9932
    ## 885  1992                  Lesotho    977.4863
    ## 886  1997                  Lesotho   1186.1480
    ## 887  2002                  Lesotho   1275.1846
    ## 888  2007                  Lesotho   1569.3314
    ## 889  1952                  Liberia    575.5730
    ## 890  1957                  Liberia    620.9700
    ## 891  1962                  Liberia    634.1952
    ## 892  1967                  Liberia    713.6036
    ## 893  1972                  Liberia    803.0055
    ## 894  1977                  Liberia    640.3224
    ## 895  1982                  Liberia    572.1996
    ## 896  1987                  Liberia    506.1139
    ## 897  1992                  Liberia    636.6229
    ## 898  1997                  Liberia    609.1740
    ## 899  2002                  Liberia    531.4824
    ## 900  2007                  Liberia    414.5073
    ## 901  1952                    Libya   2387.5481
    ## 902  1957                    Libya   3448.2844
    ## 903  1962                    Libya   6757.0308
    ## 904  1967                    Libya  18772.7517
    ## 905  1972                    Libya  21011.4972
    ## 906  1977                    Libya  21951.2118
    ## 907  1982                    Libya  17364.2754
    ## 908  1987                    Libya  11770.5898
    ## 909  1992                    Libya   9640.1385
    ## 910  1997                    Libya   9467.4461
    ## 911  2002                    Libya   9534.6775
    ## 912  2007                    Libya  12057.4993
    ## 913  1952               Madagascar   1443.0117
    ## 914  1957               Madagascar   1589.2027
    ## 915  1962               Madagascar   1643.3871
    ## 916  1967               Madagascar   1634.0473
    ## 917  1972               Madagascar   1748.5630
    ## 918  1977               Madagascar   1544.2286
    ## 919  1982               Madagascar   1302.8787
    ## 920  1987               Madagascar   1155.4419
    ## 921  1992               Madagascar   1040.6762
    ## 922  1997               Madagascar    986.2959
    ## 923  2002               Madagascar    894.6371
    ## 924  2007               Madagascar   1044.7701
    ## 925  1952                   Malawi    369.1651
    ## 926  1957                   Malawi    416.3698
    ## 927  1962                   Malawi    427.9011
    ## 928  1967                   Malawi    495.5148
    ## 929  1972                   Malawi    584.6220
    ## 930  1977                   Malawi    663.2237
    ## 931  1982                   Malawi    632.8039
    ## 932  1987                   Malawi    635.5174
    ## 933  1992                   Malawi    563.2000
    ## 934  1997                   Malawi    692.2758
    ## 935  2002                   Malawi    665.4231
    ## 936  2007                   Malawi    759.3499
    ## 937  1952                 Malaysia   1831.1329
    ## 938  1957                 Malaysia   1810.0670
    ## 939  1962                 Malaysia   2036.8849
    ## 940  1967                 Malaysia   2277.7424
    ## 941  1972                 Malaysia   2849.0948
    ## 942  1977                 Malaysia   3827.9216
    ## 943  1982                 Malaysia   4920.3560
    ## 944  1987                 Malaysia   5249.8027
    ## 945  1992                 Malaysia   7277.9128
    ## 946  1997                 Malaysia  10132.9096
    ## 947  2002                 Malaysia  10206.9779
    ## 948  2007                 Malaysia  12451.6558
    ## 949  1952                     Mali    452.3370
    ## 950  1957                     Mali    490.3822
    ## 951  1962                     Mali    496.1743
    ## 952  1967                     Mali    545.0099
    ## 953  1972                     Mali    581.3689
    ## 954  1977                     Mali    686.3953
    ## 955  1982                     Mali    618.0141
    ## 956  1987                     Mali    684.1716
    ## 957  1992                     Mali    739.0144
    ## 958  1997                     Mali    790.2580
    ## 959  2002                     Mali    951.4098
    ## 960  2007                     Mali   1042.5816
    ## 961  1952               Mauritania    743.1159
    ## 962  1957               Mauritania    846.1203
    ## 963  1962               Mauritania   1055.8960
    ## 964  1967               Mauritania   1421.1452
    ## 965  1972               Mauritania   1586.8518
    ## 966  1977               Mauritania   1497.4922
    ## 967  1982               Mauritania   1481.1502
    ## 968  1987               Mauritania   1421.6036
    ## 969  1992               Mauritania   1361.3698
    ## 970  1997               Mauritania   1483.1361
    ## 971  2002               Mauritania   1579.0195
    ## 972  2007               Mauritania   1803.1515
    ## 973  1952                Mauritius   1967.9557
    ## 974  1957                Mauritius   2034.0380
    ## 975  1962                Mauritius   2529.0675
    ## 976  1967                Mauritius   2475.3876
    ## 977  1972                Mauritius   2575.4842
    ## 978  1977                Mauritius   3710.9830
    ## 979  1982                Mauritius   3688.0377
    ## 980  1987                Mauritius   4783.5869
    ## 981  1992                Mauritius   6058.2538
    ## 982  1997                Mauritius   7425.7053
    ## 983  2002                Mauritius   9021.8159
    ## 984  2007                Mauritius  10956.9911
    ## 985  1952                   Mexico   3478.1255
    ## 986  1957                   Mexico   4131.5466
    ## 987  1962                   Mexico   4581.6094
    ## 988  1967                   Mexico   5754.7339
    ## 989  1972                   Mexico   6809.4067
    ## 990  1977                   Mexico   7674.9291
    ## 991  1982                   Mexico   9611.1475
    ## 992  1987                   Mexico   8688.1560
    ## 993  1992                   Mexico   9472.3843
    ## 994  1997                   Mexico   9767.2975
    ## 995  2002                   Mexico  10742.4405
    ## 996  2007                   Mexico  11977.5750
    ## 997  1952                 Mongolia    786.5669
    ## 998  1957                 Mongolia    912.6626
    ## 999  1962                 Mongolia   1056.3540
    ## 1000 1967                 Mongolia   1226.0411
    ## 1001 1972                 Mongolia   1421.7420
    ## 1002 1977                 Mongolia   1647.5117
    ## 1003 1982                 Mongolia   2000.6031
    ## 1004 1987                 Mongolia   2338.0083
    ## 1005 1992                 Mongolia   1785.4020
    ## 1006 1997                 Mongolia   1902.2521
    ## 1007 2002                 Mongolia   2140.7393
    ## 1008 2007                 Mongolia   3095.7723
    ## 1009 1952               Montenegro   2647.5856
    ## 1010 1957               Montenegro   3682.2599
    ## 1011 1962               Montenegro   4649.5938
    ## 1012 1967               Montenegro   5907.8509
    ## 1013 1972               Montenegro   7778.4140
    ## 1014 1977               Montenegro   9595.9299
    ## 1015 1982               Montenegro  11222.5876
    ## 1016 1987               Montenegro  11732.5102
    ## 1017 1992               Montenegro   7003.3390
    ## 1018 1997               Montenegro   6465.6133
    ## 1019 2002               Montenegro   6557.1943
    ## 1020 2007               Montenegro   9253.8961
    ## 1021 1952                  Morocco   1688.2036
    ## 1022 1957                  Morocco   1642.0023
    ## 1023 1962                  Morocco   1566.3535
    ## 1024 1967                  Morocco   1711.0448
    ## 1025 1972                  Morocco   1930.1950
    ## 1026 1977                  Morocco   2370.6200
    ## 1027 1982                  Morocco   2702.6204
    ## 1028 1987                  Morocco   2755.0470
    ## 1029 1992                  Morocco   2948.0473
    ## 1030 1997                  Morocco   2982.1019
    ## 1031 2002                  Morocco   3258.4956
    ## 1032 2007                  Morocco   3820.1752
    ## 1033 1952               Mozambique    468.5260
    ## 1034 1957               Mozambique    495.5868
    ## 1035 1962               Mozambique    556.6864
    ## 1036 1967               Mozambique    566.6692
    ## 1037 1972               Mozambique    724.9178
    ## 1038 1977               Mozambique    502.3197
    ## 1039 1982               Mozambique    462.2114
    ## 1040 1987               Mozambique    389.8762
    ## 1041 1992               Mozambique    410.8968
    ## 1042 1997               Mozambique    472.3461
    ## 1043 2002               Mozambique    633.6179
    ## 1044 2007               Mozambique    823.6856
    ## 1045 1952                  Myanmar    331.0000
    ## 1046 1957                  Myanmar    350.0000
    ## 1047 1962                  Myanmar    388.0000
    ## 1048 1967                  Myanmar    349.0000
    ## 1049 1972                  Myanmar    357.0000
    ## 1050 1977                  Myanmar    371.0000
    ## 1051 1982                  Myanmar    424.0000
    ## 1052 1987                  Myanmar    385.0000
    ## 1053 1992                  Myanmar    347.0000
    ## 1054 1997                  Myanmar    415.0000
    ## 1055 2002                  Myanmar    611.0000
    ## 1056 2007                  Myanmar    944.0000
    ## 1057 1952                  Namibia   2423.7804
    ## 1058 1957                  Namibia   2621.4481
    ## 1059 1962                  Namibia   3173.2156
    ## 1060 1967                  Namibia   3793.6948
    ## 1061 1972                  Namibia   3746.0809
    ## 1062 1977                  Namibia   3876.4860
    ## 1063 1982                  Namibia   4191.1005
    ## 1064 1987                  Namibia   3693.7313
    ## 1065 1992                  Namibia   3804.5380
    ## 1066 1997                  Namibia   3899.5243
    ## 1067 2002                  Namibia   4072.3248
    ## 1068 2007                  Namibia   4811.0604
    ## 1069 1952                    Nepal    545.8657
    ## 1070 1957                    Nepal    597.9364
    ## 1071 1962                    Nepal    652.3969
    ## 1072 1967                    Nepal    676.4422
    ## 1073 1972                    Nepal    674.7881
    ## 1074 1977                    Nepal    694.1124
    ## 1075 1982                    Nepal    718.3731
    ## 1076 1987                    Nepal    775.6325
    ## 1077 1992                    Nepal    897.7404
    ## 1078 1997                    Nepal   1010.8921
    ## 1079 2002                    Nepal   1057.2063
    ## 1080 2007                    Nepal   1091.3598
    ## 1081 1952              Netherlands   8941.5719
    ## 1082 1957              Netherlands  11276.1934
    ## 1083 1962              Netherlands  12790.8496
    ## 1084 1967              Netherlands  15363.2514
    ## 1085 1972              Netherlands  18794.7457
    ## 1086 1977              Netherlands  21209.0592
    ## 1087 1982              Netherlands  21399.4605
    ## 1088 1987              Netherlands  23651.3236
    ## 1089 1992              Netherlands  26790.9496
    ## 1090 1997              Netherlands  30246.1306
    ## 1091 2002              Netherlands  33724.7578
    ## 1092 2007              Netherlands  36797.9333
    ## 1093 1952              New Zealand  10556.5757
    ## 1094 1957              New Zealand  12247.3953
    ## 1095 1962              New Zealand  13175.6780
    ## 1096 1967              New Zealand  14463.9189
    ## 1097 1972              New Zealand  16046.0373
    ## 1098 1977              New Zealand  16233.7177
    ## 1099 1982              New Zealand  17632.4104
    ## 1100 1987              New Zealand  19007.1913
    ## 1101 1992              New Zealand  18363.3249
    ## 1102 1997              New Zealand  21050.4138
    ## 1103 2002              New Zealand  23189.8014
    ## 1104 2007              New Zealand  25185.0091
    ## 1105 1952                Nicaragua   3112.3639
    ## 1106 1957                Nicaragua   3457.4159
    ## 1107 1962                Nicaragua   3634.3644
    ## 1108 1967                Nicaragua   4643.3935
    ## 1109 1972                Nicaragua   4688.5933
    ## 1110 1977                Nicaragua   5486.3711
    ## 1111 1982                Nicaragua   3470.3382
    ## 1112 1987                Nicaragua   2955.9844
    ## 1113 1992                Nicaragua   2170.1517
    ## 1114 1997                Nicaragua   2253.0230
    ## 1115 2002                Nicaragua   2474.5488
    ## 1116 2007                Nicaragua   2749.3210
    ## 1117 1952                    Niger    761.8794
    ## 1118 1957                    Niger    835.5234
    ## 1119 1962                    Niger    997.7661
    ## 1120 1967                    Niger   1054.3849
    ## 1121 1972                    Niger    954.2092
    ## 1122 1977                    Niger    808.8971
    ## 1123 1982                    Niger    909.7221
    ## 1124 1987                    Niger    668.3000
    ## 1125 1992                    Niger    581.1827
    ## 1126 1997                    Niger    580.3052
    ## 1127 2002                    Niger    601.0745
    ## 1128 2007                    Niger    619.6769
    ## 1129 1952                  Nigeria   1077.2819
    ## 1130 1957                  Nigeria   1100.5926
    ## 1131 1962                  Nigeria   1150.9275
    ## 1132 1967                  Nigeria   1014.5141
    ## 1133 1972                  Nigeria   1698.3888
    ## 1134 1977                  Nigeria   1981.9518
    ## 1135 1982                  Nigeria   1576.9738
    ## 1136 1987                  Nigeria   1385.0296
    ## 1137 1992                  Nigeria   1619.8482
    ## 1138 1997                  Nigeria   1624.9413
    ## 1139 2002                  Nigeria   1615.2864
    ## 1140 2007                  Nigeria   2013.9773
    ## 1141 1952                   Norway  10095.4217
    ## 1142 1957                   Norway  11653.9730
    ## 1143 1962                   Norway  13450.4015
    ## 1144 1967                   Norway  16361.8765
    ## 1145 1972                   Norway  18965.0555
    ## 1146 1977                   Norway  23311.3494
    ## 1147 1982                   Norway  26298.6353
    ## 1148 1987                   Norway  31540.9748
    ## 1149 1992                   Norway  33965.6611
    ## 1150 1997                   Norway  41283.1643
    ## 1151 2002                   Norway  44683.9753
    ## 1152 2007                   Norway  49357.1902
    ## 1153 1952                     Oman   1828.2303
    ## 1154 1957                     Oman   2242.7466
    ## 1155 1962                     Oman   2924.6381
    ## 1156 1967                     Oman   4720.9427
    ## 1157 1972                     Oman  10618.0385
    ## 1158 1977                     Oman  11848.3439
    ## 1159 1982                     Oman  12954.7910
    ## 1160 1987                     Oman  18115.2231
    ## 1161 1992                     Oman  18616.7069
    ## 1162 1997                     Oman  19702.0558
    ## 1163 2002                     Oman  19774.8369
    ## 1164 2007                     Oman  22316.1929
    ## 1165 1952                 Pakistan    684.5971
    ## 1166 1957                 Pakistan    747.0835
    ## 1167 1962                 Pakistan    803.3427
    ## 1168 1967                 Pakistan    942.4083
    ## 1169 1972                 Pakistan   1049.9390
    ## 1170 1977                 Pakistan   1175.9212
    ## 1171 1982                 Pakistan   1443.4298
    ## 1172 1987                 Pakistan   1704.6866
    ## 1173 1992                 Pakistan   1971.8295
    ## 1174 1997                 Pakistan   2049.3505
    ## 1175 2002                 Pakistan   2092.7124
    ## 1176 2007                 Pakistan   2605.9476
    ## 1177 1952                   Panama   2480.3803
    ## 1178 1957                   Panama   2961.8009
    ## 1179 1962                   Panama   3536.5403
    ## 1180 1967                   Panama   4421.0091
    ## 1181 1972                   Panama   5364.2497
    ## 1182 1977                   Panama   5351.9121
    ## 1183 1982                   Panama   7009.6016
    ## 1184 1987                   Panama   7034.7792
    ## 1185 1992                   Panama   6618.7431
    ## 1186 1997                   Panama   7113.6923
    ## 1187 2002                   Panama   7356.0319
    ## 1188 2007                   Panama   9809.1856
    ## 1189 1952                 Paraguay   1952.3087
    ## 1190 1957                 Paraguay   2046.1547
    ## 1191 1962                 Paraguay   2148.0271
    ## 1192 1967                 Paraguay   2299.3763
    ## 1193 1972                 Paraguay   2523.3380
    ## 1194 1977                 Paraguay   3248.3733
    ## 1195 1982                 Paraguay   4258.5036
    ## 1196 1987                 Paraguay   3998.8757
    ## 1197 1992                 Paraguay   4196.4111
    ## 1198 1997                 Paraguay   4247.4003
    ## 1199 2002                 Paraguay   3783.6742
    ## 1200 2007                 Paraguay   4172.8385
    ## 1201 1952                     Peru   3758.5234
    ## 1202 1957                     Peru   4245.2567
    ## 1203 1962                     Peru   4957.0380
    ## 1204 1967                     Peru   5788.0933
    ## 1205 1972                     Peru   5937.8273
    ## 1206 1977                     Peru   6281.2909
    ## 1207 1982                     Peru   6434.5018
    ## 1208 1987                     Peru   6360.9434
    ## 1209 1992                     Peru   4446.3809
    ## 1210 1997                     Peru   5838.3477
    ## 1211 2002                     Peru   5909.0201
    ## 1212 2007                     Peru   7408.9056
    ## 1213 1952              Philippines   1272.8810
    ## 1214 1957              Philippines   1547.9448
    ## 1215 1962              Philippines   1649.5522
    ## 1216 1967              Philippines   1814.1274
    ## 1217 1972              Philippines   1989.3741
    ## 1218 1977              Philippines   2373.2043
    ## 1219 1982              Philippines   2603.2738
    ## 1220 1987              Philippines   2189.6350
    ## 1221 1992              Philippines   2279.3240
    ## 1222 1997              Philippines   2536.5349
    ## 1223 2002              Philippines   2650.9211
    ## 1224 2007              Philippines   3190.4810
    ## 1225 1952                   Poland   4029.3297
    ## 1226 1957                   Poland   4734.2530
    ## 1227 1962                   Poland   5338.7521
    ## 1228 1967                   Poland   6557.1528
    ## 1229 1972                   Poland   8006.5070
    ## 1230 1977                   Poland   9508.1415
    ## 1231 1982                   Poland   8451.5310
    ## 1232 1987                   Poland   9082.3512
    ## 1233 1992                   Poland   7738.8812
    ## 1234 1997                   Poland  10159.5837
    ## 1235 2002                   Poland  12002.2391
    ## 1236 2007                   Poland  15389.9247
    ## 1237 1952                 Portugal   3068.3199
    ## 1238 1957                 Portugal   3774.5717
    ## 1239 1962                 Portugal   4727.9549
    ## 1240 1967                 Portugal   6361.5180
    ## 1241 1972                 Portugal   9022.2474
    ## 1242 1977                 Portugal  10172.4857
    ## 1243 1982                 Portugal  11753.8429
    ## 1244 1987                 Portugal  13039.3088
    ## 1245 1992                 Portugal  16207.2666
    ## 1246 1997                 Portugal  17641.0316
    ## 1247 2002                 Portugal  19970.9079
    ## 1248 2007                 Portugal  20509.6478
    ## 1249 1952              Puerto Rico   3081.9598
    ## 1250 1957              Puerto Rico   3907.1562
    ## 1251 1962              Puerto Rico   5108.3446
    ## 1252 1967              Puerto Rico   6929.2777
    ## 1253 1972              Puerto Rico   9123.0417
    ## 1254 1977              Puerto Rico   9770.5249
    ## 1255 1982              Puerto Rico  10330.9891
    ## 1256 1987              Puerto Rico  12281.3419
    ## 1257 1992              Puerto Rico  14641.5871
    ## 1258 1997              Puerto Rico  16999.4333
    ## 1259 2002              Puerto Rico  18855.6062
    ## 1260 2007              Puerto Rico  19328.7090
    ## 1261 1952                  Reunion   2718.8853
    ## 1262 1957                  Reunion   2769.4518
    ## 1263 1962                  Reunion   3173.7233
    ## 1264 1967                  Reunion   4021.1757
    ## 1265 1972                  Reunion   5047.6586
    ## 1266 1977                  Reunion   4319.8041
    ## 1267 1982                  Reunion   5267.2194
    ## 1268 1987                  Reunion   5303.3775
    ## 1269 1992                  Reunion   6101.2558
    ## 1270 1997                  Reunion   6071.9414
    ## 1271 2002                  Reunion   6316.1652
    ## 1272 2007                  Reunion   7670.1226
    ## 1273 1952                  Romania   3144.6132
    ## 1274 1957                  Romania   3943.3702
    ## 1275 1962                  Romania   4734.9976
    ## 1276 1967                  Romania   6470.8665
    ## 1277 1972                  Romania   8011.4144
    ## 1278 1977                  Romania   9356.3972
    ## 1279 1982                  Romania   9605.3141
    ## 1280 1987                  Romania   9696.2733
    ## 1281 1992                  Romania   6598.4099
    ## 1282 1997                  Romania   7346.5476
    ## 1283 2002                  Romania   7885.3601
    ## 1284 2007                  Romania  10808.4756
    ## 1285 1952                   Rwanda    493.3239
    ## 1286 1957                   Rwanda    540.2894
    ## 1287 1962                   Rwanda    597.4731
    ## 1288 1967                   Rwanda    510.9637
    ## 1289 1972                   Rwanda    590.5807
    ## 1290 1977                   Rwanda    670.0806
    ## 1291 1982                   Rwanda    881.5706
    ## 1292 1987                   Rwanda    847.9912
    ## 1293 1992                   Rwanda    737.0686
    ## 1294 1997                   Rwanda    589.9445
    ## 1295 2002                   Rwanda    785.6538
    ## 1296 2007                   Rwanda    863.0885
    ## 1297 1952    Sao Tome and Principe    879.5836
    ## 1298 1957    Sao Tome and Principe    860.7369
    ## 1299 1962    Sao Tome and Principe   1071.5511
    ## 1300 1967    Sao Tome and Principe   1384.8406
    ## 1301 1972    Sao Tome and Principe   1532.9853
    ## 1302 1977    Sao Tome and Principe   1737.5617
    ## 1303 1982    Sao Tome and Principe   1890.2181
    ## 1304 1987    Sao Tome and Principe   1516.5255
    ## 1305 1992    Sao Tome and Principe   1428.7778
    ## 1306 1997    Sao Tome and Principe   1339.0760
    ## 1307 2002    Sao Tome and Principe   1353.0924
    ## 1308 2007    Sao Tome and Principe   1598.4351
    ## 1309 1952             Saudi Arabia   6459.5548
    ## 1310 1957             Saudi Arabia   8157.5912
    ## 1311 1962             Saudi Arabia  11626.4197
    ## 1312 1967             Saudi Arabia  16903.0489
    ## 1313 1972             Saudi Arabia  24837.4287
    ## 1314 1977             Saudi Arabia  34167.7626
    ## 1315 1982             Saudi Arabia  33693.1753
    ## 1316 1987             Saudi Arabia  21198.2614
    ## 1317 1992             Saudi Arabia  24841.6178
    ## 1318 1997             Saudi Arabia  20586.6902
    ## 1319 2002             Saudi Arabia  19014.5412
    ## 1320 2007             Saudi Arabia  21654.8319
    ## 1321 1952                  Senegal   1450.3570
    ## 1322 1957                  Senegal   1567.6530
    ## 1323 1962                  Senegal   1654.9887
    ## 1324 1967                  Senegal   1612.4046
    ## 1325 1972                  Senegal   1597.7121
    ## 1326 1977                  Senegal   1561.7691
    ## 1327 1982                  Senegal   1518.4800
    ## 1328 1987                  Senegal   1441.7207
    ## 1329 1992                  Senegal   1367.8994
    ## 1330 1997                  Senegal   1392.3683
    ## 1331 2002                  Senegal   1519.6353
    ## 1332 2007                  Senegal   1712.4721
    ## 1333 1952                   Serbia   3581.4594
    ## 1334 1957                   Serbia   4981.0909
    ## 1335 1962                   Serbia   6289.6292
    ## 1336 1967                   Serbia   7991.7071
    ## 1337 1972                   Serbia  10522.0675
    ## 1338 1977                   Serbia  12980.6696
    ## 1339 1982                   Serbia  15181.0927
    ## 1340 1987                   Serbia  15870.8785
    ## 1341 1992                   Serbia   9325.0682
    ## 1342 1997                   Serbia   7914.3203
    ## 1343 2002                   Serbia   7236.0753
    ## 1344 2007                   Serbia   9786.5347
    ## 1345 1952             Sierra Leone    879.7877
    ## 1346 1957             Sierra Leone   1004.4844
    ## 1347 1962             Sierra Leone   1116.6399
    ## 1348 1967             Sierra Leone   1206.0435
    ## 1349 1972             Sierra Leone   1353.7598
    ## 1350 1977             Sierra Leone   1348.2852
    ## 1351 1982             Sierra Leone   1465.0108
    ## 1352 1987             Sierra Leone   1294.4478
    ## 1353 1992             Sierra Leone   1068.6963
    ## 1354 1997             Sierra Leone    574.6482
    ## 1355 2002             Sierra Leone    699.4897
    ## 1356 2007             Sierra Leone    862.5408
    ## 1357 1952                Singapore   2315.1382
    ## 1358 1957                Singapore   2843.1044
    ## 1359 1962                Singapore   3674.7356
    ## 1360 1967                Singapore   4977.4185
    ## 1361 1972                Singapore   8597.7562
    ## 1362 1977                Singapore  11210.0895
    ## 1363 1982                Singapore  15169.1611
    ## 1364 1987                Singapore  18861.5308
    ## 1365 1992                Singapore  24769.8912
    ## 1366 1997                Singapore  33519.4766
    ## 1367 2002                Singapore  36023.1054
    ## 1368 2007                Singapore  47143.1796
    ## 1369 1952          Slovak Republic   5074.6591
    ## 1370 1957          Slovak Republic   6093.2630
    ## 1371 1962          Slovak Republic   7481.1076
    ## 1372 1967          Slovak Republic   8412.9024
    ## 1373 1972          Slovak Republic   9674.1676
    ## 1374 1977          Slovak Republic  10922.6640
    ## 1375 1982          Slovak Republic  11348.5459
    ## 1376 1987          Slovak Republic  12037.2676
    ## 1377 1992          Slovak Republic   9498.4677
    ## 1378 1997          Slovak Republic  12126.2306
    ## 1379 2002          Slovak Republic  13638.7784
    ## 1380 2007          Slovak Republic  18678.3144
    ## 1381 1952                 Slovenia   4215.0417
    ## 1382 1957                 Slovenia   5862.2766
    ## 1383 1962                 Slovenia   7402.3034
    ## 1384 1967                 Slovenia   9405.4894
    ## 1385 1972                 Slovenia  12383.4862
    ## 1386 1977                 Slovenia  15277.0302
    ## 1387 1982                 Slovenia  17866.7218
    ## 1388 1987                 Slovenia  18678.5349
    ## 1389 1992                 Slovenia  14214.7168
    ## 1390 1997                 Slovenia  17161.1073
    ## 1391 2002                 Slovenia  20660.0194
    ## 1392 2007                 Slovenia  25768.2576
    ## 1393 1952                  Somalia   1135.7498
    ## 1394 1957                  Somalia   1258.1474
    ## 1395 1962                  Somalia   1369.4883
    ## 1396 1967                  Somalia   1284.7332
    ## 1397 1972                  Somalia   1254.5761
    ## 1398 1977                  Somalia   1450.9925
    ## 1399 1982                  Somalia   1176.8070
    ## 1400 1987                  Somalia   1093.2450
    ## 1401 1992                  Somalia    926.9603
    ## 1402 1997                  Somalia    930.5964
    ## 1403 2002                  Somalia    882.0818
    ## 1404 2007                  Somalia    926.1411
    ## 1405 1952             South Africa   4725.2955
    ## 1406 1957             South Africa   5487.1042
    ## 1407 1962             South Africa   5768.7297
    ## 1408 1967             South Africa   7114.4780
    ## 1409 1972             South Africa   7765.9626
    ## 1410 1977             South Africa   8028.6514
    ## 1411 1982             South Africa   8568.2662
    ## 1412 1987             South Africa   7825.8234
    ## 1413 1992             South Africa   7225.0693
    ## 1414 1997             South Africa   7479.1882
    ## 1415 2002             South Africa   7710.9464
    ## 1416 2007             South Africa   9269.6578
    ## 1417 1952                    Spain   3834.0347
    ## 1418 1957                    Spain   4564.8024
    ## 1419 1962                    Spain   5693.8439
    ## 1420 1967                    Spain   7993.5123
    ## 1421 1972                    Spain  10638.7513
    ## 1422 1977                    Spain  13236.9212
    ## 1423 1982                    Spain  13926.1700
    ## 1424 1987                    Spain  15764.9831
    ## 1425 1992                    Spain  18603.0645
    ## 1426 1997                    Spain  20445.2990
    ## 1427 2002                    Spain  24835.4717
    ## 1428 2007                    Spain  28821.0637
    ## 1429 1952                Sri Lanka   1083.5320
    ## 1430 1957                Sri Lanka   1072.5466
    ## 1431 1962                Sri Lanka   1074.4720
    ## 1432 1967                Sri Lanka   1135.5143
    ## 1433 1972                Sri Lanka   1213.3955
    ## 1434 1977                Sri Lanka   1348.7757
    ## 1435 1982                Sri Lanka   1648.0798
    ## 1436 1987                Sri Lanka   1876.7668
    ## 1437 1992                Sri Lanka   2153.7392
    ## 1438 1997                Sri Lanka   2664.4773
    ## 1439 2002                Sri Lanka   3015.3788
    ## 1440 2007                Sri Lanka   3970.0954
    ## 1441 1952                    Sudan   1615.9911
    ## 1442 1957                    Sudan   1770.3371
    ## 1443 1962                    Sudan   1959.5938
    ## 1444 1967                    Sudan   1687.9976
    ## 1445 1972                    Sudan   1659.6528
    ## 1446 1977                    Sudan   2202.9884
    ## 1447 1982                    Sudan   1895.5441
    ## 1448 1987                    Sudan   1507.8192
    ## 1449 1992                    Sudan   1492.1970
    ## 1450 1997                    Sudan   1632.2108
    ## 1451 2002                    Sudan   1993.3983
    ## 1452 2007                    Sudan   2602.3950
    ## 1453 1952                Swaziland   1148.3766
    ## 1454 1957                Swaziland   1244.7084
    ## 1455 1962                Swaziland   1856.1821
    ## 1456 1967                Swaziland   2613.1017
    ## 1457 1972                Swaziland   3364.8366
    ## 1458 1977                Swaziland   3781.4106
    ## 1459 1982                Swaziland   3895.3840
    ## 1460 1987                Swaziland   3984.8398
    ## 1461 1992                Swaziland   3553.0224
    ## 1462 1997                Swaziland   3876.7685
    ## 1463 2002                Swaziland   4128.1169
    ## 1464 2007                Swaziland   4513.4806
    ## 1465 1952                   Sweden   8527.8447
    ## 1466 1957                   Sweden   9911.8782
    ## 1467 1962                   Sweden  12329.4419
    ## 1468 1967                   Sweden  15258.2970
    ## 1469 1972                   Sweden  17832.0246
    ## 1470 1977                   Sweden  18855.7252
    ## 1471 1982                   Sweden  20667.3812
    ## 1472 1987                   Sweden  23586.9293
    ## 1473 1992                   Sweden  23880.0168
    ## 1474 1997                   Sweden  25266.5950
    ## 1475 2002                   Sweden  29341.6309
    ## 1476 2007                   Sweden  33859.7484
    ## 1477 1952              Switzerland  14734.2327
    ## 1478 1957              Switzerland  17909.4897
    ## 1479 1962              Switzerland  20431.0927
    ## 1480 1967              Switzerland  22966.1443
    ## 1481 1972              Switzerland  27195.1130
    ## 1482 1977              Switzerland  26982.2905
    ## 1483 1982              Switzerland  28397.7151
    ## 1484 1987              Switzerland  30281.7046
    ## 1485 1992              Switzerland  31871.5303
    ## 1486 1997              Switzerland  32135.3230
    ## 1487 2002              Switzerland  34480.9577
    ## 1488 2007              Switzerland  37506.4191
    ## 1489 1952                    Syria   1643.4854
    ## 1490 1957                    Syria   2117.2349
    ## 1491 1962                    Syria   2193.0371
    ## 1492 1967                    Syria   1881.9236
    ## 1493 1972                    Syria   2571.4230
    ## 1494 1977                    Syria   3195.4846
    ## 1495 1982                    Syria   3761.8377
    ## 1496 1987                    Syria   3116.7743
    ## 1497 1992                    Syria   3340.5428
    ## 1498 1997                    Syria   4014.2390
    ## 1499 2002                    Syria   4090.9253
    ## 1500 2007                    Syria   4184.5481
    ## 1501 1952                   Taiwan   1206.9479
    ## 1502 1957                   Taiwan   1507.8613
    ## 1503 1962                   Taiwan   1822.8790
    ## 1504 1967                   Taiwan   2643.8587
    ## 1505 1972                   Taiwan   4062.5239
    ## 1506 1977                   Taiwan   5596.5198
    ## 1507 1982                   Taiwan   7426.3548
    ## 1508 1987                   Taiwan  11054.5618
    ## 1509 1992                   Taiwan  15215.6579
    ## 1510 1997                   Taiwan  20206.8210
    ## 1511 2002                   Taiwan  23235.4233
    ## 1512 2007                   Taiwan  28718.2768
    ## 1513 1952                 Tanzania    716.6501
    ## 1514 1957                 Tanzania    698.5356
    ## 1515 1962                 Tanzania    722.0038
    ## 1516 1967                 Tanzania    848.2187
    ## 1517 1972                 Tanzania    915.9851
    ## 1518 1977                 Tanzania    962.4923
    ## 1519 1982                 Tanzania    874.2426
    ## 1520 1987                 Tanzania    831.8221
    ## 1521 1992                 Tanzania    825.6825
    ## 1522 1997                 Tanzania    789.1862
    ## 1523 2002                 Tanzania    899.0742
    ## 1524 2007                 Tanzania   1107.4822
    ## 1525 1952                 Thailand    757.7974
    ## 1526 1957                 Thailand    793.5774
    ## 1527 1962                 Thailand   1002.1992
    ## 1528 1967                 Thailand   1295.4607
    ## 1529 1972                 Thailand   1524.3589
    ## 1530 1977                 Thailand   1961.2246
    ## 1531 1982                 Thailand   2393.2198
    ## 1532 1987                 Thailand   2982.6538
    ## 1533 1992                 Thailand   4616.8965
    ## 1534 1997                 Thailand   5852.6255
    ## 1535 2002                 Thailand   5913.1875
    ## 1536 2007                 Thailand   7458.3963
    ## 1537 1952                     Togo    859.8087
    ## 1538 1957                     Togo    925.9083
    ## 1539 1962                     Togo   1067.5348
    ## 1540 1967                     Togo   1477.5968
    ## 1541 1972                     Togo   1649.6602
    ## 1542 1977                     Togo   1532.7770
    ## 1543 1982                     Togo   1344.5780
    ## 1544 1987                     Togo   1202.2014
    ## 1545 1992                     Togo   1034.2989
    ## 1546 1997                     Togo    982.2869
    ## 1547 2002                     Togo    886.2206
    ## 1548 2007                     Togo    882.9699
    ## 1549 1952      Trinidad and Tobago   3023.2719
    ## 1550 1957      Trinidad and Tobago   4100.3934
    ## 1551 1962      Trinidad and Tobago   4997.5240
    ## 1552 1967      Trinidad and Tobago   5621.3685
    ## 1553 1972      Trinidad and Tobago   6619.5514
    ## 1554 1977      Trinidad and Tobago   7899.5542
    ## 1555 1982      Trinidad and Tobago   9119.5286
    ## 1556 1987      Trinidad and Tobago   7388.5978
    ## 1557 1992      Trinidad and Tobago   7370.9909
    ## 1558 1997      Trinidad and Tobago   8792.5731
    ## 1559 2002      Trinidad and Tobago  11460.6002
    ## 1560 2007      Trinidad and Tobago  18008.5092
    ## 1561 1952                  Tunisia   1468.4756
    ## 1562 1957                  Tunisia   1395.2325
    ## 1563 1962                  Tunisia   1660.3032
    ## 1564 1967                  Tunisia   1932.3602
    ## 1565 1972                  Tunisia   2753.2860
    ## 1566 1977                  Tunisia   3120.8768
    ## 1567 1982                  Tunisia   3560.2332
    ## 1568 1987                  Tunisia   3810.4193
    ## 1569 1992                  Tunisia   4332.7202
    ## 1570 1997                  Tunisia   4876.7986
    ## 1571 2002                  Tunisia   5722.8957
    ## 1572 2007                  Tunisia   7092.9230
    ## 1573 1952                   Turkey   1969.1010
    ## 1574 1957                   Turkey   2218.7543
    ## 1575 1962                   Turkey   2322.8699
    ## 1576 1967                   Turkey   2826.3564
    ## 1577 1972                   Turkey   3450.6964
    ## 1578 1977                   Turkey   4269.1223
    ## 1579 1982                   Turkey   4241.3563
    ## 1580 1987                   Turkey   5089.0437
    ## 1581 1992                   Turkey   5678.3483
    ## 1582 1997                   Turkey   6601.4299
    ## 1583 2002                   Turkey   6508.0857
    ## 1584 2007                   Turkey   8458.2764
    ## 1585 1952                   Uganda    734.7535
    ## 1586 1957                   Uganda    774.3711
    ## 1587 1962                   Uganda    767.2717
    ## 1588 1967                   Uganda    908.9185
    ## 1589 1972                   Uganda    950.7359
    ## 1590 1977                   Uganda    843.7331
    ## 1591 1982                   Uganda    682.2662
    ## 1592 1987                   Uganda    617.7244
    ## 1593 1992                   Uganda    644.1708
    ## 1594 1997                   Uganda    816.5591
    ## 1595 2002                   Uganda    927.7210
    ## 1596 2007                   Uganda   1056.3801
    ## 1597 1952           United Kingdom   9979.5085
    ## 1598 1957           United Kingdom  11283.1779
    ## 1599 1962           United Kingdom  12477.1771
    ## 1600 1967           United Kingdom  14142.8509
    ## 1601 1972           United Kingdom  15895.1164
    ## 1602 1977           United Kingdom  17428.7485
    ## 1603 1982           United Kingdom  18232.4245
    ## 1604 1987           United Kingdom  21664.7877
    ## 1605 1992           United Kingdom  22705.0925
    ## 1606 1997           United Kingdom  26074.5314
    ## 1607 2002           United Kingdom  29478.9992
    ## 1608 2007           United Kingdom  33203.2613
    ## 1609 1952            United States  13990.4821
    ## 1610 1957            United States  14847.1271
    ## 1611 1962            United States  16173.1459
    ## 1612 1967            United States  19530.3656
    ## 1613 1972            United States  21806.0359
    ## 1614 1977            United States  24072.6321
    ## 1615 1982            United States  25009.5591
    ## 1616 1987            United States  29884.3504
    ## 1617 1992            United States  32003.9322
    ## 1618 1997            United States  35767.4330
    ## 1619 2002            United States  39097.0995
    ## 1620 2007            United States  42951.6531
    ## 1621 1952                  Uruguay   5716.7667
    ## 1622 1957                  Uruguay   6150.7730
    ## 1623 1962                  Uruguay   5603.3577
    ## 1624 1967                  Uruguay   5444.6196
    ## 1625 1972                  Uruguay   5703.4089
    ## 1626 1977                  Uruguay   6504.3397
    ## 1627 1982                  Uruguay   6920.2231
    ## 1628 1987                  Uruguay   7452.3990
    ## 1629 1992                  Uruguay   8137.0048
    ## 1630 1997                  Uruguay   9230.2407
    ## 1631 2002                  Uruguay   7727.0020
    ## 1632 2007                  Uruguay  10611.4630
    ## 1633 1952                Venezuela   7689.7998
    ## 1634 1957                Venezuela   9802.4665
    ## 1635 1962                Venezuela   8422.9742
    ## 1636 1967                Venezuela   9541.4742
    ## 1637 1972                Venezuela  10505.2597
    ## 1638 1977                Venezuela  13143.9510
    ## 1639 1982                Venezuela  11152.4101
    ## 1640 1987                Venezuela   9883.5846
    ## 1641 1992                Venezuela  10733.9263
    ## 1642 1997                Venezuela  10165.4952
    ## 1643 2002                Venezuela   8605.0478
    ## 1644 2007                Venezuela  11415.8057
    ## 1645 1952                  Vietnam    605.0665
    ## 1646 1957                  Vietnam    676.2854
    ## 1647 1962                  Vietnam    772.0492
    ## 1648 1967                  Vietnam    637.1233
    ## 1649 1972                  Vietnam    699.5016
    ## 1650 1977                  Vietnam    713.5371
    ## 1651 1982                  Vietnam    707.2358
    ## 1652 1987                  Vietnam    820.7994
    ## 1653 1992                  Vietnam    989.0231
    ## 1654 1997                  Vietnam   1385.8968
    ## 1655 2002                  Vietnam   1764.4567
    ## 1656 2007                  Vietnam   2441.5764
    ## 1657 1952       West Bank and Gaza   1515.5923
    ## 1658 1957       West Bank and Gaza   1827.0677
    ## 1659 1962       West Bank and Gaza   2198.9563
    ## 1660 1967       West Bank and Gaza   2649.7150
    ## 1661 1972       West Bank and Gaza   3133.4093
    ## 1662 1977       West Bank and Gaza   3682.8315
    ## 1663 1982       West Bank and Gaza   4336.0321
    ## 1664 1987       West Bank and Gaza   5107.1974
    ## 1665 1992       West Bank and Gaza   6017.6548
    ## 1666 1997       West Bank and Gaza   7110.6676
    ## 1667 2002       West Bank and Gaza   4515.4876
    ## 1668 2007       West Bank and Gaza   3025.3498
    ## 1669 1952               Yemen Rep.    781.7176
    ## 1670 1957               Yemen Rep.    804.8305
    ## 1671 1962               Yemen Rep.    825.6232
    ## 1672 1967               Yemen Rep.    862.4421
    ## 1673 1972               Yemen Rep.   1265.0470
    ## 1674 1977               Yemen Rep.   1829.7652
    ## 1675 1982               Yemen Rep.   1977.5570
    ## 1676 1987               Yemen Rep.   1971.7415
    ## 1677 1992               Yemen Rep.   1879.4967
    ## 1678 1997               Yemen Rep.   2117.4845
    ## 1679 2002               Yemen Rep.   2234.8208
    ## 1680 2007               Yemen Rep.   2280.7699
    ## 1681 1952                   Zambia   1147.3888
    ## 1682 1957                   Zambia   1311.9568
    ## 1683 1962                   Zambia   1452.7258
    ## 1684 1967                   Zambia   1777.0773
    ## 1685 1972                   Zambia   1773.4983
    ## 1686 1977                   Zambia   1588.6883
    ## 1687 1982                   Zambia   1408.6786
    ## 1688 1987                   Zambia   1213.3151
    ## 1689 1992                   Zambia   1210.8846
    ## 1690 1997                   Zambia   1071.3538
    ## 1691 2002                   Zambia   1071.6139
    ## 1692 2007                   Zambia   1271.2116
    ## 1693 1952                 Zimbabwe    406.8841
    ## 1694 1957                 Zimbabwe    518.7643
    ## 1695 1962                 Zimbabwe    527.2722
    ## 1696 1967                 Zimbabwe    569.7951
    ## 1697 1972                 Zimbabwe    799.3622
    ## 1698 1977                 Zimbabwe    685.5877
    ## 1699 1982                 Zimbabwe    788.8550
    ## 1700 1987                 Zimbabwe    706.1573
    ## 1701 1992                 Zimbabwe    693.4208
    ## 1702 1997                 Zimbabwe    792.4500
    ## 1703 2002                 Zimbabwe    672.0386
    ## 1704 2007                 Zimbabwe    469.7093

We wrap it in parentheses so it also prints to screen.

If we only want this data for 1997, we can associate `select()` to `filter()`:

``` r
gap_small_97 <- filter(gap_small, year == 1997)
```

We can make our code more readable and avoid creating useless intermediate objects by **piping** commands into each other. The pipe symbol `%>%` **strings commands together**, using the left-side output as the first argument of the right-side function.

This command:

``` r
summary(gapminder)
```

    ##         country          year           pop               continent  
    ##  Afghanistan:  12   Min.   :1952   Min.   :6.001e+04   Africa  :624  
    ##  Albania    :  12   1st Qu.:1966   1st Qu.:2.794e+06   Americas:300  
    ##  Algeria    :  12   Median :1980   Median :7.024e+06   Asia    :396  
    ##  Angola     :  12   Mean   :1980   Mean   :2.960e+07   Europe  :360  
    ##  Argentina  :  12   3rd Qu.:1993   3rd Qu.:1.959e+07   Oceania : 24  
    ##  Australia  :  12   Max.   :2007   Max.   :1.319e+09                 
    ##  (Other)    :1632                                                    
    ##     lifeExp        gdpPercap       
    ##  Min.   :23.60   Min.   :   241.2  
    ##  1st Qu.:48.20   1st Qu.:  1202.1  
    ##  Median :60.71   Median :  3531.8  
    ##  Mean   :59.47   Mean   :  7215.3  
    ##  3rd Qu.:70.85   3rd Qu.:  9325.5  
    ##  Max.   :82.60   Max.   :113523.1  
    ## 

Is equivalent to:

``` r
gapminder %>% summary()
```

    ##         country          year           pop               continent  
    ##  Afghanistan:  12   Min.   :1952   Min.   :6.001e+04   Africa  :624  
    ##  Albania    :  12   1st Qu.:1966   1st Qu.:2.794e+06   Americas:300  
    ##  Algeria    :  12   Median :1980   Median :7.024e+06   Asia    :396  
    ##  Angola     :  12   Mean   :1980   Mean   :2.960e+07   Europe  :360  
    ##  Argentina  :  12   3rd Qu.:1993   3rd Qu.:1.959e+07   Oceania : 24  
    ##  Australia  :  12   Max.   :2007   Max.   :1.319e+09                 
    ##  (Other)    :1632                                                    
    ##     lifeExp        gdpPercap       
    ##  Min.   :23.60   Min.   :   241.2  
    ##  1st Qu.:48.20   1st Qu.:  1202.1  
    ##  Median :60.71   Median :  3531.8  
    ##  Mean   :59.47   Mean   :  7215.3  
    ##  3rd Qu.:70.85   3rd Qu.:  9325.5  
    ##  Max.   :82.60   Max.   :113523.1  
    ## 

Here's another example with the `filter()` verb:

``` r
gapminder %>%
  filter(country != "France")
```

    ##                       country year        pop continent  lifeExp
    ## 1                 Afghanistan 1952    8425333      Asia 28.80100
    ## 2                 Afghanistan 1957    9240934      Asia 30.33200
    ## 3                 Afghanistan 1962   10267083      Asia 31.99700
    ## 4                 Afghanistan 1967   11537966      Asia 34.02000
    ## 5                 Afghanistan 1972   13079460      Asia 36.08800
    ## 6                 Afghanistan 1977   14880372      Asia 38.43800
    ## 7                 Afghanistan 1982   12881816      Asia 39.85400
    ## 8                 Afghanistan 1987   13867957      Asia 40.82200
    ## 9                 Afghanistan 1992   16317921      Asia 41.67400
    ## 10                Afghanistan 1997   22227415      Asia 41.76300
    ## 11                Afghanistan 2002   25268405      Asia 42.12900
    ## 12                Afghanistan 2007   31889923      Asia 43.82800
    ## 13                    Albania 1952    1282697    Europe 55.23000
    ## 14                    Albania 1957    1476505    Europe 59.28000
    ## 15                    Albania 1962    1728137    Europe 64.82000
    ## 16                    Albania 1967    1984060    Europe 66.22000
    ## 17                    Albania 1972    2263554    Europe 67.69000
    ## 18                    Albania 1977    2509048    Europe 68.93000
    ## 19                    Albania 1982    2780097    Europe 70.42000
    ## 20                    Albania 1987    3075321    Europe 72.00000
    ## 21                    Albania 1992    3326498    Europe 71.58100
    ## 22                    Albania 1997    3428038    Europe 72.95000
    ## 23                    Albania 2002    3508512    Europe 75.65100
    ## 24                    Albania 2007    3600523    Europe 76.42300
    ## 25                    Algeria 1952    9279525    Africa 43.07700
    ## 26                    Algeria 1957   10270856    Africa 45.68500
    ## 27                    Algeria 1962   11000948    Africa 48.30300
    ## 28                    Algeria 1967   12760499    Africa 51.40700
    ## 29                    Algeria 1972   14760787    Africa 54.51800
    ## 30                    Algeria 1977   17152804    Africa 58.01400
    ## 31                    Algeria 1982   20033753    Africa 61.36800
    ## 32                    Algeria 1987   23254956    Africa 65.79900
    ## 33                    Algeria 1992   26298373    Africa 67.74400
    ## 34                    Algeria 1997   29072015    Africa 69.15200
    ## 35                    Algeria 2002   31287142    Africa 70.99400
    ## 36                    Algeria 2007   33333216    Africa 72.30100
    ## 37                     Angola 1952    4232095    Africa 30.01500
    ## 38                     Angola 1957    4561361    Africa 31.99900
    ## 39                     Angola 1962    4826015    Africa 34.00000
    ## 40                     Angola 1967    5247469    Africa 35.98500
    ## 41                     Angola 1972    5894858    Africa 37.92800
    ## 42                     Angola 1977    6162675    Africa 39.48300
    ## 43                     Angola 1982    7016384    Africa 39.94200
    ## 44                     Angola 1987    7874230    Africa 39.90600
    ## 45                     Angola 1992    8735988    Africa 40.64700
    ## 46                     Angola 1997    9875024    Africa 40.96300
    ## 47                     Angola 2002   10866106    Africa 41.00300
    ## 48                     Angola 2007   12420476    Africa 42.73100
    ## 49                  Argentina 1952   17876956  Americas 62.48500
    ## 50                  Argentina 1957   19610538  Americas 64.39900
    ## 51                  Argentina 1962   21283783  Americas 65.14200
    ## 52                  Argentina 1967   22934225  Americas 65.63400
    ## 53                  Argentina 1972   24779799  Americas 67.06500
    ## 54                  Argentina 1977   26983828  Americas 68.48100
    ## 55                  Argentina 1982   29341374  Americas 69.94200
    ## 56                  Argentina 1987   31620918  Americas 70.77400
    ## 57                  Argentina 1992   33958947  Americas 71.86800
    ## 58                  Argentina 1997   36203463  Americas 73.27500
    ## 59                  Argentina 2002   38331121  Americas 74.34000
    ## 60                  Argentina 2007   40301927  Americas 75.32000
    ## 61                  Australia 1952    8691212   Oceania 69.12000
    ## 62                  Australia 1957    9712569   Oceania 70.33000
    ## 63                  Australia 1962   10794968   Oceania 70.93000
    ## 64                  Australia 1967   11872264   Oceania 71.10000
    ## 65                  Australia 1972   13177000   Oceania 71.93000
    ## 66                  Australia 1977   14074100   Oceania 73.49000
    ## 67                  Australia 1982   15184200   Oceania 74.74000
    ## 68                  Australia 1987   16257249   Oceania 76.32000
    ## 69                  Australia 1992   17481977   Oceania 77.56000
    ## 70                  Australia 1997   18565243   Oceania 78.83000
    ## 71                  Australia 2002   19546792   Oceania 80.37000
    ## 72                  Australia 2007   20434176   Oceania 81.23500
    ## 73                    Austria 1952    6927772    Europe 66.80000
    ## 74                    Austria 1957    6965860    Europe 67.48000
    ## 75                    Austria 1962    7129864    Europe 69.54000
    ## 76                    Austria 1967    7376998    Europe 70.14000
    ## 77                    Austria 1972    7544201    Europe 70.63000
    ## 78                    Austria 1977    7568430    Europe 72.17000
    ## 79                    Austria 1982    7574613    Europe 73.18000
    ## 80                    Austria 1987    7578903    Europe 74.94000
    ## 81                    Austria 1992    7914969    Europe 76.04000
    ## 82                    Austria 1997    8069876    Europe 77.51000
    ## 83                    Austria 2002    8148312    Europe 78.98000
    ## 84                    Austria 2007    8199783    Europe 79.82900
    ## 85                    Bahrain 1952     120447      Asia 50.93900
    ## 86                    Bahrain 1957     138655      Asia 53.83200
    ## 87                    Bahrain 1962     171863      Asia 56.92300
    ## 88                    Bahrain 1967     202182      Asia 59.92300
    ## 89                    Bahrain 1972     230800      Asia 63.30000
    ## 90                    Bahrain 1977     297410      Asia 65.59300
    ## 91                    Bahrain 1982     377967      Asia 69.05200
    ## 92                    Bahrain 1987     454612      Asia 70.75000
    ## 93                    Bahrain 1992     529491      Asia 72.60100
    ## 94                    Bahrain 1997     598561      Asia 73.92500
    ## 95                    Bahrain 2002     656397      Asia 74.79500
    ## 96                    Bahrain 2007     708573      Asia 75.63500
    ## 97                 Bangladesh 1952   46886859      Asia 37.48400
    ## 98                 Bangladesh 1957   51365468      Asia 39.34800
    ## 99                 Bangladesh 1962   56839289      Asia 41.21600
    ## 100                Bangladesh 1967   62821884      Asia 43.45300
    ## 101                Bangladesh 1972   70759295      Asia 45.25200
    ## 102                Bangladesh 1977   80428306      Asia 46.92300
    ## 103                Bangladesh 1982   93074406      Asia 50.00900
    ## 104                Bangladesh 1987  103764241      Asia 52.81900
    ## 105                Bangladesh 1992  113704579      Asia 56.01800
    ## 106                Bangladesh 1997  123315288      Asia 59.41200
    ## 107                Bangladesh 2002  135656790      Asia 62.01300
    ## 108                Bangladesh 2007  150448339      Asia 64.06200
    ## 109                   Belgium 1952    8730405    Europe 68.00000
    ## 110                   Belgium 1957    8989111    Europe 69.24000
    ## 111                   Belgium 1962    9218400    Europe 70.25000
    ## 112                   Belgium 1967    9556500    Europe 70.94000
    ## 113                   Belgium 1972    9709100    Europe 71.44000
    ## 114                   Belgium 1977    9821800    Europe 72.80000
    ## 115                   Belgium 1982    9856303    Europe 73.93000
    ## 116                   Belgium 1987    9870200    Europe 75.35000
    ## 117                   Belgium 1992   10045622    Europe 76.46000
    ## 118                   Belgium 1997   10199787    Europe 77.53000
    ## 119                   Belgium 2002   10311970    Europe 78.32000
    ## 120                   Belgium 2007   10392226    Europe 79.44100
    ## 121                     Benin 1952    1738315    Africa 38.22300
    ## 122                     Benin 1957    1925173    Africa 40.35800
    ## 123                     Benin 1962    2151895    Africa 42.61800
    ## 124                     Benin 1967    2427334    Africa 44.88500
    ## 125                     Benin 1972    2761407    Africa 47.01400
    ## 126                     Benin 1977    3168267    Africa 49.19000
    ## 127                     Benin 1982    3641603    Africa 50.90400
    ## 128                     Benin 1987    4243788    Africa 52.33700
    ## 129                     Benin 1992    4981671    Africa 53.91900
    ## 130                     Benin 1997    6066080    Africa 54.77700
    ## 131                     Benin 2002    7026113    Africa 54.40600
    ## 132                     Benin 2007    8078314    Africa 56.72800
    ## 133                   Bolivia 1952    2883315  Americas 40.41400
    ## 134                   Bolivia 1957    3211738  Americas 41.89000
    ## 135                   Bolivia 1962    3593918  Americas 43.42800
    ## 136                   Bolivia 1967    4040665  Americas 45.03200
    ## 137                   Bolivia 1972    4565872  Americas 46.71400
    ## 138                   Bolivia 1977    5079716  Americas 50.02300
    ## 139                   Bolivia 1982    5642224  Americas 53.85900
    ## 140                   Bolivia 1987    6156369  Americas 57.25100
    ## 141                   Bolivia 1992    6893451  Americas 59.95700
    ## 142                   Bolivia 1997    7693188  Americas 62.05000
    ## 143                   Bolivia 2002    8445134  Americas 63.88300
    ## 144                   Bolivia 2007    9119152  Americas 65.55400
    ## 145    Bosnia and Herzegovina 1952    2791000    Europe 53.82000
    ## 146    Bosnia and Herzegovina 1957    3076000    Europe 58.45000
    ## 147    Bosnia and Herzegovina 1962    3349000    Europe 61.93000
    ## 148    Bosnia and Herzegovina 1967    3585000    Europe 64.79000
    ## 149    Bosnia and Herzegovina 1972    3819000    Europe 67.45000
    ## 150    Bosnia and Herzegovina 1977    4086000    Europe 69.86000
    ## 151    Bosnia and Herzegovina 1982    4172693    Europe 70.69000
    ## 152    Bosnia and Herzegovina 1987    4338977    Europe 71.14000
    ## 153    Bosnia and Herzegovina 1992    4256013    Europe 72.17800
    ## 154    Bosnia and Herzegovina 1997    3607000    Europe 73.24400
    ## 155    Bosnia and Herzegovina 2002    4165416    Europe 74.09000
    ## 156    Bosnia and Herzegovina 2007    4552198    Europe 74.85200
    ## 157                  Botswana 1952     442308    Africa 47.62200
    ## 158                  Botswana 1957     474639    Africa 49.61800
    ## 159                  Botswana 1962     512764    Africa 51.52000
    ## 160                  Botswana 1967     553541    Africa 53.29800
    ## 161                  Botswana 1972     619351    Africa 56.02400
    ## 162                  Botswana 1977     781472    Africa 59.31900
    ## 163                  Botswana 1982     970347    Africa 61.48400
    ## 164                  Botswana 1987    1151184    Africa 63.62200
    ## 165                  Botswana 1992    1342614    Africa 62.74500
    ## 166                  Botswana 1997    1536536    Africa 52.55600
    ## 167                  Botswana 2002    1630347    Africa 46.63400
    ## 168                  Botswana 2007    1639131    Africa 50.72800
    ## 169                    Brazil 1952   56602560  Americas 50.91700
    ## 170                    Brazil 1957   65551171  Americas 53.28500
    ## 171                    Brazil 1962   76039390  Americas 55.66500
    ## 172                    Brazil 1967   88049823  Americas 57.63200
    ## 173                    Brazil 1972  100840058  Americas 59.50400
    ## 174                    Brazil 1977  114313951  Americas 61.48900
    ## 175                    Brazil 1982  128962939  Americas 63.33600
    ## 176                    Brazil 1987  142938076  Americas 65.20500
    ## 177                    Brazil 1992  155975974  Americas 67.05700
    ## 178                    Brazil 1997  168546719  Americas 69.38800
    ## 179                    Brazil 2002  179914212  Americas 71.00600
    ## 180                    Brazil 2007  190010647  Americas 72.39000
    ## 181                  Bulgaria 1952    7274900    Europe 59.60000
    ## 182                  Bulgaria 1957    7651254    Europe 66.61000
    ## 183                  Bulgaria 1962    8012946    Europe 69.51000
    ## 184                  Bulgaria 1967    8310226    Europe 70.42000
    ## 185                  Bulgaria 1972    8576200    Europe 70.90000
    ## 186                  Bulgaria 1977    8797022    Europe 70.81000
    ## 187                  Bulgaria 1982    8892098    Europe 71.08000
    ## 188                  Bulgaria 1987    8971958    Europe 71.34000
    ## 189                  Bulgaria 1992    8658506    Europe 71.19000
    ## 190                  Bulgaria 1997    8066057    Europe 70.32000
    ## 191                  Bulgaria 2002    7661799    Europe 72.14000
    ## 192                  Bulgaria 2007    7322858    Europe 73.00500
    ## 193              Burkina Faso 1952    4469979    Africa 31.97500
    ## 194              Burkina Faso 1957    4713416    Africa 34.90600
    ## 195              Burkina Faso 1962    4919632    Africa 37.81400
    ## 196              Burkina Faso 1967    5127935    Africa 40.69700
    ## 197              Burkina Faso 1972    5433886    Africa 43.59100
    ## 198              Burkina Faso 1977    5889574    Africa 46.13700
    ## 199              Burkina Faso 1982    6634596    Africa 48.12200
    ## 200              Burkina Faso 1987    7586551    Africa 49.55700
    ## 201              Burkina Faso 1992    8878303    Africa 50.26000
    ## 202              Burkina Faso 1997   10352843    Africa 50.32400
    ## 203              Burkina Faso 2002   12251209    Africa 50.65000
    ## 204              Burkina Faso 2007   14326203    Africa 52.29500
    ## 205                   Burundi 1952    2445618    Africa 39.03100
    ## 206                   Burundi 1957    2667518    Africa 40.53300
    ## 207                   Burundi 1962    2961915    Africa 42.04500
    ## 208                   Burundi 1967    3330989    Africa 43.54800
    ## 209                   Burundi 1972    3529983    Africa 44.05700
    ## 210                   Burundi 1977    3834415    Africa 45.91000
    ## 211                   Burundi 1982    4580410    Africa 47.47100
    ## 212                   Burundi 1987    5126023    Africa 48.21100
    ## 213                   Burundi 1992    5809236    Africa 44.73600
    ## 214                   Burundi 1997    6121610    Africa 45.32600
    ## 215                   Burundi 2002    7021078    Africa 47.36000
    ## 216                   Burundi 2007    8390505    Africa 49.58000
    ## 217                  Cambodia 1952    4693836      Asia 39.41700
    ## 218                  Cambodia 1957    5322536      Asia 41.36600
    ## 219                  Cambodia 1962    6083619      Asia 43.41500
    ## 220                  Cambodia 1967    6960067      Asia 45.41500
    ## 221                  Cambodia 1972    7450606      Asia 40.31700
    ## 222                  Cambodia 1977    6978607      Asia 31.22000
    ## 223                  Cambodia 1982    7272485      Asia 50.95700
    ## 224                  Cambodia 1987    8371791      Asia 53.91400
    ## 225                  Cambodia 1992   10150094      Asia 55.80300
    ## 226                  Cambodia 1997   11782962      Asia 56.53400
    ## 227                  Cambodia 2002   12926707      Asia 56.75200
    ## 228                  Cambodia 2007   14131858      Asia 59.72300
    ## 229                  Cameroon 1952    5009067    Africa 38.52300
    ## 230                  Cameroon 1957    5359923    Africa 40.42800
    ## 231                  Cameroon 1962    5793633    Africa 42.64300
    ## 232                  Cameroon 1967    6335506    Africa 44.79900
    ## 233                  Cameroon 1972    7021028    Africa 47.04900
    ## 234                  Cameroon 1977    7959865    Africa 49.35500
    ## 235                  Cameroon 1982    9250831    Africa 52.96100
    ## 236                  Cameroon 1987   10780667    Africa 54.98500
    ## 237                  Cameroon 1992   12467171    Africa 54.31400
    ## 238                  Cameroon 1997   14195809    Africa 52.19900
    ## 239                  Cameroon 2002   15929988    Africa 49.85600
    ## 240                  Cameroon 2007   17696293    Africa 50.43000
    ## 241                    Canada 1952   14785584  Americas 68.75000
    ## 242                    Canada 1957   17010154  Americas 69.96000
    ## 243                    Canada 1962   18985849  Americas 71.30000
    ## 244                    Canada 1967   20819767  Americas 72.13000
    ## 245                    Canada 1972   22284500  Americas 72.88000
    ## 246                    Canada 1977   23796400  Americas 74.21000
    ## 247                    Canada 1982   25201900  Americas 75.76000
    ## 248                    Canada 1987   26549700  Americas 76.86000
    ## 249                    Canada 1992   28523502  Americas 77.95000
    ## 250                    Canada 1997   30305843  Americas 78.61000
    ## 251                    Canada 2002   31902268  Americas 79.77000
    ## 252                    Canada 2007   33390141  Americas 80.65300
    ## 253  Central African Republic 1952    1291695    Africa 35.46300
    ## 254  Central African Republic 1957    1392284    Africa 37.46400
    ## 255  Central African Republic 1962    1523478    Africa 39.47500
    ## 256  Central African Republic 1967    1733638    Africa 41.47800
    ## 257  Central African Republic 1972    1927260    Africa 43.45700
    ## 258  Central African Republic 1977    2167533    Africa 46.77500
    ## 259  Central African Republic 1982    2476971    Africa 48.29500
    ## 260  Central African Republic 1987    2840009    Africa 50.48500
    ## 261  Central African Republic 1992    3265124    Africa 49.39600
    ## 262  Central African Republic 1997    3696513    Africa 46.06600
    ## 263  Central African Republic 2002    4048013    Africa 43.30800
    ## 264  Central African Republic 2007    4369038    Africa 44.74100
    ## 265                      Chad 1952    2682462    Africa 38.09200
    ## 266                      Chad 1957    2894855    Africa 39.88100
    ## 267                      Chad 1962    3150417    Africa 41.71600
    ## 268                      Chad 1967    3495967    Africa 43.60100
    ## 269                      Chad 1972    3899068    Africa 45.56900
    ## 270                      Chad 1977    4388260    Africa 47.38300
    ## 271                      Chad 1982    4875118    Africa 49.51700
    ## 272                      Chad 1987    5498955    Africa 51.05100
    ## 273                      Chad 1992    6429417    Africa 51.72400
    ## 274                      Chad 1997    7562011    Africa 51.57300
    ## 275                      Chad 2002    8835739    Africa 50.52500
    ## 276                      Chad 2007   10238807    Africa 50.65100
    ## 277                     Chile 1952    6377619  Americas 54.74500
    ## 278                     Chile 1957    7048426  Americas 56.07400
    ## 279                     Chile 1962    7961258  Americas 57.92400
    ## 280                     Chile 1967    8858908  Americas 60.52300
    ## 281                     Chile 1972    9717524  Americas 63.44100
    ## 282                     Chile 1977   10599793  Americas 67.05200
    ## 283                     Chile 1982   11487112  Americas 70.56500
    ## 284                     Chile 1987   12463354  Americas 72.49200
    ## 285                     Chile 1992   13572994  Americas 74.12600
    ## 286                     Chile 1997   14599929  Americas 75.81600
    ## 287                     Chile 2002   15497046  Americas 77.86000
    ## 288                     Chile 2007   16284741  Americas 78.55300
    ## 289                     China 1952  556263528      Asia 44.00000
    ## 290                     China 1957  637408000      Asia 50.54896
    ## 291                     China 1962  665770000      Asia 44.50136
    ## 292                     China 1967  754550000      Asia 58.38112
    ## 293                     China 1972  862030000      Asia 63.11888
    ## 294                     China 1977  943455000      Asia 63.96736
    ## 295                     China 1982 1000281000      Asia 65.52500
    ## 296                     China 1987 1084035000      Asia 67.27400
    ## 297                     China 1992 1164970000      Asia 68.69000
    ## 298                     China 1997 1230075000      Asia 70.42600
    ## 299                     China 2002 1280400000      Asia 72.02800
    ## 300                     China 2007 1318683096      Asia 72.96100
    ## 301                  Colombia 1952   12350771  Americas 50.64300
    ## 302                  Colombia 1957   14485993  Americas 55.11800
    ## 303                  Colombia 1962   17009885  Americas 57.86300
    ## 304                  Colombia 1967   19764027  Americas 59.96300
    ## 305                  Colombia 1972   22542890  Americas 61.62300
    ## 306                  Colombia 1977   25094412  Americas 63.83700
    ## 307                  Colombia 1982   27764644  Americas 66.65300
    ## 308                  Colombia 1987   30964245  Americas 67.76800
    ## 309                  Colombia 1992   34202721  Americas 68.42100
    ## 310                  Colombia 1997   37657830  Americas 70.31300
    ## 311                  Colombia 2002   41008227  Americas 71.68200
    ## 312                  Colombia 2007   44227550  Americas 72.88900
    ## 313                   Comoros 1952     153936    Africa 40.71500
    ## 314                   Comoros 1957     170928    Africa 42.46000
    ## 315                   Comoros 1962     191689    Africa 44.46700
    ## 316                   Comoros 1967     217378    Africa 46.47200
    ## 317                   Comoros 1972     250027    Africa 48.94400
    ## 318                   Comoros 1977     304739    Africa 50.93900
    ## 319                   Comoros 1982     348643    Africa 52.93300
    ## 320                   Comoros 1987     395114    Africa 54.92600
    ## 321                   Comoros 1992     454429    Africa 57.93900
    ## 322                   Comoros 1997     527982    Africa 60.66000
    ## 323                   Comoros 2002     614382    Africa 62.97400
    ## 324                   Comoros 2007     710960    Africa 65.15200
    ## 325           Congo Dem. Rep. 1952   14100005    Africa 39.14300
    ## 326           Congo Dem. Rep. 1957   15577932    Africa 40.65200
    ## 327           Congo Dem. Rep. 1962   17486434    Africa 42.12200
    ## 328           Congo Dem. Rep. 1967   19941073    Africa 44.05600
    ## 329           Congo Dem. Rep. 1972   23007669    Africa 45.98900
    ## 330           Congo Dem. Rep. 1977   26480870    Africa 47.80400
    ## 331           Congo Dem. Rep. 1982   30646495    Africa 47.78400
    ## 332           Congo Dem. Rep. 1987   35481645    Africa 47.41200
    ## 333           Congo Dem. Rep. 1992   41672143    Africa 45.54800
    ## 334           Congo Dem. Rep. 1997   47798986    Africa 42.58700
    ## 335           Congo Dem. Rep. 2002   55379852    Africa 44.96600
    ## 336           Congo Dem. Rep. 2007   64606759    Africa 46.46200
    ## 337                Congo Rep. 1952     854885    Africa 42.11100
    ## 338                Congo Rep. 1957     940458    Africa 45.05300
    ## 339                Congo Rep. 1962    1047924    Africa 48.43500
    ## 340                Congo Rep. 1967    1179760    Africa 52.04000
    ## 341                Congo Rep. 1972    1340458    Africa 54.90700
    ## 342                Congo Rep. 1977    1536769    Africa 55.62500
    ## 343                Congo Rep. 1982    1774735    Africa 56.69500
    ## 344                Congo Rep. 1987    2064095    Africa 57.47000
    ## 345                Congo Rep. 1992    2409073    Africa 56.43300
    ## 346                Congo Rep. 1997    2800947    Africa 52.96200
    ## 347                Congo Rep. 2002    3328795    Africa 52.97000
    ## 348                Congo Rep. 2007    3800610    Africa 55.32200
    ## 349                Costa Rica 1952     926317  Americas 57.20600
    ## 350                Costa Rica 1957    1112300  Americas 60.02600
    ## 351                Costa Rica 1962    1345187  Americas 62.84200
    ## 352                Costa Rica 1967    1588717  Americas 65.42400
    ## 353                Costa Rica 1972    1834796  Americas 67.84900
    ## 354                Costa Rica 1977    2108457  Americas 70.75000
    ## 355                Costa Rica 1982    2424367  Americas 73.45000
    ## 356                Costa Rica 1987    2799811  Americas 74.75200
    ## 357                Costa Rica 1992    3173216  Americas 75.71300
    ## 358                Costa Rica 1997    3518107  Americas 77.26000
    ## 359                Costa Rica 2002    3834934  Americas 78.12300
    ## 360                Costa Rica 2007    4133884  Americas 78.78200
    ## 361             Cote d'Ivoire 1952    2977019    Africa 40.47700
    ## 362             Cote d'Ivoire 1957    3300000    Africa 42.46900
    ## 363             Cote d'Ivoire 1962    3832408    Africa 44.93000
    ## 364             Cote d'Ivoire 1967    4744870    Africa 47.35000
    ## 365             Cote d'Ivoire 1972    6071696    Africa 49.80100
    ## 366             Cote d'Ivoire 1977    7459574    Africa 52.37400
    ## 367             Cote d'Ivoire 1982    9025951    Africa 53.98300
    ## 368             Cote d'Ivoire 1987   10761098    Africa 54.65500
    ## 369             Cote d'Ivoire 1992   12772596    Africa 52.04400
    ## 370             Cote d'Ivoire 1997   14625967    Africa 47.99100
    ## 371             Cote d'Ivoire 2002   16252726    Africa 46.83200
    ## 372             Cote d'Ivoire 2007   18013409    Africa 48.32800
    ## 373                   Croatia 1952    3882229    Europe 61.21000
    ## 374                   Croatia 1957    3991242    Europe 64.77000
    ## 375                   Croatia 1962    4076557    Europe 67.13000
    ## 376                   Croatia 1967    4174366    Europe 68.50000
    ## 377                   Croatia 1972    4225310    Europe 69.61000
    ## 378                   Croatia 1977    4318673    Europe 70.64000
    ## 379                   Croatia 1982    4413368    Europe 70.46000
    ## 380                   Croatia 1987    4484310    Europe 71.52000
    ## 381                   Croatia 1992    4494013    Europe 72.52700
    ## 382                   Croatia 1997    4444595    Europe 73.68000
    ## 383                   Croatia 2002    4481020    Europe 74.87600
    ## 384                   Croatia 2007    4493312    Europe 75.74800
    ## 385                      Cuba 1952    6007797  Americas 59.42100
    ## 386                      Cuba 1957    6640752  Americas 62.32500
    ## 387                      Cuba 1962    7254373  Americas 65.24600
    ## 388                      Cuba 1967    8139332  Americas 68.29000
    ## 389                      Cuba 1972    8831348  Americas 70.72300
    ## 390                      Cuba 1977    9537988  Americas 72.64900
    ## 391                      Cuba 1982    9789224  Americas 73.71700
    ## 392                      Cuba 1987   10239839  Americas 74.17400
    ## 393                      Cuba 1992   10723260  Americas 74.41400
    ## 394                      Cuba 1997   10983007  Americas 76.15100
    ## 395                      Cuba 2002   11226999  Americas 77.15800
    ## 396                      Cuba 2007   11416987  Americas 78.27300
    ## 397            Czech Republic 1952    9125183    Europe 66.87000
    ## 398            Czech Republic 1957    9513758    Europe 69.03000
    ## 399            Czech Republic 1962    9620282    Europe 69.90000
    ## 400            Czech Republic 1967    9835109    Europe 70.38000
    ## 401            Czech Republic 1972    9862158    Europe 70.29000
    ## 402            Czech Republic 1977   10161915    Europe 70.71000
    ## 403            Czech Republic 1982   10303704    Europe 70.96000
    ## 404            Czech Republic 1987   10311597    Europe 71.58000
    ## 405            Czech Republic 1992   10315702    Europe 72.40000
    ## 406            Czech Republic 1997   10300707    Europe 74.01000
    ## 407            Czech Republic 2002   10256295    Europe 75.51000
    ## 408            Czech Republic 2007   10228744    Europe 76.48600
    ## 409                   Denmark 1952    4334000    Europe 70.78000
    ## 410                   Denmark 1957    4487831    Europe 71.81000
    ## 411                   Denmark 1962    4646899    Europe 72.35000
    ## 412                   Denmark 1967    4838800    Europe 72.96000
    ## 413                   Denmark 1972    4991596    Europe 73.47000
    ## 414                   Denmark 1977    5088419    Europe 74.69000
    ## 415                   Denmark 1982    5117810    Europe 74.63000
    ## 416                   Denmark 1987    5127024    Europe 74.80000
    ## 417                   Denmark 1992    5171393    Europe 75.33000
    ## 418                   Denmark 1997    5283663    Europe 76.11000
    ## 419                   Denmark 2002    5374693    Europe 77.18000
    ## 420                   Denmark 2007    5468120    Europe 78.33200
    ## 421                  Djibouti 1952      63149    Africa 34.81200
    ## 422                  Djibouti 1957      71851    Africa 37.32800
    ## 423                  Djibouti 1962      89898    Africa 39.69300
    ## 424                  Djibouti 1967     127617    Africa 42.07400
    ## 425                  Djibouti 1972     178848    Africa 44.36600
    ## 426                  Djibouti 1977     228694    Africa 46.51900
    ## 427                  Djibouti 1982     305991    Africa 48.81200
    ## 428                  Djibouti 1987     311025    Africa 50.04000
    ## 429                  Djibouti 1992     384156    Africa 51.60400
    ## 430                  Djibouti 1997     417908    Africa 53.15700
    ## 431                  Djibouti 2002     447416    Africa 53.37300
    ## 432                  Djibouti 2007     496374    Africa 54.79100
    ## 433        Dominican Republic 1952    2491346  Americas 45.92800
    ## 434        Dominican Republic 1957    2923186  Americas 49.82800
    ## 435        Dominican Republic 1962    3453434  Americas 53.45900
    ## 436        Dominican Republic 1967    4049146  Americas 56.75100
    ## 437        Dominican Republic 1972    4671329  Americas 59.63100
    ## 438        Dominican Republic 1977    5302800  Americas 61.78800
    ## 439        Dominican Republic 1982    5968349  Americas 63.72700
    ## 440        Dominican Republic 1987    6655297  Americas 66.04600
    ## 441        Dominican Republic 1992    7351181  Americas 68.45700
    ## 442        Dominican Republic 1997    7992357  Americas 69.95700
    ## 443        Dominican Republic 2002    8650322  Americas 70.84700
    ## 444        Dominican Republic 2007    9319622  Americas 72.23500
    ## 445                   Ecuador 1952    3548753  Americas 48.35700
    ## 446                   Ecuador 1957    4058385  Americas 51.35600
    ## 447                   Ecuador 1962    4681707  Americas 54.64000
    ## 448                   Ecuador 1967    5432424  Americas 56.67800
    ## 449                   Ecuador 1972    6298651  Americas 58.79600
    ## 450                   Ecuador 1977    7278866  Americas 61.31000
    ## 451                   Ecuador 1982    8365850  Americas 64.34200
    ## 452                   Ecuador 1987    9545158  Americas 67.23100
    ## 453                   Ecuador 1992   10748394  Americas 69.61300
    ## 454                   Ecuador 1997   11911819  Americas 72.31200
    ## 455                   Ecuador 2002   12921234  Americas 74.17300
    ## 456                   Ecuador 2007   13755680  Americas 74.99400
    ## 457                     Egypt 1952   22223309    Africa 41.89300
    ## 458                     Egypt 1957   25009741    Africa 44.44400
    ## 459                     Egypt 1962   28173309    Africa 46.99200
    ## 460                     Egypt 1967   31681188    Africa 49.29300
    ## 461                     Egypt 1972   34807417    Africa 51.13700
    ## 462                     Egypt 1977   38783863    Africa 53.31900
    ## 463                     Egypt 1982   45681811    Africa 56.00600
    ## 464                     Egypt 1987   52799062    Africa 59.79700
    ## 465                     Egypt 1992   59402198    Africa 63.67400
    ## 466                     Egypt 1997   66134291    Africa 67.21700
    ## 467                     Egypt 2002   73312559    Africa 69.80600
    ## 468                     Egypt 2007   80264543    Africa 71.33800
    ## 469               El Salvador 1952    2042865  Americas 45.26200
    ## 470               El Salvador 1957    2355805  Americas 48.57000
    ## 471               El Salvador 1962    2747687  Americas 52.30700
    ## 472               El Salvador 1967    3232927  Americas 55.85500
    ## 473               El Salvador 1972    3790903  Americas 58.20700
    ## 474               El Salvador 1977    4282586  Americas 56.69600
    ## 475               El Salvador 1982    4474873  Americas 56.60400
    ## 476               El Salvador 1987    4842194  Americas 63.15400
    ## 477               El Salvador 1992    5274649  Americas 66.79800
    ## 478               El Salvador 1997    5783439  Americas 69.53500
    ## 479               El Salvador 2002    6353681  Americas 70.73400
    ## 480               El Salvador 2007    6939688  Americas 71.87800
    ## 481         Equatorial Guinea 1952     216964    Africa 34.48200
    ## 482         Equatorial Guinea 1957     232922    Africa 35.98300
    ## 483         Equatorial Guinea 1962     249220    Africa 37.48500
    ## 484         Equatorial Guinea 1967     259864    Africa 38.98700
    ## 485         Equatorial Guinea 1972     277603    Africa 40.51600
    ## 486         Equatorial Guinea 1977     192675    Africa 42.02400
    ## 487         Equatorial Guinea 1982     285483    Africa 43.66200
    ## 488         Equatorial Guinea 1987     341244    Africa 45.66400
    ## 489         Equatorial Guinea 1992     387838    Africa 47.54500
    ## 490         Equatorial Guinea 1997     439971    Africa 48.24500
    ## 491         Equatorial Guinea 2002     495627    Africa 49.34800
    ## 492         Equatorial Guinea 2007     551201    Africa 51.57900
    ## 493                   Eritrea 1952    1438760    Africa 35.92800
    ## 494                   Eritrea 1957    1542611    Africa 38.04700
    ## 495                   Eritrea 1962    1666618    Africa 40.15800
    ## 496                   Eritrea 1967    1820319    Africa 42.18900
    ## 497                   Eritrea 1972    2260187    Africa 44.14200
    ## 498                   Eritrea 1977    2512642    Africa 44.53500
    ## 499                   Eritrea 1982    2637297    Africa 43.89000
    ## 500                   Eritrea 1987    2915959    Africa 46.45300
    ## 501                   Eritrea 1992    3668440    Africa 49.99100
    ## 502                   Eritrea 1997    4058319    Africa 53.37800
    ## 503                   Eritrea 2002    4414865    Africa 55.24000
    ## 504                   Eritrea 2007    4906585    Africa 58.04000
    ## 505                  Ethiopia 1952   20860941    Africa 34.07800
    ## 506                  Ethiopia 1957   22815614    Africa 36.66700
    ## 507                  Ethiopia 1962   25145372    Africa 40.05900
    ## 508                  Ethiopia 1967   27860297    Africa 42.11500
    ## 509                  Ethiopia 1972   30770372    Africa 43.51500
    ## 510                  Ethiopia 1977   34617799    Africa 44.51000
    ## 511                  Ethiopia 1982   38111756    Africa 44.91600
    ## 512                  Ethiopia 1987   42999530    Africa 46.68400
    ## 513                  Ethiopia 1992   52088559    Africa 48.09100
    ## 514                  Ethiopia 1997   59861301    Africa 49.40200
    ## 515                  Ethiopia 2002   67946797    Africa 50.72500
    ## 516                  Ethiopia 2007   76511887    Africa 52.94700
    ## 517                   Finland 1952    4090500    Europe 66.55000
    ## 518                   Finland 1957    4324000    Europe 67.49000
    ## 519                   Finland 1962    4491443    Europe 68.75000
    ## 520                   Finland 1967    4605744    Europe 69.83000
    ## 521                   Finland 1972    4639657    Europe 70.87000
    ## 522                   Finland 1977    4738902    Europe 72.52000
    ## 523                   Finland 1982    4826933    Europe 74.55000
    ## 524                   Finland 1987    4931729    Europe 74.83000
    ## 525                   Finland 1992    5041039    Europe 75.70000
    ## 526                   Finland 1997    5134406    Europe 77.13000
    ## 527                   Finland 2002    5193039    Europe 78.37000
    ## 528                   Finland 2007    5238460    Europe 79.31300
    ## 529                     Gabon 1952     420702    Africa 37.00300
    ## 530                     Gabon 1957     434904    Africa 38.99900
    ## 531                     Gabon 1962     455661    Africa 40.48900
    ## 532                     Gabon 1967     489004    Africa 44.59800
    ## 533                     Gabon 1972     537977    Africa 48.69000
    ## 534                     Gabon 1977     706367    Africa 52.79000
    ## 535                     Gabon 1982     753874    Africa 56.56400
    ## 536                     Gabon 1987     880397    Africa 60.19000
    ## 537                     Gabon 1992     985739    Africa 61.36600
    ## 538                     Gabon 1997    1126189    Africa 60.46100
    ## 539                     Gabon 2002    1299304    Africa 56.76100
    ## 540                     Gabon 2007    1454867    Africa 56.73500
    ## 541                    Gambia 1952     284320    Africa 30.00000
    ## 542                    Gambia 1957     323150    Africa 32.06500
    ## 543                    Gambia 1962     374020    Africa 33.89600
    ## 544                    Gambia 1967     439593    Africa 35.85700
    ## 545                    Gambia 1972     517101    Africa 38.30800
    ## 546                    Gambia 1977     608274    Africa 41.84200
    ## 547                    Gambia 1982     715523    Africa 45.58000
    ## 548                    Gambia 1987     848406    Africa 49.26500
    ## 549                    Gambia 1992    1025384    Africa 52.64400
    ## 550                    Gambia 1997    1235767    Africa 55.86100
    ## 551                    Gambia 2002    1457766    Africa 58.04100
    ## 552                    Gambia 2007    1688359    Africa 59.44800
    ## 553                   Germany 1952   69145952    Europe 67.50000
    ## 554                   Germany 1957   71019069    Europe 69.10000
    ## 555                   Germany 1962   73739117    Europe 70.30000
    ## 556                   Germany 1967   76368453    Europe 70.80000
    ## 557                   Germany 1972   78717088    Europe 71.00000
    ## 558                   Germany 1977   78160773    Europe 72.50000
    ## 559                   Germany 1982   78335266    Europe 73.80000
    ## 560                   Germany 1987   77718298    Europe 74.84700
    ## 561                   Germany 1992   80597764    Europe 76.07000
    ## 562                   Germany 1997   82011073    Europe 77.34000
    ## 563                   Germany 2002   82350671    Europe 78.67000
    ## 564                   Germany 2007   82400996    Europe 79.40600
    ## 565                     Ghana 1952    5581001    Africa 43.14900
    ## 566                     Ghana 1957    6391288    Africa 44.77900
    ## 567                     Ghana 1962    7355248    Africa 46.45200
    ## 568                     Ghana 1967    8490213    Africa 48.07200
    ## 569                     Ghana 1972    9354120    Africa 49.87500
    ## 570                     Ghana 1977   10538093    Africa 51.75600
    ## 571                     Ghana 1982   11400338    Africa 53.74400
    ## 572                     Ghana 1987   14168101    Africa 55.72900
    ## 573                     Ghana 1992   16278738    Africa 57.50100
    ## 574                     Ghana 1997   18418288    Africa 58.55600
    ## 575                     Ghana 2002   20550751    Africa 58.45300
    ## 576                     Ghana 2007   22873338    Africa 60.02200
    ## 577                    Greece 1952    7733250    Europe 65.86000
    ## 578                    Greece 1957    8096218    Europe 67.86000
    ## 579                    Greece 1962    8448233    Europe 69.51000
    ## 580                    Greece 1967    8716441    Europe 71.00000
    ## 581                    Greece 1972    8888628    Europe 72.34000
    ## 582                    Greece 1977    9308479    Europe 73.68000
    ## 583                    Greece 1982    9786480    Europe 75.24000
    ## 584                    Greece 1987    9974490    Europe 76.67000
    ## 585                    Greece 1992   10325429    Europe 77.03000
    ## 586                    Greece 1997   10502372    Europe 77.86900
    ## 587                    Greece 2002   10603863    Europe 78.25600
    ## 588                    Greece 2007   10706290    Europe 79.48300
    ## 589                 Guatemala 1952    3146381  Americas 42.02300
    ## 590                 Guatemala 1957    3640876  Americas 44.14200
    ## 591                 Guatemala 1962    4208858  Americas 46.95400
    ## 592                 Guatemala 1967    4690773  Americas 50.01600
    ## 593                 Guatemala 1972    5149581  Americas 53.73800
    ## 594                 Guatemala 1977    5703430  Americas 56.02900
    ## 595                 Guatemala 1982    6395630  Americas 58.13700
    ## 596                 Guatemala 1987    7326406  Americas 60.78200
    ## 597                 Guatemala 1992    8486949  Americas 63.37300
    ## 598                 Guatemala 1997    9803875  Americas 66.32200
    ## 599                 Guatemala 2002   11178650  Americas 68.97800
    ## 600                 Guatemala 2007   12572928  Americas 70.25900
    ## 601                    Guinea 1952    2664249    Africa 33.60900
    ## 602                    Guinea 1957    2876726    Africa 34.55800
    ## 603                    Guinea 1962    3140003    Africa 35.75300
    ## 604                    Guinea 1967    3451418    Africa 37.19700
    ## 605                    Guinea 1972    3811387    Africa 38.84200
    ## 606                    Guinea 1977    4227026    Africa 40.76200
    ## 607                    Guinea 1982    4710497    Africa 42.89100
    ## 608                    Guinea 1987    5650262    Africa 45.55200
    ## 609                    Guinea 1992    6990574    Africa 48.57600
    ## 610                    Guinea 1997    8048834    Africa 51.45500
    ## 611                    Guinea 2002    8807818    Africa 53.67600
    ## 612                    Guinea 2007    9947814    Africa 56.00700
    ## 613             Guinea-Bissau 1952     580653    Africa 32.50000
    ## 614             Guinea-Bissau 1957     601095    Africa 33.48900
    ## 615             Guinea-Bissau 1962     627820    Africa 34.48800
    ## 616             Guinea-Bissau 1967     601287    Africa 35.49200
    ## 617             Guinea-Bissau 1972     625361    Africa 36.48600
    ## 618             Guinea-Bissau 1977     745228    Africa 37.46500
    ## 619             Guinea-Bissau 1982     825987    Africa 39.32700
    ## 620             Guinea-Bissau 1987     927524    Africa 41.24500
    ## 621             Guinea-Bissau 1992    1050938    Africa 43.26600
    ## 622             Guinea-Bissau 1997    1193708    Africa 44.87300
    ## 623             Guinea-Bissau 2002    1332459    Africa 45.50400
    ## 624             Guinea-Bissau 2007    1472041    Africa 46.38800
    ## 625                     Haiti 1952    3201488  Americas 37.57900
    ## 626                     Haiti 1957    3507701  Americas 40.69600
    ## 627                     Haiti 1962    3880130  Americas 43.59000
    ## 628                     Haiti 1967    4318137  Americas 46.24300
    ## 629                     Haiti 1972    4698301  Americas 48.04200
    ## 630                     Haiti 1977    4908554  Americas 49.92300
    ## 631                     Haiti 1982    5198399  Americas 51.46100
    ## 632                     Haiti 1987    5756203  Americas 53.63600
    ## 633                     Haiti 1992    6326682  Americas 55.08900
    ## 634                     Haiti 1997    6913545  Americas 56.67100
    ## 635                     Haiti 2002    7607651  Americas 58.13700
    ## 636                     Haiti 2007    8502814  Americas 60.91600
    ## 637                  Honduras 1952    1517453  Americas 41.91200
    ## 638                  Honduras 1957    1770390  Americas 44.66500
    ## 639                  Honduras 1962    2090162  Americas 48.04100
    ## 640                  Honduras 1967    2500689  Americas 50.92400
    ## 641                  Honduras 1972    2965146  Americas 53.88400
    ## 642                  Honduras 1977    3055235  Americas 57.40200
    ## 643                  Honduras 1982    3669448  Americas 60.90900
    ## 644                  Honduras 1987    4372203  Americas 64.49200
    ## 645                  Honduras 1992    5077347  Americas 66.39900
    ## 646                  Honduras 1997    5867957  Americas 67.65900
    ## 647                  Honduras 2002    6677328  Americas 68.56500
    ## 648                  Honduras 2007    7483763  Americas 70.19800
    ## 649           Hong Kong China 1952    2125900      Asia 60.96000
    ## 650           Hong Kong China 1957    2736300      Asia 64.75000
    ## 651           Hong Kong China 1962    3305200      Asia 67.65000
    ## 652           Hong Kong China 1967    3722800      Asia 70.00000
    ## 653           Hong Kong China 1972    4115700      Asia 72.00000
    ## 654           Hong Kong China 1977    4583700      Asia 73.60000
    ## 655           Hong Kong China 1982    5264500      Asia 75.45000
    ## 656           Hong Kong China 1987    5584510      Asia 76.20000
    ## 657           Hong Kong China 1992    5829696      Asia 77.60100
    ## 658           Hong Kong China 1997    6495918      Asia 80.00000
    ## 659           Hong Kong China 2002    6762476      Asia 81.49500
    ## 660           Hong Kong China 2007    6980412      Asia 82.20800
    ## 661                   Hungary 1952    9504000    Europe 64.03000
    ## 662                   Hungary 1957    9839000    Europe 66.41000
    ## 663                   Hungary 1962   10063000    Europe 67.96000
    ## 664                   Hungary 1967   10223422    Europe 69.50000
    ## 665                   Hungary 1972   10394091    Europe 69.76000
    ## 666                   Hungary 1977   10637171    Europe 69.95000
    ## 667                   Hungary 1982   10705535    Europe 69.39000
    ## 668                   Hungary 1987   10612740    Europe 69.58000
    ## 669                   Hungary 1992   10348684    Europe 69.17000
    ## 670                   Hungary 1997   10244684    Europe 71.04000
    ## 671                   Hungary 2002   10083313    Europe 72.59000
    ## 672                   Hungary 2007    9956108    Europe 73.33800
    ## 673                   Iceland 1952     147962    Europe 72.49000
    ## 674                   Iceland 1957     165110    Europe 73.47000
    ## 675                   Iceland 1962     182053    Europe 73.68000
    ## 676                   Iceland 1967     198676    Europe 73.73000
    ## 677                   Iceland 1972     209275    Europe 74.46000
    ## 678                   Iceland 1977     221823    Europe 76.11000
    ## 679                   Iceland 1982     233997    Europe 76.99000
    ## 680                   Iceland 1987     244676    Europe 77.23000
    ## 681                   Iceland 1992     259012    Europe 78.77000
    ## 682                   Iceland 1997     271192    Europe 78.95000
    ## 683                   Iceland 2002     288030    Europe 80.50000
    ## 684                   Iceland 2007     301931    Europe 81.75700
    ## 685                     India 1952  372000000      Asia 37.37300
    ## 686                     India 1957  409000000      Asia 40.24900
    ## 687                     India 1962  454000000      Asia 43.60500
    ## 688                     India 1967  506000000      Asia 47.19300
    ## 689                     India 1972  567000000      Asia 50.65100
    ## 690                     India 1977  634000000      Asia 54.20800
    ## 691                     India 1982  708000000      Asia 56.59600
    ## 692                     India 1987  788000000      Asia 58.55300
    ## 693                     India 1992  872000000      Asia 60.22300
    ## 694                     India 1997  959000000      Asia 61.76500
    ## 695                     India 2002 1034172547      Asia 62.87900
    ## 696                     India 2007 1110396331      Asia 64.69800
    ## 697                 Indonesia 1952   82052000      Asia 37.46800
    ## 698                 Indonesia 1957   90124000      Asia 39.91800
    ## 699                 Indonesia 1962   99028000      Asia 42.51800
    ## 700                 Indonesia 1967  109343000      Asia 45.96400
    ## 701                 Indonesia 1972  121282000      Asia 49.20300
    ## 702                 Indonesia 1977  136725000      Asia 52.70200
    ## 703                 Indonesia 1982  153343000      Asia 56.15900
    ## 704                 Indonesia 1987  169276000      Asia 60.13700
    ## 705                 Indonesia 1992  184816000      Asia 62.68100
    ## 706                 Indonesia 1997  199278000      Asia 66.04100
    ## 707                 Indonesia 2002  211060000      Asia 68.58800
    ## 708                 Indonesia 2007  223547000      Asia 70.65000
    ## 709                      Iran 1952   17272000      Asia 44.86900
    ## 710                      Iran 1957   19792000      Asia 47.18100
    ## 711                      Iran 1962   22874000      Asia 49.32500
    ## 712                      Iran 1967   26538000      Asia 52.46900
    ## 713                      Iran 1972   30614000      Asia 55.23400
    ## 714                      Iran 1977   35480679      Asia 57.70200
    ## 715                      Iran 1982   43072751      Asia 59.62000
    ## 716                      Iran 1987   51889696      Asia 63.04000
    ## 717                      Iran 1992   60397973      Asia 65.74200
    ## 718                      Iran 1997   63327987      Asia 68.04200
    ## 719                      Iran 2002   66907826      Asia 69.45100
    ## 720                      Iran 2007   69453570      Asia 70.96400
    ## 721                      Iraq 1952    5441766      Asia 45.32000
    ## 722                      Iraq 1957    6248643      Asia 48.43700
    ## 723                      Iraq 1962    7240260      Asia 51.45700
    ## 724                      Iraq 1967    8519282      Asia 54.45900
    ## 725                      Iraq 1972   10061506      Asia 56.95000
    ## 726                      Iraq 1977   11882916      Asia 60.41300
    ## 727                      Iraq 1982   14173318      Asia 62.03800
    ## 728                      Iraq 1987   16543189      Asia 65.04400
    ## 729                      Iraq 1992   17861905      Asia 59.46100
    ## 730                      Iraq 1997   20775703      Asia 58.81100
    ## 731                      Iraq 2002   24001816      Asia 57.04600
    ## 732                      Iraq 2007   27499638      Asia 59.54500
    ## 733                   Ireland 1952    2952156    Europe 66.91000
    ## 734                   Ireland 1957    2878220    Europe 68.90000
    ## 735                   Ireland 1962    2830000    Europe 70.29000
    ## 736                   Ireland 1967    2900100    Europe 71.08000
    ## 737                   Ireland 1972    3024400    Europe 71.28000
    ## 738                   Ireland 1977    3271900    Europe 72.03000
    ## 739                   Ireland 1982    3480000    Europe 73.10000
    ## 740                   Ireland 1987    3539900    Europe 74.36000
    ## 741                   Ireland 1992    3557761    Europe 75.46700
    ## 742                   Ireland 1997    3667233    Europe 76.12200
    ## 743                   Ireland 2002    3879155    Europe 77.78300
    ## 744                   Ireland 2007    4109086    Europe 78.88500
    ## 745                    Israel 1952    1620914      Asia 65.39000
    ## 746                    Israel 1957    1944401      Asia 67.84000
    ## 747                    Israel 1962    2310904      Asia 69.39000
    ## 748                    Israel 1967    2693585      Asia 70.75000
    ## 749                    Israel 1972    3095893      Asia 71.63000
    ## 750                    Israel 1977    3495918      Asia 73.06000
    ## 751                    Israel 1982    3858421      Asia 74.45000
    ## 752                    Israel 1987    4203148      Asia 75.60000
    ## 753                    Israel 1992    4936550      Asia 76.93000
    ## 754                    Israel 1997    5531387      Asia 78.26900
    ## 755                    Israel 2002    6029529      Asia 79.69600
    ## 756                    Israel 2007    6426679      Asia 80.74500
    ## 757                     Italy 1952   47666000    Europe 65.94000
    ## 758                     Italy 1957   49182000    Europe 67.81000
    ## 759                     Italy 1962   50843200    Europe 69.24000
    ## 760                     Italy 1967   52667100    Europe 71.06000
    ## 761                     Italy 1972   54365564    Europe 72.19000
    ## 762                     Italy 1977   56059245    Europe 73.48000
    ## 763                     Italy 1982   56535636    Europe 74.98000
    ## 764                     Italy 1987   56729703    Europe 76.42000
    ## 765                     Italy 1992   56840847    Europe 77.44000
    ## 766                     Italy 1997   57479469    Europe 78.82000
    ## 767                     Italy 2002   57926999    Europe 80.24000
    ## 768                     Italy 2007   58147733    Europe 80.54600
    ## 769                   Jamaica 1952    1426095  Americas 58.53000
    ## 770                   Jamaica 1957    1535090  Americas 62.61000
    ## 771                   Jamaica 1962    1665128  Americas 65.61000
    ## 772                   Jamaica 1967    1861096  Americas 67.51000
    ## 773                   Jamaica 1972    1997616  Americas 69.00000
    ## 774                   Jamaica 1977    2156814  Americas 70.11000
    ## 775                   Jamaica 1982    2298309  Americas 71.21000
    ## 776                   Jamaica 1987    2326606  Americas 71.77000
    ## 777                   Jamaica 1992    2378618  Americas 71.76600
    ## 778                   Jamaica 1997    2531311  Americas 72.26200
    ## 779                   Jamaica 2002    2664659  Americas 72.04700
    ## 780                   Jamaica 2007    2780132  Americas 72.56700
    ## 781                     Japan 1952   86459025      Asia 63.03000
    ## 782                     Japan 1957   91563009      Asia 65.50000
    ## 783                     Japan 1962   95831757      Asia 68.73000
    ## 784                     Japan 1967  100825279      Asia 71.43000
    ## 785                     Japan 1972  107188273      Asia 73.42000
    ## 786                     Japan 1977  113872473      Asia 75.38000
    ## 787                     Japan 1982  118454974      Asia 77.11000
    ## 788                     Japan 1987  122091325      Asia 78.67000
    ## 789                     Japan 1992  124329269      Asia 79.36000
    ## 790                     Japan 1997  125956499      Asia 80.69000
    ## 791                     Japan 2002  127065841      Asia 82.00000
    ## 792                     Japan 2007  127467972      Asia 82.60300
    ## 793                    Jordan 1952     607914      Asia 43.15800
    ## 794                    Jordan 1957     746559      Asia 45.66900
    ## 795                    Jordan 1962     933559      Asia 48.12600
    ## 796                    Jordan 1967    1255058      Asia 51.62900
    ## 797                    Jordan 1972    1613551      Asia 56.52800
    ## 798                    Jordan 1977    1937652      Asia 61.13400
    ## 799                    Jordan 1982    2347031      Asia 63.73900
    ## 800                    Jordan 1987    2820042      Asia 65.86900
    ## 801                    Jordan 1992    3867409      Asia 68.01500
    ## 802                    Jordan 1997    4526235      Asia 69.77200
    ## 803                    Jordan 2002    5307470      Asia 71.26300
    ## 804                    Jordan 2007    6053193      Asia 72.53500
    ## 805                     Kenya 1952    6464046    Africa 42.27000
    ## 806                     Kenya 1957    7454779    Africa 44.68600
    ## 807                     Kenya 1962    8678557    Africa 47.94900
    ## 808                     Kenya 1967   10191512    Africa 50.65400
    ## 809                     Kenya 1972   12044785    Africa 53.55900
    ## 810                     Kenya 1977   14500404    Africa 56.15500
    ## 811                     Kenya 1982   17661452    Africa 58.76600
    ## 812                     Kenya 1987   21198082    Africa 59.33900
    ## 813                     Kenya 1992   25020539    Africa 59.28500
    ## 814                     Kenya 1997   28263827    Africa 54.40700
    ## 815                     Kenya 2002   31386842    Africa 50.99200
    ## 816                     Kenya 2007   35610177    Africa 54.11000
    ## 817           Korea Dem. Rep. 1952    8865488      Asia 50.05600
    ## 818           Korea Dem. Rep. 1957    9411381      Asia 54.08100
    ## 819           Korea Dem. Rep. 1962   10917494      Asia 56.65600
    ## 820           Korea Dem. Rep. 1967   12617009      Asia 59.94200
    ## 821           Korea Dem. Rep. 1972   14781241      Asia 63.98300
    ## 822           Korea Dem. Rep. 1977   16325320      Asia 67.15900
    ## 823           Korea Dem. Rep. 1982   17647518      Asia 69.10000
    ## 824           Korea Dem. Rep. 1987   19067554      Asia 70.64700
    ## 825           Korea Dem. Rep. 1992   20711375      Asia 69.97800
    ## 826           Korea Dem. Rep. 1997   21585105      Asia 67.72700
    ## 827           Korea Dem. Rep. 2002   22215365      Asia 66.66200
    ## 828           Korea Dem. Rep. 2007   23301725      Asia 67.29700
    ## 829                Korea Rep. 1952   20947571      Asia 47.45300
    ## 830                Korea Rep. 1957   22611552      Asia 52.68100
    ## 831                Korea Rep. 1962   26420307      Asia 55.29200
    ## 832                Korea Rep. 1967   30131000      Asia 57.71600
    ## 833                Korea Rep. 1972   33505000      Asia 62.61200
    ## 834                Korea Rep. 1977   36436000      Asia 64.76600
    ## 835                Korea Rep. 1982   39326000      Asia 67.12300
    ## 836                Korea Rep. 1987   41622000      Asia 69.81000
    ## 837                Korea Rep. 1992   43805450      Asia 72.24400
    ## 838                Korea Rep. 1997   46173816      Asia 74.64700
    ## 839                Korea Rep. 2002   47969150      Asia 77.04500
    ## 840                Korea Rep. 2007   49044790      Asia 78.62300
    ## 841                    Kuwait 1952     160000      Asia 55.56500
    ## 842                    Kuwait 1957     212846      Asia 58.03300
    ## 843                    Kuwait 1962     358266      Asia 60.47000
    ## 844                    Kuwait 1967     575003      Asia 64.62400
    ## 845                    Kuwait 1972     841934      Asia 67.71200
    ## 846                    Kuwait 1977    1140357      Asia 69.34300
    ## 847                    Kuwait 1982    1497494      Asia 71.30900
    ## 848                    Kuwait 1987    1891487      Asia 74.17400
    ## 849                    Kuwait 1992    1418095      Asia 75.19000
    ## 850                    Kuwait 1997    1765345      Asia 76.15600
    ## 851                    Kuwait 2002    2111561      Asia 76.90400
    ## 852                    Kuwait 2007    2505559      Asia 77.58800
    ## 853                   Lebanon 1952    1439529      Asia 55.92800
    ## 854                   Lebanon 1957    1647412      Asia 59.48900
    ## 855                   Lebanon 1962    1886848      Asia 62.09400
    ## 856                   Lebanon 1967    2186894      Asia 63.87000
    ## 857                   Lebanon 1972    2680018      Asia 65.42100
    ## 858                   Lebanon 1977    3115787      Asia 66.09900
    ## 859                   Lebanon 1982    3086876      Asia 66.98300
    ## 860                   Lebanon 1987    3089353      Asia 67.92600
    ## 861                   Lebanon 1992    3219994      Asia 69.29200
    ## 862                   Lebanon 1997    3430388      Asia 70.26500
    ## 863                   Lebanon 2002    3677780      Asia 71.02800
    ## 864                   Lebanon 2007    3921278      Asia 71.99300
    ## 865                   Lesotho 1952     748747    Africa 42.13800
    ## 866                   Lesotho 1957     813338    Africa 45.04700
    ## 867                   Lesotho 1962     893143    Africa 47.74700
    ## 868                   Lesotho 1967     996380    Africa 48.49200
    ## 869                   Lesotho 1972    1116779    Africa 49.76700
    ## 870                   Lesotho 1977    1251524    Africa 52.20800
    ## 871                   Lesotho 1982    1411807    Africa 55.07800
    ## 872                   Lesotho 1987    1599200    Africa 57.18000
    ## 873                   Lesotho 1992    1803195    Africa 59.68500
    ## 874                   Lesotho 1997    1982823    Africa 55.55800
    ## 875                   Lesotho 2002    2046772    Africa 44.59300
    ## 876                   Lesotho 2007    2012649    Africa 42.59200
    ## 877                   Liberia 1952     863308    Africa 38.48000
    ## 878                   Liberia 1957     975950    Africa 39.48600
    ## 879                   Liberia 1962    1112796    Africa 40.50200
    ## 880                   Liberia 1967    1279406    Africa 41.53600
    ## 881                   Liberia 1972    1482628    Africa 42.61400
    ## 882                   Liberia 1977    1703617    Africa 43.76400
    ## 883                   Liberia 1982    1956875    Africa 44.85200
    ## 884                   Liberia 1987    2269414    Africa 46.02700
    ## 885                   Liberia 1992    1912974    Africa 40.80200
    ## 886                   Liberia 1997    2200725    Africa 42.22100
    ## 887                   Liberia 2002    2814651    Africa 43.75300
    ## 888                   Liberia 2007    3193942    Africa 45.67800
    ## 889                     Libya 1952    1019729    Africa 42.72300
    ## 890                     Libya 1957    1201578    Africa 45.28900
    ## 891                     Libya 1962    1441863    Africa 47.80800
    ## 892                     Libya 1967    1759224    Africa 50.22700
    ## 893                     Libya 1972    2183877    Africa 52.77300
    ## 894                     Libya 1977    2721783    Africa 57.44200
    ## 895                     Libya 1982    3344074    Africa 62.15500
    ## 896                     Libya 1987    3799845    Africa 66.23400
    ## 897                     Libya 1992    4364501    Africa 68.75500
    ## 898                     Libya 1997    4759670    Africa 71.55500
    ## 899                     Libya 2002    5368585    Africa 72.73700
    ## 900                     Libya 2007    6036914    Africa 73.95200
    ## 901                Madagascar 1952    4762912    Africa 36.68100
    ## 902                Madagascar 1957    5181679    Africa 38.86500
    ## 903                Madagascar 1962    5703324    Africa 40.84800
    ## 904                Madagascar 1967    6334556    Africa 42.88100
    ## 905                Madagascar 1972    7082430    Africa 44.85100
    ## 906                Madagascar 1977    8007166    Africa 46.88100
    ## 907                Madagascar 1982    9171477    Africa 48.96900
    ## 908                Madagascar 1987   10568642    Africa 49.35000
    ## 909                Madagascar 1992   12210395    Africa 52.21400
    ## 910                Madagascar 1997   14165114    Africa 54.97800
    ## 911                Madagascar 2002   16473477    Africa 57.28600
    ## 912                Madagascar 2007   19167654    Africa 59.44300
    ## 913                    Malawi 1952    2917802    Africa 36.25600
    ## 914                    Malawi 1957    3221238    Africa 37.20700
    ## 915                    Malawi 1962    3628608    Africa 38.41000
    ## 916                    Malawi 1967    4147252    Africa 39.48700
    ## 917                    Malawi 1972    4730997    Africa 41.76600
    ## 918                    Malawi 1977    5637246    Africa 43.76700
    ## 919                    Malawi 1982    6502825    Africa 45.64200
    ## 920                    Malawi 1987    7824747    Africa 47.45700
    ## 921                    Malawi 1992   10014249    Africa 49.42000
    ## 922                    Malawi 1997   10419991    Africa 47.49500
    ## 923                    Malawi 2002   11824495    Africa 45.00900
    ## 924                    Malawi 2007   13327079    Africa 48.30300
    ## 925                  Malaysia 1952    6748378      Asia 48.46300
    ## 926                  Malaysia 1957    7739235      Asia 52.10200
    ## 927                  Malaysia 1962    8906385      Asia 55.73700
    ## 928                  Malaysia 1967   10154878      Asia 59.37100
    ## 929                  Malaysia 1972   11441462      Asia 63.01000
    ## 930                  Malaysia 1977   12845381      Asia 65.25600
    ## 931                  Malaysia 1982   14441916      Asia 68.00000
    ## 932                  Malaysia 1987   16331785      Asia 69.50000
    ## 933                  Malaysia 1992   18319502      Asia 70.69300
    ## 934                  Malaysia 1997   20476091      Asia 71.93800
    ## 935                  Malaysia 2002   22662365      Asia 73.04400
    ## 936                  Malaysia 2007   24821286      Asia 74.24100
    ## 937                      Mali 1952    3838168    Africa 33.68500
    ## 938                      Mali 1957    4241884    Africa 35.30700
    ## 939                      Mali 1962    4690372    Africa 36.93600
    ## 940                      Mali 1967    5212416    Africa 38.48700
    ## 941                      Mali 1972    5828158    Africa 39.97700
    ## 942                      Mali 1977    6491649    Africa 41.71400
    ## 943                      Mali 1982    6998256    Africa 43.91600
    ## 944                      Mali 1987    7634008    Africa 46.36400
    ## 945                      Mali 1992    8416215    Africa 48.38800
    ## 946                      Mali 1997    9384984    Africa 49.90300
    ## 947                      Mali 2002   10580176    Africa 51.81800
    ## 948                      Mali 2007   12031795    Africa 54.46700
    ## 949                Mauritania 1952    1022556    Africa 40.54300
    ## 950                Mauritania 1957    1076852    Africa 42.33800
    ## 951                Mauritania 1962    1146757    Africa 44.24800
    ## 952                Mauritania 1967    1230542    Africa 46.28900
    ## 953                Mauritania 1972    1332786    Africa 48.43700
    ## 954                Mauritania 1977    1456688    Africa 50.85200
    ## 955                Mauritania 1982    1622136    Africa 53.59900
    ## 956                Mauritania 1987    1841240    Africa 56.14500
    ## 957                Mauritania 1992    2119465    Africa 58.33300
    ## 958                Mauritania 1997    2444741    Africa 60.43000
    ## 959                Mauritania 2002    2828858    Africa 62.24700
    ## 960                Mauritania 2007    3270065    Africa 64.16400
    ## 961                 Mauritius 1952     516556    Africa 50.98600
    ## 962                 Mauritius 1957     609816    Africa 58.08900
    ## 963                 Mauritius 1962     701016    Africa 60.24600
    ## 964                 Mauritius 1967     789309    Africa 61.55700
    ## 965                 Mauritius 1972     851334    Africa 62.94400
    ## 966                 Mauritius 1977     913025    Africa 64.93000
    ## 967                 Mauritius 1982     992040    Africa 66.71100
    ## 968                 Mauritius 1987    1042663    Africa 68.74000
    ## 969                 Mauritius 1992    1096202    Africa 69.74500
    ## 970                 Mauritius 1997    1149818    Africa 70.73600
    ## 971                 Mauritius 2002    1200206    Africa 71.95400
    ## 972                 Mauritius 2007    1250882    Africa 72.80100
    ## 973                    Mexico 1952   30144317  Americas 50.78900
    ## 974                    Mexico 1957   35015548  Americas 55.19000
    ## 975                    Mexico 1962   41121485  Americas 58.29900
    ## 976                    Mexico 1967   47995559  Americas 60.11000
    ## 977                    Mexico 1972   55984294  Americas 62.36100
    ## 978                    Mexico 1977   63759976  Americas 65.03200
    ## 979                    Mexico 1982   71640904  Americas 67.40500
    ## 980                    Mexico 1987   80122492  Americas 69.49800
    ## 981                    Mexico 1992   88111030  Americas 71.45500
    ## 982                    Mexico 1997   95895146  Americas 73.67000
    ## 983                    Mexico 2002  102479927  Americas 74.90200
    ## 984                    Mexico 2007  108700891  Americas 76.19500
    ## 985                  Mongolia 1952     800663      Asia 42.24400
    ## 986                  Mongolia 1957     882134      Asia 45.24800
    ## 987                  Mongolia 1962    1010280      Asia 48.25100
    ## 988                  Mongolia 1967    1149500      Asia 51.25300
    ## 989                  Mongolia 1972    1320500      Asia 53.75400
    ## 990                  Mongolia 1977    1528000      Asia 55.49100
    ## 991                  Mongolia 1982    1756032      Asia 57.48900
    ## 992                  Mongolia 1987    2015133      Asia 60.22200
    ## 993                  Mongolia 1992    2312802      Asia 61.27100
    ## 994                  Mongolia 1997    2494803      Asia 63.62500
    ## 995                  Mongolia 2002    2674234      Asia 65.03300
    ## 996                  Mongolia 2007    2874127      Asia 66.80300
    ## 997                Montenegro 1952     413834    Europe 59.16400
    ## 998                Montenegro 1957     442829    Europe 61.44800
    ## 999                Montenegro 1962     474528    Europe 63.72800
    ## 1000               Montenegro 1967     501035    Europe 67.17800
    ## 1001               Montenegro 1972     527678    Europe 70.63600
    ## 1002               Montenegro 1977     560073    Europe 73.06600
    ## 1003               Montenegro 1982     562548    Europe 74.10100
    ## 1004               Montenegro 1987     569473    Europe 74.86500
    ## 1005               Montenegro 1992     621621    Europe 75.43500
    ## 1006               Montenegro 1997     692651    Europe 75.44500
    ## 1007               Montenegro 2002     720230    Europe 73.98100
    ## 1008               Montenegro 2007     684736    Europe 74.54300
    ## 1009                  Morocco 1952    9939217    Africa 42.87300
    ## 1010                  Morocco 1957   11406350    Africa 45.42300
    ## 1011                  Morocco 1962   13056604    Africa 47.92400
    ## 1012                  Morocco 1967   14770296    Africa 50.33500
    ## 1013                  Morocco 1972   16660670    Africa 52.86200
    ## 1014                  Morocco 1977   18396941    Africa 55.73000
    ## 1015                  Morocco 1982   20198730    Africa 59.65000
    ## 1016                  Morocco 1987   22987397    Africa 62.67700
    ## 1017                  Morocco 1992   25798239    Africa 65.39300
    ## 1018                  Morocco 1997   28529501    Africa 67.66000
    ## 1019                  Morocco 2002   31167783    Africa 69.61500
    ## 1020                  Morocco 2007   33757175    Africa 71.16400
    ## 1021               Mozambique 1952    6446316    Africa 31.28600
    ## 1022               Mozambique 1957    7038035    Africa 33.77900
    ## 1023               Mozambique 1962    7788944    Africa 36.16100
    ## 1024               Mozambique 1967    8680909    Africa 38.11300
    ## 1025               Mozambique 1972    9809596    Africa 40.32800
    ## 1026               Mozambique 1977   11127868    Africa 42.49500
    ## 1027               Mozambique 1982   12587223    Africa 42.79500
    ## 1028               Mozambique 1987   12891952    Africa 42.86100
    ## 1029               Mozambique 1992   13160731    Africa 44.28400
    ## 1030               Mozambique 1997   16603334    Africa 46.34400
    ## 1031               Mozambique 2002   18473780    Africa 44.02600
    ## 1032               Mozambique 2007   19951656    Africa 42.08200
    ## 1033                  Myanmar 1952   20092996      Asia 36.31900
    ## 1034                  Myanmar 1957   21731844      Asia 41.90500
    ## 1035                  Myanmar 1962   23634436      Asia 45.10800
    ## 1036                  Myanmar 1967   25870271      Asia 49.37900
    ## 1037                  Myanmar 1972   28466390      Asia 53.07000
    ## 1038                  Myanmar 1977   31528087      Asia 56.05900
    ## 1039                  Myanmar 1982   34680442      Asia 58.05600
    ## 1040                  Myanmar 1987   38028578      Asia 58.33900
    ## 1041                  Myanmar 1992   40546538      Asia 59.32000
    ## 1042                  Myanmar 1997   43247867      Asia 60.32800
    ## 1043                  Myanmar 2002   45598081      Asia 59.90800
    ## 1044                  Myanmar 2007   47761980      Asia 62.06900
    ## 1045                  Namibia 1952     485831    Africa 41.72500
    ## 1046                  Namibia 1957     548080    Africa 45.22600
    ## 1047                  Namibia 1962     621392    Africa 48.38600
    ## 1048                  Namibia 1967     706640    Africa 51.15900
    ## 1049                  Namibia 1972     821782    Africa 53.86700
    ## 1050                  Namibia 1977     977026    Africa 56.43700
    ## 1051                  Namibia 1982    1099010    Africa 58.96800
    ## 1052                  Namibia 1987    1278184    Africa 60.83500
    ## 1053                  Namibia 1992    1554253    Africa 61.99900
    ## 1054                  Namibia 1997    1774766    Africa 58.90900
    ## 1055                  Namibia 2002    1972153    Africa 51.47900
    ## 1056                  Namibia 2007    2055080    Africa 52.90600
    ## 1057                    Nepal 1952    9182536      Asia 36.15700
    ## 1058                    Nepal 1957    9682338      Asia 37.68600
    ## 1059                    Nepal 1962   10332057      Asia 39.39300
    ## 1060                    Nepal 1967   11261690      Asia 41.47200
    ## 1061                    Nepal 1972   12412593      Asia 43.97100
    ## 1062                    Nepal 1977   13933198      Asia 46.74800
    ## 1063                    Nepal 1982   15796314      Asia 49.59400
    ## 1064                    Nepal 1987   17917180      Asia 52.53700
    ## 1065                    Nepal 1992   20326209      Asia 55.72700
    ## 1066                    Nepal 1997   23001113      Asia 59.42600
    ## 1067                    Nepal 2002   25873917      Asia 61.34000
    ## 1068                    Nepal 2007   28901790      Asia 63.78500
    ## 1069              Netherlands 1952   10381988    Europe 72.13000
    ## 1070              Netherlands 1957   11026383    Europe 72.99000
    ## 1071              Netherlands 1962   11805689    Europe 73.23000
    ## 1072              Netherlands 1967   12596822    Europe 73.82000
    ## 1073              Netherlands 1972   13329874    Europe 73.75000
    ## 1074              Netherlands 1977   13852989    Europe 75.24000
    ## 1075              Netherlands 1982   14310401    Europe 76.05000
    ## 1076              Netherlands 1987   14665278    Europe 76.83000
    ## 1077              Netherlands 1992   15174244    Europe 77.42000
    ## 1078              Netherlands 1997   15604464    Europe 78.03000
    ## 1079              Netherlands 2002   16122830    Europe 78.53000
    ## 1080              Netherlands 2007   16570613    Europe 79.76200
    ## 1081              New Zealand 1952    1994794   Oceania 69.39000
    ## 1082              New Zealand 1957    2229407   Oceania 70.26000
    ## 1083              New Zealand 1962    2488550   Oceania 71.24000
    ## 1084              New Zealand 1967    2728150   Oceania 71.52000
    ## 1085              New Zealand 1972    2929100   Oceania 71.89000
    ## 1086              New Zealand 1977    3164900   Oceania 72.22000
    ## 1087              New Zealand 1982    3210650   Oceania 73.84000
    ## 1088              New Zealand 1987    3317166   Oceania 74.32000
    ## 1089              New Zealand 1992    3437674   Oceania 76.33000
    ## 1090              New Zealand 1997    3676187   Oceania 77.55000
    ## 1091              New Zealand 2002    3908037   Oceania 79.11000
    ## 1092              New Zealand 2007    4115771   Oceania 80.20400
    ## 1093                Nicaragua 1952    1165790  Americas 42.31400
    ## 1094                Nicaragua 1957    1358828  Americas 45.43200
    ## 1095                Nicaragua 1962    1590597  Americas 48.63200
    ## 1096                Nicaragua 1967    1865490  Americas 51.88400
    ## 1097                Nicaragua 1972    2182908  Americas 55.15100
    ## 1098                Nicaragua 1977    2554598  Americas 57.47000
    ## 1099                Nicaragua 1982    2979423  Americas 59.29800
    ## 1100                Nicaragua 1987    3344353  Americas 62.00800
    ## 1101                Nicaragua 1992    4017939  Americas 65.84300
    ## 1102                Nicaragua 1997    4609572  Americas 68.42600
    ## 1103                Nicaragua 2002    5146848  Americas 70.83600
    ## 1104                Nicaragua 2007    5675356  Americas 72.89900
    ## 1105                    Niger 1952    3379468    Africa 37.44400
    ## 1106                    Niger 1957    3692184    Africa 38.59800
    ## 1107                    Niger 1962    4076008    Africa 39.48700
    ## 1108                    Niger 1967    4534062    Africa 40.11800
    ## 1109                    Niger 1972    5060262    Africa 40.54600
    ## 1110                    Niger 1977    5682086    Africa 41.29100
    ## 1111                    Niger 1982    6437188    Africa 42.59800
    ## 1112                    Niger 1987    7332638    Africa 44.55500
    ## 1113                    Niger 1992    8392818    Africa 47.39100
    ## 1114                    Niger 1997    9666252    Africa 51.31300
    ## 1115                    Niger 2002   11140655    Africa 54.49600
    ## 1116                    Niger 2007   12894865    Africa 56.86700
    ## 1117                  Nigeria 1952   33119096    Africa 36.32400
    ## 1118                  Nigeria 1957   37173340    Africa 37.80200
    ## 1119                  Nigeria 1962   41871351    Africa 39.36000
    ## 1120                  Nigeria 1967   47287752    Africa 41.04000
    ## 1121                  Nigeria 1972   53740085    Africa 42.82100
    ## 1122                  Nigeria 1977   62209173    Africa 44.51400
    ## 1123                  Nigeria 1982   73039376    Africa 45.82600
    ## 1124                  Nigeria 1987   81551520    Africa 46.88600
    ## 1125                  Nigeria 1992   93364244    Africa 47.47200
    ## 1126                  Nigeria 1997  106207839    Africa 47.46400
    ## 1127                  Nigeria 2002  119901274    Africa 46.60800
    ## 1128                  Nigeria 2007  135031164    Africa 46.85900
    ## 1129                   Norway 1952    3327728    Europe 72.67000
    ## 1130                   Norway 1957    3491938    Europe 73.44000
    ## 1131                   Norway 1962    3638919    Europe 73.47000
    ## 1132                   Norway 1967    3786019    Europe 74.08000
    ## 1133                   Norway 1972    3933004    Europe 74.34000
    ## 1134                   Norway 1977    4043205    Europe 75.37000
    ## 1135                   Norway 1982    4114787    Europe 75.97000
    ## 1136                   Norway 1987    4186147    Europe 75.89000
    ## 1137                   Norway 1992    4286357    Europe 77.32000
    ## 1138                   Norway 1997    4405672    Europe 78.32000
    ## 1139                   Norway 2002    4535591    Europe 79.05000
    ## 1140                   Norway 2007    4627926    Europe 80.19600
    ## 1141                     Oman 1952     507833      Asia 37.57800
    ## 1142                     Oman 1957     561977      Asia 40.08000
    ## 1143                     Oman 1962     628164      Asia 43.16500
    ## 1144                     Oman 1967     714775      Asia 46.98800
    ## 1145                     Oman 1972     829050      Asia 52.14300
    ## 1146                     Oman 1977    1004533      Asia 57.36700
    ## 1147                     Oman 1982    1301048      Asia 62.72800
    ## 1148                     Oman 1987    1593882      Asia 67.73400
    ## 1149                     Oman 1992    1915208      Asia 71.19700
    ## 1150                     Oman 1997    2283635      Asia 72.49900
    ## 1151                     Oman 2002    2713462      Asia 74.19300
    ## 1152                     Oman 2007    3204897      Asia 75.64000
    ## 1153                 Pakistan 1952   41346560      Asia 43.43600
    ## 1154                 Pakistan 1957   46679944      Asia 45.55700
    ## 1155                 Pakistan 1962   53100671      Asia 47.67000
    ## 1156                 Pakistan 1967   60641899      Asia 49.80000
    ## 1157                 Pakistan 1972   69325921      Asia 51.92900
    ## 1158                 Pakistan 1977   78152686      Asia 54.04300
    ## 1159                 Pakistan 1982   91462088      Asia 56.15800
    ## 1160                 Pakistan 1987  105186881      Asia 58.24500
    ## 1161                 Pakistan 1992  120065004      Asia 60.83800
    ## 1162                 Pakistan 1997  135564834      Asia 61.81800
    ## 1163                 Pakistan 2002  153403524      Asia 63.61000
    ## 1164                 Pakistan 2007  169270617      Asia 65.48300
    ## 1165                   Panama 1952     940080  Americas 55.19100
    ## 1166                   Panama 1957    1063506  Americas 59.20100
    ## 1167                   Panama 1962    1215725  Americas 61.81700
    ## 1168                   Panama 1967    1405486  Americas 64.07100
    ## 1169                   Panama 1972    1616384  Americas 66.21600
    ## 1170                   Panama 1977    1839782  Americas 68.68100
    ## 1171                   Panama 1982    2036305  Americas 70.47200
    ## 1172                   Panama 1987    2253639  Americas 71.52300
    ## 1173                   Panama 1992    2484997  Americas 72.46200
    ## 1174                   Panama 1997    2734531  Americas 73.73800
    ## 1175                   Panama 2002    2990875  Americas 74.71200
    ## 1176                   Panama 2007    3242173  Americas 75.53700
    ## 1177                 Paraguay 1952    1555876  Americas 62.64900
    ## 1178                 Paraguay 1957    1770902  Americas 63.19600
    ## 1179                 Paraguay 1962    2009813  Americas 64.36100
    ## 1180                 Paraguay 1967    2287985  Americas 64.95100
    ## 1181                 Paraguay 1972    2614104  Americas 65.81500
    ## 1182                 Paraguay 1977    2984494  Americas 66.35300
    ## 1183                 Paraguay 1982    3366439  Americas 66.87400
    ## 1184                 Paraguay 1987    3886512  Americas 67.37800
    ## 1185                 Paraguay 1992    4483945  Americas 68.22500
    ## 1186                 Paraguay 1997    5154123  Americas 69.40000
    ## 1187                 Paraguay 2002    5884491  Americas 70.75500
    ## 1188                 Paraguay 2007    6667147  Americas 71.75200
    ## 1189                     Peru 1952    8025700  Americas 43.90200
    ## 1190                     Peru 1957    9146100  Americas 46.26300
    ## 1191                     Peru 1962   10516500  Americas 49.09600
    ## 1192                     Peru 1967   12132200  Americas 51.44500
    ## 1193                     Peru 1972   13954700  Americas 55.44800
    ## 1194                     Peru 1977   15990099  Americas 58.44700
    ## 1195                     Peru 1982   18125129  Americas 61.40600
    ## 1196                     Peru 1987   20195924  Americas 64.13400
    ## 1197                     Peru 1992   22430449  Americas 66.45800
    ## 1198                     Peru 1997   24748122  Americas 68.38600
    ## 1199                     Peru 2002   26769436  Americas 69.90600
    ## 1200                     Peru 2007   28674757  Americas 71.42100
    ## 1201              Philippines 1952   22438691      Asia 47.75200
    ## 1202              Philippines 1957   26072194      Asia 51.33400
    ## 1203              Philippines 1962   30325264      Asia 54.75700
    ## 1204              Philippines 1967   35356600      Asia 56.39300
    ## 1205              Philippines 1972   40850141      Asia 58.06500
    ## 1206              Philippines 1977   46850962      Asia 60.06000
    ## 1207              Philippines 1982   53456774      Asia 62.08200
    ## 1208              Philippines 1987   60017788      Asia 64.15100
    ## 1209              Philippines 1992   67185766      Asia 66.45800
    ## 1210              Philippines 1997   75012988      Asia 68.56400
    ## 1211              Philippines 2002   82995088      Asia 70.30300
    ## 1212              Philippines 2007   91077287      Asia 71.68800
    ## 1213                   Poland 1952   25730551    Europe 61.31000
    ## 1214                   Poland 1957   28235346    Europe 65.77000
    ## 1215                   Poland 1962   30329617    Europe 67.64000
    ## 1216                   Poland 1967   31785378    Europe 69.61000
    ## 1217                   Poland 1972   33039545    Europe 70.85000
    ## 1218                   Poland 1977   34621254    Europe 70.67000
    ## 1219                   Poland 1982   36227381    Europe 71.32000
    ## 1220                   Poland 1987   37740710    Europe 70.98000
    ## 1221                   Poland 1992   38370697    Europe 70.99000
    ## 1222                   Poland 1997   38654957    Europe 72.75000
    ## 1223                   Poland 2002   38625976    Europe 74.67000
    ## 1224                   Poland 2007   38518241    Europe 75.56300
    ## 1225                 Portugal 1952    8526050    Europe 59.82000
    ## 1226                 Portugal 1957    8817650    Europe 61.51000
    ## 1227                 Portugal 1962    9019800    Europe 64.39000
    ## 1228                 Portugal 1967    9103000    Europe 66.60000
    ## 1229                 Portugal 1972    8970450    Europe 69.26000
    ## 1230                 Portugal 1977    9662600    Europe 70.41000
    ## 1231                 Portugal 1982    9859650    Europe 72.77000
    ## 1232                 Portugal 1987    9915289    Europe 74.06000
    ## 1233                 Portugal 1992    9927680    Europe 74.86000
    ## 1234                 Portugal 1997   10156415    Europe 75.97000
    ## 1235                 Portugal 2002   10433867    Europe 77.29000
    ## 1236                 Portugal 2007   10642836    Europe 78.09800
    ## 1237              Puerto Rico 1952    2227000  Americas 64.28000
    ## 1238              Puerto Rico 1957    2260000  Americas 68.54000
    ## 1239              Puerto Rico 1962    2448046  Americas 69.62000
    ## 1240              Puerto Rico 1967    2648961  Americas 71.10000
    ## 1241              Puerto Rico 1972    2847132  Americas 72.16000
    ## 1242              Puerto Rico 1977    3080828  Americas 73.44000
    ## 1243              Puerto Rico 1982    3279001  Americas 73.75000
    ## 1244              Puerto Rico 1987    3444468  Americas 74.63000
    ## 1245              Puerto Rico 1992    3585176  Americas 73.91100
    ## 1246              Puerto Rico 1997    3759430  Americas 74.91700
    ## 1247              Puerto Rico 2002    3859606  Americas 77.77800
    ## 1248              Puerto Rico 2007    3942491  Americas 78.74600
    ## 1249                  Reunion 1952     257700    Africa 52.72400
    ## 1250                  Reunion 1957     308700    Africa 55.09000
    ## 1251                  Reunion 1962     358900    Africa 57.66600
    ## 1252                  Reunion 1967     414024    Africa 60.54200
    ## 1253                  Reunion 1972     461633    Africa 64.27400
    ## 1254                  Reunion 1977     492095    Africa 67.06400
    ## 1255                  Reunion 1982     517810    Africa 69.88500
    ## 1256                  Reunion 1987     562035    Africa 71.91300
    ## 1257                  Reunion 1992     622191    Africa 73.61500
    ## 1258                  Reunion 1997     684810    Africa 74.77200
    ## 1259                  Reunion 2002     743981    Africa 75.74400
    ## 1260                  Reunion 2007     798094    Africa 76.44200
    ## 1261                  Romania 1952   16630000    Europe 61.05000
    ## 1262                  Romania 1957   17829327    Europe 64.10000
    ## 1263                  Romania 1962   18680721    Europe 66.80000
    ## 1264                  Romania 1967   19284814    Europe 66.80000
    ## 1265                  Romania 1972   20662648    Europe 69.21000
    ## 1266                  Romania 1977   21658597    Europe 69.46000
    ## 1267                  Romania 1982   22356726    Europe 69.66000
    ## 1268                  Romania 1987   22686371    Europe 69.53000
    ## 1269                  Romania 1992   22797027    Europe 69.36000
    ## 1270                  Romania 1997   22562458    Europe 69.72000
    ## 1271                  Romania 2002   22404337    Europe 71.32200
    ## 1272                  Romania 2007   22276056    Europe 72.47600
    ## 1273                   Rwanda 1952    2534927    Africa 40.00000
    ## 1274                   Rwanda 1957    2822082    Africa 41.50000
    ## 1275                   Rwanda 1962    3051242    Africa 43.00000
    ## 1276                   Rwanda 1967    3451079    Africa 44.10000
    ## 1277                   Rwanda 1972    3992121    Africa 44.60000
    ## 1278                   Rwanda 1977    4657072    Africa 45.00000
    ## 1279                   Rwanda 1982    5507565    Africa 46.21800
    ## 1280                   Rwanda 1987    6349365    Africa 44.02000
    ## 1281                   Rwanda 1992    7290203    Africa 23.59900
    ## 1282                   Rwanda 1997    7212583    Africa 36.08700
    ## 1283                   Rwanda 2002    7852401    Africa 43.41300
    ## 1284                   Rwanda 2007    8860588    Africa 46.24200
    ## 1285    Sao Tome and Principe 1952      60011    Africa 46.47100
    ## 1286    Sao Tome and Principe 1957      61325    Africa 48.94500
    ## 1287    Sao Tome and Principe 1962      65345    Africa 51.89300
    ## 1288    Sao Tome and Principe 1967      70787    Africa 54.42500
    ## 1289    Sao Tome and Principe 1972      76595    Africa 56.48000
    ## 1290    Sao Tome and Principe 1977      86796    Africa 58.55000
    ## 1291    Sao Tome and Principe 1982      98593    Africa 60.35100
    ## 1292    Sao Tome and Principe 1987     110812    Africa 61.72800
    ## 1293    Sao Tome and Principe 1992     125911    Africa 62.74200
    ## 1294    Sao Tome and Principe 1997     145608    Africa 63.30600
    ## 1295    Sao Tome and Principe 2002     170372    Africa 64.33700
    ## 1296    Sao Tome and Principe 2007     199579    Africa 65.52800
    ## 1297             Saudi Arabia 1952    4005677      Asia 39.87500
    ## 1298             Saudi Arabia 1957    4419650      Asia 42.86800
    ## 1299             Saudi Arabia 1962    4943029      Asia 45.91400
    ## 1300             Saudi Arabia 1967    5618198      Asia 49.90100
    ## 1301             Saudi Arabia 1972    6472756      Asia 53.88600
    ## 1302             Saudi Arabia 1977    8128505      Asia 58.69000
    ## 1303             Saudi Arabia 1982   11254672      Asia 63.01200
    ## 1304             Saudi Arabia 1987   14619745      Asia 66.29500
    ## 1305             Saudi Arabia 1992   16945857      Asia 68.76800
    ## 1306             Saudi Arabia 1997   21229759      Asia 70.53300
    ## 1307             Saudi Arabia 2002   24501530      Asia 71.62600
    ## 1308             Saudi Arabia 2007   27601038      Asia 72.77700
    ## 1309                  Senegal 1952    2755589    Africa 37.27800
    ## 1310                  Senegal 1957    3054547    Africa 39.32900
    ## 1311                  Senegal 1962    3430243    Africa 41.45400
    ## 1312                  Senegal 1967    3965841    Africa 43.56300
    ## 1313                  Senegal 1972    4588696    Africa 45.81500
    ## 1314                  Senegal 1977    5260855    Africa 48.87900
    ## 1315                  Senegal 1982    6147783    Africa 52.37900
    ## 1316                  Senegal 1987    7171347    Africa 55.76900
    ## 1317                  Senegal 1992    8307920    Africa 58.19600
    ## 1318                  Senegal 1997    9535314    Africa 60.18700
    ## 1319                  Senegal 2002   10870037    Africa 61.60000
    ## 1320                  Senegal 2007   12267493    Africa 63.06200
    ## 1321                   Serbia 1952    6860147    Europe 57.99600
    ## 1322                   Serbia 1957    7271135    Europe 61.68500
    ## 1323                   Serbia 1962    7616060    Europe 64.53100
    ## 1324                   Serbia 1967    7971222    Europe 66.91400
    ## 1325                   Serbia 1972    8313288    Europe 68.70000
    ## 1326                   Serbia 1977    8686367    Europe 70.30000
    ## 1327                   Serbia 1982    9032824    Europe 70.16200
    ## 1328                   Serbia 1987    9230783    Europe 71.21800
    ## 1329                   Serbia 1992    9826397    Europe 71.65900
    ## 1330                   Serbia 1997   10336594    Europe 72.23200
    ## 1331                   Serbia 2002   10111559    Europe 73.21300
    ## 1332                   Serbia 2007   10150265    Europe 74.00200
    ## 1333             Sierra Leone 1952    2143249    Africa 30.33100
    ## 1334             Sierra Leone 1957    2295678    Africa 31.57000
    ## 1335             Sierra Leone 1962    2467895    Africa 32.76700
    ## 1336             Sierra Leone 1967    2662190    Africa 34.11300
    ## 1337             Sierra Leone 1972    2879013    Africa 35.40000
    ## 1338             Sierra Leone 1977    3140897    Africa 36.78800
    ## 1339             Sierra Leone 1982    3464522    Africa 38.44500
    ## 1340             Sierra Leone 1987    3868905    Africa 40.00600
    ## 1341             Sierra Leone 1992    4260884    Africa 38.33300
    ## 1342             Sierra Leone 1997    4578212    Africa 39.89700
    ## 1343             Sierra Leone 2002    5359092    Africa 41.01200
    ## 1344             Sierra Leone 2007    6144562    Africa 42.56800
    ## 1345                Singapore 1952    1127000      Asia 60.39600
    ## 1346                Singapore 1957    1445929      Asia 63.17900
    ## 1347                Singapore 1962    1750200      Asia 65.79800
    ## 1348                Singapore 1967    1977600      Asia 67.94600
    ## 1349                Singapore 1972    2152400      Asia 69.52100
    ## 1350                Singapore 1977    2325300      Asia 70.79500
    ## 1351                Singapore 1982    2651869      Asia 71.76000
    ## 1352                Singapore 1987    2794552      Asia 73.56000
    ## 1353                Singapore 1992    3235865      Asia 75.78800
    ## 1354                Singapore 1997    3802309      Asia 77.15800
    ## 1355                Singapore 2002    4197776      Asia 78.77000
    ## 1356                Singapore 2007    4553009      Asia 79.97200
    ## 1357          Slovak Republic 1952    3558137    Europe 64.36000
    ## 1358          Slovak Republic 1957    3844277    Europe 67.45000
    ## 1359          Slovak Republic 1962    4237384    Europe 70.33000
    ## 1360          Slovak Republic 1967    4442238    Europe 70.98000
    ## 1361          Slovak Republic 1972    4593433    Europe 70.35000
    ## 1362          Slovak Republic 1977    4827803    Europe 70.45000
    ## 1363          Slovak Republic 1982    5048043    Europe 70.80000
    ## 1364          Slovak Republic 1987    5199318    Europe 71.08000
    ## 1365          Slovak Republic 1992    5302888    Europe 71.38000
    ## 1366          Slovak Republic 1997    5383010    Europe 72.71000
    ## 1367          Slovak Republic 2002    5410052    Europe 73.80000
    ## 1368          Slovak Republic 2007    5447502    Europe 74.66300
    ## 1369                 Slovenia 1952    1489518    Europe 65.57000
    ## 1370                 Slovenia 1957    1533070    Europe 67.85000
    ## 1371                 Slovenia 1962    1582962    Europe 69.15000
    ## 1372                 Slovenia 1967    1646912    Europe 69.18000
    ## 1373                 Slovenia 1972    1694510    Europe 69.82000
    ## 1374                 Slovenia 1977    1746919    Europe 70.97000
    ## 1375                 Slovenia 1982    1861252    Europe 71.06300
    ## 1376                 Slovenia 1987    1945870    Europe 72.25000
    ## 1377                 Slovenia 1992    1999210    Europe 73.64000
    ## 1378                 Slovenia 1997    2011612    Europe 75.13000
    ## 1379                 Slovenia 2002    2011497    Europe 76.66000
    ## 1380                 Slovenia 2007    2009245    Europe 77.92600
    ## 1381                  Somalia 1952    2526994    Africa 32.97800
    ## 1382                  Somalia 1957    2780415    Africa 34.97700
    ## 1383                  Somalia 1962    3080153    Africa 36.98100
    ## 1384                  Somalia 1967    3428839    Africa 38.97700
    ## 1385                  Somalia 1972    3840161    Africa 40.97300
    ## 1386                  Somalia 1977    4353666    Africa 41.97400
    ## 1387                  Somalia 1982    5828892    Africa 42.95500
    ## 1388                  Somalia 1987    6921858    Africa 44.50100
    ## 1389                  Somalia 1992    6099799    Africa 39.65800
    ## 1390                  Somalia 1997    6633514    Africa 43.79500
    ## 1391                  Somalia 2002    7753310    Africa 45.93600
    ## 1392                  Somalia 2007    9118773    Africa 48.15900
    ## 1393             South Africa 1952   14264935    Africa 45.00900
    ## 1394             South Africa 1957   16151549    Africa 47.98500
    ## 1395             South Africa 1962   18356657    Africa 49.95100
    ## 1396             South Africa 1967   20997321    Africa 51.92700
    ## 1397             South Africa 1972   23935810    Africa 53.69600
    ## 1398             South Africa 1977   27129932    Africa 55.52700
    ## 1399             South Africa 1982   31140029    Africa 58.16100
    ## 1400             South Africa 1987   35933379    Africa 60.83400
    ## 1401             South Africa 1992   39964159    Africa 61.88800
    ## 1402             South Africa 1997   42835005    Africa 60.23600
    ## 1403             South Africa 2002   44433622    Africa 53.36500
    ## 1404             South Africa 2007   43997828    Africa 49.33900
    ## 1405                    Spain 1952   28549870    Europe 64.94000
    ## 1406                    Spain 1957   29841614    Europe 66.66000
    ## 1407                    Spain 1962   31158061    Europe 69.69000
    ## 1408                    Spain 1967   32850275    Europe 71.44000
    ## 1409                    Spain 1972   34513161    Europe 73.06000
    ## 1410                    Spain 1977   36439000    Europe 74.39000
    ## 1411                    Spain 1982   37983310    Europe 76.30000
    ## 1412                    Spain 1987   38880702    Europe 76.90000
    ## 1413                    Spain 1992   39549438    Europe 77.57000
    ## 1414                    Spain 1997   39855442    Europe 78.77000
    ## 1415                    Spain 2002   40152517    Europe 79.78000
    ## 1416                    Spain 2007   40448191    Europe 80.94100
    ## 1417                Sri Lanka 1952    7982342      Asia 57.59300
    ## 1418                Sri Lanka 1957    9128546      Asia 61.45600
    ## 1419                Sri Lanka 1962   10421936      Asia 62.19200
    ## 1420                Sri Lanka 1967   11737396      Asia 64.26600
    ## 1421                Sri Lanka 1972   13016733      Asia 65.04200
    ## 1422                Sri Lanka 1977   14116836      Asia 65.94900
    ## 1423                Sri Lanka 1982   15410151      Asia 68.75700
    ## 1424                Sri Lanka 1987   16495304      Asia 69.01100
    ## 1425                Sri Lanka 1992   17587060      Asia 70.37900
    ## 1426                Sri Lanka 1997   18698655      Asia 70.45700
    ## 1427                Sri Lanka 2002   19576783      Asia 70.81500
    ## 1428                Sri Lanka 2007   20378239      Asia 72.39600
    ## 1429                    Sudan 1952    8504667    Africa 38.63500
    ## 1430                    Sudan 1957    9753392    Africa 39.62400
    ## 1431                    Sudan 1962   11183227    Africa 40.87000
    ## 1432                    Sudan 1967   12716129    Africa 42.85800
    ## 1433                    Sudan 1972   14597019    Africa 45.08300
    ## 1434                    Sudan 1977   17104986    Africa 47.80000
    ## 1435                    Sudan 1982   20367053    Africa 50.33800
    ## 1436                    Sudan 1987   24725960    Africa 51.74400
    ## 1437                    Sudan 1992   28227588    Africa 53.55600
    ## 1438                    Sudan 1997   32160729    Africa 55.37300
    ## 1439                    Sudan 2002   37090298    Africa 56.36900
    ## 1440                    Sudan 2007   42292929    Africa 58.55600
    ## 1441                Swaziland 1952     290243    Africa 41.40700
    ## 1442                Swaziland 1957     326741    Africa 43.42400
    ## 1443                Swaziland 1962     370006    Africa 44.99200
    ## 1444                Swaziland 1967     420690    Africa 46.63300
    ## 1445                Swaziland 1972     480105    Africa 49.55200
    ## 1446                Swaziland 1977     551425    Africa 52.53700
    ## 1447                Swaziland 1982     649901    Africa 55.56100
    ## 1448                Swaziland 1987     779348    Africa 57.67800
    ## 1449                Swaziland 1992     962344    Africa 58.47400
    ## 1450                Swaziland 1997    1054486    Africa 54.28900
    ## 1451                Swaziland 2002    1130269    Africa 43.86900
    ## 1452                Swaziland 2007    1133066    Africa 39.61300
    ## 1453                   Sweden 1952    7124673    Europe 71.86000
    ## 1454                   Sweden 1957    7363802    Europe 72.49000
    ## 1455                   Sweden 1962    7561588    Europe 73.37000
    ## 1456                   Sweden 1967    7867931    Europe 74.16000
    ## 1457                   Sweden 1972    8122293    Europe 74.72000
    ## 1458                   Sweden 1977    8251648    Europe 75.44000
    ## 1459                   Sweden 1982    8325260    Europe 76.42000
    ## 1460                   Sweden 1987    8421403    Europe 77.19000
    ## 1461                   Sweden 1992    8718867    Europe 78.16000
    ## 1462                   Sweden 1997    8897619    Europe 79.39000
    ## 1463                   Sweden 2002    8954175    Europe 80.04000
    ## 1464                   Sweden 2007    9031088    Europe 80.88400
    ## 1465              Switzerland 1952    4815000    Europe 69.62000
    ## 1466              Switzerland 1957    5126000    Europe 70.56000
    ## 1467              Switzerland 1962    5666000    Europe 71.32000
    ## 1468              Switzerland 1967    6063000    Europe 72.77000
    ## 1469              Switzerland 1972    6401400    Europe 73.78000
    ## 1470              Switzerland 1977    6316424    Europe 75.39000
    ## 1471              Switzerland 1982    6468126    Europe 76.21000
    ## 1472              Switzerland 1987    6649942    Europe 77.41000
    ## 1473              Switzerland 1992    6995447    Europe 78.03000
    ## 1474              Switzerland 1997    7193761    Europe 79.37000
    ## 1475              Switzerland 2002    7361757    Europe 80.62000
    ## 1476              Switzerland 2007    7554661    Europe 81.70100
    ## 1477                    Syria 1952    3661549      Asia 45.88300
    ## 1478                    Syria 1957    4149908      Asia 48.28400
    ## 1479                    Syria 1962    4834621      Asia 50.30500
    ## 1480                    Syria 1967    5680812      Asia 53.65500
    ## 1481                    Syria 1972    6701172      Asia 57.29600
    ## 1482                    Syria 1977    7932503      Asia 61.19500
    ## 1483                    Syria 1982    9410494      Asia 64.59000
    ## 1484                    Syria 1987   11242847      Asia 66.97400
    ## 1485                    Syria 1992   13219062      Asia 69.24900
    ## 1486                    Syria 1997   15081016      Asia 71.52700
    ## 1487                    Syria 2002   17155814      Asia 73.05300
    ## 1488                    Syria 2007   19314747      Asia 74.14300
    ## 1489                   Taiwan 1952    8550362      Asia 58.50000
    ## 1490                   Taiwan 1957   10164215      Asia 62.40000
    ## 1491                   Taiwan 1962   11918938      Asia 65.20000
    ## 1492                   Taiwan 1967   13648692      Asia 67.50000
    ## 1493                   Taiwan 1972   15226039      Asia 69.39000
    ## 1494                   Taiwan 1977   16785196      Asia 70.59000
    ## 1495                   Taiwan 1982   18501390      Asia 72.16000
    ## 1496                   Taiwan 1987   19757799      Asia 73.40000
    ## 1497                   Taiwan 1992   20686918      Asia 74.26000
    ## 1498                   Taiwan 1997   21628605      Asia 75.25000
    ## 1499                   Taiwan 2002   22454239      Asia 76.99000
    ## 1500                   Taiwan 2007   23174294      Asia 78.40000
    ## 1501                 Tanzania 1952    8322925    Africa 41.21500
    ## 1502                 Tanzania 1957    9452826    Africa 42.97400
    ## 1503                 Tanzania 1962   10863958    Africa 44.24600
    ## 1504                 Tanzania 1967   12607312    Africa 45.75700
    ## 1505                 Tanzania 1972   14706593    Africa 47.62000
    ## 1506                 Tanzania 1977   17129565    Africa 49.91900
    ## 1507                 Tanzania 1982   19844382    Africa 50.60800
    ## 1508                 Tanzania 1987   23040630    Africa 51.53500
    ## 1509                 Tanzania 1992   26605473    Africa 50.44000
    ## 1510                 Tanzania 1997   30686889    Africa 48.46600
    ## 1511                 Tanzania 2002   34593779    Africa 49.65100
    ## 1512                 Tanzania 2007   38139640    Africa 52.51700
    ## 1513                 Thailand 1952   21289402      Asia 50.84800
    ## 1514                 Thailand 1957   25041917      Asia 53.63000
    ## 1515                 Thailand 1962   29263397      Asia 56.06100
    ## 1516                 Thailand 1967   34024249      Asia 58.28500
    ## 1517                 Thailand 1972   39276153      Asia 60.40500
    ## 1518                 Thailand 1977   44148285      Asia 62.49400
    ## 1519                 Thailand 1982   48827160      Asia 64.59700
    ## 1520                 Thailand 1987   52910342      Asia 66.08400
    ## 1521                 Thailand 1992   56667095      Asia 67.29800
    ## 1522                 Thailand 1997   60216677      Asia 67.52100
    ## 1523                 Thailand 2002   62806748      Asia 68.56400
    ## 1524                 Thailand 2007   65068149      Asia 70.61600
    ## 1525                     Togo 1952    1219113    Africa 38.59600
    ## 1526                     Togo 1957    1357445    Africa 41.20800
    ## 1527                     Togo 1962    1528098    Africa 43.92200
    ## 1528                     Togo 1967    1735550    Africa 46.76900
    ## 1529                     Togo 1972    2056351    Africa 49.75900
    ## 1530                     Togo 1977    2308582    Africa 52.88700
    ## 1531                     Togo 1982    2644765    Africa 55.47100
    ## 1532                     Togo 1987    3154264    Africa 56.94100
    ## 1533                     Togo 1992    3747553    Africa 58.06100
    ## 1534                     Togo 1997    4320890    Africa 58.39000
    ## 1535                     Togo 2002    4977378    Africa 57.56100
    ## 1536                     Togo 2007    5701579    Africa 58.42000
    ## 1537      Trinidad and Tobago 1952     662850  Americas 59.10000
    ## 1538      Trinidad and Tobago 1957     764900  Americas 61.80000
    ## 1539      Trinidad and Tobago 1962     887498  Americas 64.90000
    ## 1540      Trinidad and Tobago 1967     960155  Americas 65.40000
    ## 1541      Trinidad and Tobago 1972     975199  Americas 65.90000
    ## 1542      Trinidad and Tobago 1977    1039009  Americas 68.30000
    ## 1543      Trinidad and Tobago 1982    1116479  Americas 68.83200
    ## 1544      Trinidad and Tobago 1987    1191336  Americas 69.58200
    ## 1545      Trinidad and Tobago 1992    1183669  Americas 69.86200
    ## 1546      Trinidad and Tobago 1997    1138101  Americas 69.46500
    ## 1547      Trinidad and Tobago 2002    1101832  Americas 68.97600
    ## 1548      Trinidad and Tobago 2007    1056608  Americas 69.81900
    ## 1549                  Tunisia 1952    3647735    Africa 44.60000
    ## 1550                  Tunisia 1957    3950849    Africa 47.10000
    ## 1551                  Tunisia 1962    4286552    Africa 49.57900
    ## 1552                  Tunisia 1967    4786986    Africa 52.05300
    ## 1553                  Tunisia 1972    5303507    Africa 55.60200
    ## 1554                  Tunisia 1977    6005061    Africa 59.83700
    ## 1555                  Tunisia 1982    6734098    Africa 64.04800
    ## 1556                  Tunisia 1987    7724976    Africa 66.89400
    ## 1557                  Tunisia 1992    8523077    Africa 70.00100
    ## 1558                  Tunisia 1997    9231669    Africa 71.97300
    ## 1559                  Tunisia 2002    9770575    Africa 73.04200
    ## 1560                  Tunisia 2007   10276158    Africa 73.92300
    ## 1561                   Turkey 1952   22235677    Europe 43.58500
    ## 1562                   Turkey 1957   25670939    Europe 48.07900
    ## 1563                   Turkey 1962   29788695    Europe 52.09800
    ## 1564                   Turkey 1967   33411317    Europe 54.33600
    ## 1565                   Turkey 1972   37492953    Europe 57.00500
    ## 1566                   Turkey 1977   42404033    Europe 59.50700
    ## 1567                   Turkey 1982   47328791    Europe 61.03600
    ## 1568                   Turkey 1987   52881328    Europe 63.10800
    ## 1569                   Turkey 1992   58179144    Europe 66.14600
    ## 1570                   Turkey 1997   63047647    Europe 68.83500
    ## 1571                   Turkey 2002   67308928    Europe 70.84500
    ## 1572                   Turkey 2007   71158647    Europe 71.77700
    ## 1573                   Uganda 1952    5824797    Africa 39.97800
    ## 1574                   Uganda 1957    6675501    Africa 42.57100
    ## 1575                   Uganda 1962    7688797    Africa 45.34400
    ## 1576                   Uganda 1967    8900294    Africa 48.05100
    ## 1577                   Uganda 1972   10190285    Africa 51.01600
    ## 1578                   Uganda 1977   11457758    Africa 50.35000
    ## 1579                   Uganda 1982   12939400    Africa 49.84900
    ## 1580                   Uganda 1987   15283050    Africa 51.50900
    ## 1581                   Uganda 1992   18252190    Africa 48.82500
    ## 1582                   Uganda 1997   21210254    Africa 44.57800
    ## 1583                   Uganda 2002   24739869    Africa 47.81300
    ## 1584                   Uganda 2007   29170398    Africa 51.54200
    ## 1585           United Kingdom 1952   50430000    Europe 69.18000
    ## 1586           United Kingdom 1957   51430000    Europe 70.42000
    ## 1587           United Kingdom 1962   53292000    Europe 70.76000
    ## 1588           United Kingdom 1967   54959000    Europe 71.36000
    ## 1589           United Kingdom 1972   56079000    Europe 72.01000
    ## 1590           United Kingdom 1977   56179000    Europe 72.76000
    ## 1591           United Kingdom 1982   56339704    Europe 74.04000
    ## 1592           United Kingdom 1987   56981620    Europe 75.00700
    ## 1593           United Kingdom 1992   57866349    Europe 76.42000
    ## 1594           United Kingdom 1997   58808266    Europe 77.21800
    ## 1595           United Kingdom 2002   59912431    Europe 78.47100
    ## 1596           United Kingdom 2007   60776238    Europe 79.42500
    ## 1597            United States 1952  157553000  Americas 68.44000
    ## 1598            United States 1957  171984000  Americas 69.49000
    ## 1599            United States 1962  186538000  Americas 70.21000
    ## 1600            United States 1967  198712000  Americas 70.76000
    ## 1601            United States 1972  209896000  Americas 71.34000
    ## 1602            United States 1977  220239000  Americas 73.38000
    ## 1603            United States 1982  232187835  Americas 74.65000
    ## 1604            United States 1987  242803533  Americas 75.02000
    ## 1605            United States 1992  256894189  Americas 76.09000
    ## 1606            United States 1997  272911760  Americas 76.81000
    ## 1607            United States 2002  287675526  Americas 77.31000
    ## 1608            United States 2007  301139947  Americas 78.24200
    ## 1609                  Uruguay 1952    2252965  Americas 66.07100
    ## 1610                  Uruguay 1957    2424959  Americas 67.04400
    ## 1611                  Uruguay 1962    2598466  Americas 68.25300
    ## 1612                  Uruguay 1967    2748579  Americas 68.46800
    ## 1613                  Uruguay 1972    2829526  Americas 68.67300
    ## 1614                  Uruguay 1977    2873520  Americas 69.48100
    ## 1615                  Uruguay 1982    2953997  Americas 70.80500
    ## 1616                  Uruguay 1987    3045153  Americas 71.91800
    ## 1617                  Uruguay 1992    3149262  Americas 72.75200
    ## 1618                  Uruguay 1997    3262838  Americas 74.22300
    ## 1619                  Uruguay 2002    3363085  Americas 75.30700
    ## 1620                  Uruguay 2007    3447496  Americas 76.38400
    ## 1621                Venezuela 1952    5439568  Americas 55.08800
    ## 1622                Venezuela 1957    6702668  Americas 57.90700
    ## 1623                Venezuela 1962    8143375  Americas 60.77000
    ## 1624                Venezuela 1967    9709552  Americas 63.47900
    ## 1625                Venezuela 1972   11515649  Americas 65.71200
    ## 1626                Venezuela 1977   13503563  Americas 67.45600
    ## 1627                Venezuela 1982   15620766  Americas 68.55700
    ## 1628                Venezuela 1987   17910182  Americas 70.19000
    ## 1629                Venezuela 1992   20265563  Americas 71.15000
    ## 1630                Venezuela 1997   22374398  Americas 72.14600
    ## 1631                Venezuela 2002   24287670  Americas 72.76600
    ## 1632                Venezuela 2007   26084662  Americas 73.74700
    ## 1633                  Vietnam 1952   26246839      Asia 40.41200
    ## 1634                  Vietnam 1957   28998543      Asia 42.88700
    ## 1635                  Vietnam 1962   33796140      Asia 45.36300
    ## 1636                  Vietnam 1967   39463910      Asia 47.83800
    ## 1637                  Vietnam 1972   44655014      Asia 50.25400
    ## 1638                  Vietnam 1977   50533506      Asia 55.76400
    ## 1639                  Vietnam 1982   56142181      Asia 58.81600
    ## 1640                  Vietnam 1987   62826491      Asia 62.82000
    ## 1641                  Vietnam 1992   69940728      Asia 67.66200
    ## 1642                  Vietnam 1997   76048996      Asia 70.67200
    ## 1643                  Vietnam 2002   80908147      Asia 73.01700
    ## 1644                  Vietnam 2007   85262356      Asia 74.24900
    ## 1645       West Bank and Gaza 1952    1030585      Asia 43.16000
    ## 1646       West Bank and Gaza 1957    1070439      Asia 45.67100
    ## 1647       West Bank and Gaza 1962    1133134      Asia 48.12700
    ## 1648       West Bank and Gaza 1967    1142636      Asia 51.63100
    ## 1649       West Bank and Gaza 1972    1089572      Asia 56.53200
    ## 1650       West Bank and Gaza 1977    1261091      Asia 60.76500
    ## 1651       West Bank and Gaza 1982    1425876      Asia 64.40600
    ## 1652       West Bank and Gaza 1987    1691210      Asia 67.04600
    ## 1653       West Bank and Gaza 1992    2104779      Asia 69.71800
    ## 1654       West Bank and Gaza 1997    2826046      Asia 71.09600
    ## 1655       West Bank and Gaza 2002    3389578      Asia 72.37000
    ## 1656       West Bank and Gaza 2007    4018332      Asia 73.42200
    ## 1657               Yemen Rep. 1952    4963829      Asia 32.54800
    ## 1658               Yemen Rep. 1957    5498090      Asia 33.97000
    ## 1659               Yemen Rep. 1962    6120081      Asia 35.18000
    ## 1660               Yemen Rep. 1967    6740785      Asia 36.98400
    ## 1661               Yemen Rep. 1972    7407075      Asia 39.84800
    ## 1662               Yemen Rep. 1977    8403990      Asia 44.17500
    ## 1663               Yemen Rep. 1982    9657618      Asia 49.11300
    ## 1664               Yemen Rep. 1987   11219340      Asia 52.92200
    ## 1665               Yemen Rep. 1992   13367997      Asia 55.59900
    ## 1666               Yemen Rep. 1997   15826497      Asia 58.02000
    ## 1667               Yemen Rep. 2002   18701257      Asia 60.30800
    ## 1668               Yemen Rep. 2007   22211743      Asia 62.69800
    ## 1669                   Zambia 1952    2672000    Africa 42.03800
    ## 1670                   Zambia 1957    3016000    Africa 44.07700
    ## 1671                   Zambia 1962    3421000    Africa 46.02300
    ## 1672                   Zambia 1967    3900000    Africa 47.76800
    ## 1673                   Zambia 1972    4506497    Africa 50.10700
    ## 1674                   Zambia 1977    5216550    Africa 51.38600
    ## 1675                   Zambia 1982    6100407    Africa 51.82100
    ## 1676                   Zambia 1987    7272406    Africa 50.82100
    ## 1677                   Zambia 1992    8381163    Africa 46.10000
    ## 1678                   Zambia 1997    9417789    Africa 40.23800
    ## 1679                   Zambia 2002   10595811    Africa 39.19300
    ## 1680                   Zambia 2007   11746035    Africa 42.38400
    ## 1681                 Zimbabwe 1952    3080907    Africa 48.45100
    ## 1682                 Zimbabwe 1957    3646340    Africa 50.46900
    ## 1683                 Zimbabwe 1962    4277736    Africa 52.35800
    ## 1684                 Zimbabwe 1967    4995432    Africa 53.99500
    ## 1685                 Zimbabwe 1972    5861135    Africa 55.63500
    ## 1686                 Zimbabwe 1977    6642107    Africa 57.67400
    ## 1687                 Zimbabwe 1982    7636524    Africa 60.36300
    ## 1688                 Zimbabwe 1987    9216418    Africa 62.35100
    ## 1689                 Zimbabwe 1992   10704340    Africa 60.37700
    ## 1690                 Zimbabwe 1997   11404948    Africa 46.80900
    ## 1691                 Zimbabwe 2002   11926563    Africa 39.98900
    ## 1692                 Zimbabwe 2007   12311143    Africa 43.48700
    ##        gdpPercap
    ## 1       779.4453
    ## 2       820.8530
    ## 3       853.1007
    ## 4       836.1971
    ## 5       739.9811
    ## 6       786.1134
    ## 7       978.0114
    ## 8       852.3959
    ## 9       649.3414
    ## 10      635.3414
    ## 11      726.7341
    ## 12      974.5803
    ## 13     1601.0561
    ## 14     1942.2842
    ## 15     2312.8890
    ## 16     2760.1969
    ## 17     3313.4222
    ## 18     3533.0039
    ## 19     3630.8807
    ## 20     3738.9327
    ## 21     2497.4379
    ## 22     3193.0546
    ## 23     4604.2117
    ## 24     5937.0295
    ## 25     2449.0082
    ## 26     3013.9760
    ## 27     2550.8169
    ## 28     3246.9918
    ## 29     4182.6638
    ## 30     4910.4168
    ## 31     5745.1602
    ## 32     5681.3585
    ## 33     5023.2166
    ## 34     4797.2951
    ## 35     5288.0404
    ## 36     6223.3675
    ## 37     3520.6103
    ## 38     3827.9405
    ## 39     4269.2767
    ## 40     5522.7764
    ## 41     5473.2880
    ## 42     3008.6474
    ## 43     2756.9537
    ## 44     2430.2083
    ## 45     2627.8457
    ## 46     2277.1409
    ## 47     2773.2873
    ## 48     4797.2313
    ## 49     5911.3151
    ## 50     6856.8562
    ## 51     7133.1660
    ## 52     8052.9530
    ## 53     9443.0385
    ## 54    10079.0267
    ## 55     8997.8974
    ## 56     9139.6714
    ## 57     9308.4187
    ## 58    10967.2820
    ## 59     8797.6407
    ## 60    12779.3796
    ## 61    10039.5956
    ## 62    10949.6496
    ## 63    12217.2269
    ## 64    14526.1246
    ## 65    16788.6295
    ## 66    18334.1975
    ## 67    19477.0093
    ## 68    21888.8890
    ## 69    23424.7668
    ## 70    26997.9366
    ## 71    30687.7547
    ## 72    34435.3674
    ## 73     6137.0765
    ## 74     8842.5980
    ## 75    10750.7211
    ## 76    12834.6024
    ## 77    16661.6256
    ## 78    19749.4223
    ## 79    21597.0836
    ## 80    23687.8261
    ## 81    27042.0187
    ## 82    29095.9207
    ## 83    32417.6077
    ## 84    36126.4927
    ## 85     9867.0848
    ## 86    11635.7995
    ## 87    12753.2751
    ## 88    14804.6727
    ## 89    18268.6584
    ## 90    19340.1020
    ## 91    19211.1473
    ## 92    18524.0241
    ## 93    19035.5792
    ## 94    20292.0168
    ## 95    23403.5593
    ## 96    29796.0483
    ## 97      684.2442
    ## 98      661.6375
    ## 99      686.3416
    ## 100     721.1861
    ## 101     630.2336
    ## 102     659.8772
    ## 103     676.9819
    ## 104     751.9794
    ## 105     837.8102
    ## 106     972.7700
    ## 107    1136.3904
    ## 108    1391.2538
    ## 109    8343.1051
    ## 110    9714.9606
    ## 111   10991.2068
    ## 112   13149.0412
    ## 113   16672.1436
    ## 114   19117.9745
    ## 115   20979.8459
    ## 116   22525.5631
    ## 117   25575.5707
    ## 118   27561.1966
    ## 119   30485.8838
    ## 120   33692.6051
    ## 121    1062.7522
    ## 122     959.6011
    ## 123     949.4991
    ## 124    1035.8314
    ## 125    1085.7969
    ## 126    1029.1613
    ## 127    1277.8976
    ## 128    1225.8560
    ## 129    1191.2077
    ## 130    1232.9753
    ## 131    1372.8779
    ## 132    1441.2849
    ## 133    2677.3263
    ## 134    2127.6863
    ## 135    2180.9725
    ## 136    2586.8861
    ## 137    2980.3313
    ## 138    3548.0978
    ## 139    3156.5105
    ## 140    2753.6915
    ## 141    2961.6997
    ## 142    3326.1432
    ## 143    3413.2627
    ## 144    3822.1371
    ## 145     973.5332
    ## 146    1353.9892
    ## 147    1709.6837
    ## 148    2172.3524
    ## 149    2860.1698
    ## 150    3528.4813
    ## 151    4126.6132
    ## 152    4314.1148
    ## 153    2546.7814
    ## 154    4766.3559
    ## 155    6018.9752
    ## 156    7446.2988
    ## 157     851.2411
    ## 158     918.2325
    ## 159     983.6540
    ## 160    1214.7093
    ## 161    2263.6111
    ## 162    3214.8578
    ## 163    4551.1421
    ## 164    6205.8839
    ## 165    7954.1116
    ## 166    8647.1423
    ## 167   11003.6051
    ## 168   12569.8518
    ## 169    2108.9444
    ## 170    2487.3660
    ## 171    3336.5858
    ## 172    3429.8644
    ## 173    4985.7115
    ## 174    6660.1187
    ## 175    7030.8359
    ## 176    7807.0958
    ## 177    6950.2830
    ## 178    7957.9808
    ## 179    8131.2128
    ## 180    9065.8008
    ## 181    2444.2866
    ## 182    3008.6707
    ## 183    4254.3378
    ## 184    5577.0028
    ## 185    6597.4944
    ## 186    7612.2404
    ## 187    8224.1916
    ## 188    8239.8548
    ## 189    6302.6234
    ## 190    5970.3888
    ## 191    7696.7777
    ## 192   10680.7928
    ## 193     543.2552
    ## 194     617.1835
    ## 195     722.5120
    ## 196     794.8266
    ## 197     854.7360
    ## 198     743.3870
    ## 199     807.1986
    ## 200     912.0631
    ## 201     931.7528
    ## 202     946.2950
    ## 203    1037.6452
    ## 204    1217.0330
    ## 205     339.2965
    ## 206     379.5646
    ## 207     355.2032
    ## 208     412.9775
    ## 209     464.0995
    ## 210     556.1033
    ## 211     559.6032
    ## 212     621.8188
    ## 213     631.6999
    ## 214     463.1151
    ## 215     446.4035
    ## 216     430.0707
    ## 217     368.4693
    ## 218     434.0383
    ## 219     496.9136
    ## 220     523.4323
    ## 221     421.6240
    ## 222     524.9722
    ## 223     624.4755
    ## 224     683.8956
    ## 225     682.3032
    ## 226     734.2852
    ## 227     896.2260
    ## 228    1713.7787
    ## 229    1172.6677
    ## 230    1313.0481
    ## 231    1399.6074
    ## 232    1508.4531
    ## 233    1684.1465
    ## 234    1783.4329
    ## 235    2367.9833
    ## 236    2602.6642
    ## 237    1793.1633
    ## 238    1694.3375
    ## 239    1934.0114
    ## 240    2042.0952
    ## 241   11367.1611
    ## 242   12489.9501
    ## 243   13462.4855
    ## 244   16076.5880
    ## 245   18970.5709
    ## 246   22090.8831
    ## 247   22898.7921
    ## 248   26626.5150
    ## 249   26342.8843
    ## 250   28954.9259
    ## 251   33328.9651
    ## 252   36319.2350
    ## 253    1071.3107
    ## 254    1190.8443
    ## 255    1193.0688
    ## 256    1136.0566
    ## 257    1070.0133
    ## 258    1109.3743
    ## 259     956.7530
    ## 260     844.8764
    ## 261     747.9055
    ## 262     740.5063
    ## 263     738.6906
    ## 264     706.0165
    ## 265    1178.6659
    ## 266    1308.4956
    ## 267    1389.8176
    ## 268    1196.8106
    ## 269    1104.1040
    ## 270    1133.9850
    ## 271     797.9081
    ## 272     952.3861
    ## 273    1058.0643
    ## 274    1004.9614
    ## 275    1156.1819
    ## 276    1704.0637
    ## 277    3939.9788
    ## 278    4315.6227
    ## 279    4519.0943
    ## 280    5106.6543
    ## 281    5494.0244
    ## 282    4756.7638
    ## 283    5095.6657
    ## 284    5547.0638
    ## 285    7596.1260
    ## 286   10118.0532
    ## 287   10778.7838
    ## 288   13171.6388
    ## 289     400.4486
    ## 290     575.9870
    ## 291     487.6740
    ## 292     612.7057
    ## 293     676.9001
    ## 294     741.2375
    ## 295     962.4214
    ## 296    1378.9040
    ## 297    1655.7842
    ## 298    2289.2341
    ## 299    3119.2809
    ## 300    4959.1149
    ## 301    2144.1151
    ## 302    2323.8056
    ## 303    2492.3511
    ## 304    2678.7298
    ## 305    3264.6600
    ## 306    3815.8079
    ## 307    4397.5757
    ## 308    4903.2191
    ## 309    5444.6486
    ## 310    6117.3617
    ## 311    5755.2600
    ## 312    7006.5804
    ## 313    1102.9909
    ## 314    1211.1485
    ## 315    1406.6483
    ## 316    1876.0296
    ## 317    1937.5777
    ## 318    1172.6030
    ## 319    1267.1001
    ## 320    1315.9808
    ## 321    1246.9074
    ## 322    1173.6182
    ## 323    1075.8116
    ## 324     986.1479
    ## 325     780.5423
    ## 326     905.8602
    ## 327     896.3146
    ## 328     861.5932
    ## 329     904.8961
    ## 330     795.7573
    ## 331     673.7478
    ## 332     672.7748
    ## 333     457.7192
    ## 334     312.1884
    ## 335     241.1659
    ## 336     277.5519
    ## 337    2125.6214
    ## 338    2315.0566
    ## 339    2464.7832
    ## 340    2677.9396
    ## 341    3213.1527
    ## 342    3259.1790
    ## 343    4879.5075
    ## 344    4201.1949
    ## 345    4016.2395
    ## 346    3484.1644
    ## 347    3484.0620
    ## 348    3632.5578
    ## 349    2627.0095
    ## 350    2990.0108
    ## 351    3460.9370
    ## 352    4161.7278
    ## 353    5118.1469
    ## 354    5926.8770
    ## 355    5262.7348
    ## 356    5629.9153
    ## 357    6160.4163
    ## 358    6677.0453
    ## 359    7723.4472
    ## 360    9645.0614
    ## 361    1388.5947
    ## 362    1500.8959
    ## 363    1728.8694
    ## 364    2052.0505
    ## 365    2378.2011
    ## 366    2517.7365
    ## 367    2602.7102
    ## 368    2156.9561
    ## 369    1648.0738
    ## 370    1786.2654
    ## 371    1648.8008
    ## 372    1544.7501
    ## 373    3119.2365
    ## 374    4338.2316
    ## 375    5477.8900
    ## 376    6960.2979
    ## 377    9164.0901
    ## 378   11305.3852
    ## 379   13221.8218
    ## 380   13822.5839
    ## 381    8447.7949
    ## 382    9875.6045
    ## 383   11628.3890
    ## 384   14619.2227
    ## 385    5586.5388
    ## 386    6092.1744
    ## 387    5180.7559
    ## 388    5690.2680
    ## 389    5305.4453
    ## 390    6380.4950
    ## 391    7316.9181
    ## 392    7532.9248
    ## 393    5592.8440
    ## 394    5431.9904
    ## 395    6340.6467
    ## 396    8948.1029
    ## 397    6876.1403
    ## 398    8256.3439
    ## 399   10136.8671
    ## 400   11399.4449
    ## 401   13108.4536
    ## 402   14800.1606
    ## 403   15377.2285
    ## 404   16310.4434
    ## 405   14297.0212
    ## 406   16048.5142
    ## 407   17596.2102
    ## 408   22833.3085
    ## 409    9692.3852
    ## 410   11099.6593
    ## 411   13583.3135
    ## 412   15937.2112
    ## 413   18866.2072
    ## 414   20422.9015
    ## 415   21688.0405
    ## 416   25116.1758
    ## 417   26406.7399
    ## 418   29804.3457
    ## 419   32166.5001
    ## 420   35278.4187
    ## 421    2669.5295
    ## 422    2864.9691
    ## 423    3020.9893
    ## 424    3020.0505
    ## 425    3694.2124
    ## 426    3081.7610
    ## 427    2879.4681
    ## 428    2880.1026
    ## 429    2377.1562
    ## 430    1895.0170
    ## 431    1908.2609
    ## 432    2082.4816
    ## 433    1397.7171
    ## 434    1544.4030
    ## 435    1662.1374
    ## 436    1653.7230
    ## 437    2189.8745
    ## 438    2681.9889
    ## 439    2861.0924
    ## 440    2899.8422
    ## 441    3044.2142
    ## 442    3614.1013
    ## 443    4563.8082
    ## 444    6025.3748
    ## 445    3522.1107
    ## 446    3780.5467
    ## 447    4086.1141
    ## 448    4579.0742
    ## 449    5280.9947
    ## 450    6679.6233
    ## 451    7213.7913
    ## 452    6481.7770
    ## 453    7103.7026
    ## 454    7429.4559
    ## 455    5773.0445
    ## 456    6873.2623
    ## 457    1418.8224
    ## 458    1458.9153
    ## 459    1693.3359
    ## 460    1814.8807
    ## 461    2024.0081
    ## 462    2785.4936
    ## 463    3503.7296
    ## 464    3885.4607
    ## 465    3794.7552
    ## 466    4173.1818
    ## 467    4754.6044
    ## 468    5581.1810
    ## 469    3048.3029
    ## 470    3421.5232
    ## 471    3776.8036
    ## 472    4358.5954
    ## 473    4520.2460
    ## 474    5138.9224
    ## 475    4098.3442
    ## 476    4140.4421
    ## 477    4444.2317
    ## 478    5154.8255
    ## 479    5351.5687
    ## 480    5728.3535
    ## 481     375.6431
    ## 482     426.0964
    ## 483     582.8420
    ## 484     915.5960
    ## 485     672.4123
    ## 486     958.5668
    ## 487     927.8253
    ## 488     966.8968
    ## 489    1132.0550
    ## 490    2814.4808
    ## 491    7703.4959
    ## 492   12154.0897
    ## 493     328.9406
    ## 494     344.1619
    ## 495     380.9958
    ## 496     468.7950
    ## 497     514.3242
    ## 498     505.7538
    ## 499     524.8758
    ## 500     521.1341
    ## 501     582.8585
    ## 502     913.4708
    ## 503     765.3500
    ## 504     641.3695
    ## 505     362.1463
    ## 506     378.9042
    ## 507     419.4564
    ## 508     516.1186
    ## 509     566.2439
    ## 510     556.8084
    ## 511     577.8607
    ## 512     573.7413
    ## 513     421.3535
    ## 514     515.8894
    ## 515     530.0535
    ## 516     690.8056
    ## 517    6424.5191
    ## 518    7545.4154
    ## 519    9371.8426
    ## 520   10921.6363
    ## 521   14358.8759
    ## 522   15605.4228
    ## 523   18533.1576
    ## 524   21141.0122
    ## 525   20647.1650
    ## 526   23723.9502
    ## 527   28204.5906
    ## 528   33207.0844
    ## 529    4293.4765
    ## 530    4976.1981
    ## 531    6631.4592
    ## 532    8358.7620
    ## 533   11401.9484
    ## 534   21745.5733
    ## 535   15113.3619
    ## 536   11864.4084
    ## 537   13522.1575
    ## 538   14722.8419
    ## 539   12521.7139
    ## 540   13206.4845
    ## 541     485.2307
    ## 542     520.9267
    ## 543     599.6503
    ## 544     734.7829
    ## 545     756.0868
    ## 546     884.7553
    ## 547     835.8096
    ## 548     611.6589
    ## 549     665.6244
    ## 550     653.7302
    ## 551     660.5856
    ## 552     752.7497
    ## 553    7144.1144
    ## 554   10187.8267
    ## 555   12902.4629
    ## 556   14745.6256
    ## 557   18016.1803
    ## 558   20512.9212
    ## 559   22031.5327
    ## 560   24639.1857
    ## 561   26505.3032
    ## 562   27788.8842
    ## 563   30035.8020
    ## 564   32170.3744
    ## 565     911.2989
    ## 566    1043.5615
    ## 567    1190.0411
    ## 568    1125.6972
    ## 569    1178.2237
    ## 570     993.2240
    ## 571     876.0326
    ## 572     847.0061
    ## 573     925.0602
    ## 574    1005.2458
    ## 575    1111.9846
    ## 576    1327.6089
    ## 577    3530.6901
    ## 578    4916.2999
    ## 579    6017.1907
    ## 580    8513.0970
    ## 581   12724.8296
    ## 582   14195.5243
    ## 583   15268.4209
    ## 584   16120.5284
    ## 585   17541.4963
    ## 586   18747.6981
    ## 587   22514.2548
    ## 588   27538.4119
    ## 589    2428.2378
    ## 590    2617.1560
    ## 591    2750.3644
    ## 592    3242.5311
    ## 593    4031.4083
    ## 594    4879.9927
    ## 595    4820.4948
    ## 596    4246.4860
    ## 597    4439.4508
    ## 598    4684.3138
    ## 599    4858.3475
    ## 600    5186.0500
    ## 601     510.1965
    ## 602     576.2670
    ## 603     686.3737
    ## 604     708.7595
    ## 605     741.6662
    ## 606     874.6859
    ## 607     857.2504
    ## 608     805.5725
    ## 609     794.3484
    ## 610     869.4498
    ## 611     945.5836
    ## 612     942.6542
    ## 613     299.8503
    ## 614     431.7905
    ## 615     522.0344
    ## 616     715.5806
    ## 617     820.2246
    ## 618     764.7260
    ## 619     838.1240
    ## 620     736.4154
    ## 621     745.5399
    ## 622     796.6645
    ## 623     575.7047
    ## 624     579.2317
    ## 625    1840.3669
    ## 626    1726.8879
    ## 627    1796.5890
    ## 628    1452.0577
    ## 629    1654.4569
    ## 630    1874.2989
    ## 631    2011.1595
    ## 632    1823.0160
    ## 633    1456.3095
    ## 634    1341.7269
    ## 635    1270.3649
    ## 636    1201.6372
    ## 637    2194.9262
    ## 638    2220.4877
    ## 639    2291.1568
    ## 640    2538.2694
    ## 641    2529.8423
    ## 642    3203.2081
    ## 643    3121.7608
    ## 644    3023.0967
    ## 645    3081.6946
    ## 646    3160.4549
    ## 647    3099.7287
    ## 648    3548.3308
    ## 649    3054.4212
    ## 650    3629.0765
    ## 651    4692.6483
    ## 652    6197.9628
    ## 653    8315.9281
    ## 654   11186.1413
    ## 655   14560.5305
    ## 656   20038.4727
    ## 657   24757.6030
    ## 658   28377.6322
    ## 659   30209.0152
    ## 660   39724.9787
    ## 661    5263.6738
    ## 662    6040.1800
    ## 663    7550.3599
    ## 664    9326.6447
    ## 665   10168.6561
    ## 666   11674.8374
    ## 667   12545.9907
    ## 668   12986.4800
    ## 669   10535.6285
    ## 670   11712.7768
    ## 671   14843.9356
    ## 672   18008.9444
    ## 673    7267.6884
    ## 674    9244.0014
    ## 675   10350.1591
    ## 676   13319.8957
    ## 677   15798.0636
    ## 678   19654.9625
    ## 679   23269.6075
    ## 680   26923.2063
    ## 681   25144.3920
    ## 682   28061.0997
    ## 683   31163.2020
    ## 684   36180.7892
    ## 685     546.5657
    ## 686     590.0620
    ## 687     658.3472
    ## 688     700.7706
    ## 689     724.0325
    ## 690     813.3373
    ## 691     855.7235
    ## 692     976.5127
    ## 693    1164.4068
    ## 694    1458.8174
    ## 695    1746.7695
    ## 696    2452.2104
    ## 697     749.6817
    ## 698     858.9003
    ## 699     849.2898
    ## 700     762.4318
    ## 701    1111.1079
    ## 702    1382.7021
    ## 703    1516.8730
    ## 704    1748.3570
    ## 705    2383.1409
    ## 706    3119.3356
    ## 707    2873.9129
    ## 708    3540.6516
    ## 709    3035.3260
    ## 710    3290.2576
    ## 711    4187.3298
    ## 712    5906.7318
    ## 713    9613.8186
    ## 714   11888.5951
    ## 715    7608.3346
    ## 716    6642.8814
    ## 717    7235.6532
    ## 718    8263.5903
    ## 719    9240.7620
    ## 720   11605.7145
    ## 721    4129.7661
    ## 722    6229.3336
    ## 723    8341.7378
    ## 724    8931.4598
    ## 725    9576.0376
    ## 726   14688.2351
    ## 727   14517.9071
    ## 728   11643.5727
    ## 729    3745.6407
    ## 730    3076.2398
    ## 731    4390.7173
    ## 732    4471.0619
    ## 733    5210.2803
    ## 734    5599.0779
    ## 735    6631.5973
    ## 736    7655.5690
    ## 737    9530.7729
    ## 738   11150.9811
    ## 739   12618.3214
    ## 740   13872.8665
    ## 741   17558.8155
    ## 742   24521.9471
    ## 743   34077.0494
    ## 744   40675.9964
    ## 745    4086.5221
    ## 746    5385.2785
    ## 747    7105.6307
    ## 748    8393.7414
    ## 749   12786.9322
    ## 750   13306.6192
    ## 751   15367.0292
    ## 752   17122.4799
    ## 753   18051.5225
    ## 754   20896.6092
    ## 755   21905.5951
    ## 756   25523.2771
    ## 757    4931.4042
    ## 758    6248.6562
    ## 759    8243.5823
    ## 760   10022.4013
    ## 761   12269.2738
    ## 762   14255.9847
    ## 763   16537.4835
    ## 764   19207.2348
    ## 765   22013.6449
    ## 766   24675.0245
    ## 767   27968.0982
    ## 768   28569.7197
    ## 769    2898.5309
    ## 770    4756.5258
    ## 771    5246.1075
    ## 772    6124.7035
    ## 773    7433.8893
    ## 774    6650.1956
    ## 775    6068.0513
    ## 776    6351.2375
    ## 777    7404.9237
    ## 778    7121.9247
    ## 779    6994.7749
    ## 780    7320.8803
    ## 781    3216.9563
    ## 782    4317.6944
    ## 783    6576.6495
    ## 784    9847.7886
    ## 785   14778.7864
    ## 786   16610.3770
    ## 787   19384.1057
    ## 788   22375.9419
    ## 789   26824.8951
    ## 790   28816.5850
    ## 791   28604.5919
    ## 792   31656.0681
    ## 793    1546.9078
    ## 794    1886.0806
    ## 795    2348.0092
    ## 796    2741.7963
    ## 797    2110.8563
    ## 798    2852.3516
    ## 799    4161.4160
    ## 800    4448.6799
    ## 801    3431.5936
    ## 802    3645.3796
    ## 803    3844.9172
    ## 804    4519.4612
    ## 805     853.5409
    ## 806     944.4383
    ## 807     896.9664
    ## 808    1056.7365
    ## 809    1222.3600
    ## 810    1267.6132
    ## 811    1348.2258
    ## 812    1361.9369
    ## 813    1341.9217
    ## 814    1360.4850
    ## 815    1287.5147
    ## 816    1463.2493
    ## 817    1088.2778
    ## 818    1571.1347
    ## 819    1621.6936
    ## 820    2143.5406
    ## 821    3701.6215
    ## 822    4106.3012
    ## 823    4106.5253
    ## 824    4106.4923
    ## 825    3726.0635
    ## 826    1690.7568
    ## 827    1646.7582
    ## 828    1593.0655
    ## 829    1030.5922
    ## 830    1487.5935
    ## 831    1536.3444
    ## 832    2029.2281
    ## 833    3030.8767
    ## 834    4657.2210
    ## 835    5622.9425
    ## 836    8533.0888
    ## 837   12104.2787
    ## 838   15993.5280
    ## 839   19233.9882
    ## 840   23348.1397
    ## 841  108382.3529
    ## 842  113523.1329
    ## 843   95458.1118
    ## 844   80894.8833
    ## 845  109347.8670
    ## 846   59265.4771
    ## 847   31354.0357
    ## 848   28118.4300
    ## 849   34932.9196
    ## 850   40300.6200
    ## 851   35110.1057
    ## 852   47306.9898
    ## 853    4834.8041
    ## 854    6089.7869
    ## 855    5714.5606
    ## 856    6006.9830
    ## 857    7486.3843
    ## 858    8659.6968
    ## 859    7640.5195
    ## 860    5377.0913
    ## 861    6890.8069
    ## 862    8754.9639
    ## 863    9313.9388
    ## 864   10461.0587
    ## 865     298.8462
    ## 866     335.9971
    ## 867     411.8006
    ## 868     498.6390
    ## 869     496.5816
    ## 870     745.3695
    ## 871     797.2631
    ## 872     773.9932
    ## 873     977.4863
    ## 874    1186.1480
    ## 875    1275.1846
    ## 876    1569.3314
    ## 877     575.5730
    ## 878     620.9700
    ## 879     634.1952
    ## 880     713.6036
    ## 881     803.0055
    ## 882     640.3224
    ## 883     572.1996
    ## 884     506.1139
    ## 885     636.6229
    ## 886     609.1740
    ## 887     531.4824
    ## 888     414.5073
    ## 889    2387.5481
    ## 890    3448.2844
    ## 891    6757.0308
    ## 892   18772.7517
    ## 893   21011.4972
    ## 894   21951.2118
    ## 895   17364.2754
    ## 896   11770.5898
    ## 897    9640.1385
    ## 898    9467.4461
    ## 899    9534.6775
    ## 900   12057.4993
    ## 901    1443.0117
    ## 902    1589.2027
    ## 903    1643.3871
    ## 904    1634.0473
    ## 905    1748.5630
    ## 906    1544.2286
    ## 907    1302.8787
    ## 908    1155.4419
    ## 909    1040.6762
    ## 910     986.2959
    ## 911     894.6371
    ## 912    1044.7701
    ## 913     369.1651
    ## 914     416.3698
    ## 915     427.9011
    ## 916     495.5148
    ## 917     584.6220
    ## 918     663.2237
    ## 919     632.8039
    ## 920     635.5174
    ## 921     563.2000
    ## 922     692.2758
    ## 923     665.4231
    ## 924     759.3499
    ## 925    1831.1329
    ## 926    1810.0670
    ## 927    2036.8849
    ## 928    2277.7424
    ## 929    2849.0948
    ## 930    3827.9216
    ## 931    4920.3560
    ## 932    5249.8027
    ## 933    7277.9128
    ## 934   10132.9096
    ## 935   10206.9779
    ## 936   12451.6558
    ## 937     452.3370
    ## 938     490.3822
    ## 939     496.1743
    ## 940     545.0099
    ## 941     581.3689
    ## 942     686.3953
    ## 943     618.0141
    ## 944     684.1716
    ## 945     739.0144
    ## 946     790.2580
    ## 947     951.4098
    ## 948    1042.5816
    ## 949     743.1159
    ## 950     846.1203
    ## 951    1055.8960
    ## 952    1421.1452
    ## 953    1586.8518
    ## 954    1497.4922
    ## 955    1481.1502
    ## 956    1421.6036
    ## 957    1361.3698
    ## 958    1483.1361
    ## 959    1579.0195
    ## 960    1803.1515
    ## 961    1967.9557
    ## 962    2034.0380
    ## 963    2529.0675
    ## 964    2475.3876
    ## 965    2575.4842
    ## 966    3710.9830
    ## 967    3688.0377
    ## 968    4783.5869
    ## 969    6058.2538
    ## 970    7425.7053
    ## 971    9021.8159
    ## 972   10956.9911
    ## 973    3478.1255
    ## 974    4131.5466
    ## 975    4581.6094
    ## 976    5754.7339
    ## 977    6809.4067
    ## 978    7674.9291
    ## 979    9611.1475
    ## 980    8688.1560
    ## 981    9472.3843
    ## 982    9767.2975
    ## 983   10742.4405
    ## 984   11977.5750
    ## 985     786.5669
    ## 986     912.6626
    ## 987    1056.3540
    ## 988    1226.0411
    ## 989    1421.7420
    ## 990    1647.5117
    ## 991    2000.6031
    ## 992    2338.0083
    ## 993    1785.4020
    ## 994    1902.2521
    ## 995    2140.7393
    ## 996    3095.7723
    ## 997    2647.5856
    ## 998    3682.2599
    ## 999    4649.5938
    ## 1000   5907.8509
    ## 1001   7778.4140
    ## 1002   9595.9299
    ## 1003  11222.5876
    ## 1004  11732.5102
    ## 1005   7003.3390
    ## 1006   6465.6133
    ## 1007   6557.1943
    ## 1008   9253.8961
    ## 1009   1688.2036
    ## 1010   1642.0023
    ## 1011   1566.3535
    ## 1012   1711.0448
    ## 1013   1930.1950
    ## 1014   2370.6200
    ## 1015   2702.6204
    ## 1016   2755.0470
    ## 1017   2948.0473
    ## 1018   2982.1019
    ## 1019   3258.4956
    ## 1020   3820.1752
    ## 1021    468.5260
    ## 1022    495.5868
    ## 1023    556.6864
    ## 1024    566.6692
    ## 1025    724.9178
    ## 1026    502.3197
    ## 1027    462.2114
    ## 1028    389.8762
    ## 1029    410.8968
    ## 1030    472.3461
    ## 1031    633.6179
    ## 1032    823.6856
    ## 1033    331.0000
    ## 1034    350.0000
    ## 1035    388.0000
    ## 1036    349.0000
    ## 1037    357.0000
    ## 1038    371.0000
    ## 1039    424.0000
    ## 1040    385.0000
    ## 1041    347.0000
    ## 1042    415.0000
    ## 1043    611.0000
    ## 1044    944.0000
    ## 1045   2423.7804
    ## 1046   2621.4481
    ## 1047   3173.2156
    ## 1048   3793.6948
    ## 1049   3746.0809
    ## 1050   3876.4860
    ## 1051   4191.1005
    ## 1052   3693.7313
    ## 1053   3804.5380
    ## 1054   3899.5243
    ## 1055   4072.3248
    ## 1056   4811.0604
    ## 1057    545.8657
    ## 1058    597.9364
    ## 1059    652.3969
    ## 1060    676.4422
    ## 1061    674.7881
    ## 1062    694.1124
    ## 1063    718.3731
    ## 1064    775.6325
    ## 1065    897.7404
    ## 1066   1010.8921
    ## 1067   1057.2063
    ## 1068   1091.3598
    ## 1069   8941.5719
    ## 1070  11276.1934
    ## 1071  12790.8496
    ## 1072  15363.2514
    ## 1073  18794.7457
    ## 1074  21209.0592
    ## 1075  21399.4605
    ## 1076  23651.3236
    ## 1077  26790.9496
    ## 1078  30246.1306
    ## 1079  33724.7578
    ## 1080  36797.9333
    ## 1081  10556.5757
    ## 1082  12247.3953
    ## 1083  13175.6780
    ## 1084  14463.9189
    ## 1085  16046.0373
    ## 1086  16233.7177
    ## 1087  17632.4104
    ## 1088  19007.1913
    ## 1089  18363.3249
    ## 1090  21050.4138
    ## 1091  23189.8014
    ## 1092  25185.0091
    ## 1093   3112.3639
    ## 1094   3457.4159
    ## 1095   3634.3644
    ## 1096   4643.3935
    ## 1097   4688.5933
    ## 1098   5486.3711
    ## 1099   3470.3382
    ## 1100   2955.9844
    ## 1101   2170.1517
    ## 1102   2253.0230
    ## 1103   2474.5488
    ## 1104   2749.3210
    ## 1105    761.8794
    ## 1106    835.5234
    ## 1107    997.7661
    ## 1108   1054.3849
    ## 1109    954.2092
    ## 1110    808.8971
    ## 1111    909.7221
    ## 1112    668.3000
    ## 1113    581.1827
    ## 1114    580.3052
    ## 1115    601.0745
    ## 1116    619.6769
    ## 1117   1077.2819
    ## 1118   1100.5926
    ## 1119   1150.9275
    ## 1120   1014.5141
    ## 1121   1698.3888
    ## 1122   1981.9518
    ## 1123   1576.9738
    ## 1124   1385.0296
    ## 1125   1619.8482
    ## 1126   1624.9413
    ## 1127   1615.2864
    ## 1128   2013.9773
    ## 1129  10095.4217
    ## 1130  11653.9730
    ## 1131  13450.4015
    ## 1132  16361.8765
    ## 1133  18965.0555
    ## 1134  23311.3494
    ## 1135  26298.6353
    ## 1136  31540.9748
    ## 1137  33965.6611
    ## 1138  41283.1643
    ## 1139  44683.9753
    ## 1140  49357.1902
    ## 1141   1828.2303
    ## 1142   2242.7466
    ## 1143   2924.6381
    ## 1144   4720.9427
    ## 1145  10618.0385
    ## 1146  11848.3439
    ## 1147  12954.7910
    ## 1148  18115.2231
    ## 1149  18616.7069
    ## 1150  19702.0558
    ## 1151  19774.8369
    ## 1152  22316.1929
    ## 1153    684.5971
    ## 1154    747.0835
    ## 1155    803.3427
    ## 1156    942.4083
    ## 1157   1049.9390
    ## 1158   1175.9212
    ## 1159   1443.4298
    ## 1160   1704.6866
    ## 1161   1971.8295
    ## 1162   2049.3505
    ## 1163   2092.7124
    ## 1164   2605.9476
    ## 1165   2480.3803
    ## 1166   2961.8009
    ## 1167   3536.5403
    ## 1168   4421.0091
    ## 1169   5364.2497
    ## 1170   5351.9121
    ## 1171   7009.6016
    ## 1172   7034.7792
    ## 1173   6618.7431
    ## 1174   7113.6923
    ## 1175   7356.0319
    ## 1176   9809.1856
    ## 1177   1952.3087
    ## 1178   2046.1547
    ## 1179   2148.0271
    ## 1180   2299.3763
    ## 1181   2523.3380
    ## 1182   3248.3733
    ## 1183   4258.5036
    ## 1184   3998.8757
    ## 1185   4196.4111
    ## 1186   4247.4003
    ## 1187   3783.6742
    ## 1188   4172.8385
    ## 1189   3758.5234
    ## 1190   4245.2567
    ## 1191   4957.0380
    ## 1192   5788.0933
    ## 1193   5937.8273
    ## 1194   6281.2909
    ## 1195   6434.5018
    ## 1196   6360.9434
    ## 1197   4446.3809
    ## 1198   5838.3477
    ## 1199   5909.0201
    ## 1200   7408.9056
    ## 1201   1272.8810
    ## 1202   1547.9448
    ## 1203   1649.5522
    ## 1204   1814.1274
    ## 1205   1989.3741
    ## 1206   2373.2043
    ## 1207   2603.2738
    ## 1208   2189.6350
    ## 1209   2279.3240
    ## 1210   2536.5349
    ## 1211   2650.9211
    ## 1212   3190.4810
    ## 1213   4029.3297
    ## 1214   4734.2530
    ## 1215   5338.7521
    ## 1216   6557.1528
    ## 1217   8006.5070
    ## 1218   9508.1415
    ## 1219   8451.5310
    ## 1220   9082.3512
    ## 1221   7738.8812
    ## 1222  10159.5837
    ## 1223  12002.2391
    ## 1224  15389.9247
    ## 1225   3068.3199
    ## 1226   3774.5717
    ## 1227   4727.9549
    ## 1228   6361.5180
    ## 1229   9022.2474
    ## 1230  10172.4857
    ## 1231  11753.8429
    ## 1232  13039.3088
    ## 1233  16207.2666
    ## 1234  17641.0316
    ## 1235  19970.9079
    ## 1236  20509.6478
    ## 1237   3081.9598
    ## 1238   3907.1562
    ## 1239   5108.3446
    ## 1240   6929.2777
    ## 1241   9123.0417
    ## 1242   9770.5249
    ## 1243  10330.9891
    ## 1244  12281.3419
    ## 1245  14641.5871
    ## 1246  16999.4333
    ## 1247  18855.6062
    ## 1248  19328.7090
    ## 1249   2718.8853
    ## 1250   2769.4518
    ## 1251   3173.7233
    ## 1252   4021.1757
    ## 1253   5047.6586
    ## 1254   4319.8041
    ## 1255   5267.2194
    ## 1256   5303.3775
    ## 1257   6101.2558
    ## 1258   6071.9414
    ## 1259   6316.1652
    ## 1260   7670.1226
    ## 1261   3144.6132
    ## 1262   3943.3702
    ## 1263   4734.9976
    ## 1264   6470.8665
    ## 1265   8011.4144
    ## 1266   9356.3972
    ## 1267   9605.3141
    ## 1268   9696.2733
    ## 1269   6598.4099
    ## 1270   7346.5476
    ## 1271   7885.3601
    ## 1272  10808.4756
    ## 1273    493.3239
    ## 1274    540.2894
    ## 1275    597.4731
    ## 1276    510.9637
    ## 1277    590.5807
    ## 1278    670.0806
    ## 1279    881.5706
    ## 1280    847.9912
    ## 1281    737.0686
    ## 1282    589.9445
    ## 1283    785.6538
    ## 1284    863.0885
    ## 1285    879.5836
    ## 1286    860.7369
    ## 1287   1071.5511
    ## 1288   1384.8406
    ## 1289   1532.9853
    ## 1290   1737.5617
    ## 1291   1890.2181
    ## 1292   1516.5255
    ## 1293   1428.7778
    ## 1294   1339.0760
    ## 1295   1353.0924
    ## 1296   1598.4351
    ## 1297   6459.5548
    ## 1298   8157.5912
    ## 1299  11626.4197
    ## 1300  16903.0489
    ## 1301  24837.4287
    ## 1302  34167.7626
    ## 1303  33693.1753
    ## 1304  21198.2614
    ## 1305  24841.6178
    ## 1306  20586.6902
    ## 1307  19014.5412
    ## 1308  21654.8319
    ## 1309   1450.3570
    ## 1310   1567.6530
    ## 1311   1654.9887
    ## 1312   1612.4046
    ## 1313   1597.7121
    ## 1314   1561.7691
    ## 1315   1518.4800
    ## 1316   1441.7207
    ## 1317   1367.8994
    ## 1318   1392.3683
    ## 1319   1519.6353
    ## 1320   1712.4721
    ## 1321   3581.4594
    ## 1322   4981.0909
    ## 1323   6289.6292
    ## 1324   7991.7071
    ## 1325  10522.0675
    ## 1326  12980.6696
    ## 1327  15181.0927
    ## 1328  15870.8785
    ## 1329   9325.0682
    ## 1330   7914.3203
    ## 1331   7236.0753
    ## 1332   9786.5347
    ## 1333    879.7877
    ## 1334   1004.4844
    ## 1335   1116.6399
    ## 1336   1206.0435
    ## 1337   1353.7598
    ## 1338   1348.2852
    ## 1339   1465.0108
    ## 1340   1294.4478
    ## 1341   1068.6963
    ## 1342    574.6482
    ## 1343    699.4897
    ## 1344    862.5408
    ## 1345   2315.1382
    ## 1346   2843.1044
    ## 1347   3674.7356
    ## 1348   4977.4185
    ## 1349   8597.7562
    ## 1350  11210.0895
    ## 1351  15169.1611
    ## 1352  18861.5308
    ## 1353  24769.8912
    ## 1354  33519.4766
    ## 1355  36023.1054
    ## 1356  47143.1796
    ## 1357   5074.6591
    ## 1358   6093.2630
    ## 1359   7481.1076
    ## 1360   8412.9024
    ## 1361   9674.1676
    ## 1362  10922.6640
    ## 1363  11348.5459
    ## 1364  12037.2676
    ## 1365   9498.4677
    ## 1366  12126.2306
    ## 1367  13638.7784
    ## 1368  18678.3144
    ## 1369   4215.0417
    ## 1370   5862.2766
    ## 1371   7402.3034
    ## 1372   9405.4894
    ## 1373  12383.4862
    ## 1374  15277.0302
    ## 1375  17866.7218
    ## 1376  18678.5349
    ## 1377  14214.7168
    ## 1378  17161.1073
    ## 1379  20660.0194
    ## 1380  25768.2576
    ## 1381   1135.7498
    ## 1382   1258.1474
    ## 1383   1369.4883
    ## 1384   1284.7332
    ## 1385   1254.5761
    ## 1386   1450.9925
    ## 1387   1176.8070
    ## 1388   1093.2450
    ## 1389    926.9603
    ## 1390    930.5964
    ## 1391    882.0818
    ## 1392    926.1411
    ## 1393   4725.2955
    ## 1394   5487.1042
    ## 1395   5768.7297
    ## 1396   7114.4780
    ## 1397   7765.9626
    ## 1398   8028.6514
    ## 1399   8568.2662
    ## 1400   7825.8234
    ## 1401   7225.0693
    ## 1402   7479.1882
    ## 1403   7710.9464
    ## 1404   9269.6578
    ## 1405   3834.0347
    ## 1406   4564.8024
    ## 1407   5693.8439
    ## 1408   7993.5123
    ## 1409  10638.7513
    ## 1410  13236.9212
    ## 1411  13926.1700
    ## 1412  15764.9831
    ## 1413  18603.0645
    ## 1414  20445.2990
    ## 1415  24835.4717
    ## 1416  28821.0637
    ## 1417   1083.5320
    ## 1418   1072.5466
    ## 1419   1074.4720
    ## 1420   1135.5143
    ## 1421   1213.3955
    ## 1422   1348.7757
    ## 1423   1648.0798
    ## 1424   1876.7668
    ## 1425   2153.7392
    ## 1426   2664.4773
    ## 1427   3015.3788
    ## 1428   3970.0954
    ## 1429   1615.9911
    ## 1430   1770.3371
    ## 1431   1959.5938
    ## 1432   1687.9976
    ## 1433   1659.6528
    ## 1434   2202.9884
    ## 1435   1895.5441
    ## 1436   1507.8192
    ## 1437   1492.1970
    ## 1438   1632.2108
    ## 1439   1993.3983
    ## 1440   2602.3950
    ## 1441   1148.3766
    ## 1442   1244.7084
    ## 1443   1856.1821
    ## 1444   2613.1017
    ## 1445   3364.8366
    ## 1446   3781.4106
    ## 1447   3895.3840
    ## 1448   3984.8398
    ## 1449   3553.0224
    ## 1450   3876.7685
    ## 1451   4128.1169
    ## 1452   4513.4806
    ## 1453   8527.8447
    ## 1454   9911.8782
    ## 1455  12329.4419
    ## 1456  15258.2970
    ## 1457  17832.0246
    ## 1458  18855.7252
    ## 1459  20667.3812
    ## 1460  23586.9293
    ## 1461  23880.0168
    ## 1462  25266.5950
    ## 1463  29341.6309
    ## 1464  33859.7484
    ## 1465  14734.2327
    ## 1466  17909.4897
    ## 1467  20431.0927
    ## 1468  22966.1443
    ## 1469  27195.1130
    ## 1470  26982.2905
    ## 1471  28397.7151
    ## 1472  30281.7046
    ## 1473  31871.5303
    ## 1474  32135.3230
    ## 1475  34480.9577
    ## 1476  37506.4191
    ## 1477   1643.4854
    ## 1478   2117.2349
    ## 1479   2193.0371
    ## 1480   1881.9236
    ## 1481   2571.4230
    ## 1482   3195.4846
    ## 1483   3761.8377
    ## 1484   3116.7743
    ## 1485   3340.5428
    ## 1486   4014.2390
    ## 1487   4090.9253
    ## 1488   4184.5481
    ## 1489   1206.9479
    ## 1490   1507.8613
    ## 1491   1822.8790
    ## 1492   2643.8587
    ## 1493   4062.5239
    ## 1494   5596.5198
    ## 1495   7426.3548
    ## 1496  11054.5618
    ## 1497  15215.6579
    ## 1498  20206.8210
    ## 1499  23235.4233
    ## 1500  28718.2768
    ## 1501    716.6501
    ## 1502    698.5356
    ## 1503    722.0038
    ## 1504    848.2187
    ## 1505    915.9851
    ## 1506    962.4923
    ## 1507    874.2426
    ## 1508    831.8221
    ## 1509    825.6825
    ## 1510    789.1862
    ## 1511    899.0742
    ## 1512   1107.4822
    ## 1513    757.7974
    ## 1514    793.5774
    ## 1515   1002.1992
    ## 1516   1295.4607
    ## 1517   1524.3589
    ## 1518   1961.2246
    ## 1519   2393.2198
    ## 1520   2982.6538
    ## 1521   4616.8965
    ## 1522   5852.6255
    ## 1523   5913.1875
    ## 1524   7458.3963
    ## 1525    859.8087
    ## 1526    925.9083
    ## 1527   1067.5348
    ## 1528   1477.5968
    ## 1529   1649.6602
    ## 1530   1532.7770
    ## 1531   1344.5780
    ## 1532   1202.2014
    ## 1533   1034.2989
    ## 1534    982.2869
    ## 1535    886.2206
    ## 1536    882.9699
    ## 1537   3023.2719
    ## 1538   4100.3934
    ## 1539   4997.5240
    ## 1540   5621.3685
    ## 1541   6619.5514
    ## 1542   7899.5542
    ## 1543   9119.5286
    ## 1544   7388.5978
    ## 1545   7370.9909
    ## 1546   8792.5731
    ## 1547  11460.6002
    ## 1548  18008.5092
    ## 1549   1468.4756
    ## 1550   1395.2325
    ## 1551   1660.3032
    ## 1552   1932.3602
    ## 1553   2753.2860
    ## 1554   3120.8768
    ## 1555   3560.2332
    ## 1556   3810.4193
    ## 1557   4332.7202
    ## 1558   4876.7986
    ## 1559   5722.8957
    ## 1560   7092.9230
    ## 1561   1969.1010
    ## 1562   2218.7543
    ## 1563   2322.8699
    ## 1564   2826.3564
    ## 1565   3450.6964
    ## 1566   4269.1223
    ## 1567   4241.3563
    ## 1568   5089.0437
    ## 1569   5678.3483
    ## 1570   6601.4299
    ## 1571   6508.0857
    ## 1572   8458.2764
    ## 1573    734.7535
    ## 1574    774.3711
    ## 1575    767.2717
    ## 1576    908.9185
    ## 1577    950.7359
    ## 1578    843.7331
    ## 1579    682.2662
    ## 1580    617.7244
    ## 1581    644.1708
    ## 1582    816.5591
    ## 1583    927.7210
    ## 1584   1056.3801
    ## 1585   9979.5085
    ## 1586  11283.1779
    ## 1587  12477.1771
    ## 1588  14142.8509
    ## 1589  15895.1164
    ## 1590  17428.7485
    ## 1591  18232.4245
    ## 1592  21664.7877
    ## 1593  22705.0925
    ## 1594  26074.5314
    ## 1595  29478.9992
    ## 1596  33203.2613
    ## 1597  13990.4821
    ## 1598  14847.1271
    ## 1599  16173.1459
    ## 1600  19530.3656
    ## 1601  21806.0359
    ## 1602  24072.6321
    ## 1603  25009.5591
    ## 1604  29884.3504
    ## 1605  32003.9322
    ## 1606  35767.4330
    ## 1607  39097.0995
    ## 1608  42951.6531
    ## 1609   5716.7667
    ## 1610   6150.7730
    ## 1611   5603.3577
    ## 1612   5444.6196
    ## 1613   5703.4089
    ## 1614   6504.3397
    ## 1615   6920.2231
    ## 1616   7452.3990
    ## 1617   8137.0048
    ## 1618   9230.2407
    ## 1619   7727.0020
    ## 1620  10611.4630
    ## 1621   7689.7998
    ## 1622   9802.4665
    ## 1623   8422.9742
    ## 1624   9541.4742
    ## 1625  10505.2597
    ## 1626  13143.9510
    ## 1627  11152.4101
    ## 1628   9883.5846
    ## 1629  10733.9263
    ## 1630  10165.4952
    ## 1631   8605.0478
    ## 1632  11415.8057
    ## 1633    605.0665
    ## 1634    676.2854
    ## 1635    772.0492
    ## 1636    637.1233
    ## 1637    699.5016
    ## 1638    713.5371
    ## 1639    707.2358
    ## 1640    820.7994
    ## 1641    989.0231
    ## 1642   1385.8968
    ## 1643   1764.4567
    ## 1644   2441.5764
    ## 1645   1515.5923
    ## 1646   1827.0677
    ## 1647   2198.9563
    ## 1648   2649.7150
    ## 1649   3133.4093
    ## 1650   3682.8315
    ## 1651   4336.0321
    ## 1652   5107.1974
    ## 1653   6017.6548
    ## 1654   7110.6676
    ## 1655   4515.4876
    ## 1656   3025.3498
    ## 1657    781.7176
    ## 1658    804.8305
    ## 1659    825.6232
    ## 1660    862.4421
    ## 1661   1265.0470
    ## 1662   1829.7652
    ## 1663   1977.5570
    ## 1664   1971.7415
    ## 1665   1879.4967
    ## 1666   2117.4845
    ## 1667   2234.8208
    ## 1668   2280.7699
    ## 1669   1147.3888
    ## 1670   1311.9568
    ## 1671   1452.7258
    ## 1672   1777.0773
    ## 1673   1773.4983
    ## 1674   1588.6883
    ## 1675   1408.6786
    ## 1676   1213.3151
    ## 1677   1210.8846
    ## 1678   1071.3538
    ## 1679   1071.6139
    ## 1680   1271.2116
    ## 1681    406.8841
    ## 1682    518.7643
    ## 1683    527.2722
    ## 1684    569.7951
    ## 1685    799.3622
    ## 1686    685.5877
    ## 1687    788.8550
    ## 1688    706.1573
    ## 1689    693.4208
    ## 1690    792.4500
    ## 1691    672.0386
    ## 1692    469.7093

... becomes:

``` r
filter(gapminder, country != "France")
```

    ##                       country year        pop continent  lifeExp
    ## 1                 Afghanistan 1952    8425333      Asia 28.80100
    ## 2                 Afghanistan 1957    9240934      Asia 30.33200
    ## 3                 Afghanistan 1962   10267083      Asia 31.99700
    ## 4                 Afghanistan 1967   11537966      Asia 34.02000
    ## 5                 Afghanistan 1972   13079460      Asia 36.08800
    ## 6                 Afghanistan 1977   14880372      Asia 38.43800
    ## 7                 Afghanistan 1982   12881816      Asia 39.85400
    ## 8                 Afghanistan 1987   13867957      Asia 40.82200
    ## 9                 Afghanistan 1992   16317921      Asia 41.67400
    ## 10                Afghanistan 1997   22227415      Asia 41.76300
    ## 11                Afghanistan 2002   25268405      Asia 42.12900
    ## 12                Afghanistan 2007   31889923      Asia 43.82800
    ## 13                    Albania 1952    1282697    Europe 55.23000
    ## 14                    Albania 1957    1476505    Europe 59.28000
    ## 15                    Albania 1962    1728137    Europe 64.82000
    ## 16                    Albania 1967    1984060    Europe 66.22000
    ## 17                    Albania 1972    2263554    Europe 67.69000
    ## 18                    Albania 1977    2509048    Europe 68.93000
    ## 19                    Albania 1982    2780097    Europe 70.42000
    ## 20                    Albania 1987    3075321    Europe 72.00000
    ## 21                    Albania 1992    3326498    Europe 71.58100
    ## 22                    Albania 1997    3428038    Europe 72.95000
    ## 23                    Albania 2002    3508512    Europe 75.65100
    ## 24                    Albania 2007    3600523    Europe 76.42300
    ## 25                    Algeria 1952    9279525    Africa 43.07700
    ## 26                    Algeria 1957   10270856    Africa 45.68500
    ## 27                    Algeria 1962   11000948    Africa 48.30300
    ## 28                    Algeria 1967   12760499    Africa 51.40700
    ## 29                    Algeria 1972   14760787    Africa 54.51800
    ## 30                    Algeria 1977   17152804    Africa 58.01400
    ## 31                    Algeria 1982   20033753    Africa 61.36800
    ## 32                    Algeria 1987   23254956    Africa 65.79900
    ## 33                    Algeria 1992   26298373    Africa 67.74400
    ## 34                    Algeria 1997   29072015    Africa 69.15200
    ## 35                    Algeria 2002   31287142    Africa 70.99400
    ## 36                    Algeria 2007   33333216    Africa 72.30100
    ## 37                     Angola 1952    4232095    Africa 30.01500
    ## 38                     Angola 1957    4561361    Africa 31.99900
    ## 39                     Angola 1962    4826015    Africa 34.00000
    ## 40                     Angola 1967    5247469    Africa 35.98500
    ## 41                     Angola 1972    5894858    Africa 37.92800
    ## 42                     Angola 1977    6162675    Africa 39.48300
    ## 43                     Angola 1982    7016384    Africa 39.94200
    ## 44                     Angola 1987    7874230    Africa 39.90600
    ## 45                     Angola 1992    8735988    Africa 40.64700
    ## 46                     Angola 1997    9875024    Africa 40.96300
    ## 47                     Angola 2002   10866106    Africa 41.00300
    ## 48                     Angola 2007   12420476    Africa 42.73100
    ## 49                  Argentina 1952   17876956  Americas 62.48500
    ## 50                  Argentina 1957   19610538  Americas 64.39900
    ## 51                  Argentina 1962   21283783  Americas 65.14200
    ## 52                  Argentina 1967   22934225  Americas 65.63400
    ## 53                  Argentina 1972   24779799  Americas 67.06500
    ## 54                  Argentina 1977   26983828  Americas 68.48100
    ## 55                  Argentina 1982   29341374  Americas 69.94200
    ## 56                  Argentina 1987   31620918  Americas 70.77400
    ## 57                  Argentina 1992   33958947  Americas 71.86800
    ## 58                  Argentina 1997   36203463  Americas 73.27500
    ## 59                  Argentina 2002   38331121  Americas 74.34000
    ## 60                  Argentina 2007   40301927  Americas 75.32000
    ## 61                  Australia 1952    8691212   Oceania 69.12000
    ## 62                  Australia 1957    9712569   Oceania 70.33000
    ## 63                  Australia 1962   10794968   Oceania 70.93000
    ## 64                  Australia 1967   11872264   Oceania 71.10000
    ## 65                  Australia 1972   13177000   Oceania 71.93000
    ## 66                  Australia 1977   14074100   Oceania 73.49000
    ## 67                  Australia 1982   15184200   Oceania 74.74000
    ## 68                  Australia 1987   16257249   Oceania 76.32000
    ## 69                  Australia 1992   17481977   Oceania 77.56000
    ## 70                  Australia 1997   18565243   Oceania 78.83000
    ## 71                  Australia 2002   19546792   Oceania 80.37000
    ## 72                  Australia 2007   20434176   Oceania 81.23500
    ## 73                    Austria 1952    6927772    Europe 66.80000
    ## 74                    Austria 1957    6965860    Europe 67.48000
    ## 75                    Austria 1962    7129864    Europe 69.54000
    ## 76                    Austria 1967    7376998    Europe 70.14000
    ## 77                    Austria 1972    7544201    Europe 70.63000
    ## 78                    Austria 1977    7568430    Europe 72.17000
    ## 79                    Austria 1982    7574613    Europe 73.18000
    ## 80                    Austria 1987    7578903    Europe 74.94000
    ## 81                    Austria 1992    7914969    Europe 76.04000
    ## 82                    Austria 1997    8069876    Europe 77.51000
    ## 83                    Austria 2002    8148312    Europe 78.98000
    ## 84                    Austria 2007    8199783    Europe 79.82900
    ## 85                    Bahrain 1952     120447      Asia 50.93900
    ## 86                    Bahrain 1957     138655      Asia 53.83200
    ## 87                    Bahrain 1962     171863      Asia 56.92300
    ## 88                    Bahrain 1967     202182      Asia 59.92300
    ## 89                    Bahrain 1972     230800      Asia 63.30000
    ## 90                    Bahrain 1977     297410      Asia 65.59300
    ## 91                    Bahrain 1982     377967      Asia 69.05200
    ## 92                    Bahrain 1987     454612      Asia 70.75000
    ## 93                    Bahrain 1992     529491      Asia 72.60100
    ## 94                    Bahrain 1997     598561      Asia 73.92500
    ## 95                    Bahrain 2002     656397      Asia 74.79500
    ## 96                    Bahrain 2007     708573      Asia 75.63500
    ## 97                 Bangladesh 1952   46886859      Asia 37.48400
    ## 98                 Bangladesh 1957   51365468      Asia 39.34800
    ## 99                 Bangladesh 1962   56839289      Asia 41.21600
    ## 100                Bangladesh 1967   62821884      Asia 43.45300
    ## 101                Bangladesh 1972   70759295      Asia 45.25200
    ## 102                Bangladesh 1977   80428306      Asia 46.92300
    ## 103                Bangladesh 1982   93074406      Asia 50.00900
    ## 104                Bangladesh 1987  103764241      Asia 52.81900
    ## 105                Bangladesh 1992  113704579      Asia 56.01800
    ## 106                Bangladesh 1997  123315288      Asia 59.41200
    ## 107                Bangladesh 2002  135656790      Asia 62.01300
    ## 108                Bangladesh 2007  150448339      Asia 64.06200
    ## 109                   Belgium 1952    8730405    Europe 68.00000
    ## 110                   Belgium 1957    8989111    Europe 69.24000
    ## 111                   Belgium 1962    9218400    Europe 70.25000
    ## 112                   Belgium 1967    9556500    Europe 70.94000
    ## 113                   Belgium 1972    9709100    Europe 71.44000
    ## 114                   Belgium 1977    9821800    Europe 72.80000
    ## 115                   Belgium 1982    9856303    Europe 73.93000
    ## 116                   Belgium 1987    9870200    Europe 75.35000
    ## 117                   Belgium 1992   10045622    Europe 76.46000
    ## 118                   Belgium 1997   10199787    Europe 77.53000
    ## 119                   Belgium 2002   10311970    Europe 78.32000
    ## 120                   Belgium 2007   10392226    Europe 79.44100
    ## 121                     Benin 1952    1738315    Africa 38.22300
    ## 122                     Benin 1957    1925173    Africa 40.35800
    ## 123                     Benin 1962    2151895    Africa 42.61800
    ## 124                     Benin 1967    2427334    Africa 44.88500
    ## 125                     Benin 1972    2761407    Africa 47.01400
    ## 126                     Benin 1977    3168267    Africa 49.19000
    ## 127                     Benin 1982    3641603    Africa 50.90400
    ## 128                     Benin 1987    4243788    Africa 52.33700
    ## 129                     Benin 1992    4981671    Africa 53.91900
    ## 130                     Benin 1997    6066080    Africa 54.77700
    ## 131                     Benin 2002    7026113    Africa 54.40600
    ## 132                     Benin 2007    8078314    Africa 56.72800
    ## 133                   Bolivia 1952    2883315  Americas 40.41400
    ## 134                   Bolivia 1957    3211738  Americas 41.89000
    ## 135                   Bolivia 1962    3593918  Americas 43.42800
    ## 136                   Bolivia 1967    4040665  Americas 45.03200
    ## 137                   Bolivia 1972    4565872  Americas 46.71400
    ## 138                   Bolivia 1977    5079716  Americas 50.02300
    ## 139                   Bolivia 1982    5642224  Americas 53.85900
    ## 140                   Bolivia 1987    6156369  Americas 57.25100
    ## 141                   Bolivia 1992    6893451  Americas 59.95700
    ## 142                   Bolivia 1997    7693188  Americas 62.05000
    ## 143                   Bolivia 2002    8445134  Americas 63.88300
    ## 144                   Bolivia 2007    9119152  Americas 65.55400
    ## 145    Bosnia and Herzegovina 1952    2791000    Europe 53.82000
    ## 146    Bosnia and Herzegovina 1957    3076000    Europe 58.45000
    ## 147    Bosnia and Herzegovina 1962    3349000    Europe 61.93000
    ## 148    Bosnia and Herzegovina 1967    3585000    Europe 64.79000
    ## 149    Bosnia and Herzegovina 1972    3819000    Europe 67.45000
    ## 150    Bosnia and Herzegovina 1977    4086000    Europe 69.86000
    ## 151    Bosnia and Herzegovina 1982    4172693    Europe 70.69000
    ## 152    Bosnia and Herzegovina 1987    4338977    Europe 71.14000
    ## 153    Bosnia and Herzegovina 1992    4256013    Europe 72.17800
    ## 154    Bosnia and Herzegovina 1997    3607000    Europe 73.24400
    ## 155    Bosnia and Herzegovina 2002    4165416    Europe 74.09000
    ## 156    Bosnia and Herzegovina 2007    4552198    Europe 74.85200
    ## 157                  Botswana 1952     442308    Africa 47.62200
    ## 158                  Botswana 1957     474639    Africa 49.61800
    ## 159                  Botswana 1962     512764    Africa 51.52000
    ## 160                  Botswana 1967     553541    Africa 53.29800
    ## 161                  Botswana 1972     619351    Africa 56.02400
    ## 162                  Botswana 1977     781472    Africa 59.31900
    ## 163                  Botswana 1982     970347    Africa 61.48400
    ## 164                  Botswana 1987    1151184    Africa 63.62200
    ## 165                  Botswana 1992    1342614    Africa 62.74500
    ## 166                  Botswana 1997    1536536    Africa 52.55600
    ## 167                  Botswana 2002    1630347    Africa 46.63400
    ## 168                  Botswana 2007    1639131    Africa 50.72800
    ## 169                    Brazil 1952   56602560  Americas 50.91700
    ## 170                    Brazil 1957   65551171  Americas 53.28500
    ## 171                    Brazil 1962   76039390  Americas 55.66500
    ## 172                    Brazil 1967   88049823  Americas 57.63200
    ## 173                    Brazil 1972  100840058  Americas 59.50400
    ## 174                    Brazil 1977  114313951  Americas 61.48900
    ## 175                    Brazil 1982  128962939  Americas 63.33600
    ## 176                    Brazil 1987  142938076  Americas 65.20500
    ## 177                    Brazil 1992  155975974  Americas 67.05700
    ## 178                    Brazil 1997  168546719  Americas 69.38800
    ## 179                    Brazil 2002  179914212  Americas 71.00600
    ## 180                    Brazil 2007  190010647  Americas 72.39000
    ## 181                  Bulgaria 1952    7274900    Europe 59.60000
    ## 182                  Bulgaria 1957    7651254    Europe 66.61000
    ## 183                  Bulgaria 1962    8012946    Europe 69.51000
    ## 184                  Bulgaria 1967    8310226    Europe 70.42000
    ## 185                  Bulgaria 1972    8576200    Europe 70.90000
    ## 186                  Bulgaria 1977    8797022    Europe 70.81000
    ## 187                  Bulgaria 1982    8892098    Europe 71.08000
    ## 188                  Bulgaria 1987    8971958    Europe 71.34000
    ## 189                  Bulgaria 1992    8658506    Europe 71.19000
    ## 190                  Bulgaria 1997    8066057    Europe 70.32000
    ## 191                  Bulgaria 2002    7661799    Europe 72.14000
    ## 192                  Bulgaria 2007    7322858    Europe 73.00500
    ## 193              Burkina Faso 1952    4469979    Africa 31.97500
    ## 194              Burkina Faso 1957    4713416    Africa 34.90600
    ## 195              Burkina Faso 1962    4919632    Africa 37.81400
    ## 196              Burkina Faso 1967    5127935    Africa 40.69700
    ## 197              Burkina Faso 1972    5433886    Africa 43.59100
    ## 198              Burkina Faso 1977    5889574    Africa 46.13700
    ## 199              Burkina Faso 1982    6634596    Africa 48.12200
    ## 200              Burkina Faso 1987    7586551    Africa 49.55700
    ## 201              Burkina Faso 1992    8878303    Africa 50.26000
    ## 202              Burkina Faso 1997   10352843    Africa 50.32400
    ## 203              Burkina Faso 2002   12251209    Africa 50.65000
    ## 204              Burkina Faso 2007   14326203    Africa 52.29500
    ## 205                   Burundi 1952    2445618    Africa 39.03100
    ## 206                   Burundi 1957    2667518    Africa 40.53300
    ## 207                   Burundi 1962    2961915    Africa 42.04500
    ## 208                   Burundi 1967    3330989    Africa 43.54800
    ## 209                   Burundi 1972    3529983    Africa 44.05700
    ## 210                   Burundi 1977    3834415    Africa 45.91000
    ## 211                   Burundi 1982    4580410    Africa 47.47100
    ## 212                   Burundi 1987    5126023    Africa 48.21100
    ## 213                   Burundi 1992    5809236    Africa 44.73600
    ## 214                   Burundi 1997    6121610    Africa 45.32600
    ## 215                   Burundi 2002    7021078    Africa 47.36000
    ## 216                   Burundi 2007    8390505    Africa 49.58000
    ## 217                  Cambodia 1952    4693836      Asia 39.41700
    ## 218                  Cambodia 1957    5322536      Asia 41.36600
    ## 219                  Cambodia 1962    6083619      Asia 43.41500
    ## 220                  Cambodia 1967    6960067      Asia 45.41500
    ## 221                  Cambodia 1972    7450606      Asia 40.31700
    ## 222                  Cambodia 1977    6978607      Asia 31.22000
    ## 223                  Cambodia 1982    7272485      Asia 50.95700
    ## 224                  Cambodia 1987    8371791      Asia 53.91400
    ## 225                  Cambodia 1992   10150094      Asia 55.80300
    ## 226                  Cambodia 1997   11782962      Asia 56.53400
    ## 227                  Cambodia 2002   12926707      Asia 56.75200
    ## 228                  Cambodia 2007   14131858      Asia 59.72300
    ## 229                  Cameroon 1952    5009067    Africa 38.52300
    ## 230                  Cameroon 1957    5359923    Africa 40.42800
    ## 231                  Cameroon 1962    5793633    Africa 42.64300
    ## 232                  Cameroon 1967    6335506    Africa 44.79900
    ## 233                  Cameroon 1972    7021028    Africa 47.04900
    ## 234                  Cameroon 1977    7959865    Africa 49.35500
    ## 235                  Cameroon 1982    9250831    Africa 52.96100
    ## 236                  Cameroon 1987   10780667    Africa 54.98500
    ## 237                  Cameroon 1992   12467171    Africa 54.31400
    ## 238                  Cameroon 1997   14195809    Africa 52.19900
    ## 239                  Cameroon 2002   15929988    Africa 49.85600
    ## 240                  Cameroon 2007   17696293    Africa 50.43000
    ## 241                    Canada 1952   14785584  Americas 68.75000
    ## 242                    Canada 1957   17010154  Americas 69.96000
    ## 243                    Canada 1962   18985849  Americas 71.30000
    ## 244                    Canada 1967   20819767  Americas 72.13000
    ## 245                    Canada 1972   22284500  Americas 72.88000
    ## 246                    Canada 1977   23796400  Americas 74.21000
    ## 247                    Canada 1982   25201900  Americas 75.76000
    ## 248                    Canada 1987   26549700  Americas 76.86000
    ## 249                    Canada 1992   28523502  Americas 77.95000
    ## 250                    Canada 1997   30305843  Americas 78.61000
    ## 251                    Canada 2002   31902268  Americas 79.77000
    ## 252                    Canada 2007   33390141  Americas 80.65300
    ## 253  Central African Republic 1952    1291695    Africa 35.46300
    ## 254  Central African Republic 1957    1392284    Africa 37.46400
    ## 255  Central African Republic 1962    1523478    Africa 39.47500
    ## 256  Central African Republic 1967    1733638    Africa 41.47800
    ## 257  Central African Republic 1972    1927260    Africa 43.45700
    ## 258  Central African Republic 1977    2167533    Africa 46.77500
    ## 259  Central African Republic 1982    2476971    Africa 48.29500
    ## 260  Central African Republic 1987    2840009    Africa 50.48500
    ## 261  Central African Republic 1992    3265124    Africa 49.39600
    ## 262  Central African Republic 1997    3696513    Africa 46.06600
    ## 263  Central African Republic 2002    4048013    Africa 43.30800
    ## 264  Central African Republic 2007    4369038    Africa 44.74100
    ## 265                      Chad 1952    2682462    Africa 38.09200
    ## 266                      Chad 1957    2894855    Africa 39.88100
    ## 267                      Chad 1962    3150417    Africa 41.71600
    ## 268                      Chad 1967    3495967    Africa 43.60100
    ## 269                      Chad 1972    3899068    Africa 45.56900
    ## 270                      Chad 1977    4388260    Africa 47.38300
    ## 271                      Chad 1982    4875118    Africa 49.51700
    ## 272                      Chad 1987    5498955    Africa 51.05100
    ## 273                      Chad 1992    6429417    Africa 51.72400
    ## 274                      Chad 1997    7562011    Africa 51.57300
    ## 275                      Chad 2002    8835739    Africa 50.52500
    ## 276                      Chad 2007   10238807    Africa 50.65100
    ## 277                     Chile 1952    6377619  Americas 54.74500
    ## 278                     Chile 1957    7048426  Americas 56.07400
    ## 279                     Chile 1962    7961258  Americas 57.92400
    ## 280                     Chile 1967    8858908  Americas 60.52300
    ## 281                     Chile 1972    9717524  Americas 63.44100
    ## 282                     Chile 1977   10599793  Americas 67.05200
    ## 283                     Chile 1982   11487112  Americas 70.56500
    ## 284                     Chile 1987   12463354  Americas 72.49200
    ## 285                     Chile 1992   13572994  Americas 74.12600
    ## 286                     Chile 1997   14599929  Americas 75.81600
    ## 287                     Chile 2002   15497046  Americas 77.86000
    ## 288                     Chile 2007   16284741  Americas 78.55300
    ## 289                     China 1952  556263528      Asia 44.00000
    ## 290                     China 1957  637408000      Asia 50.54896
    ## 291                     China 1962  665770000      Asia 44.50136
    ## 292                     China 1967  754550000      Asia 58.38112
    ## 293                     China 1972  862030000      Asia 63.11888
    ## 294                     China 1977  943455000      Asia 63.96736
    ## 295                     China 1982 1000281000      Asia 65.52500
    ## 296                     China 1987 1084035000      Asia 67.27400
    ## 297                     China 1992 1164970000      Asia 68.69000
    ## 298                     China 1997 1230075000      Asia 70.42600
    ## 299                     China 2002 1280400000      Asia 72.02800
    ## 300                     China 2007 1318683096      Asia 72.96100
    ## 301                  Colombia 1952   12350771  Americas 50.64300
    ## 302                  Colombia 1957   14485993  Americas 55.11800
    ## 303                  Colombia 1962   17009885  Americas 57.86300
    ## 304                  Colombia 1967   19764027  Americas 59.96300
    ## 305                  Colombia 1972   22542890  Americas 61.62300
    ## 306                  Colombia 1977   25094412  Americas 63.83700
    ## 307                  Colombia 1982   27764644  Americas 66.65300
    ## 308                  Colombia 1987   30964245  Americas 67.76800
    ## 309                  Colombia 1992   34202721  Americas 68.42100
    ## 310                  Colombia 1997   37657830  Americas 70.31300
    ## 311                  Colombia 2002   41008227  Americas 71.68200
    ## 312                  Colombia 2007   44227550  Americas 72.88900
    ## 313                   Comoros 1952     153936    Africa 40.71500
    ## 314                   Comoros 1957     170928    Africa 42.46000
    ## 315                   Comoros 1962     191689    Africa 44.46700
    ## 316                   Comoros 1967     217378    Africa 46.47200
    ## 317                   Comoros 1972     250027    Africa 48.94400
    ## 318                   Comoros 1977     304739    Africa 50.93900
    ## 319                   Comoros 1982     348643    Africa 52.93300
    ## 320                   Comoros 1987     395114    Africa 54.92600
    ## 321                   Comoros 1992     454429    Africa 57.93900
    ## 322                   Comoros 1997     527982    Africa 60.66000
    ## 323                   Comoros 2002     614382    Africa 62.97400
    ## 324                   Comoros 2007     710960    Africa 65.15200
    ## 325           Congo Dem. Rep. 1952   14100005    Africa 39.14300
    ## 326           Congo Dem. Rep. 1957   15577932    Africa 40.65200
    ## 327           Congo Dem. Rep. 1962   17486434    Africa 42.12200
    ## 328           Congo Dem. Rep. 1967   19941073    Africa 44.05600
    ## 329           Congo Dem. Rep. 1972   23007669    Africa 45.98900
    ## 330           Congo Dem. Rep. 1977   26480870    Africa 47.80400
    ## 331           Congo Dem. Rep. 1982   30646495    Africa 47.78400
    ## 332           Congo Dem. Rep. 1987   35481645    Africa 47.41200
    ## 333           Congo Dem. Rep. 1992   41672143    Africa 45.54800
    ## 334           Congo Dem. Rep. 1997   47798986    Africa 42.58700
    ## 335           Congo Dem. Rep. 2002   55379852    Africa 44.96600
    ## 336           Congo Dem. Rep. 2007   64606759    Africa 46.46200
    ## 337                Congo Rep. 1952     854885    Africa 42.11100
    ## 338                Congo Rep. 1957     940458    Africa 45.05300
    ## 339                Congo Rep. 1962    1047924    Africa 48.43500
    ## 340                Congo Rep. 1967    1179760    Africa 52.04000
    ## 341                Congo Rep. 1972    1340458    Africa 54.90700
    ## 342                Congo Rep. 1977    1536769    Africa 55.62500
    ## 343                Congo Rep. 1982    1774735    Africa 56.69500
    ## 344                Congo Rep. 1987    2064095    Africa 57.47000
    ## 345                Congo Rep. 1992    2409073    Africa 56.43300
    ## 346                Congo Rep. 1997    2800947    Africa 52.96200
    ## 347                Congo Rep. 2002    3328795    Africa 52.97000
    ## 348                Congo Rep. 2007    3800610    Africa 55.32200
    ## 349                Costa Rica 1952     926317  Americas 57.20600
    ## 350                Costa Rica 1957    1112300  Americas 60.02600
    ## 351                Costa Rica 1962    1345187  Americas 62.84200
    ## 352                Costa Rica 1967    1588717  Americas 65.42400
    ## 353                Costa Rica 1972    1834796  Americas 67.84900
    ## 354                Costa Rica 1977    2108457  Americas 70.75000
    ## 355                Costa Rica 1982    2424367  Americas 73.45000
    ## 356                Costa Rica 1987    2799811  Americas 74.75200
    ## 357                Costa Rica 1992    3173216  Americas 75.71300
    ## 358                Costa Rica 1997    3518107  Americas 77.26000
    ## 359                Costa Rica 2002    3834934  Americas 78.12300
    ## 360                Costa Rica 2007    4133884  Americas 78.78200
    ## 361             Cote d'Ivoire 1952    2977019    Africa 40.47700
    ## 362             Cote d'Ivoire 1957    3300000    Africa 42.46900
    ## 363             Cote d'Ivoire 1962    3832408    Africa 44.93000
    ## 364             Cote d'Ivoire 1967    4744870    Africa 47.35000
    ## 365             Cote d'Ivoire 1972    6071696    Africa 49.80100
    ## 366             Cote d'Ivoire 1977    7459574    Africa 52.37400
    ## 367             Cote d'Ivoire 1982    9025951    Africa 53.98300
    ## 368             Cote d'Ivoire 1987   10761098    Africa 54.65500
    ## 369             Cote d'Ivoire 1992   12772596    Africa 52.04400
    ## 370             Cote d'Ivoire 1997   14625967    Africa 47.99100
    ## 371             Cote d'Ivoire 2002   16252726    Africa 46.83200
    ## 372             Cote d'Ivoire 2007   18013409    Africa 48.32800
    ## 373                   Croatia 1952    3882229    Europe 61.21000
    ## 374                   Croatia 1957    3991242    Europe 64.77000
    ## 375                   Croatia 1962    4076557    Europe 67.13000
    ## 376                   Croatia 1967    4174366    Europe 68.50000
    ## 377                   Croatia 1972    4225310    Europe 69.61000
    ## 378                   Croatia 1977    4318673    Europe 70.64000
    ## 379                   Croatia 1982    4413368    Europe 70.46000
    ## 380                   Croatia 1987    4484310    Europe 71.52000
    ## 381                   Croatia 1992    4494013    Europe 72.52700
    ## 382                   Croatia 1997    4444595    Europe 73.68000
    ## 383                   Croatia 2002    4481020    Europe 74.87600
    ## 384                   Croatia 2007    4493312    Europe 75.74800
    ## 385                      Cuba 1952    6007797  Americas 59.42100
    ## 386                      Cuba 1957    6640752  Americas 62.32500
    ## 387                      Cuba 1962    7254373  Americas 65.24600
    ## 388                      Cuba 1967    8139332  Americas 68.29000
    ## 389                      Cuba 1972    8831348  Americas 70.72300
    ## 390                      Cuba 1977    9537988  Americas 72.64900
    ## 391                      Cuba 1982    9789224  Americas 73.71700
    ## 392                      Cuba 1987   10239839  Americas 74.17400
    ## 393                      Cuba 1992   10723260  Americas 74.41400
    ## 394                      Cuba 1997   10983007  Americas 76.15100
    ## 395                      Cuba 2002   11226999  Americas 77.15800
    ## 396                      Cuba 2007   11416987  Americas 78.27300
    ## 397            Czech Republic 1952    9125183    Europe 66.87000
    ## 398            Czech Republic 1957    9513758    Europe 69.03000
    ## 399            Czech Republic 1962    9620282    Europe 69.90000
    ## 400            Czech Republic 1967    9835109    Europe 70.38000
    ## 401            Czech Republic 1972    9862158    Europe 70.29000
    ## 402            Czech Republic 1977   10161915    Europe 70.71000
    ## 403            Czech Republic 1982   10303704    Europe 70.96000
    ## 404            Czech Republic 1987   10311597    Europe 71.58000
    ## 405            Czech Republic 1992   10315702    Europe 72.40000
    ## 406            Czech Republic 1997   10300707    Europe 74.01000
    ## 407            Czech Republic 2002   10256295    Europe 75.51000
    ## 408            Czech Republic 2007   10228744    Europe 76.48600
    ## 409                   Denmark 1952    4334000    Europe 70.78000
    ## 410                   Denmark 1957    4487831    Europe 71.81000
    ## 411                   Denmark 1962    4646899    Europe 72.35000
    ## 412                   Denmark 1967    4838800    Europe 72.96000
    ## 413                   Denmark 1972    4991596    Europe 73.47000
    ## 414                   Denmark 1977    5088419    Europe 74.69000
    ## 415                   Denmark 1982    5117810    Europe 74.63000
    ## 416                   Denmark 1987    5127024    Europe 74.80000
    ## 417                   Denmark 1992    5171393    Europe 75.33000
    ## 418                   Denmark 1997    5283663    Europe 76.11000
    ## 419                   Denmark 2002    5374693    Europe 77.18000
    ## 420                   Denmark 2007    5468120    Europe 78.33200
    ## 421                  Djibouti 1952      63149    Africa 34.81200
    ## 422                  Djibouti 1957      71851    Africa 37.32800
    ## 423                  Djibouti 1962      89898    Africa 39.69300
    ## 424                  Djibouti 1967     127617    Africa 42.07400
    ## 425                  Djibouti 1972     178848    Africa 44.36600
    ## 426                  Djibouti 1977     228694    Africa 46.51900
    ## 427                  Djibouti 1982     305991    Africa 48.81200
    ## 428                  Djibouti 1987     311025    Africa 50.04000
    ## 429                  Djibouti 1992     384156    Africa 51.60400
    ## 430                  Djibouti 1997     417908    Africa 53.15700
    ## 431                  Djibouti 2002     447416    Africa 53.37300
    ## 432                  Djibouti 2007     496374    Africa 54.79100
    ## 433        Dominican Republic 1952    2491346  Americas 45.92800
    ## 434        Dominican Republic 1957    2923186  Americas 49.82800
    ## 435        Dominican Republic 1962    3453434  Americas 53.45900
    ## 436        Dominican Republic 1967    4049146  Americas 56.75100
    ## 437        Dominican Republic 1972    4671329  Americas 59.63100
    ## 438        Dominican Republic 1977    5302800  Americas 61.78800
    ## 439        Dominican Republic 1982    5968349  Americas 63.72700
    ## 440        Dominican Republic 1987    6655297  Americas 66.04600
    ## 441        Dominican Republic 1992    7351181  Americas 68.45700
    ## 442        Dominican Republic 1997    7992357  Americas 69.95700
    ## 443        Dominican Republic 2002    8650322  Americas 70.84700
    ## 444        Dominican Republic 2007    9319622  Americas 72.23500
    ## 445                   Ecuador 1952    3548753  Americas 48.35700
    ## 446                   Ecuador 1957    4058385  Americas 51.35600
    ## 447                   Ecuador 1962    4681707  Americas 54.64000
    ## 448                   Ecuador 1967    5432424  Americas 56.67800
    ## 449                   Ecuador 1972    6298651  Americas 58.79600
    ## 450                   Ecuador 1977    7278866  Americas 61.31000
    ## 451                   Ecuador 1982    8365850  Americas 64.34200
    ## 452                   Ecuador 1987    9545158  Americas 67.23100
    ## 453                   Ecuador 1992   10748394  Americas 69.61300
    ## 454                   Ecuador 1997   11911819  Americas 72.31200
    ## 455                   Ecuador 2002   12921234  Americas 74.17300
    ## 456                   Ecuador 2007   13755680  Americas 74.99400
    ## 457                     Egypt 1952   22223309    Africa 41.89300
    ## 458                     Egypt 1957   25009741    Africa 44.44400
    ## 459                     Egypt 1962   28173309    Africa 46.99200
    ## 460                     Egypt 1967   31681188    Africa 49.29300
    ## 461                     Egypt 1972   34807417    Africa 51.13700
    ## 462                     Egypt 1977   38783863    Africa 53.31900
    ## 463                     Egypt 1982   45681811    Africa 56.00600
    ## 464                     Egypt 1987   52799062    Africa 59.79700
    ## 465                     Egypt 1992   59402198    Africa 63.67400
    ## 466                     Egypt 1997   66134291    Africa 67.21700
    ## 467                     Egypt 2002   73312559    Africa 69.80600
    ## 468                     Egypt 2007   80264543    Africa 71.33800
    ## 469               El Salvador 1952    2042865  Americas 45.26200
    ## 470               El Salvador 1957    2355805  Americas 48.57000
    ## 471               El Salvador 1962    2747687  Americas 52.30700
    ## 472               El Salvador 1967    3232927  Americas 55.85500
    ## 473               El Salvador 1972    3790903  Americas 58.20700
    ## 474               El Salvador 1977    4282586  Americas 56.69600
    ## 475               El Salvador 1982    4474873  Americas 56.60400
    ## 476               El Salvador 1987    4842194  Americas 63.15400
    ## 477               El Salvador 1992    5274649  Americas 66.79800
    ## 478               El Salvador 1997    5783439  Americas 69.53500
    ## 479               El Salvador 2002    6353681  Americas 70.73400
    ## 480               El Salvador 2007    6939688  Americas 71.87800
    ## 481         Equatorial Guinea 1952     216964    Africa 34.48200
    ## 482         Equatorial Guinea 1957     232922    Africa 35.98300
    ## 483         Equatorial Guinea 1962     249220    Africa 37.48500
    ## 484         Equatorial Guinea 1967     259864    Africa 38.98700
    ## 485         Equatorial Guinea 1972     277603    Africa 40.51600
    ## 486         Equatorial Guinea 1977     192675    Africa 42.02400
    ## 487         Equatorial Guinea 1982     285483    Africa 43.66200
    ## 488         Equatorial Guinea 1987     341244    Africa 45.66400
    ## 489         Equatorial Guinea 1992     387838    Africa 47.54500
    ## 490         Equatorial Guinea 1997     439971    Africa 48.24500
    ## 491         Equatorial Guinea 2002     495627    Africa 49.34800
    ## 492         Equatorial Guinea 2007     551201    Africa 51.57900
    ## 493                   Eritrea 1952    1438760    Africa 35.92800
    ## 494                   Eritrea 1957    1542611    Africa 38.04700
    ## 495                   Eritrea 1962    1666618    Africa 40.15800
    ## 496                   Eritrea 1967    1820319    Africa 42.18900
    ## 497                   Eritrea 1972    2260187    Africa 44.14200
    ## 498                   Eritrea 1977    2512642    Africa 44.53500
    ## 499                   Eritrea 1982    2637297    Africa 43.89000
    ## 500                   Eritrea 1987    2915959    Africa 46.45300
    ## 501                   Eritrea 1992    3668440    Africa 49.99100
    ## 502                   Eritrea 1997    4058319    Africa 53.37800
    ## 503                   Eritrea 2002    4414865    Africa 55.24000
    ## 504                   Eritrea 2007    4906585    Africa 58.04000
    ## 505                  Ethiopia 1952   20860941    Africa 34.07800
    ## 506                  Ethiopia 1957   22815614    Africa 36.66700
    ## 507                  Ethiopia 1962   25145372    Africa 40.05900
    ## 508                  Ethiopia 1967   27860297    Africa 42.11500
    ## 509                  Ethiopia 1972   30770372    Africa 43.51500
    ## 510                  Ethiopia 1977   34617799    Africa 44.51000
    ## 511                  Ethiopia 1982   38111756    Africa 44.91600
    ## 512                  Ethiopia 1987   42999530    Africa 46.68400
    ## 513                  Ethiopia 1992   52088559    Africa 48.09100
    ## 514                  Ethiopia 1997   59861301    Africa 49.40200
    ## 515                  Ethiopia 2002   67946797    Africa 50.72500
    ## 516                  Ethiopia 2007   76511887    Africa 52.94700
    ## 517                   Finland 1952    4090500    Europe 66.55000
    ## 518                   Finland 1957    4324000    Europe 67.49000
    ## 519                   Finland 1962    4491443    Europe 68.75000
    ## 520                   Finland 1967    4605744    Europe 69.83000
    ## 521                   Finland 1972    4639657    Europe 70.87000
    ## 522                   Finland 1977    4738902    Europe 72.52000
    ## 523                   Finland 1982    4826933    Europe 74.55000
    ## 524                   Finland 1987    4931729    Europe 74.83000
    ## 525                   Finland 1992    5041039    Europe 75.70000
    ## 526                   Finland 1997    5134406    Europe 77.13000
    ## 527                   Finland 2002    5193039    Europe 78.37000
    ## 528                   Finland 2007    5238460    Europe 79.31300
    ## 529                     Gabon 1952     420702    Africa 37.00300
    ## 530                     Gabon 1957     434904    Africa 38.99900
    ## 531                     Gabon 1962     455661    Africa 40.48900
    ## 532                     Gabon 1967     489004    Africa 44.59800
    ## 533                     Gabon 1972     537977    Africa 48.69000
    ## 534                     Gabon 1977     706367    Africa 52.79000
    ## 535                     Gabon 1982     753874    Africa 56.56400
    ## 536                     Gabon 1987     880397    Africa 60.19000
    ## 537                     Gabon 1992     985739    Africa 61.36600
    ## 538                     Gabon 1997    1126189    Africa 60.46100
    ## 539                     Gabon 2002    1299304    Africa 56.76100
    ## 540                     Gabon 2007    1454867    Africa 56.73500
    ## 541                    Gambia 1952     284320    Africa 30.00000
    ## 542                    Gambia 1957     323150    Africa 32.06500
    ## 543                    Gambia 1962     374020    Africa 33.89600
    ## 544                    Gambia 1967     439593    Africa 35.85700
    ## 545                    Gambia 1972     517101    Africa 38.30800
    ## 546                    Gambia 1977     608274    Africa 41.84200
    ## 547                    Gambia 1982     715523    Africa 45.58000
    ## 548                    Gambia 1987     848406    Africa 49.26500
    ## 549                    Gambia 1992    1025384    Africa 52.64400
    ## 550                    Gambia 1997    1235767    Africa 55.86100
    ## 551                    Gambia 2002    1457766    Africa 58.04100
    ## 552                    Gambia 2007    1688359    Africa 59.44800
    ## 553                   Germany 1952   69145952    Europe 67.50000
    ## 554                   Germany 1957   71019069    Europe 69.10000
    ## 555                   Germany 1962   73739117    Europe 70.30000
    ## 556                   Germany 1967   76368453    Europe 70.80000
    ## 557                   Germany 1972   78717088    Europe 71.00000
    ## 558                   Germany 1977   78160773    Europe 72.50000
    ## 559                   Germany 1982   78335266    Europe 73.80000
    ## 560                   Germany 1987   77718298    Europe 74.84700
    ## 561                   Germany 1992   80597764    Europe 76.07000
    ## 562                   Germany 1997   82011073    Europe 77.34000
    ## 563                   Germany 2002   82350671    Europe 78.67000
    ## 564                   Germany 2007   82400996    Europe 79.40600
    ## 565                     Ghana 1952    5581001    Africa 43.14900
    ## 566                     Ghana 1957    6391288    Africa 44.77900
    ## 567                     Ghana 1962    7355248    Africa 46.45200
    ## 568                     Ghana 1967    8490213    Africa 48.07200
    ## 569                     Ghana 1972    9354120    Africa 49.87500
    ## 570                     Ghana 1977   10538093    Africa 51.75600
    ## 571                     Ghana 1982   11400338    Africa 53.74400
    ## 572                     Ghana 1987   14168101    Africa 55.72900
    ## 573                     Ghana 1992   16278738    Africa 57.50100
    ## 574                     Ghana 1997   18418288    Africa 58.55600
    ## 575                     Ghana 2002   20550751    Africa 58.45300
    ## 576                     Ghana 2007   22873338    Africa 60.02200
    ## 577                    Greece 1952    7733250    Europe 65.86000
    ## 578                    Greece 1957    8096218    Europe 67.86000
    ## 579                    Greece 1962    8448233    Europe 69.51000
    ## 580                    Greece 1967    8716441    Europe 71.00000
    ## 581                    Greece 1972    8888628    Europe 72.34000
    ## 582                    Greece 1977    9308479    Europe 73.68000
    ## 583                    Greece 1982    9786480    Europe 75.24000
    ## 584                    Greece 1987    9974490    Europe 76.67000
    ## 585                    Greece 1992   10325429    Europe 77.03000
    ## 586                    Greece 1997   10502372    Europe 77.86900
    ## 587                    Greece 2002   10603863    Europe 78.25600
    ## 588                    Greece 2007   10706290    Europe 79.48300
    ## 589                 Guatemala 1952    3146381  Americas 42.02300
    ## 590                 Guatemala 1957    3640876  Americas 44.14200
    ## 591                 Guatemala 1962    4208858  Americas 46.95400
    ## 592                 Guatemala 1967    4690773  Americas 50.01600
    ## 593                 Guatemala 1972    5149581  Americas 53.73800
    ## 594                 Guatemala 1977    5703430  Americas 56.02900
    ## 595                 Guatemala 1982    6395630  Americas 58.13700
    ## 596                 Guatemala 1987    7326406  Americas 60.78200
    ## 597                 Guatemala 1992    8486949  Americas 63.37300
    ## 598                 Guatemala 1997    9803875  Americas 66.32200
    ## 599                 Guatemala 2002   11178650  Americas 68.97800
    ## 600                 Guatemala 2007   12572928  Americas 70.25900
    ## 601                    Guinea 1952    2664249    Africa 33.60900
    ## 602                    Guinea 1957    2876726    Africa 34.55800
    ## 603                    Guinea 1962    3140003    Africa 35.75300
    ## 604                    Guinea 1967    3451418    Africa 37.19700
    ## 605                    Guinea 1972    3811387    Africa 38.84200
    ## 606                    Guinea 1977    4227026    Africa 40.76200
    ## 607                    Guinea 1982    4710497    Africa 42.89100
    ## 608                    Guinea 1987    5650262    Africa 45.55200
    ## 609                    Guinea 1992    6990574    Africa 48.57600
    ## 610                    Guinea 1997    8048834    Africa 51.45500
    ## 611                    Guinea 2002    8807818    Africa 53.67600
    ## 612                    Guinea 2007    9947814    Africa 56.00700
    ## 613             Guinea-Bissau 1952     580653    Africa 32.50000
    ## 614             Guinea-Bissau 1957     601095    Africa 33.48900
    ## 615             Guinea-Bissau 1962     627820    Africa 34.48800
    ## 616             Guinea-Bissau 1967     601287    Africa 35.49200
    ## 617             Guinea-Bissau 1972     625361    Africa 36.48600
    ## 618             Guinea-Bissau 1977     745228    Africa 37.46500
    ## 619             Guinea-Bissau 1982     825987    Africa 39.32700
    ## 620             Guinea-Bissau 1987     927524    Africa 41.24500
    ## 621             Guinea-Bissau 1992    1050938    Africa 43.26600
    ## 622             Guinea-Bissau 1997    1193708    Africa 44.87300
    ## 623             Guinea-Bissau 2002    1332459    Africa 45.50400
    ## 624             Guinea-Bissau 2007    1472041    Africa 46.38800
    ## 625                     Haiti 1952    3201488  Americas 37.57900
    ## 626                     Haiti 1957    3507701  Americas 40.69600
    ## 627                     Haiti 1962    3880130  Americas 43.59000
    ## 628                     Haiti 1967    4318137  Americas 46.24300
    ## 629                     Haiti 1972    4698301  Americas 48.04200
    ## 630                     Haiti 1977    4908554  Americas 49.92300
    ## 631                     Haiti 1982    5198399  Americas 51.46100
    ## 632                     Haiti 1987    5756203  Americas 53.63600
    ## 633                     Haiti 1992    6326682  Americas 55.08900
    ## 634                     Haiti 1997    6913545  Americas 56.67100
    ## 635                     Haiti 2002    7607651  Americas 58.13700
    ## 636                     Haiti 2007    8502814  Americas 60.91600
    ## 637                  Honduras 1952    1517453  Americas 41.91200
    ## 638                  Honduras 1957    1770390  Americas 44.66500
    ## 639                  Honduras 1962    2090162  Americas 48.04100
    ## 640                  Honduras 1967    2500689  Americas 50.92400
    ## 641                  Honduras 1972    2965146  Americas 53.88400
    ## 642                  Honduras 1977    3055235  Americas 57.40200
    ## 643                  Honduras 1982    3669448  Americas 60.90900
    ## 644                  Honduras 1987    4372203  Americas 64.49200
    ## 645                  Honduras 1992    5077347  Americas 66.39900
    ## 646                  Honduras 1997    5867957  Americas 67.65900
    ## 647                  Honduras 2002    6677328  Americas 68.56500
    ## 648                  Honduras 2007    7483763  Americas 70.19800
    ## 649           Hong Kong China 1952    2125900      Asia 60.96000
    ## 650           Hong Kong China 1957    2736300      Asia 64.75000
    ## 651           Hong Kong China 1962    3305200      Asia 67.65000
    ## 652           Hong Kong China 1967    3722800      Asia 70.00000
    ## 653           Hong Kong China 1972    4115700      Asia 72.00000
    ## 654           Hong Kong China 1977    4583700      Asia 73.60000
    ## 655           Hong Kong China 1982    5264500      Asia 75.45000
    ## 656           Hong Kong China 1987    5584510      Asia 76.20000
    ## 657           Hong Kong China 1992    5829696      Asia 77.60100
    ## 658           Hong Kong China 1997    6495918      Asia 80.00000
    ## 659           Hong Kong China 2002    6762476      Asia 81.49500
    ## 660           Hong Kong China 2007    6980412      Asia 82.20800
    ## 661                   Hungary 1952    9504000    Europe 64.03000
    ## 662                   Hungary 1957    9839000    Europe 66.41000
    ## 663                   Hungary 1962   10063000    Europe 67.96000
    ## 664                   Hungary 1967   10223422    Europe 69.50000
    ## 665                   Hungary 1972   10394091    Europe 69.76000
    ## 666                   Hungary 1977   10637171    Europe 69.95000
    ## 667                   Hungary 1982   10705535    Europe 69.39000
    ## 668                   Hungary 1987   10612740    Europe 69.58000
    ## 669                   Hungary 1992   10348684    Europe 69.17000
    ## 670                   Hungary 1997   10244684    Europe 71.04000
    ## 671                   Hungary 2002   10083313    Europe 72.59000
    ## 672                   Hungary 2007    9956108    Europe 73.33800
    ## 673                   Iceland 1952     147962    Europe 72.49000
    ## 674                   Iceland 1957     165110    Europe 73.47000
    ## 675                   Iceland 1962     182053    Europe 73.68000
    ## 676                   Iceland 1967     198676    Europe 73.73000
    ## 677                   Iceland 1972     209275    Europe 74.46000
    ## 678                   Iceland 1977     221823    Europe 76.11000
    ## 679                   Iceland 1982     233997    Europe 76.99000
    ## 680                   Iceland 1987     244676    Europe 77.23000
    ## 681                   Iceland 1992     259012    Europe 78.77000
    ## 682                   Iceland 1997     271192    Europe 78.95000
    ## 683                   Iceland 2002     288030    Europe 80.50000
    ## 684                   Iceland 2007     301931    Europe 81.75700
    ## 685                     India 1952  372000000      Asia 37.37300
    ## 686                     India 1957  409000000      Asia 40.24900
    ## 687                     India 1962  454000000      Asia 43.60500
    ## 688                     India 1967  506000000      Asia 47.19300
    ## 689                     India 1972  567000000      Asia 50.65100
    ## 690                     India 1977  634000000      Asia 54.20800
    ## 691                     India 1982  708000000      Asia 56.59600
    ## 692                     India 1987  788000000      Asia 58.55300
    ## 693                     India 1992  872000000      Asia 60.22300
    ## 694                     India 1997  959000000      Asia 61.76500
    ## 695                     India 2002 1034172547      Asia 62.87900
    ## 696                     India 2007 1110396331      Asia 64.69800
    ## 697                 Indonesia 1952   82052000      Asia 37.46800
    ## 698                 Indonesia 1957   90124000      Asia 39.91800
    ## 699                 Indonesia 1962   99028000      Asia 42.51800
    ## 700                 Indonesia 1967  109343000      Asia 45.96400
    ## 701                 Indonesia 1972  121282000      Asia 49.20300
    ## 702                 Indonesia 1977  136725000      Asia 52.70200
    ## 703                 Indonesia 1982  153343000      Asia 56.15900
    ## 704                 Indonesia 1987  169276000      Asia 60.13700
    ## 705                 Indonesia 1992  184816000      Asia 62.68100
    ## 706                 Indonesia 1997  199278000      Asia 66.04100
    ## 707                 Indonesia 2002  211060000      Asia 68.58800
    ## 708                 Indonesia 2007  223547000      Asia 70.65000
    ## 709                      Iran 1952   17272000      Asia 44.86900
    ## 710                      Iran 1957   19792000      Asia 47.18100
    ## 711                      Iran 1962   22874000      Asia 49.32500
    ## 712                      Iran 1967   26538000      Asia 52.46900
    ## 713                      Iran 1972   30614000      Asia 55.23400
    ## 714                      Iran 1977   35480679      Asia 57.70200
    ## 715                      Iran 1982   43072751      Asia 59.62000
    ## 716                      Iran 1987   51889696      Asia 63.04000
    ## 717                      Iran 1992   60397973      Asia 65.74200
    ## 718                      Iran 1997   63327987      Asia 68.04200
    ## 719                      Iran 2002   66907826      Asia 69.45100
    ## 720                      Iran 2007   69453570      Asia 70.96400
    ## 721                      Iraq 1952    5441766      Asia 45.32000
    ## 722                      Iraq 1957    6248643      Asia 48.43700
    ## 723                      Iraq 1962    7240260      Asia 51.45700
    ## 724                      Iraq 1967    8519282      Asia 54.45900
    ## 725                      Iraq 1972   10061506      Asia 56.95000
    ## 726                      Iraq 1977   11882916      Asia 60.41300
    ## 727                      Iraq 1982   14173318      Asia 62.03800
    ## 728                      Iraq 1987   16543189      Asia 65.04400
    ## 729                      Iraq 1992   17861905      Asia 59.46100
    ## 730                      Iraq 1997   20775703      Asia 58.81100
    ## 731                      Iraq 2002   24001816      Asia 57.04600
    ## 732                      Iraq 2007   27499638      Asia 59.54500
    ## 733                   Ireland 1952    2952156    Europe 66.91000
    ## 734                   Ireland 1957    2878220    Europe 68.90000
    ## 735                   Ireland 1962    2830000    Europe 70.29000
    ## 736                   Ireland 1967    2900100    Europe 71.08000
    ## 737                   Ireland 1972    3024400    Europe 71.28000
    ## 738                   Ireland 1977    3271900    Europe 72.03000
    ## 739                   Ireland 1982    3480000    Europe 73.10000
    ## 740                   Ireland 1987    3539900    Europe 74.36000
    ## 741                   Ireland 1992    3557761    Europe 75.46700
    ## 742                   Ireland 1997    3667233    Europe 76.12200
    ## 743                   Ireland 2002    3879155    Europe 77.78300
    ## 744                   Ireland 2007    4109086    Europe 78.88500
    ## 745                    Israel 1952    1620914      Asia 65.39000
    ## 746                    Israel 1957    1944401      Asia 67.84000
    ## 747                    Israel 1962    2310904      Asia 69.39000
    ## 748                    Israel 1967    2693585      Asia 70.75000
    ## 749                    Israel 1972    3095893      Asia 71.63000
    ## 750                    Israel 1977    3495918      Asia 73.06000
    ## 751                    Israel 1982    3858421      Asia 74.45000
    ## 752                    Israel 1987    4203148      Asia 75.60000
    ## 753                    Israel 1992    4936550      Asia 76.93000
    ## 754                    Israel 1997    5531387      Asia 78.26900
    ## 755                    Israel 2002    6029529      Asia 79.69600
    ## 756                    Israel 2007    6426679      Asia 80.74500
    ## 757                     Italy 1952   47666000    Europe 65.94000
    ## 758                     Italy 1957   49182000    Europe 67.81000
    ## 759                     Italy 1962   50843200    Europe 69.24000
    ## 760                     Italy 1967   52667100    Europe 71.06000
    ## 761                     Italy 1972   54365564    Europe 72.19000
    ## 762                     Italy 1977   56059245    Europe 73.48000
    ## 763                     Italy 1982   56535636    Europe 74.98000
    ## 764                     Italy 1987   56729703    Europe 76.42000
    ## 765                     Italy 1992   56840847    Europe 77.44000
    ## 766                     Italy 1997   57479469    Europe 78.82000
    ## 767                     Italy 2002   57926999    Europe 80.24000
    ## 768                     Italy 2007   58147733    Europe 80.54600
    ## 769                   Jamaica 1952    1426095  Americas 58.53000
    ## 770                   Jamaica 1957    1535090  Americas 62.61000
    ## 771                   Jamaica 1962    1665128  Americas 65.61000
    ## 772                   Jamaica 1967    1861096  Americas 67.51000
    ## 773                   Jamaica 1972    1997616  Americas 69.00000
    ## 774                   Jamaica 1977    2156814  Americas 70.11000
    ## 775                   Jamaica 1982    2298309  Americas 71.21000
    ## 776                   Jamaica 1987    2326606  Americas 71.77000
    ## 777                   Jamaica 1992    2378618  Americas 71.76600
    ## 778                   Jamaica 1997    2531311  Americas 72.26200
    ## 779                   Jamaica 2002    2664659  Americas 72.04700
    ## 780                   Jamaica 2007    2780132  Americas 72.56700
    ## 781                     Japan 1952   86459025      Asia 63.03000
    ## 782                     Japan 1957   91563009      Asia 65.50000
    ## 783                     Japan 1962   95831757      Asia 68.73000
    ## 784                     Japan 1967  100825279      Asia 71.43000
    ## 785                     Japan 1972  107188273      Asia 73.42000
    ## 786                     Japan 1977  113872473      Asia 75.38000
    ## 787                     Japan 1982  118454974      Asia 77.11000
    ## 788                     Japan 1987  122091325      Asia 78.67000
    ## 789                     Japan 1992  124329269      Asia 79.36000
    ## 790                     Japan 1997  125956499      Asia 80.69000
    ## 791                     Japan 2002  127065841      Asia 82.00000
    ## 792                     Japan 2007  127467972      Asia 82.60300
    ## 793                    Jordan 1952     607914      Asia 43.15800
    ## 794                    Jordan 1957     746559      Asia 45.66900
    ## 795                    Jordan 1962     933559      Asia 48.12600
    ## 796                    Jordan 1967    1255058      Asia 51.62900
    ## 797                    Jordan 1972    1613551      Asia 56.52800
    ## 798                    Jordan 1977    1937652      Asia 61.13400
    ## 799                    Jordan 1982    2347031      Asia 63.73900
    ## 800                    Jordan 1987    2820042      Asia 65.86900
    ## 801                    Jordan 1992    3867409      Asia 68.01500
    ## 802                    Jordan 1997    4526235      Asia 69.77200
    ## 803                    Jordan 2002    5307470      Asia 71.26300
    ## 804                    Jordan 2007    6053193      Asia 72.53500
    ## 805                     Kenya 1952    6464046    Africa 42.27000
    ## 806                     Kenya 1957    7454779    Africa 44.68600
    ## 807                     Kenya 1962    8678557    Africa 47.94900
    ## 808                     Kenya 1967   10191512    Africa 50.65400
    ## 809                     Kenya 1972   12044785    Africa 53.55900
    ## 810                     Kenya 1977   14500404    Africa 56.15500
    ## 811                     Kenya 1982   17661452    Africa 58.76600
    ## 812                     Kenya 1987   21198082    Africa 59.33900
    ## 813                     Kenya 1992   25020539    Africa 59.28500
    ## 814                     Kenya 1997   28263827    Africa 54.40700
    ## 815                     Kenya 2002   31386842    Africa 50.99200
    ## 816                     Kenya 2007   35610177    Africa 54.11000
    ## 817           Korea Dem. Rep. 1952    8865488      Asia 50.05600
    ## 818           Korea Dem. Rep. 1957    9411381      Asia 54.08100
    ## 819           Korea Dem. Rep. 1962   10917494      Asia 56.65600
    ## 820           Korea Dem. Rep. 1967   12617009      Asia 59.94200
    ## 821           Korea Dem. Rep. 1972   14781241      Asia 63.98300
    ## 822           Korea Dem. Rep. 1977   16325320      Asia 67.15900
    ## 823           Korea Dem. Rep. 1982   17647518      Asia 69.10000
    ## 824           Korea Dem. Rep. 1987   19067554      Asia 70.64700
    ## 825           Korea Dem. Rep. 1992   20711375      Asia 69.97800
    ## 826           Korea Dem. Rep. 1997   21585105      Asia 67.72700
    ## 827           Korea Dem. Rep. 2002   22215365      Asia 66.66200
    ## 828           Korea Dem. Rep. 2007   23301725      Asia 67.29700
    ## 829                Korea Rep. 1952   20947571      Asia 47.45300
    ## 830                Korea Rep. 1957   22611552      Asia 52.68100
    ## 831                Korea Rep. 1962   26420307      Asia 55.29200
    ## 832                Korea Rep. 1967   30131000      Asia 57.71600
    ## 833                Korea Rep. 1972   33505000      Asia 62.61200
    ## 834                Korea Rep. 1977   36436000      Asia 64.76600
    ## 835                Korea Rep. 1982   39326000      Asia 67.12300
    ## 836                Korea Rep. 1987   41622000      Asia 69.81000
    ## 837                Korea Rep. 1992   43805450      Asia 72.24400
    ## 838                Korea Rep. 1997   46173816      Asia 74.64700
    ## 839                Korea Rep. 2002   47969150      Asia 77.04500
    ## 840                Korea Rep. 2007   49044790      Asia 78.62300
    ## 841                    Kuwait 1952     160000      Asia 55.56500
    ## 842                    Kuwait 1957     212846      Asia 58.03300
    ## 843                    Kuwait 1962     358266      Asia 60.47000
    ## 844                    Kuwait 1967     575003      Asia 64.62400
    ## 845                    Kuwait 1972     841934      Asia 67.71200
    ## 846                    Kuwait 1977    1140357      Asia 69.34300
    ## 847                    Kuwait 1982    1497494      Asia 71.30900
    ## 848                    Kuwait 1987    1891487      Asia 74.17400
    ## 849                    Kuwait 1992    1418095      Asia 75.19000
    ## 850                    Kuwait 1997    1765345      Asia 76.15600
    ## 851                    Kuwait 2002    2111561      Asia 76.90400
    ## 852                    Kuwait 2007    2505559      Asia 77.58800
    ## 853                   Lebanon 1952    1439529      Asia 55.92800
    ## 854                   Lebanon 1957    1647412      Asia 59.48900
    ## 855                   Lebanon 1962    1886848      Asia 62.09400
    ## 856                   Lebanon 1967    2186894      Asia 63.87000
    ## 857                   Lebanon 1972    2680018      Asia 65.42100
    ## 858                   Lebanon 1977    3115787      Asia 66.09900
    ## 859                   Lebanon 1982    3086876      Asia 66.98300
    ## 860                   Lebanon 1987    3089353      Asia 67.92600
    ## 861                   Lebanon 1992    3219994      Asia 69.29200
    ## 862                   Lebanon 1997    3430388      Asia 70.26500
    ## 863                   Lebanon 2002    3677780      Asia 71.02800
    ## 864                   Lebanon 2007    3921278      Asia 71.99300
    ## 865                   Lesotho 1952     748747    Africa 42.13800
    ## 866                   Lesotho 1957     813338    Africa 45.04700
    ## 867                   Lesotho 1962     893143    Africa 47.74700
    ## 868                   Lesotho 1967     996380    Africa 48.49200
    ## 869                   Lesotho 1972    1116779    Africa 49.76700
    ## 870                   Lesotho 1977    1251524    Africa 52.20800
    ## 871                   Lesotho 1982    1411807    Africa 55.07800
    ## 872                   Lesotho 1987    1599200    Africa 57.18000
    ## 873                   Lesotho 1992    1803195    Africa 59.68500
    ## 874                   Lesotho 1997    1982823    Africa 55.55800
    ## 875                   Lesotho 2002    2046772    Africa 44.59300
    ## 876                   Lesotho 2007    2012649    Africa 42.59200
    ## 877                   Liberia 1952     863308    Africa 38.48000
    ## 878                   Liberia 1957     975950    Africa 39.48600
    ## 879                   Liberia 1962    1112796    Africa 40.50200
    ## 880                   Liberia 1967    1279406    Africa 41.53600
    ## 881                   Liberia 1972    1482628    Africa 42.61400
    ## 882                   Liberia 1977    1703617    Africa 43.76400
    ## 883                   Liberia 1982    1956875    Africa 44.85200
    ## 884                   Liberia 1987    2269414    Africa 46.02700
    ## 885                   Liberia 1992    1912974    Africa 40.80200
    ## 886                   Liberia 1997    2200725    Africa 42.22100
    ## 887                   Liberia 2002    2814651    Africa 43.75300
    ## 888                   Liberia 2007    3193942    Africa 45.67800
    ## 889                     Libya 1952    1019729    Africa 42.72300
    ## 890                     Libya 1957    1201578    Africa 45.28900
    ## 891                     Libya 1962    1441863    Africa 47.80800
    ## 892                     Libya 1967    1759224    Africa 50.22700
    ## 893                     Libya 1972    2183877    Africa 52.77300
    ## 894                     Libya 1977    2721783    Africa 57.44200
    ## 895                     Libya 1982    3344074    Africa 62.15500
    ## 896                     Libya 1987    3799845    Africa 66.23400
    ## 897                     Libya 1992    4364501    Africa 68.75500
    ## 898                     Libya 1997    4759670    Africa 71.55500
    ## 899                     Libya 2002    5368585    Africa 72.73700
    ## 900                     Libya 2007    6036914    Africa 73.95200
    ## 901                Madagascar 1952    4762912    Africa 36.68100
    ## 902                Madagascar 1957    5181679    Africa 38.86500
    ## 903                Madagascar 1962    5703324    Africa 40.84800
    ## 904                Madagascar 1967    6334556    Africa 42.88100
    ## 905                Madagascar 1972    7082430    Africa 44.85100
    ## 906                Madagascar 1977    8007166    Africa 46.88100
    ## 907                Madagascar 1982    9171477    Africa 48.96900
    ## 908                Madagascar 1987   10568642    Africa 49.35000
    ## 909                Madagascar 1992   12210395    Africa 52.21400
    ## 910                Madagascar 1997   14165114    Africa 54.97800
    ## 911                Madagascar 2002   16473477    Africa 57.28600
    ## 912                Madagascar 2007   19167654    Africa 59.44300
    ## 913                    Malawi 1952    2917802    Africa 36.25600
    ## 914                    Malawi 1957    3221238    Africa 37.20700
    ## 915                    Malawi 1962    3628608    Africa 38.41000
    ## 916                    Malawi 1967    4147252    Africa 39.48700
    ## 917                    Malawi 1972    4730997    Africa 41.76600
    ## 918                    Malawi 1977    5637246    Africa 43.76700
    ## 919                    Malawi 1982    6502825    Africa 45.64200
    ## 920                    Malawi 1987    7824747    Africa 47.45700
    ## 921                    Malawi 1992   10014249    Africa 49.42000
    ## 922                    Malawi 1997   10419991    Africa 47.49500
    ## 923                    Malawi 2002   11824495    Africa 45.00900
    ## 924                    Malawi 2007   13327079    Africa 48.30300
    ## 925                  Malaysia 1952    6748378      Asia 48.46300
    ## 926                  Malaysia 1957    7739235      Asia 52.10200
    ## 927                  Malaysia 1962    8906385      Asia 55.73700
    ## 928                  Malaysia 1967   10154878      Asia 59.37100
    ## 929                  Malaysia 1972   11441462      Asia 63.01000
    ## 930                  Malaysia 1977   12845381      Asia 65.25600
    ## 931                  Malaysia 1982   14441916      Asia 68.00000
    ## 932                  Malaysia 1987   16331785      Asia 69.50000
    ## 933                  Malaysia 1992   18319502      Asia 70.69300
    ## 934                  Malaysia 1997   20476091      Asia 71.93800
    ## 935                  Malaysia 2002   22662365      Asia 73.04400
    ## 936                  Malaysia 2007   24821286      Asia 74.24100
    ## 937                      Mali 1952    3838168    Africa 33.68500
    ## 938                      Mali 1957    4241884    Africa 35.30700
    ## 939                      Mali 1962    4690372    Africa 36.93600
    ## 940                      Mali 1967    5212416    Africa 38.48700
    ## 941                      Mali 1972    5828158    Africa 39.97700
    ## 942                      Mali 1977    6491649    Africa 41.71400
    ## 943                      Mali 1982    6998256    Africa 43.91600
    ## 944                      Mali 1987    7634008    Africa 46.36400
    ## 945                      Mali 1992    8416215    Africa 48.38800
    ## 946                      Mali 1997    9384984    Africa 49.90300
    ## 947                      Mali 2002   10580176    Africa 51.81800
    ## 948                      Mali 2007   12031795    Africa 54.46700
    ## 949                Mauritania 1952    1022556    Africa 40.54300
    ## 950                Mauritania 1957    1076852    Africa 42.33800
    ## 951                Mauritania 1962    1146757    Africa 44.24800
    ## 952                Mauritania 1967    1230542    Africa 46.28900
    ## 953                Mauritania 1972    1332786    Africa 48.43700
    ## 954                Mauritania 1977    1456688    Africa 50.85200
    ## 955                Mauritania 1982    1622136    Africa 53.59900
    ## 956                Mauritania 1987    1841240    Africa 56.14500
    ## 957                Mauritania 1992    2119465    Africa 58.33300
    ## 958                Mauritania 1997    2444741    Africa 60.43000
    ## 959                Mauritania 2002    2828858    Africa 62.24700
    ## 960                Mauritania 2007    3270065    Africa 64.16400
    ## 961                 Mauritius 1952     516556    Africa 50.98600
    ## 962                 Mauritius 1957     609816    Africa 58.08900
    ## 963                 Mauritius 1962     701016    Africa 60.24600
    ## 964                 Mauritius 1967     789309    Africa 61.55700
    ## 965                 Mauritius 1972     851334    Africa 62.94400
    ## 966                 Mauritius 1977     913025    Africa 64.93000
    ## 967                 Mauritius 1982     992040    Africa 66.71100
    ## 968                 Mauritius 1987    1042663    Africa 68.74000
    ## 969                 Mauritius 1992    1096202    Africa 69.74500
    ## 970                 Mauritius 1997    1149818    Africa 70.73600
    ## 971                 Mauritius 2002    1200206    Africa 71.95400
    ## 972                 Mauritius 2007    1250882    Africa 72.80100
    ## 973                    Mexico 1952   30144317  Americas 50.78900
    ## 974                    Mexico 1957   35015548  Americas 55.19000
    ## 975                    Mexico 1962   41121485  Americas 58.29900
    ## 976                    Mexico 1967   47995559  Americas 60.11000
    ## 977                    Mexico 1972   55984294  Americas 62.36100
    ## 978                    Mexico 1977   63759976  Americas 65.03200
    ## 979                    Mexico 1982   71640904  Americas 67.40500
    ## 980                    Mexico 1987   80122492  Americas 69.49800
    ## 981                    Mexico 1992   88111030  Americas 71.45500
    ## 982                    Mexico 1997   95895146  Americas 73.67000
    ## 983                    Mexico 2002  102479927  Americas 74.90200
    ## 984                    Mexico 2007  108700891  Americas 76.19500
    ## 985                  Mongolia 1952     800663      Asia 42.24400
    ## 986                  Mongolia 1957     882134      Asia 45.24800
    ## 987                  Mongolia 1962    1010280      Asia 48.25100
    ## 988                  Mongolia 1967    1149500      Asia 51.25300
    ## 989                  Mongolia 1972    1320500      Asia 53.75400
    ## 990                  Mongolia 1977    1528000      Asia 55.49100
    ## 991                  Mongolia 1982    1756032      Asia 57.48900
    ## 992                  Mongolia 1987    2015133      Asia 60.22200
    ## 993                  Mongolia 1992    2312802      Asia 61.27100
    ## 994                  Mongolia 1997    2494803      Asia 63.62500
    ## 995                  Mongolia 2002    2674234      Asia 65.03300
    ## 996                  Mongolia 2007    2874127      Asia 66.80300
    ## 997                Montenegro 1952     413834    Europe 59.16400
    ## 998                Montenegro 1957     442829    Europe 61.44800
    ## 999                Montenegro 1962     474528    Europe 63.72800
    ## 1000               Montenegro 1967     501035    Europe 67.17800
    ## 1001               Montenegro 1972     527678    Europe 70.63600
    ## 1002               Montenegro 1977     560073    Europe 73.06600
    ## 1003               Montenegro 1982     562548    Europe 74.10100
    ## 1004               Montenegro 1987     569473    Europe 74.86500
    ## 1005               Montenegro 1992     621621    Europe 75.43500
    ## 1006               Montenegro 1997     692651    Europe 75.44500
    ## 1007               Montenegro 2002     720230    Europe 73.98100
    ## 1008               Montenegro 2007     684736    Europe 74.54300
    ## 1009                  Morocco 1952    9939217    Africa 42.87300
    ## 1010                  Morocco 1957   11406350    Africa 45.42300
    ## 1011                  Morocco 1962   13056604    Africa 47.92400
    ## 1012                  Morocco 1967   14770296    Africa 50.33500
    ## 1013                  Morocco 1972   16660670    Africa 52.86200
    ## 1014                  Morocco 1977   18396941    Africa 55.73000
    ## 1015                  Morocco 1982   20198730    Africa 59.65000
    ## 1016                  Morocco 1987   22987397    Africa 62.67700
    ## 1017                  Morocco 1992   25798239    Africa 65.39300
    ## 1018                  Morocco 1997   28529501    Africa 67.66000
    ## 1019                  Morocco 2002   31167783    Africa 69.61500
    ## 1020                  Morocco 2007   33757175    Africa 71.16400
    ## 1021               Mozambique 1952    6446316    Africa 31.28600
    ## 1022               Mozambique 1957    7038035    Africa 33.77900
    ## 1023               Mozambique 1962    7788944    Africa 36.16100
    ## 1024               Mozambique 1967    8680909    Africa 38.11300
    ## 1025               Mozambique 1972    9809596    Africa 40.32800
    ## 1026               Mozambique 1977   11127868    Africa 42.49500
    ## 1027               Mozambique 1982   12587223    Africa 42.79500
    ## 1028               Mozambique 1987   12891952    Africa 42.86100
    ## 1029               Mozambique 1992   13160731    Africa 44.28400
    ## 1030               Mozambique 1997   16603334    Africa 46.34400
    ## 1031               Mozambique 2002   18473780    Africa 44.02600
    ## 1032               Mozambique 2007   19951656    Africa 42.08200
    ## 1033                  Myanmar 1952   20092996      Asia 36.31900
    ## 1034                  Myanmar 1957   21731844      Asia 41.90500
    ## 1035                  Myanmar 1962   23634436      Asia 45.10800
    ## 1036                  Myanmar 1967   25870271      Asia 49.37900
    ## 1037                  Myanmar 1972   28466390      Asia 53.07000
    ## 1038                  Myanmar 1977   31528087      Asia 56.05900
    ## 1039                  Myanmar 1982   34680442      Asia 58.05600
    ## 1040                  Myanmar 1987   38028578      Asia 58.33900
    ## 1041                  Myanmar 1992   40546538      Asia 59.32000
    ## 1042                  Myanmar 1997   43247867      Asia 60.32800
    ## 1043                  Myanmar 2002   45598081      Asia 59.90800
    ## 1044                  Myanmar 2007   47761980      Asia 62.06900
    ## 1045                  Namibia 1952     485831    Africa 41.72500
    ## 1046                  Namibia 1957     548080    Africa 45.22600
    ## 1047                  Namibia 1962     621392    Africa 48.38600
    ## 1048                  Namibia 1967     706640    Africa 51.15900
    ## 1049                  Namibia 1972     821782    Africa 53.86700
    ## 1050                  Namibia 1977     977026    Africa 56.43700
    ## 1051                  Namibia 1982    1099010    Africa 58.96800
    ## 1052                  Namibia 1987    1278184    Africa 60.83500
    ## 1053                  Namibia 1992    1554253    Africa 61.99900
    ## 1054                  Namibia 1997    1774766    Africa 58.90900
    ## 1055                  Namibia 2002    1972153    Africa 51.47900
    ## 1056                  Namibia 2007    2055080    Africa 52.90600
    ## 1057                    Nepal 1952    9182536      Asia 36.15700
    ## 1058                    Nepal 1957    9682338      Asia 37.68600
    ## 1059                    Nepal 1962   10332057      Asia 39.39300
    ## 1060                    Nepal 1967   11261690      Asia 41.47200
    ## 1061                    Nepal 1972   12412593      Asia 43.97100
    ## 1062                    Nepal 1977   13933198      Asia 46.74800
    ## 1063                    Nepal 1982   15796314      Asia 49.59400
    ## 1064                    Nepal 1987   17917180      Asia 52.53700
    ## 1065                    Nepal 1992   20326209      Asia 55.72700
    ## 1066                    Nepal 1997   23001113      Asia 59.42600
    ## 1067                    Nepal 2002   25873917      Asia 61.34000
    ## 1068                    Nepal 2007   28901790      Asia 63.78500
    ## 1069              Netherlands 1952   10381988    Europe 72.13000
    ## 1070              Netherlands 1957   11026383    Europe 72.99000
    ## 1071              Netherlands 1962   11805689    Europe 73.23000
    ## 1072              Netherlands 1967   12596822    Europe 73.82000
    ## 1073              Netherlands 1972   13329874    Europe 73.75000
    ## 1074              Netherlands 1977   13852989    Europe 75.24000
    ## 1075              Netherlands 1982   14310401    Europe 76.05000
    ## 1076              Netherlands 1987   14665278    Europe 76.83000
    ## 1077              Netherlands 1992   15174244    Europe 77.42000
    ## 1078              Netherlands 1997   15604464    Europe 78.03000
    ## 1079              Netherlands 2002   16122830    Europe 78.53000
    ## 1080              Netherlands 2007   16570613    Europe 79.76200
    ## 1081              New Zealand 1952    1994794   Oceania 69.39000
    ## 1082              New Zealand 1957    2229407   Oceania 70.26000
    ## 1083              New Zealand 1962    2488550   Oceania 71.24000
    ## 1084              New Zealand 1967    2728150   Oceania 71.52000
    ## 1085              New Zealand 1972    2929100   Oceania 71.89000
    ## 1086              New Zealand 1977    3164900   Oceania 72.22000
    ## 1087              New Zealand 1982    3210650   Oceania 73.84000
    ## 1088              New Zealand 1987    3317166   Oceania 74.32000
    ## 1089              New Zealand 1992    3437674   Oceania 76.33000
    ## 1090              New Zealand 1997    3676187   Oceania 77.55000
    ## 1091              New Zealand 2002    3908037   Oceania 79.11000
    ## 1092              New Zealand 2007    4115771   Oceania 80.20400
    ## 1093                Nicaragua 1952    1165790  Americas 42.31400
    ## 1094                Nicaragua 1957    1358828  Americas 45.43200
    ## 1095                Nicaragua 1962    1590597  Americas 48.63200
    ## 1096                Nicaragua 1967    1865490  Americas 51.88400
    ## 1097                Nicaragua 1972    2182908  Americas 55.15100
    ## 1098                Nicaragua 1977    2554598  Americas 57.47000
    ## 1099                Nicaragua 1982    2979423  Americas 59.29800
    ## 1100                Nicaragua 1987    3344353  Americas 62.00800
    ## 1101                Nicaragua 1992    4017939  Americas 65.84300
    ## 1102                Nicaragua 1997    4609572  Americas 68.42600
    ## 1103                Nicaragua 2002    5146848  Americas 70.83600
    ## 1104                Nicaragua 2007    5675356  Americas 72.89900
    ## 1105                    Niger 1952    3379468    Africa 37.44400
    ## 1106                    Niger 1957    3692184    Africa 38.59800
    ## 1107                    Niger 1962    4076008    Africa 39.48700
    ## 1108                    Niger 1967    4534062    Africa 40.11800
    ## 1109                    Niger 1972    5060262    Africa 40.54600
    ## 1110                    Niger 1977    5682086    Africa 41.29100
    ## 1111                    Niger 1982    6437188    Africa 42.59800
    ## 1112                    Niger 1987    7332638    Africa 44.55500
    ## 1113                    Niger 1992    8392818    Africa 47.39100
    ## 1114                    Niger 1997    9666252    Africa 51.31300
    ## 1115                    Niger 2002   11140655    Africa 54.49600
    ## 1116                    Niger 2007   12894865    Africa 56.86700
    ## 1117                  Nigeria 1952   33119096    Africa 36.32400
    ## 1118                  Nigeria 1957   37173340    Africa 37.80200
    ## 1119                  Nigeria 1962   41871351    Africa 39.36000
    ## 1120                  Nigeria 1967   47287752    Africa 41.04000
    ## 1121                  Nigeria 1972   53740085    Africa 42.82100
    ## 1122                  Nigeria 1977   62209173    Africa 44.51400
    ## 1123                  Nigeria 1982   73039376    Africa 45.82600
    ## 1124                  Nigeria 1987   81551520    Africa 46.88600
    ## 1125                  Nigeria 1992   93364244    Africa 47.47200
    ## 1126                  Nigeria 1997  106207839    Africa 47.46400
    ## 1127                  Nigeria 2002  119901274    Africa 46.60800
    ## 1128                  Nigeria 2007  135031164    Africa 46.85900
    ## 1129                   Norway 1952    3327728    Europe 72.67000
    ## 1130                   Norway 1957    3491938    Europe 73.44000
    ## 1131                   Norway 1962    3638919    Europe 73.47000
    ## 1132                   Norway 1967    3786019    Europe 74.08000
    ## 1133                   Norway 1972    3933004    Europe 74.34000
    ## 1134                   Norway 1977    4043205    Europe 75.37000
    ## 1135                   Norway 1982    4114787    Europe 75.97000
    ## 1136                   Norway 1987    4186147    Europe 75.89000
    ## 1137                   Norway 1992    4286357    Europe 77.32000
    ## 1138                   Norway 1997    4405672    Europe 78.32000
    ## 1139                   Norway 2002    4535591    Europe 79.05000
    ## 1140                   Norway 2007    4627926    Europe 80.19600
    ## 1141                     Oman 1952     507833      Asia 37.57800
    ## 1142                     Oman 1957     561977      Asia 40.08000
    ## 1143                     Oman 1962     628164      Asia 43.16500
    ## 1144                     Oman 1967     714775      Asia 46.98800
    ## 1145                     Oman 1972     829050      Asia 52.14300
    ## 1146                     Oman 1977    1004533      Asia 57.36700
    ## 1147                     Oman 1982    1301048      Asia 62.72800
    ## 1148                     Oman 1987    1593882      Asia 67.73400
    ## 1149                     Oman 1992    1915208      Asia 71.19700
    ## 1150                     Oman 1997    2283635      Asia 72.49900
    ## 1151                     Oman 2002    2713462      Asia 74.19300
    ## 1152                     Oman 2007    3204897      Asia 75.64000
    ## 1153                 Pakistan 1952   41346560      Asia 43.43600
    ## 1154                 Pakistan 1957   46679944      Asia 45.55700
    ## 1155                 Pakistan 1962   53100671      Asia 47.67000
    ## 1156                 Pakistan 1967   60641899      Asia 49.80000
    ## 1157                 Pakistan 1972   69325921      Asia 51.92900
    ## 1158                 Pakistan 1977   78152686      Asia 54.04300
    ## 1159                 Pakistan 1982   91462088      Asia 56.15800
    ## 1160                 Pakistan 1987  105186881      Asia 58.24500
    ## 1161                 Pakistan 1992  120065004      Asia 60.83800
    ## 1162                 Pakistan 1997  135564834      Asia 61.81800
    ## 1163                 Pakistan 2002  153403524      Asia 63.61000
    ## 1164                 Pakistan 2007  169270617      Asia 65.48300
    ## 1165                   Panama 1952     940080  Americas 55.19100
    ## 1166                   Panama 1957    1063506  Americas 59.20100
    ## 1167                   Panama 1962    1215725  Americas 61.81700
    ## 1168                   Panama 1967    1405486  Americas 64.07100
    ## 1169                   Panama 1972    1616384  Americas 66.21600
    ## 1170                   Panama 1977    1839782  Americas 68.68100
    ## 1171                   Panama 1982    2036305  Americas 70.47200
    ## 1172                   Panama 1987    2253639  Americas 71.52300
    ## 1173                   Panama 1992    2484997  Americas 72.46200
    ## 1174                   Panama 1997    2734531  Americas 73.73800
    ## 1175                   Panama 2002    2990875  Americas 74.71200
    ## 1176                   Panama 2007    3242173  Americas 75.53700
    ## 1177                 Paraguay 1952    1555876  Americas 62.64900
    ## 1178                 Paraguay 1957    1770902  Americas 63.19600
    ## 1179                 Paraguay 1962    2009813  Americas 64.36100
    ## 1180                 Paraguay 1967    2287985  Americas 64.95100
    ## 1181                 Paraguay 1972    2614104  Americas 65.81500
    ## 1182                 Paraguay 1977    2984494  Americas 66.35300
    ## 1183                 Paraguay 1982    3366439  Americas 66.87400
    ## 1184                 Paraguay 1987    3886512  Americas 67.37800
    ## 1185                 Paraguay 1992    4483945  Americas 68.22500
    ## 1186                 Paraguay 1997    5154123  Americas 69.40000
    ## 1187                 Paraguay 2002    5884491  Americas 70.75500
    ## 1188                 Paraguay 2007    6667147  Americas 71.75200
    ## 1189                     Peru 1952    8025700  Americas 43.90200
    ## 1190                     Peru 1957    9146100  Americas 46.26300
    ## 1191                     Peru 1962   10516500  Americas 49.09600
    ## 1192                     Peru 1967   12132200  Americas 51.44500
    ## 1193                     Peru 1972   13954700  Americas 55.44800
    ## 1194                     Peru 1977   15990099  Americas 58.44700
    ## 1195                     Peru 1982   18125129  Americas 61.40600
    ## 1196                     Peru 1987   20195924  Americas 64.13400
    ## 1197                     Peru 1992   22430449  Americas 66.45800
    ## 1198                     Peru 1997   24748122  Americas 68.38600
    ## 1199                     Peru 2002   26769436  Americas 69.90600
    ## 1200                     Peru 2007   28674757  Americas 71.42100
    ## 1201              Philippines 1952   22438691      Asia 47.75200
    ## 1202              Philippines 1957   26072194      Asia 51.33400
    ## 1203              Philippines 1962   30325264      Asia 54.75700
    ## 1204              Philippines 1967   35356600      Asia 56.39300
    ## 1205              Philippines 1972   40850141      Asia 58.06500
    ## 1206              Philippines 1977   46850962      Asia 60.06000
    ## 1207              Philippines 1982   53456774      Asia 62.08200
    ## 1208              Philippines 1987   60017788      Asia 64.15100
    ## 1209              Philippines 1992   67185766      Asia 66.45800
    ## 1210              Philippines 1997   75012988      Asia 68.56400
    ## 1211              Philippines 2002   82995088      Asia 70.30300
    ## 1212              Philippines 2007   91077287      Asia 71.68800
    ## 1213                   Poland 1952   25730551    Europe 61.31000
    ## 1214                   Poland 1957   28235346    Europe 65.77000
    ## 1215                   Poland 1962   30329617    Europe 67.64000
    ## 1216                   Poland 1967   31785378    Europe 69.61000
    ## 1217                   Poland 1972   33039545    Europe 70.85000
    ## 1218                   Poland 1977   34621254    Europe 70.67000
    ## 1219                   Poland 1982   36227381    Europe 71.32000
    ## 1220                   Poland 1987   37740710    Europe 70.98000
    ## 1221                   Poland 1992   38370697    Europe 70.99000
    ## 1222                   Poland 1997   38654957    Europe 72.75000
    ## 1223                   Poland 2002   38625976    Europe 74.67000
    ## 1224                   Poland 2007   38518241    Europe 75.56300
    ## 1225                 Portugal 1952    8526050    Europe 59.82000
    ## 1226                 Portugal 1957    8817650    Europe 61.51000
    ## 1227                 Portugal 1962    9019800    Europe 64.39000
    ## 1228                 Portugal 1967    9103000    Europe 66.60000
    ## 1229                 Portugal 1972    8970450    Europe 69.26000
    ## 1230                 Portugal 1977    9662600    Europe 70.41000
    ## 1231                 Portugal 1982    9859650    Europe 72.77000
    ## 1232                 Portugal 1987    9915289    Europe 74.06000
    ## 1233                 Portugal 1992    9927680    Europe 74.86000
    ## 1234                 Portugal 1997   10156415    Europe 75.97000
    ## 1235                 Portugal 2002   10433867    Europe 77.29000
    ## 1236                 Portugal 2007   10642836    Europe 78.09800
    ## 1237              Puerto Rico 1952    2227000  Americas 64.28000
    ## 1238              Puerto Rico 1957    2260000  Americas 68.54000
    ## 1239              Puerto Rico 1962    2448046  Americas 69.62000
    ## 1240              Puerto Rico 1967    2648961  Americas 71.10000
    ## 1241              Puerto Rico 1972    2847132  Americas 72.16000
    ## 1242              Puerto Rico 1977    3080828  Americas 73.44000
    ## 1243              Puerto Rico 1982    3279001  Americas 73.75000
    ## 1244              Puerto Rico 1987    3444468  Americas 74.63000
    ## 1245              Puerto Rico 1992    3585176  Americas 73.91100
    ## 1246              Puerto Rico 1997    3759430  Americas 74.91700
    ## 1247              Puerto Rico 2002    3859606  Americas 77.77800
    ## 1248              Puerto Rico 2007    3942491  Americas 78.74600
    ## 1249                  Reunion 1952     257700    Africa 52.72400
    ## 1250                  Reunion 1957     308700    Africa 55.09000
    ## 1251                  Reunion 1962     358900    Africa 57.66600
    ## 1252                  Reunion 1967     414024    Africa 60.54200
    ## 1253                  Reunion 1972     461633    Africa 64.27400
    ## 1254                  Reunion 1977     492095    Africa 67.06400
    ## 1255                  Reunion 1982     517810    Africa 69.88500
    ## 1256                  Reunion 1987     562035    Africa 71.91300
    ## 1257                  Reunion 1992     622191    Africa 73.61500
    ## 1258                  Reunion 1997     684810    Africa 74.77200
    ## 1259                  Reunion 2002     743981    Africa 75.74400
    ## 1260                  Reunion 2007     798094    Africa 76.44200
    ## 1261                  Romania 1952   16630000    Europe 61.05000
    ## 1262                  Romania 1957   17829327    Europe 64.10000
    ## 1263                  Romania 1962   18680721    Europe 66.80000
    ## 1264                  Romania 1967   19284814    Europe 66.80000
    ## 1265                  Romania 1972   20662648    Europe 69.21000
    ## 1266                  Romania 1977   21658597    Europe 69.46000
    ## 1267                  Romania 1982   22356726    Europe 69.66000
    ## 1268                  Romania 1987   22686371    Europe 69.53000
    ## 1269                  Romania 1992   22797027    Europe 69.36000
    ## 1270                  Romania 1997   22562458    Europe 69.72000
    ## 1271                  Romania 2002   22404337    Europe 71.32200
    ## 1272                  Romania 2007   22276056    Europe 72.47600
    ## 1273                   Rwanda 1952    2534927    Africa 40.00000
    ## 1274                   Rwanda 1957    2822082    Africa 41.50000
    ## 1275                   Rwanda 1962    3051242    Africa 43.00000
    ## 1276                   Rwanda 1967    3451079    Africa 44.10000
    ## 1277                   Rwanda 1972    3992121    Africa 44.60000
    ## 1278                   Rwanda 1977    4657072    Africa 45.00000
    ## 1279                   Rwanda 1982    5507565    Africa 46.21800
    ## 1280                   Rwanda 1987    6349365    Africa 44.02000
    ## 1281                   Rwanda 1992    7290203    Africa 23.59900
    ## 1282                   Rwanda 1997    7212583    Africa 36.08700
    ## 1283                   Rwanda 2002    7852401    Africa 43.41300
    ## 1284                   Rwanda 2007    8860588    Africa 46.24200
    ## 1285    Sao Tome and Principe 1952      60011    Africa 46.47100
    ## 1286    Sao Tome and Principe 1957      61325    Africa 48.94500
    ## 1287    Sao Tome and Principe 1962      65345    Africa 51.89300
    ## 1288    Sao Tome and Principe 1967      70787    Africa 54.42500
    ## 1289    Sao Tome and Principe 1972      76595    Africa 56.48000
    ## 1290    Sao Tome and Principe 1977      86796    Africa 58.55000
    ## 1291    Sao Tome and Principe 1982      98593    Africa 60.35100
    ## 1292    Sao Tome and Principe 1987     110812    Africa 61.72800
    ## 1293    Sao Tome and Principe 1992     125911    Africa 62.74200
    ## 1294    Sao Tome and Principe 1997     145608    Africa 63.30600
    ## 1295    Sao Tome and Principe 2002     170372    Africa 64.33700
    ## 1296    Sao Tome and Principe 2007     199579    Africa 65.52800
    ## 1297             Saudi Arabia 1952    4005677      Asia 39.87500
    ## 1298             Saudi Arabia 1957    4419650      Asia 42.86800
    ## 1299             Saudi Arabia 1962    4943029      Asia 45.91400
    ## 1300             Saudi Arabia 1967    5618198      Asia 49.90100
    ## 1301             Saudi Arabia 1972    6472756      Asia 53.88600
    ## 1302             Saudi Arabia 1977    8128505      Asia 58.69000
    ## 1303             Saudi Arabia 1982   11254672      Asia 63.01200
    ## 1304             Saudi Arabia 1987   14619745      Asia 66.29500
    ## 1305             Saudi Arabia 1992   16945857      Asia 68.76800
    ## 1306             Saudi Arabia 1997   21229759      Asia 70.53300
    ## 1307             Saudi Arabia 2002   24501530      Asia 71.62600
    ## 1308             Saudi Arabia 2007   27601038      Asia 72.77700
    ## 1309                  Senegal 1952    2755589    Africa 37.27800
    ## 1310                  Senegal 1957    3054547    Africa 39.32900
    ## 1311                  Senegal 1962    3430243    Africa 41.45400
    ## 1312                  Senegal 1967    3965841    Africa 43.56300
    ## 1313                  Senegal 1972    4588696    Africa 45.81500
    ## 1314                  Senegal 1977    5260855    Africa 48.87900
    ## 1315                  Senegal 1982    6147783    Africa 52.37900
    ## 1316                  Senegal 1987    7171347    Africa 55.76900
    ## 1317                  Senegal 1992    8307920    Africa 58.19600
    ## 1318                  Senegal 1997    9535314    Africa 60.18700
    ## 1319                  Senegal 2002   10870037    Africa 61.60000
    ## 1320                  Senegal 2007   12267493    Africa 63.06200
    ## 1321                   Serbia 1952    6860147    Europe 57.99600
    ## 1322                   Serbia 1957    7271135    Europe 61.68500
    ## 1323                   Serbia 1962    7616060    Europe 64.53100
    ## 1324                   Serbia 1967    7971222    Europe 66.91400
    ## 1325                   Serbia 1972    8313288    Europe 68.70000
    ## 1326                   Serbia 1977    8686367    Europe 70.30000
    ## 1327                   Serbia 1982    9032824    Europe 70.16200
    ## 1328                   Serbia 1987    9230783    Europe 71.21800
    ## 1329                   Serbia 1992    9826397    Europe 71.65900
    ## 1330                   Serbia 1997   10336594    Europe 72.23200
    ## 1331                   Serbia 2002   10111559    Europe 73.21300
    ## 1332                   Serbia 2007   10150265    Europe 74.00200
    ## 1333             Sierra Leone 1952    2143249    Africa 30.33100
    ## 1334             Sierra Leone 1957    2295678    Africa 31.57000
    ## 1335             Sierra Leone 1962    2467895    Africa 32.76700
    ## 1336             Sierra Leone 1967    2662190    Africa 34.11300
    ## 1337             Sierra Leone 1972    2879013    Africa 35.40000
    ## 1338             Sierra Leone 1977    3140897    Africa 36.78800
    ## 1339             Sierra Leone 1982    3464522    Africa 38.44500
    ## 1340             Sierra Leone 1987    3868905    Africa 40.00600
    ## 1341             Sierra Leone 1992    4260884    Africa 38.33300
    ## 1342             Sierra Leone 1997    4578212    Africa 39.89700
    ## 1343             Sierra Leone 2002    5359092    Africa 41.01200
    ## 1344             Sierra Leone 2007    6144562    Africa 42.56800
    ## 1345                Singapore 1952    1127000      Asia 60.39600
    ## 1346                Singapore 1957    1445929      Asia 63.17900
    ## 1347                Singapore 1962    1750200      Asia 65.79800
    ## 1348                Singapore 1967    1977600      Asia 67.94600
    ## 1349                Singapore 1972    2152400      Asia 69.52100
    ## 1350                Singapore 1977    2325300      Asia 70.79500
    ## 1351                Singapore 1982    2651869      Asia 71.76000
    ## 1352                Singapore 1987    2794552      Asia 73.56000
    ## 1353                Singapore 1992    3235865      Asia 75.78800
    ## 1354                Singapore 1997    3802309      Asia 77.15800
    ## 1355                Singapore 2002    4197776      Asia 78.77000
    ## 1356                Singapore 2007    4553009      Asia 79.97200
    ## 1357          Slovak Republic 1952    3558137    Europe 64.36000
    ## 1358          Slovak Republic 1957    3844277    Europe 67.45000
    ## 1359          Slovak Republic 1962    4237384    Europe 70.33000
    ## 1360          Slovak Republic 1967    4442238    Europe 70.98000
    ## 1361          Slovak Republic 1972    4593433    Europe 70.35000
    ## 1362          Slovak Republic 1977    4827803    Europe 70.45000
    ## 1363          Slovak Republic 1982    5048043    Europe 70.80000
    ## 1364          Slovak Republic 1987    5199318    Europe 71.08000
    ## 1365          Slovak Republic 1992    5302888    Europe 71.38000
    ## 1366          Slovak Republic 1997    5383010    Europe 72.71000
    ## 1367          Slovak Republic 2002    5410052    Europe 73.80000
    ## 1368          Slovak Republic 2007    5447502    Europe 74.66300
    ## 1369                 Slovenia 1952    1489518    Europe 65.57000
    ## 1370                 Slovenia 1957    1533070    Europe 67.85000
    ## 1371                 Slovenia 1962    1582962    Europe 69.15000
    ## 1372                 Slovenia 1967    1646912    Europe 69.18000
    ## 1373                 Slovenia 1972    1694510    Europe 69.82000
    ## 1374                 Slovenia 1977    1746919    Europe 70.97000
    ## 1375                 Slovenia 1982    1861252    Europe 71.06300
    ## 1376                 Slovenia 1987    1945870    Europe 72.25000
    ## 1377                 Slovenia 1992    1999210    Europe 73.64000
    ## 1378                 Slovenia 1997    2011612    Europe 75.13000
    ## 1379                 Slovenia 2002    2011497    Europe 76.66000
    ## 1380                 Slovenia 2007    2009245    Europe 77.92600
    ## 1381                  Somalia 1952    2526994    Africa 32.97800
    ## 1382                  Somalia 1957    2780415    Africa 34.97700
    ## 1383                  Somalia 1962    3080153    Africa 36.98100
    ## 1384                  Somalia 1967    3428839    Africa 38.97700
    ## 1385                  Somalia 1972    3840161    Africa 40.97300
    ## 1386                  Somalia 1977    4353666    Africa 41.97400
    ## 1387                  Somalia 1982    5828892    Africa 42.95500
    ## 1388                  Somalia 1987    6921858    Africa 44.50100
    ## 1389                  Somalia 1992    6099799    Africa 39.65800
    ## 1390                  Somalia 1997    6633514    Africa 43.79500
    ## 1391                  Somalia 2002    7753310    Africa 45.93600
    ## 1392                  Somalia 2007    9118773    Africa 48.15900
    ## 1393             South Africa 1952   14264935    Africa 45.00900
    ## 1394             South Africa 1957   16151549    Africa 47.98500
    ## 1395             South Africa 1962   18356657    Africa 49.95100
    ## 1396             South Africa 1967   20997321    Africa 51.92700
    ## 1397             South Africa 1972   23935810    Africa 53.69600
    ## 1398             South Africa 1977   27129932    Africa 55.52700
    ## 1399             South Africa 1982   31140029    Africa 58.16100
    ## 1400             South Africa 1987   35933379    Africa 60.83400
    ## 1401             South Africa 1992   39964159    Africa 61.88800
    ## 1402             South Africa 1997   42835005    Africa 60.23600
    ## 1403             South Africa 2002   44433622    Africa 53.36500
    ## 1404             South Africa 2007   43997828    Africa 49.33900
    ## 1405                    Spain 1952   28549870    Europe 64.94000
    ## 1406                    Spain 1957   29841614    Europe 66.66000
    ## 1407                    Spain 1962   31158061    Europe 69.69000
    ## 1408                    Spain 1967   32850275    Europe 71.44000
    ## 1409                    Spain 1972   34513161    Europe 73.06000
    ## 1410                    Spain 1977   36439000    Europe 74.39000
    ## 1411                    Spain 1982   37983310    Europe 76.30000
    ## 1412                    Spain 1987   38880702    Europe 76.90000
    ## 1413                    Spain 1992   39549438    Europe 77.57000
    ## 1414                    Spain 1997   39855442    Europe 78.77000
    ## 1415                    Spain 2002   40152517    Europe 79.78000
    ## 1416                    Spain 2007   40448191    Europe 80.94100
    ## 1417                Sri Lanka 1952    7982342      Asia 57.59300
    ## 1418                Sri Lanka 1957    9128546      Asia 61.45600
    ## 1419                Sri Lanka 1962   10421936      Asia 62.19200
    ## 1420                Sri Lanka 1967   11737396      Asia 64.26600
    ## 1421                Sri Lanka 1972   13016733      Asia 65.04200
    ## 1422                Sri Lanka 1977   14116836      Asia 65.94900
    ## 1423                Sri Lanka 1982   15410151      Asia 68.75700
    ## 1424                Sri Lanka 1987   16495304      Asia 69.01100
    ## 1425                Sri Lanka 1992   17587060      Asia 70.37900
    ## 1426                Sri Lanka 1997   18698655      Asia 70.45700
    ## 1427                Sri Lanka 2002   19576783      Asia 70.81500
    ## 1428                Sri Lanka 2007   20378239      Asia 72.39600
    ## 1429                    Sudan 1952    8504667    Africa 38.63500
    ## 1430                    Sudan 1957    9753392    Africa 39.62400
    ## 1431                    Sudan 1962   11183227    Africa 40.87000
    ## 1432                    Sudan 1967   12716129    Africa 42.85800
    ## 1433                    Sudan 1972   14597019    Africa 45.08300
    ## 1434                    Sudan 1977   17104986    Africa 47.80000
    ## 1435                    Sudan 1982   20367053    Africa 50.33800
    ## 1436                    Sudan 1987   24725960    Africa 51.74400
    ## 1437                    Sudan 1992   28227588    Africa 53.55600
    ## 1438                    Sudan 1997   32160729    Africa 55.37300
    ## 1439                    Sudan 2002   37090298    Africa 56.36900
    ## 1440                    Sudan 2007   42292929    Africa 58.55600
    ## 1441                Swaziland 1952     290243    Africa 41.40700
    ## 1442                Swaziland 1957     326741    Africa 43.42400
    ## 1443                Swaziland 1962     370006    Africa 44.99200
    ## 1444                Swaziland 1967     420690    Africa 46.63300
    ## 1445                Swaziland 1972     480105    Africa 49.55200
    ## 1446                Swaziland 1977     551425    Africa 52.53700
    ## 1447                Swaziland 1982     649901    Africa 55.56100
    ## 1448                Swaziland 1987     779348    Africa 57.67800
    ## 1449                Swaziland 1992     962344    Africa 58.47400
    ## 1450                Swaziland 1997    1054486    Africa 54.28900
    ## 1451                Swaziland 2002    1130269    Africa 43.86900
    ## 1452                Swaziland 2007    1133066    Africa 39.61300
    ## 1453                   Sweden 1952    7124673    Europe 71.86000
    ## 1454                   Sweden 1957    7363802    Europe 72.49000
    ## 1455                   Sweden 1962    7561588    Europe 73.37000
    ## 1456                   Sweden 1967    7867931    Europe 74.16000
    ## 1457                   Sweden 1972    8122293    Europe 74.72000
    ## 1458                   Sweden 1977    8251648    Europe 75.44000
    ## 1459                   Sweden 1982    8325260    Europe 76.42000
    ## 1460                   Sweden 1987    8421403    Europe 77.19000
    ## 1461                   Sweden 1992    8718867    Europe 78.16000
    ## 1462                   Sweden 1997    8897619    Europe 79.39000
    ## 1463                   Sweden 2002    8954175    Europe 80.04000
    ## 1464                   Sweden 2007    9031088    Europe 80.88400
    ## 1465              Switzerland 1952    4815000    Europe 69.62000
    ## 1466              Switzerland 1957    5126000    Europe 70.56000
    ## 1467              Switzerland 1962    5666000    Europe 71.32000
    ## 1468              Switzerland 1967    6063000    Europe 72.77000
    ## 1469              Switzerland 1972    6401400    Europe 73.78000
    ## 1470              Switzerland 1977    6316424    Europe 75.39000
    ## 1471              Switzerland 1982    6468126    Europe 76.21000
    ## 1472              Switzerland 1987    6649942    Europe 77.41000
    ## 1473              Switzerland 1992    6995447    Europe 78.03000
    ## 1474              Switzerland 1997    7193761    Europe 79.37000
    ## 1475              Switzerland 2002    7361757    Europe 80.62000
    ## 1476              Switzerland 2007    7554661    Europe 81.70100
    ## 1477                    Syria 1952    3661549      Asia 45.88300
    ## 1478                    Syria 1957    4149908      Asia 48.28400
    ## 1479                    Syria 1962    4834621      Asia 50.30500
    ## 1480                    Syria 1967    5680812      Asia 53.65500
    ## 1481                    Syria 1972    6701172      Asia 57.29600
    ## 1482                    Syria 1977    7932503      Asia 61.19500
    ## 1483                    Syria 1982    9410494      Asia 64.59000
    ## 1484                    Syria 1987   11242847      Asia 66.97400
    ## 1485                    Syria 1992   13219062      Asia 69.24900
    ## 1486                    Syria 1997   15081016      Asia 71.52700
    ## 1487                    Syria 2002   17155814      Asia 73.05300
    ## 1488                    Syria 2007   19314747      Asia 74.14300
    ## 1489                   Taiwan 1952    8550362      Asia 58.50000
    ## 1490                   Taiwan 1957   10164215      Asia 62.40000
    ## 1491                   Taiwan 1962   11918938      Asia 65.20000
    ## 1492                   Taiwan 1967   13648692      Asia 67.50000
    ## 1493                   Taiwan 1972   15226039      Asia 69.39000
    ## 1494                   Taiwan 1977   16785196      Asia 70.59000
    ## 1495                   Taiwan 1982   18501390      Asia 72.16000
    ## 1496                   Taiwan 1987   19757799      Asia 73.40000
    ## 1497                   Taiwan 1992   20686918      Asia 74.26000
    ## 1498                   Taiwan 1997   21628605      Asia 75.25000
    ## 1499                   Taiwan 2002   22454239      Asia 76.99000
    ## 1500                   Taiwan 2007   23174294      Asia 78.40000
    ## 1501                 Tanzania 1952    8322925    Africa 41.21500
    ## 1502                 Tanzania 1957    9452826    Africa 42.97400
    ## 1503                 Tanzania 1962   10863958    Africa 44.24600
    ## 1504                 Tanzania 1967   12607312    Africa 45.75700
    ## 1505                 Tanzania 1972   14706593    Africa 47.62000
    ## 1506                 Tanzania 1977   17129565    Africa 49.91900
    ## 1507                 Tanzania 1982   19844382    Africa 50.60800
    ## 1508                 Tanzania 1987   23040630    Africa 51.53500
    ## 1509                 Tanzania 1992   26605473    Africa 50.44000
    ## 1510                 Tanzania 1997   30686889    Africa 48.46600
    ## 1511                 Tanzania 2002   34593779    Africa 49.65100
    ## 1512                 Tanzania 2007   38139640    Africa 52.51700
    ## 1513                 Thailand 1952   21289402      Asia 50.84800
    ## 1514                 Thailand 1957   25041917      Asia 53.63000
    ## 1515                 Thailand 1962   29263397      Asia 56.06100
    ## 1516                 Thailand 1967   34024249      Asia 58.28500
    ## 1517                 Thailand 1972   39276153      Asia 60.40500
    ## 1518                 Thailand 1977   44148285      Asia 62.49400
    ## 1519                 Thailand 1982   48827160      Asia 64.59700
    ## 1520                 Thailand 1987   52910342      Asia 66.08400
    ## 1521                 Thailand 1992   56667095      Asia 67.29800
    ## 1522                 Thailand 1997   60216677      Asia 67.52100
    ## 1523                 Thailand 2002   62806748      Asia 68.56400
    ## 1524                 Thailand 2007   65068149      Asia 70.61600
    ## 1525                     Togo 1952    1219113    Africa 38.59600
    ## 1526                     Togo 1957    1357445    Africa 41.20800
    ## 1527                     Togo 1962    1528098    Africa 43.92200
    ## 1528                     Togo 1967    1735550    Africa 46.76900
    ## 1529                     Togo 1972    2056351    Africa 49.75900
    ## 1530                     Togo 1977    2308582    Africa 52.88700
    ## 1531                     Togo 1982    2644765    Africa 55.47100
    ## 1532                     Togo 1987    3154264    Africa 56.94100
    ## 1533                     Togo 1992    3747553    Africa 58.06100
    ## 1534                     Togo 1997    4320890    Africa 58.39000
    ## 1535                     Togo 2002    4977378    Africa 57.56100
    ## 1536                     Togo 2007    5701579    Africa 58.42000
    ## 1537      Trinidad and Tobago 1952     662850  Americas 59.10000
    ## 1538      Trinidad and Tobago 1957     764900  Americas 61.80000
    ## 1539      Trinidad and Tobago 1962     887498  Americas 64.90000
    ## 1540      Trinidad and Tobago 1967     960155  Americas 65.40000
    ## 1541      Trinidad and Tobago 1972     975199  Americas 65.90000
    ## 1542      Trinidad and Tobago 1977    1039009  Americas 68.30000
    ## 1543      Trinidad and Tobago 1982    1116479  Americas 68.83200
    ## 1544      Trinidad and Tobago 1987    1191336  Americas 69.58200
    ## 1545      Trinidad and Tobago 1992    1183669  Americas 69.86200
    ## 1546      Trinidad and Tobago 1997    1138101  Americas 69.46500
    ## 1547      Trinidad and Tobago 2002    1101832  Americas 68.97600
    ## 1548      Trinidad and Tobago 2007    1056608  Americas 69.81900
    ## 1549                  Tunisia 1952    3647735    Africa 44.60000
    ## 1550                  Tunisia 1957    3950849    Africa 47.10000
    ## 1551                  Tunisia 1962    4286552    Africa 49.57900
    ## 1552                  Tunisia 1967    4786986    Africa 52.05300
    ## 1553                  Tunisia 1972    5303507    Africa 55.60200
    ## 1554                  Tunisia 1977    6005061    Africa 59.83700
    ## 1555                  Tunisia 1982    6734098    Africa 64.04800
    ## 1556                  Tunisia 1987    7724976    Africa 66.89400
    ## 1557                  Tunisia 1992    8523077    Africa 70.00100
    ## 1558                  Tunisia 1997    9231669    Africa 71.97300
    ## 1559                  Tunisia 2002    9770575    Africa 73.04200
    ## 1560                  Tunisia 2007   10276158    Africa 73.92300
    ## 1561                   Turkey 1952   22235677    Europe 43.58500
    ## 1562                   Turkey 1957   25670939    Europe 48.07900
    ## 1563                   Turkey 1962   29788695    Europe 52.09800
    ## 1564                   Turkey 1967   33411317    Europe 54.33600
    ## 1565                   Turkey 1972   37492953    Europe 57.00500
    ## 1566                   Turkey 1977   42404033    Europe 59.50700
    ## 1567                   Turkey 1982   47328791    Europe 61.03600
    ## 1568                   Turkey 1987   52881328    Europe 63.10800
    ## 1569                   Turkey 1992   58179144    Europe 66.14600
    ## 1570                   Turkey 1997   63047647    Europe 68.83500
    ## 1571                   Turkey 2002   67308928    Europe 70.84500
    ## 1572                   Turkey 2007   71158647    Europe 71.77700
    ## 1573                   Uganda 1952    5824797    Africa 39.97800
    ## 1574                   Uganda 1957    6675501    Africa 42.57100
    ## 1575                   Uganda 1962    7688797    Africa 45.34400
    ## 1576                   Uganda 1967    8900294    Africa 48.05100
    ## 1577                   Uganda 1972   10190285    Africa 51.01600
    ## 1578                   Uganda 1977   11457758    Africa 50.35000
    ## 1579                   Uganda 1982   12939400    Africa 49.84900
    ## 1580                   Uganda 1987   15283050    Africa 51.50900
    ## 1581                   Uganda 1992   18252190    Africa 48.82500
    ## 1582                   Uganda 1997   21210254    Africa 44.57800
    ## 1583                   Uganda 2002   24739869    Africa 47.81300
    ## 1584                   Uganda 2007   29170398    Africa 51.54200
    ## 1585           United Kingdom 1952   50430000    Europe 69.18000
    ## 1586           United Kingdom 1957   51430000    Europe 70.42000
    ## 1587           United Kingdom 1962   53292000    Europe 70.76000
    ## 1588           United Kingdom 1967   54959000    Europe 71.36000
    ## 1589           United Kingdom 1972   56079000    Europe 72.01000
    ## 1590           United Kingdom 1977   56179000    Europe 72.76000
    ## 1591           United Kingdom 1982   56339704    Europe 74.04000
    ## 1592           United Kingdom 1987   56981620    Europe 75.00700
    ## 1593           United Kingdom 1992   57866349    Europe 76.42000
    ## 1594           United Kingdom 1997   58808266    Europe 77.21800
    ## 1595           United Kingdom 2002   59912431    Europe 78.47100
    ## 1596           United Kingdom 2007   60776238    Europe 79.42500
    ## 1597            United States 1952  157553000  Americas 68.44000
    ## 1598            United States 1957  171984000  Americas 69.49000
    ## 1599            United States 1962  186538000  Americas 70.21000
    ## 1600            United States 1967  198712000  Americas 70.76000
    ## 1601            United States 1972  209896000  Americas 71.34000
    ## 1602            United States 1977  220239000  Americas 73.38000
    ## 1603            United States 1982  232187835  Americas 74.65000
    ## 1604            United States 1987  242803533  Americas 75.02000
    ## 1605            United States 1992  256894189  Americas 76.09000
    ## 1606            United States 1997  272911760  Americas 76.81000
    ## 1607            United States 2002  287675526  Americas 77.31000
    ## 1608            United States 2007  301139947  Americas 78.24200
    ## 1609                  Uruguay 1952    2252965  Americas 66.07100
    ## 1610                  Uruguay 1957    2424959  Americas 67.04400
    ## 1611                  Uruguay 1962    2598466  Americas 68.25300
    ## 1612                  Uruguay 1967    2748579  Americas 68.46800
    ## 1613                  Uruguay 1972    2829526  Americas 68.67300
    ## 1614                  Uruguay 1977    2873520  Americas 69.48100
    ## 1615                  Uruguay 1982    2953997  Americas 70.80500
    ## 1616                  Uruguay 1987    3045153  Americas 71.91800
    ## 1617                  Uruguay 1992    3149262  Americas 72.75200
    ## 1618                  Uruguay 1997    3262838  Americas 74.22300
    ## 1619                  Uruguay 2002    3363085  Americas 75.30700
    ## 1620                  Uruguay 2007    3447496  Americas 76.38400
    ## 1621                Venezuela 1952    5439568  Americas 55.08800
    ## 1622                Venezuela 1957    6702668  Americas 57.90700
    ## 1623                Venezuela 1962    8143375  Americas 60.77000
    ## 1624                Venezuela 1967    9709552  Americas 63.47900
    ## 1625                Venezuela 1972   11515649  Americas 65.71200
    ## 1626                Venezuela 1977   13503563  Americas 67.45600
    ## 1627                Venezuela 1982   15620766  Americas 68.55700
    ## 1628                Venezuela 1987   17910182  Americas 70.19000
    ## 1629                Venezuela 1992   20265563  Americas 71.15000
    ## 1630                Venezuela 1997   22374398  Americas 72.14600
    ## 1631                Venezuela 2002   24287670  Americas 72.76600
    ## 1632                Venezuela 2007   26084662  Americas 73.74700
    ## 1633                  Vietnam 1952   26246839      Asia 40.41200
    ## 1634                  Vietnam 1957   28998543      Asia 42.88700
    ## 1635                  Vietnam 1962   33796140      Asia 45.36300
    ## 1636                  Vietnam 1967   39463910      Asia 47.83800
    ## 1637                  Vietnam 1972   44655014      Asia 50.25400
    ## 1638                  Vietnam 1977   50533506      Asia 55.76400
    ## 1639                  Vietnam 1982   56142181      Asia 58.81600
    ## 1640                  Vietnam 1987   62826491      Asia 62.82000
    ## 1641                  Vietnam 1992   69940728      Asia 67.66200
    ## 1642                  Vietnam 1997   76048996      Asia 70.67200
    ## 1643                  Vietnam 2002   80908147      Asia 73.01700
    ## 1644                  Vietnam 2007   85262356      Asia 74.24900
    ## 1645       West Bank and Gaza 1952    1030585      Asia 43.16000
    ## 1646       West Bank and Gaza 1957    1070439      Asia 45.67100
    ## 1647       West Bank and Gaza 1962    1133134      Asia 48.12700
    ## 1648       West Bank and Gaza 1967    1142636      Asia 51.63100
    ## 1649       West Bank and Gaza 1972    1089572      Asia 56.53200
    ## 1650       West Bank and Gaza 1977    1261091      Asia 60.76500
    ## 1651       West Bank and Gaza 1982    1425876      Asia 64.40600
    ## 1652       West Bank and Gaza 1987    1691210      Asia 67.04600
    ## 1653       West Bank and Gaza 1992    2104779      Asia 69.71800
    ## 1654       West Bank and Gaza 1997    2826046      Asia 71.09600
    ## 1655       West Bank and Gaza 2002    3389578      Asia 72.37000
    ## 1656       West Bank and Gaza 2007    4018332      Asia 73.42200
    ## 1657               Yemen Rep. 1952    4963829      Asia 32.54800
    ## 1658               Yemen Rep. 1957    5498090      Asia 33.97000
    ## 1659               Yemen Rep. 1962    6120081      Asia 35.18000
    ## 1660               Yemen Rep. 1967    6740785      Asia 36.98400
    ## 1661               Yemen Rep. 1972    7407075      Asia 39.84800
    ## 1662               Yemen Rep. 1977    8403990      Asia 44.17500
    ## 1663               Yemen Rep. 1982    9657618      Asia 49.11300
    ## 1664               Yemen Rep. 1987   11219340      Asia 52.92200
    ## 1665               Yemen Rep. 1992   13367997      Asia 55.59900
    ## 1666               Yemen Rep. 1997   15826497      Asia 58.02000
    ## 1667               Yemen Rep. 2002   18701257      Asia 60.30800
    ## 1668               Yemen Rep. 2007   22211743      Asia 62.69800
    ## 1669                   Zambia 1952    2672000    Africa 42.03800
    ## 1670                   Zambia 1957    3016000    Africa 44.07700
    ## 1671                   Zambia 1962    3421000    Africa 46.02300
    ## 1672                   Zambia 1967    3900000    Africa 47.76800
    ## 1673                   Zambia 1972    4506497    Africa 50.10700
    ## 1674                   Zambia 1977    5216550    Africa 51.38600
    ## 1675                   Zambia 1982    6100407    Africa 51.82100
    ## 1676                   Zambia 1987    7272406    Africa 50.82100
    ## 1677                   Zambia 1992    8381163    Africa 46.10000
    ## 1678                   Zambia 1997    9417789    Africa 40.23800
    ## 1679                   Zambia 2002   10595811    Africa 39.19300
    ## 1680                   Zambia 2007   11746035    Africa 42.38400
    ## 1681                 Zimbabwe 1952    3080907    Africa 48.45100
    ## 1682                 Zimbabwe 1957    3646340    Africa 50.46900
    ## 1683                 Zimbabwe 1962    4277736    Africa 52.35800
    ## 1684                 Zimbabwe 1967    4995432    Africa 53.99500
    ## 1685                 Zimbabwe 1972    5861135    Africa 55.63500
    ## 1686                 Zimbabwe 1977    6642107    Africa 57.67400
    ## 1687                 Zimbabwe 1982    7636524    Africa 60.36300
    ## 1688                 Zimbabwe 1987    9216418    Africa 62.35100
    ## 1689                 Zimbabwe 1992   10704340    Africa 60.37700
    ## 1690                 Zimbabwe 1997   11404948    Africa 46.80900
    ## 1691                 Zimbabwe 2002   11926563    Africa 39.98900
    ## 1692                 Zimbabwe 2007   12311143    Africa 43.48700
    ##        gdpPercap
    ## 1       779.4453
    ## 2       820.8530
    ## 3       853.1007
    ## 4       836.1971
    ## 5       739.9811
    ## 6       786.1134
    ## 7       978.0114
    ## 8       852.3959
    ## 9       649.3414
    ## 10      635.3414
    ## 11      726.7341
    ## 12      974.5803
    ## 13     1601.0561
    ## 14     1942.2842
    ## 15     2312.8890
    ## 16     2760.1969
    ## 17     3313.4222
    ## 18     3533.0039
    ## 19     3630.8807
    ## 20     3738.9327
    ## 21     2497.4379
    ## 22     3193.0546
    ## 23     4604.2117
    ## 24     5937.0295
    ## 25     2449.0082
    ## 26     3013.9760
    ## 27     2550.8169
    ## 28     3246.9918
    ## 29     4182.6638
    ## 30     4910.4168
    ## 31     5745.1602
    ## 32     5681.3585
    ## 33     5023.2166
    ## 34     4797.2951
    ## 35     5288.0404
    ## 36     6223.3675
    ## 37     3520.6103
    ## 38     3827.9405
    ## 39     4269.2767
    ## 40     5522.7764
    ## 41     5473.2880
    ## 42     3008.6474
    ## 43     2756.9537
    ## 44     2430.2083
    ## 45     2627.8457
    ## 46     2277.1409
    ## 47     2773.2873
    ## 48     4797.2313
    ## 49     5911.3151
    ## 50     6856.8562
    ## 51     7133.1660
    ## 52     8052.9530
    ## 53     9443.0385
    ## 54    10079.0267
    ## 55     8997.8974
    ## 56     9139.6714
    ## 57     9308.4187
    ## 58    10967.2820
    ## 59     8797.6407
    ## 60    12779.3796
    ## 61    10039.5956
    ## 62    10949.6496
    ## 63    12217.2269
    ## 64    14526.1246
    ## 65    16788.6295
    ## 66    18334.1975
    ## 67    19477.0093
    ## 68    21888.8890
    ## 69    23424.7668
    ## 70    26997.9366
    ## 71    30687.7547
    ## 72    34435.3674
    ## 73     6137.0765
    ## 74     8842.5980
    ## 75    10750.7211
    ## 76    12834.6024
    ## 77    16661.6256
    ## 78    19749.4223
    ## 79    21597.0836
    ## 80    23687.8261
    ## 81    27042.0187
    ## 82    29095.9207
    ## 83    32417.6077
    ## 84    36126.4927
    ## 85     9867.0848
    ## 86    11635.7995
    ## 87    12753.2751
    ## 88    14804.6727
    ## 89    18268.6584
    ## 90    19340.1020
    ## 91    19211.1473
    ## 92    18524.0241
    ## 93    19035.5792
    ## 94    20292.0168
    ## 95    23403.5593
    ## 96    29796.0483
    ## 97      684.2442
    ## 98      661.6375
    ## 99      686.3416
    ## 100     721.1861
    ## 101     630.2336
    ## 102     659.8772
    ## 103     676.9819
    ## 104     751.9794
    ## 105     837.8102
    ## 106     972.7700
    ## 107    1136.3904
    ## 108    1391.2538
    ## 109    8343.1051
    ## 110    9714.9606
    ## 111   10991.2068
    ## 112   13149.0412
    ## 113   16672.1436
    ## 114   19117.9745
    ## 115   20979.8459
    ## 116   22525.5631
    ## 117   25575.5707
    ## 118   27561.1966
    ## 119   30485.8838
    ## 120   33692.6051
    ## 121    1062.7522
    ## 122     959.6011
    ## 123     949.4991
    ## 124    1035.8314
    ## 125    1085.7969
    ## 126    1029.1613
    ## 127    1277.8976
    ## 128    1225.8560
    ## 129    1191.2077
    ## 130    1232.9753
    ## 131    1372.8779
    ## 132    1441.2849
    ## 133    2677.3263
    ## 134    2127.6863
    ## 135    2180.9725
    ## 136    2586.8861
    ## 137    2980.3313
    ## 138    3548.0978
    ## 139    3156.5105
    ## 140    2753.6915
    ## 141    2961.6997
    ## 142    3326.1432
    ## 143    3413.2627
    ## 144    3822.1371
    ## 145     973.5332
    ## 146    1353.9892
    ## 147    1709.6837
    ## 148    2172.3524
    ## 149    2860.1698
    ## 150    3528.4813
    ## 151    4126.6132
    ## 152    4314.1148
    ## 153    2546.7814
    ## 154    4766.3559
    ## 155    6018.9752
    ## 156    7446.2988
    ## 157     851.2411
    ## 158     918.2325
    ## 159     983.6540
    ## 160    1214.7093
    ## 161    2263.6111
    ## 162    3214.8578
    ## 163    4551.1421
    ## 164    6205.8839
    ## 165    7954.1116
    ## 166    8647.1423
    ## 167   11003.6051
    ## 168   12569.8518
    ## 169    2108.9444
    ## 170    2487.3660
    ## 171    3336.5858
    ## 172    3429.8644
    ## 173    4985.7115
    ## 174    6660.1187
    ## 175    7030.8359
    ## 176    7807.0958
    ## 177    6950.2830
    ## 178    7957.9808
    ## 179    8131.2128
    ## 180    9065.8008
    ## 181    2444.2866
    ## 182    3008.6707
    ## 183    4254.3378
    ## 184    5577.0028
    ## 185    6597.4944
    ## 186    7612.2404
    ## 187    8224.1916
    ## 188    8239.8548
    ## 189    6302.6234
    ## 190    5970.3888
    ## 191    7696.7777
    ## 192   10680.7928
    ## 193     543.2552
    ## 194     617.1835
    ## 195     722.5120
    ## 196     794.8266
    ## 197     854.7360
    ## 198     743.3870
    ## 199     807.1986
    ## 200     912.0631
    ## 201     931.7528
    ## 202     946.2950
    ## 203    1037.6452
    ## 204    1217.0330
    ## 205     339.2965
    ## 206     379.5646
    ## 207     355.2032
    ## 208     412.9775
    ## 209     464.0995
    ## 210     556.1033
    ## 211     559.6032
    ## 212     621.8188
    ## 213     631.6999
    ## 214     463.1151
    ## 215     446.4035
    ## 216     430.0707
    ## 217     368.4693
    ## 218     434.0383
    ## 219     496.9136
    ## 220     523.4323
    ## 221     421.6240
    ## 222     524.9722
    ## 223     624.4755
    ## 224     683.8956
    ## 225     682.3032
    ## 226     734.2852
    ## 227     896.2260
    ## 228    1713.7787
    ## 229    1172.6677
    ## 230    1313.0481
    ## 231    1399.6074
    ## 232    1508.4531
    ## 233    1684.1465
    ## 234    1783.4329
    ## 235    2367.9833
    ## 236    2602.6642
    ## 237    1793.1633
    ## 238    1694.3375
    ## 239    1934.0114
    ## 240    2042.0952
    ## 241   11367.1611
    ## 242   12489.9501
    ## 243   13462.4855
    ## 244   16076.5880
    ## 245   18970.5709
    ## 246   22090.8831
    ## 247   22898.7921
    ## 248   26626.5150
    ## 249   26342.8843
    ## 250   28954.9259
    ## 251   33328.9651
    ## 252   36319.2350
    ## 253    1071.3107
    ## 254    1190.8443
    ## 255    1193.0688
    ## 256    1136.0566
    ## 257    1070.0133
    ## 258    1109.3743
    ## 259     956.7530
    ## 260     844.8764
    ## 261     747.9055
    ## 262     740.5063
    ## 263     738.6906
    ## 264     706.0165
    ## 265    1178.6659
    ## 266    1308.4956
    ## 267    1389.8176
    ## 268    1196.8106
    ## 269    1104.1040
    ## 270    1133.9850
    ## 271     797.9081
    ## 272     952.3861
    ## 273    1058.0643
    ## 274    1004.9614
    ## 275    1156.1819
    ## 276    1704.0637
    ## 277    3939.9788
    ## 278    4315.6227
    ## 279    4519.0943
    ## 280    5106.6543
    ## 281    5494.0244
    ## 282    4756.7638
    ## 283    5095.6657
    ## 284    5547.0638
    ## 285    7596.1260
    ## 286   10118.0532
    ## 287   10778.7838
    ## 288   13171.6388
    ## 289     400.4486
    ## 290     575.9870
    ## 291     487.6740
    ## 292     612.7057
    ## 293     676.9001
    ## 294     741.2375
    ## 295     962.4214
    ## 296    1378.9040
    ## 297    1655.7842
    ## 298    2289.2341
    ## 299    3119.2809
    ## 300    4959.1149
    ## 301    2144.1151
    ## 302    2323.8056
    ## 303    2492.3511
    ## 304    2678.7298
    ## 305    3264.6600
    ## 306    3815.8079
    ## 307    4397.5757
    ## 308    4903.2191
    ## 309    5444.6486
    ## 310    6117.3617
    ## 311    5755.2600
    ## 312    7006.5804
    ## 313    1102.9909
    ## 314    1211.1485
    ## 315    1406.6483
    ## 316    1876.0296
    ## 317    1937.5777
    ## 318    1172.6030
    ## 319    1267.1001
    ## 320    1315.9808
    ## 321    1246.9074
    ## 322    1173.6182
    ## 323    1075.8116
    ## 324     986.1479
    ## 325     780.5423
    ## 326     905.8602
    ## 327     896.3146
    ## 328     861.5932
    ## 329     904.8961
    ## 330     795.7573
    ## 331     673.7478
    ## 332     672.7748
    ## 333     457.7192
    ## 334     312.1884
    ## 335     241.1659
    ## 336     277.5519
    ## 337    2125.6214
    ## 338    2315.0566
    ## 339    2464.7832
    ## 340    2677.9396
    ## 341    3213.1527
    ## 342    3259.1790
    ## 343    4879.5075
    ## 344    4201.1949
    ## 345    4016.2395
    ## 346    3484.1644
    ## 347    3484.0620
    ## 348    3632.5578
    ## 349    2627.0095
    ## 350    2990.0108
    ## 351    3460.9370
    ## 352    4161.7278
    ## 353    5118.1469
    ## 354    5926.8770
    ## 355    5262.7348
    ## 356    5629.9153
    ## 357    6160.4163
    ## 358    6677.0453
    ## 359    7723.4472
    ## 360    9645.0614
    ## 361    1388.5947
    ## 362    1500.8959
    ## 363    1728.8694
    ## 364    2052.0505
    ## 365    2378.2011
    ## 366    2517.7365
    ## 367    2602.7102
    ## 368    2156.9561
    ## 369    1648.0738
    ## 370    1786.2654
    ## 371    1648.8008
    ## 372    1544.7501
    ## 373    3119.2365
    ## 374    4338.2316
    ## 375    5477.8900
    ## 376    6960.2979
    ## 377    9164.0901
    ## 378   11305.3852
    ## 379   13221.8218
    ## 380   13822.5839
    ## 381    8447.7949
    ## 382    9875.6045
    ## 383   11628.3890
    ## 384   14619.2227
    ## 385    5586.5388
    ## 386    6092.1744
    ## 387    5180.7559
    ## 388    5690.2680
    ## 389    5305.4453
    ## 390    6380.4950
    ## 391    7316.9181
    ## 392    7532.9248
    ## 393    5592.8440
    ## 394    5431.9904
    ## 395    6340.6467
    ## 396    8948.1029
    ## 397    6876.1403
    ## 398    8256.3439
    ## 399   10136.8671
    ## 400   11399.4449
    ## 401   13108.4536
    ## 402   14800.1606
    ## 403   15377.2285
    ## 404   16310.4434
    ## 405   14297.0212
    ## 406   16048.5142
    ## 407   17596.2102
    ## 408   22833.3085
    ## 409    9692.3852
    ## 410   11099.6593
    ## 411   13583.3135
    ## 412   15937.2112
    ## 413   18866.2072
    ## 414   20422.9015
    ## 415   21688.0405
    ## 416   25116.1758
    ## 417   26406.7399
    ## 418   29804.3457
    ## 419   32166.5001
    ## 420   35278.4187
    ## 421    2669.5295
    ## 422    2864.9691
    ## 423    3020.9893
    ## 424    3020.0505
    ## 425    3694.2124
    ## 426    3081.7610
    ## 427    2879.4681
    ## 428    2880.1026
    ## 429    2377.1562
    ## 430    1895.0170
    ## 431    1908.2609
    ## 432    2082.4816
    ## 433    1397.7171
    ## 434    1544.4030
    ## 435    1662.1374
    ## 436    1653.7230
    ## 437    2189.8745
    ## 438    2681.9889
    ## 439    2861.0924
    ## 440    2899.8422
    ## 441    3044.2142
    ## 442    3614.1013
    ## 443    4563.8082
    ## 444    6025.3748
    ## 445    3522.1107
    ## 446    3780.5467
    ## 447    4086.1141
    ## 448    4579.0742
    ## 449    5280.9947
    ## 450    6679.6233
    ## 451    7213.7913
    ## 452    6481.7770
    ## 453    7103.7026
    ## 454    7429.4559
    ## 455    5773.0445
    ## 456    6873.2623
    ## 457    1418.8224
    ## 458    1458.9153
    ## 459    1693.3359
    ## 460    1814.8807
    ## 461    2024.0081
    ## 462    2785.4936
    ## 463    3503.7296
    ## 464    3885.4607
    ## 465    3794.7552
    ## 466    4173.1818
    ## 467    4754.6044
    ## 468    5581.1810
    ## 469    3048.3029
    ## 470    3421.5232
    ## 471    3776.8036
    ## 472    4358.5954
    ## 473    4520.2460
    ## 474    5138.9224
    ## 475    4098.3442
    ## 476    4140.4421
    ## 477    4444.2317
    ## 478    5154.8255
    ## 479    5351.5687
    ## 480    5728.3535
    ## 481     375.6431
    ## 482     426.0964
    ## 483     582.8420
    ## 484     915.5960
    ## 485     672.4123
    ## 486     958.5668
    ## 487     927.8253
    ## 488     966.8968
    ## 489    1132.0550
    ## 490    2814.4808
    ## 491    7703.4959
    ## 492   12154.0897
    ## 493     328.9406
    ## 494     344.1619
    ## 495     380.9958
    ## 496     468.7950
    ## 497     514.3242
    ## 498     505.7538
    ## 499     524.8758
    ## 500     521.1341
    ## 501     582.8585
    ## 502     913.4708
    ## 503     765.3500
    ## 504     641.3695
    ## 505     362.1463
    ## 506     378.9042
    ## 507     419.4564
    ## 508     516.1186
    ## 509     566.2439
    ## 510     556.8084
    ## 511     577.8607
    ## 512     573.7413
    ## 513     421.3535
    ## 514     515.8894
    ## 515     530.0535
    ## 516     690.8056
    ## 517    6424.5191
    ## 518    7545.4154
    ## 519    9371.8426
    ## 520   10921.6363
    ## 521   14358.8759
    ## 522   15605.4228
    ## 523   18533.1576
    ## 524   21141.0122
    ## 525   20647.1650
    ## 526   23723.9502
    ## 527   28204.5906
    ## 528   33207.0844
    ## 529    4293.4765
    ## 530    4976.1981
    ## 531    6631.4592
    ## 532    8358.7620
    ## 533   11401.9484
    ## 534   21745.5733
    ## 535   15113.3619
    ## 536   11864.4084
    ## 537   13522.1575
    ## 538   14722.8419
    ## 539   12521.7139
    ## 540   13206.4845
    ## 541     485.2307
    ## 542     520.9267
    ## 543     599.6503
    ## 544     734.7829
    ## 545     756.0868
    ## 546     884.7553
    ## 547     835.8096
    ## 548     611.6589
    ## 549     665.6244
    ## 550     653.7302
    ## 551     660.5856
    ## 552     752.7497
    ## 553    7144.1144
    ## 554   10187.8267
    ## 555   12902.4629
    ## 556   14745.6256
    ## 557   18016.1803
    ## 558   20512.9212
    ## 559   22031.5327
    ## 560   24639.1857
    ## 561   26505.3032
    ## 562   27788.8842
    ## 563   30035.8020
    ## 564   32170.3744
    ## 565     911.2989
    ## 566    1043.5615
    ## 567    1190.0411
    ## 568    1125.6972
    ## 569    1178.2237
    ## 570     993.2240
    ## 571     876.0326
    ## 572     847.0061
    ## 573     925.0602
    ## 574    1005.2458
    ## 575    1111.9846
    ## 576    1327.6089
    ## 577    3530.6901
    ## 578    4916.2999
    ## 579    6017.1907
    ## 580    8513.0970
    ## 581   12724.8296
    ## 582   14195.5243
    ## 583   15268.4209
    ## 584   16120.5284
    ## 585   17541.4963
    ## 586   18747.6981
    ## 587   22514.2548
    ## 588   27538.4119
    ## 589    2428.2378
    ## 590    2617.1560
    ## 591    2750.3644
    ## 592    3242.5311
    ## 593    4031.4083
    ## 594    4879.9927
    ## 595    4820.4948
    ## 596    4246.4860
    ## 597    4439.4508
    ## 598    4684.3138
    ## 599    4858.3475
    ## 600    5186.0500
    ## 601     510.1965
    ## 602     576.2670
    ## 603     686.3737
    ## 604     708.7595
    ## 605     741.6662
    ## 606     874.6859
    ## 607     857.2504
    ## 608     805.5725
    ## 609     794.3484
    ## 610     869.4498
    ## 611     945.5836
    ## 612     942.6542
    ## 613     299.8503
    ## 614     431.7905
    ## 615     522.0344
    ## 616     715.5806
    ## 617     820.2246
    ## 618     764.7260
    ## 619     838.1240
    ## 620     736.4154
    ## 621     745.5399
    ## 622     796.6645
    ## 623     575.7047
    ## 624     579.2317
    ## 625    1840.3669
    ## 626    1726.8879
    ## 627    1796.5890
    ## 628    1452.0577
    ## 629    1654.4569
    ## 630    1874.2989
    ## 631    2011.1595
    ## 632    1823.0160
    ## 633    1456.3095
    ## 634    1341.7269
    ## 635    1270.3649
    ## 636    1201.6372
    ## 637    2194.9262
    ## 638    2220.4877
    ## 639    2291.1568
    ## 640    2538.2694
    ## 641    2529.8423
    ## 642    3203.2081
    ## 643    3121.7608
    ## 644    3023.0967
    ## 645    3081.6946
    ## 646    3160.4549
    ## 647    3099.7287
    ## 648    3548.3308
    ## 649    3054.4212
    ## 650    3629.0765
    ## 651    4692.6483
    ## 652    6197.9628
    ## 653    8315.9281
    ## 654   11186.1413
    ## 655   14560.5305
    ## 656   20038.4727
    ## 657   24757.6030
    ## 658   28377.6322
    ## 659   30209.0152
    ## 660   39724.9787
    ## 661    5263.6738
    ## 662    6040.1800
    ## 663    7550.3599
    ## 664    9326.6447
    ## 665   10168.6561
    ## 666   11674.8374
    ## 667   12545.9907
    ## 668   12986.4800
    ## 669   10535.6285
    ## 670   11712.7768
    ## 671   14843.9356
    ## 672   18008.9444
    ## 673    7267.6884
    ## 674    9244.0014
    ## 675   10350.1591
    ## 676   13319.8957
    ## 677   15798.0636
    ## 678   19654.9625
    ## 679   23269.6075
    ## 680   26923.2063
    ## 681   25144.3920
    ## 682   28061.0997
    ## 683   31163.2020
    ## 684   36180.7892
    ## 685     546.5657
    ## 686     590.0620
    ## 687     658.3472
    ## 688     700.7706
    ## 689     724.0325
    ## 690     813.3373
    ## 691     855.7235
    ## 692     976.5127
    ## 693    1164.4068
    ## 694    1458.8174
    ## 695    1746.7695
    ## 696    2452.2104
    ## 697     749.6817
    ## 698     858.9003
    ## 699     849.2898
    ## 700     762.4318
    ## 701    1111.1079
    ## 702    1382.7021
    ## 703    1516.8730
    ## 704    1748.3570
    ## 705    2383.1409
    ## 706    3119.3356
    ## 707    2873.9129
    ## 708    3540.6516
    ## 709    3035.3260
    ## 710    3290.2576
    ## 711    4187.3298
    ## 712    5906.7318
    ## 713    9613.8186
    ## 714   11888.5951
    ## 715    7608.3346
    ## 716    6642.8814
    ## 717    7235.6532
    ## 718    8263.5903
    ## 719    9240.7620
    ## 720   11605.7145
    ## 721    4129.7661
    ## 722    6229.3336
    ## 723    8341.7378
    ## 724    8931.4598
    ## 725    9576.0376
    ## 726   14688.2351
    ## 727   14517.9071
    ## 728   11643.5727
    ## 729    3745.6407
    ## 730    3076.2398
    ## 731    4390.7173
    ## 732    4471.0619
    ## 733    5210.2803
    ## 734    5599.0779
    ## 735    6631.5973
    ## 736    7655.5690
    ## 737    9530.7729
    ## 738   11150.9811
    ## 739   12618.3214
    ## 740   13872.8665
    ## 741   17558.8155
    ## 742   24521.9471
    ## 743   34077.0494
    ## 744   40675.9964
    ## 745    4086.5221
    ## 746    5385.2785
    ## 747    7105.6307
    ## 748    8393.7414
    ## 749   12786.9322
    ## 750   13306.6192
    ## 751   15367.0292
    ## 752   17122.4799
    ## 753   18051.5225
    ## 754   20896.6092
    ## 755   21905.5951
    ## 756   25523.2771
    ## 757    4931.4042
    ## 758    6248.6562
    ## 759    8243.5823
    ## 760   10022.4013
    ## 761   12269.2738
    ## 762   14255.9847
    ## 763   16537.4835
    ## 764   19207.2348
    ## 765   22013.6449
    ## 766   24675.0245
    ## 767   27968.0982
    ## 768   28569.7197
    ## 769    2898.5309
    ## 770    4756.5258
    ## 771    5246.1075
    ## 772    6124.7035
    ## 773    7433.8893
    ## 774    6650.1956
    ## 775    6068.0513
    ## 776    6351.2375
    ## 777    7404.9237
    ## 778    7121.9247
    ## 779    6994.7749
    ## 780    7320.8803
    ## 781    3216.9563
    ## 782    4317.6944
    ## 783    6576.6495
    ## 784    9847.7886
    ## 785   14778.7864
    ## 786   16610.3770
    ## 787   19384.1057
    ## 788   22375.9419
    ## 789   26824.8951
    ## 790   28816.5850
    ## 791   28604.5919
    ## 792   31656.0681
    ## 793    1546.9078
    ## 794    1886.0806
    ## 795    2348.0092
    ## 796    2741.7963
    ## 797    2110.8563
    ## 798    2852.3516
    ## 799    4161.4160
    ## 800    4448.6799
    ## 801    3431.5936
    ## 802    3645.3796
    ## 803    3844.9172
    ## 804    4519.4612
    ## 805     853.5409
    ## 806     944.4383
    ## 807     896.9664
    ## 808    1056.7365
    ## 809    1222.3600
    ## 810    1267.6132
    ## 811    1348.2258
    ## 812    1361.9369
    ## 813    1341.9217
    ## 814    1360.4850
    ## 815    1287.5147
    ## 816    1463.2493
    ## 817    1088.2778
    ## 818    1571.1347
    ## 819    1621.6936
    ## 820    2143.5406
    ## 821    3701.6215
    ## 822    4106.3012
    ## 823    4106.5253
    ## 824    4106.4923
    ## 825    3726.0635
    ## 826    1690.7568
    ## 827    1646.7582
    ## 828    1593.0655
    ## 829    1030.5922
    ## 830    1487.5935
    ## 831    1536.3444
    ## 832    2029.2281
    ## 833    3030.8767
    ## 834    4657.2210
    ## 835    5622.9425
    ## 836    8533.0888
    ## 837   12104.2787
    ## 838   15993.5280
    ## 839   19233.9882
    ## 840   23348.1397
    ## 841  108382.3529
    ## 842  113523.1329
    ## 843   95458.1118
    ## 844   80894.8833
    ## 845  109347.8670
    ## 846   59265.4771
    ## 847   31354.0357
    ## 848   28118.4300
    ## 849   34932.9196
    ## 850   40300.6200
    ## 851   35110.1057
    ## 852   47306.9898
    ## 853    4834.8041
    ## 854    6089.7869
    ## 855    5714.5606
    ## 856    6006.9830
    ## 857    7486.3843
    ## 858    8659.6968
    ## 859    7640.5195
    ## 860    5377.0913
    ## 861    6890.8069
    ## 862    8754.9639
    ## 863    9313.9388
    ## 864   10461.0587
    ## 865     298.8462
    ## 866     335.9971
    ## 867     411.8006
    ## 868     498.6390
    ## 869     496.5816
    ## 870     745.3695
    ## 871     797.2631
    ## 872     773.9932
    ## 873     977.4863
    ## 874    1186.1480
    ## 875    1275.1846
    ## 876    1569.3314
    ## 877     575.5730
    ## 878     620.9700
    ## 879     634.1952
    ## 880     713.6036
    ## 881     803.0055
    ## 882     640.3224
    ## 883     572.1996
    ## 884     506.1139
    ## 885     636.6229
    ## 886     609.1740
    ## 887     531.4824
    ## 888     414.5073
    ## 889    2387.5481
    ## 890    3448.2844
    ## 891    6757.0308
    ## 892   18772.7517
    ## 893   21011.4972
    ## 894   21951.2118
    ## 895   17364.2754
    ## 896   11770.5898
    ## 897    9640.1385
    ## 898    9467.4461
    ## 899    9534.6775
    ## 900   12057.4993
    ## 901    1443.0117
    ## 902    1589.2027
    ## 903    1643.3871
    ## 904    1634.0473
    ## 905    1748.5630
    ## 906    1544.2286
    ## 907    1302.8787
    ## 908    1155.4419
    ## 909    1040.6762
    ## 910     986.2959
    ## 911     894.6371
    ## 912    1044.7701
    ## 913     369.1651
    ## 914     416.3698
    ## 915     427.9011
    ## 916     495.5148
    ## 917     584.6220
    ## 918     663.2237
    ## 919     632.8039
    ## 920     635.5174
    ## 921     563.2000
    ## 922     692.2758
    ## 923     665.4231
    ## 924     759.3499
    ## 925    1831.1329
    ## 926    1810.0670
    ## 927    2036.8849
    ## 928    2277.7424
    ## 929    2849.0948
    ## 930    3827.9216
    ## 931    4920.3560
    ## 932    5249.8027
    ## 933    7277.9128
    ## 934   10132.9096
    ## 935   10206.9779
    ## 936   12451.6558
    ## 937     452.3370
    ## 938     490.3822
    ## 939     496.1743
    ## 940     545.0099
    ## 941     581.3689
    ## 942     686.3953
    ## 943     618.0141
    ## 944     684.1716
    ## 945     739.0144
    ## 946     790.2580
    ## 947     951.4098
    ## 948    1042.5816
    ## 949     743.1159
    ## 950     846.1203
    ## 951    1055.8960
    ## 952    1421.1452
    ## 953    1586.8518
    ## 954    1497.4922
    ## 955    1481.1502
    ## 956    1421.6036
    ## 957    1361.3698
    ## 958    1483.1361
    ## 959    1579.0195
    ## 960    1803.1515
    ## 961    1967.9557
    ## 962    2034.0380
    ## 963    2529.0675
    ## 964    2475.3876
    ## 965    2575.4842
    ## 966    3710.9830
    ## 967    3688.0377
    ## 968    4783.5869
    ## 969    6058.2538
    ## 970    7425.7053
    ## 971    9021.8159
    ## 972   10956.9911
    ## 973    3478.1255
    ## 974    4131.5466
    ## 975    4581.6094
    ## 976    5754.7339
    ## 977    6809.4067
    ## 978    7674.9291
    ## 979    9611.1475
    ## 980    8688.1560
    ## 981    9472.3843
    ## 982    9767.2975
    ## 983   10742.4405
    ## 984   11977.5750
    ## 985     786.5669
    ## 986     912.6626
    ## 987    1056.3540
    ## 988    1226.0411
    ## 989    1421.7420
    ## 990    1647.5117
    ## 991    2000.6031
    ## 992    2338.0083
    ## 993    1785.4020
    ## 994    1902.2521
    ## 995    2140.7393
    ## 996    3095.7723
    ## 997    2647.5856
    ## 998    3682.2599
    ## 999    4649.5938
    ## 1000   5907.8509
    ## 1001   7778.4140
    ## 1002   9595.9299
    ## 1003  11222.5876
    ## 1004  11732.5102
    ## 1005   7003.3390
    ## 1006   6465.6133
    ## 1007   6557.1943
    ## 1008   9253.8961
    ## 1009   1688.2036
    ## 1010   1642.0023
    ## 1011   1566.3535
    ## 1012   1711.0448
    ## 1013   1930.1950
    ## 1014   2370.6200
    ## 1015   2702.6204
    ## 1016   2755.0470
    ## 1017   2948.0473
    ## 1018   2982.1019
    ## 1019   3258.4956
    ## 1020   3820.1752
    ## 1021    468.5260
    ## 1022    495.5868
    ## 1023    556.6864
    ## 1024    566.6692
    ## 1025    724.9178
    ## 1026    502.3197
    ## 1027    462.2114
    ## 1028    389.8762
    ## 1029    410.8968
    ## 1030    472.3461
    ## 1031    633.6179
    ## 1032    823.6856
    ## 1033    331.0000
    ## 1034    350.0000
    ## 1035    388.0000
    ## 1036    349.0000
    ## 1037    357.0000
    ## 1038    371.0000
    ## 1039    424.0000
    ## 1040    385.0000
    ## 1041    347.0000
    ## 1042    415.0000
    ## 1043    611.0000
    ## 1044    944.0000
    ## 1045   2423.7804
    ## 1046   2621.4481
    ## 1047   3173.2156
    ## 1048   3793.6948
    ## 1049   3746.0809
    ## 1050   3876.4860
    ## 1051   4191.1005
    ## 1052   3693.7313
    ## 1053   3804.5380
    ## 1054   3899.5243
    ## 1055   4072.3248
    ## 1056   4811.0604
    ## 1057    545.8657
    ## 1058    597.9364
    ## 1059    652.3969
    ## 1060    676.4422
    ## 1061    674.7881
    ## 1062    694.1124
    ## 1063    718.3731
    ## 1064    775.6325
    ## 1065    897.7404
    ## 1066   1010.8921
    ## 1067   1057.2063
    ## 1068   1091.3598
    ## 1069   8941.5719
    ## 1070  11276.1934
    ## 1071  12790.8496
    ## 1072  15363.2514
    ## 1073  18794.7457
    ## 1074  21209.0592
    ## 1075  21399.4605
    ## 1076  23651.3236
    ## 1077  26790.9496
    ## 1078  30246.1306
    ## 1079  33724.7578
    ## 1080  36797.9333
    ## 1081  10556.5757
    ## 1082  12247.3953
    ## 1083  13175.6780
    ## 1084  14463.9189
    ## 1085  16046.0373
    ## 1086  16233.7177
    ## 1087  17632.4104
    ## 1088  19007.1913
    ## 1089  18363.3249
    ## 1090  21050.4138
    ## 1091  23189.8014
    ## 1092  25185.0091
    ## 1093   3112.3639
    ## 1094   3457.4159
    ## 1095   3634.3644
    ## 1096   4643.3935
    ## 1097   4688.5933
    ## 1098   5486.3711
    ## 1099   3470.3382
    ## 1100   2955.9844
    ## 1101   2170.1517
    ## 1102   2253.0230
    ## 1103   2474.5488
    ## 1104   2749.3210
    ## 1105    761.8794
    ## 1106    835.5234
    ## 1107    997.7661
    ## 1108   1054.3849
    ## 1109    954.2092
    ## 1110    808.8971
    ## 1111    909.7221
    ## 1112    668.3000
    ## 1113    581.1827
    ## 1114    580.3052
    ## 1115    601.0745
    ## 1116    619.6769
    ## 1117   1077.2819
    ## 1118   1100.5926
    ## 1119   1150.9275
    ## 1120   1014.5141
    ## 1121   1698.3888
    ## 1122   1981.9518
    ## 1123   1576.9738
    ## 1124   1385.0296
    ## 1125   1619.8482
    ## 1126   1624.9413
    ## 1127   1615.2864
    ## 1128   2013.9773
    ## 1129  10095.4217
    ## 1130  11653.9730
    ## 1131  13450.4015
    ## 1132  16361.8765
    ## 1133  18965.0555
    ## 1134  23311.3494
    ## 1135  26298.6353
    ## 1136  31540.9748
    ## 1137  33965.6611
    ## 1138  41283.1643
    ## 1139  44683.9753
    ## 1140  49357.1902
    ## 1141   1828.2303
    ## 1142   2242.7466
    ## 1143   2924.6381
    ## 1144   4720.9427
    ## 1145  10618.0385
    ## 1146  11848.3439
    ## 1147  12954.7910
    ## 1148  18115.2231
    ## 1149  18616.7069
    ## 1150  19702.0558
    ## 1151  19774.8369
    ## 1152  22316.1929
    ## 1153    684.5971
    ## 1154    747.0835
    ## 1155    803.3427
    ## 1156    942.4083
    ## 1157   1049.9390
    ## 1158   1175.9212
    ## 1159   1443.4298
    ## 1160   1704.6866
    ## 1161   1971.8295
    ## 1162   2049.3505
    ## 1163   2092.7124
    ## 1164   2605.9476
    ## 1165   2480.3803
    ## 1166   2961.8009
    ## 1167   3536.5403
    ## 1168   4421.0091
    ## 1169   5364.2497
    ## 1170   5351.9121
    ## 1171   7009.6016
    ## 1172   7034.7792
    ## 1173   6618.7431
    ## 1174   7113.6923
    ## 1175   7356.0319
    ## 1176   9809.1856
    ## 1177   1952.3087
    ## 1178   2046.1547
    ## 1179   2148.0271
    ## 1180   2299.3763
    ## 1181   2523.3380
    ## 1182   3248.3733
    ## 1183   4258.5036
    ## 1184   3998.8757
    ## 1185   4196.4111
    ## 1186   4247.4003
    ## 1187   3783.6742
    ## 1188   4172.8385
    ## 1189   3758.5234
    ## 1190   4245.2567
    ## 1191   4957.0380
    ## 1192   5788.0933
    ## 1193   5937.8273
    ## 1194   6281.2909
    ## 1195   6434.5018
    ## 1196   6360.9434
    ## 1197   4446.3809
    ## 1198   5838.3477
    ## 1199   5909.0201
    ## 1200   7408.9056
    ## 1201   1272.8810
    ## 1202   1547.9448
    ## 1203   1649.5522
    ## 1204   1814.1274
    ## 1205   1989.3741
    ## 1206   2373.2043
    ## 1207   2603.2738
    ## 1208   2189.6350
    ## 1209   2279.3240
    ## 1210   2536.5349
    ## 1211   2650.9211
    ## 1212   3190.4810
    ## 1213   4029.3297
    ## 1214   4734.2530
    ## 1215   5338.7521
    ## 1216   6557.1528
    ## 1217   8006.5070
    ## 1218   9508.1415
    ## 1219   8451.5310
    ## 1220   9082.3512
    ## 1221   7738.8812
    ## 1222  10159.5837
    ## 1223  12002.2391
    ## 1224  15389.9247
    ## 1225   3068.3199
    ## 1226   3774.5717
    ## 1227   4727.9549
    ## 1228   6361.5180
    ## 1229   9022.2474
    ## 1230  10172.4857
    ## 1231  11753.8429
    ## 1232  13039.3088
    ## 1233  16207.2666
    ## 1234  17641.0316
    ## 1235  19970.9079
    ## 1236  20509.6478
    ## 1237   3081.9598
    ## 1238   3907.1562
    ## 1239   5108.3446
    ## 1240   6929.2777
    ## 1241   9123.0417
    ## 1242   9770.5249
    ## 1243  10330.9891
    ## 1244  12281.3419
    ## 1245  14641.5871
    ## 1246  16999.4333
    ## 1247  18855.6062
    ## 1248  19328.7090
    ## 1249   2718.8853
    ## 1250   2769.4518
    ## 1251   3173.7233
    ## 1252   4021.1757
    ## 1253   5047.6586
    ## 1254   4319.8041
    ## 1255   5267.2194
    ## 1256   5303.3775
    ## 1257   6101.2558
    ## 1258   6071.9414
    ## 1259   6316.1652
    ## 1260   7670.1226
    ## 1261   3144.6132
    ## 1262   3943.3702
    ## 1263   4734.9976
    ## 1264   6470.8665
    ## 1265   8011.4144
    ## 1266   9356.3972
    ## 1267   9605.3141
    ## 1268   9696.2733
    ## 1269   6598.4099
    ## 1270   7346.5476
    ## 1271   7885.3601
    ## 1272  10808.4756
    ## 1273    493.3239
    ## 1274    540.2894
    ## 1275    597.4731
    ## 1276    510.9637
    ## 1277    590.5807
    ## 1278    670.0806
    ## 1279    881.5706
    ## 1280    847.9912
    ## 1281    737.0686
    ## 1282    589.9445
    ## 1283    785.6538
    ## 1284    863.0885
    ## 1285    879.5836
    ## 1286    860.7369
    ## 1287   1071.5511
    ## 1288   1384.8406
    ## 1289   1532.9853
    ## 1290   1737.5617
    ## 1291   1890.2181
    ## 1292   1516.5255
    ## 1293   1428.7778
    ## 1294   1339.0760
    ## 1295   1353.0924
    ## 1296   1598.4351
    ## 1297   6459.5548
    ## 1298   8157.5912
    ## 1299  11626.4197
    ## 1300  16903.0489
    ## 1301  24837.4287
    ## 1302  34167.7626
    ## 1303  33693.1753
    ## 1304  21198.2614
    ## 1305  24841.6178
    ## 1306  20586.6902
    ## 1307  19014.5412
    ## 1308  21654.8319
    ## 1309   1450.3570
    ## 1310   1567.6530
    ## 1311   1654.9887
    ## 1312   1612.4046
    ## 1313   1597.7121
    ## 1314   1561.7691
    ## 1315   1518.4800
    ## 1316   1441.7207
    ## 1317   1367.8994
    ## 1318   1392.3683
    ## 1319   1519.6353
    ## 1320   1712.4721
    ## 1321   3581.4594
    ## 1322   4981.0909
    ## 1323   6289.6292
    ## 1324   7991.7071
    ## 1325  10522.0675
    ## 1326  12980.6696
    ## 1327  15181.0927
    ## 1328  15870.8785
    ## 1329   9325.0682
    ## 1330   7914.3203
    ## 1331   7236.0753
    ## 1332   9786.5347
    ## 1333    879.7877
    ## 1334   1004.4844
    ## 1335   1116.6399
    ## 1336   1206.0435
    ## 1337   1353.7598
    ## 1338   1348.2852
    ## 1339   1465.0108
    ## 1340   1294.4478
    ## 1341   1068.6963
    ## 1342    574.6482
    ## 1343    699.4897
    ## 1344    862.5408
    ## 1345   2315.1382
    ## 1346   2843.1044
    ## 1347   3674.7356
    ## 1348   4977.4185
    ## 1349   8597.7562
    ## 1350  11210.0895
    ## 1351  15169.1611
    ## 1352  18861.5308
    ## 1353  24769.8912
    ## 1354  33519.4766
    ## 1355  36023.1054
    ## 1356  47143.1796
    ## 1357   5074.6591
    ## 1358   6093.2630
    ## 1359   7481.1076
    ## 1360   8412.9024
    ## 1361   9674.1676
    ## 1362  10922.6640
    ## 1363  11348.5459
    ## 1364  12037.2676
    ## 1365   9498.4677
    ## 1366  12126.2306
    ## 1367  13638.7784
    ## 1368  18678.3144
    ## 1369   4215.0417
    ## 1370   5862.2766
    ## 1371   7402.3034
    ## 1372   9405.4894
    ## 1373  12383.4862
    ## 1374  15277.0302
    ## 1375  17866.7218
    ## 1376  18678.5349
    ## 1377  14214.7168
    ## 1378  17161.1073
    ## 1379  20660.0194
    ## 1380  25768.2576
    ## 1381   1135.7498
    ## 1382   1258.1474
    ## 1383   1369.4883
    ## 1384   1284.7332
    ## 1385   1254.5761
    ## 1386   1450.9925
    ## 1387   1176.8070
    ## 1388   1093.2450
    ## 1389    926.9603
    ## 1390    930.5964
    ## 1391    882.0818
    ## 1392    926.1411
    ## 1393   4725.2955
    ## 1394   5487.1042
    ## 1395   5768.7297
    ## 1396   7114.4780
    ## 1397   7765.9626
    ## 1398   8028.6514
    ## 1399   8568.2662
    ## 1400   7825.8234
    ## 1401   7225.0693
    ## 1402   7479.1882
    ## 1403   7710.9464
    ## 1404   9269.6578
    ## 1405   3834.0347
    ## 1406   4564.8024
    ## 1407   5693.8439
    ## 1408   7993.5123
    ## 1409  10638.7513
    ## 1410  13236.9212
    ## 1411  13926.1700
    ## 1412  15764.9831
    ## 1413  18603.0645
    ## 1414  20445.2990
    ## 1415  24835.4717
    ## 1416  28821.0637
    ## 1417   1083.5320
    ## 1418   1072.5466
    ## 1419   1074.4720
    ## 1420   1135.5143
    ## 1421   1213.3955
    ## 1422   1348.7757
    ## 1423   1648.0798
    ## 1424   1876.7668
    ## 1425   2153.7392
    ## 1426   2664.4773
    ## 1427   3015.3788
    ## 1428   3970.0954
    ## 1429   1615.9911
    ## 1430   1770.3371
    ## 1431   1959.5938
    ## 1432   1687.9976
    ## 1433   1659.6528
    ## 1434   2202.9884
    ## 1435   1895.5441
    ## 1436   1507.8192
    ## 1437   1492.1970
    ## 1438   1632.2108
    ## 1439   1993.3983
    ## 1440   2602.3950
    ## 1441   1148.3766
    ## 1442   1244.7084
    ## 1443   1856.1821
    ## 1444   2613.1017
    ## 1445   3364.8366
    ## 1446   3781.4106
    ## 1447   3895.3840
    ## 1448   3984.8398
    ## 1449   3553.0224
    ## 1450   3876.7685
    ## 1451   4128.1169
    ## 1452   4513.4806
    ## 1453   8527.8447
    ## 1454   9911.8782
    ## 1455  12329.4419
    ## 1456  15258.2970
    ## 1457  17832.0246
    ## 1458  18855.7252
    ## 1459  20667.3812
    ## 1460  23586.9293
    ## 1461  23880.0168
    ## 1462  25266.5950
    ## 1463  29341.6309
    ## 1464  33859.7484
    ## 1465  14734.2327
    ## 1466  17909.4897
    ## 1467  20431.0927
    ## 1468  22966.1443
    ## 1469  27195.1130
    ## 1470  26982.2905
    ## 1471  28397.7151
    ## 1472  30281.7046
    ## 1473  31871.5303
    ## 1474  32135.3230
    ## 1475  34480.9577
    ## 1476  37506.4191
    ## 1477   1643.4854
    ## 1478   2117.2349
    ## 1479   2193.0371
    ## 1480   1881.9236
    ## 1481   2571.4230
    ## 1482   3195.4846
    ## 1483   3761.8377
    ## 1484   3116.7743
    ## 1485   3340.5428
    ## 1486   4014.2390
    ## 1487   4090.9253
    ## 1488   4184.5481
    ## 1489   1206.9479
    ## 1490   1507.8613
    ## 1491   1822.8790
    ## 1492   2643.8587
    ## 1493   4062.5239
    ## 1494   5596.5198
    ## 1495   7426.3548
    ## 1496  11054.5618
    ## 1497  15215.6579
    ## 1498  20206.8210
    ## 1499  23235.4233
    ## 1500  28718.2768
    ## 1501    716.6501
    ## 1502    698.5356
    ## 1503    722.0038
    ## 1504    848.2187
    ## 1505    915.9851
    ## 1506    962.4923
    ## 1507    874.2426
    ## 1508    831.8221
    ## 1509    825.6825
    ## 1510    789.1862
    ## 1511    899.0742
    ## 1512   1107.4822
    ## 1513    757.7974
    ## 1514    793.5774
    ## 1515   1002.1992
    ## 1516   1295.4607
    ## 1517   1524.3589
    ## 1518   1961.2246
    ## 1519   2393.2198
    ## 1520   2982.6538
    ## 1521   4616.8965
    ## 1522   5852.6255
    ## 1523   5913.1875
    ## 1524   7458.3963
    ## 1525    859.8087
    ## 1526    925.9083
    ## 1527   1067.5348
    ## 1528   1477.5968
    ## 1529   1649.6602
    ## 1530   1532.7770
    ## 1531   1344.5780
    ## 1532   1202.2014
    ## 1533   1034.2989
    ## 1534    982.2869
    ## 1535    886.2206
    ## 1536    882.9699
    ## 1537   3023.2719
    ## 1538   4100.3934
    ## 1539   4997.5240
    ## 1540   5621.3685
    ## 1541   6619.5514
    ## 1542   7899.5542
    ## 1543   9119.5286
    ## 1544   7388.5978
    ## 1545   7370.9909
    ## 1546   8792.5731
    ## 1547  11460.6002
    ## 1548  18008.5092
    ## 1549   1468.4756
    ## 1550   1395.2325
    ## 1551   1660.3032
    ## 1552   1932.3602
    ## 1553   2753.2860
    ## 1554   3120.8768
    ## 1555   3560.2332
    ## 1556   3810.4193
    ## 1557   4332.7202
    ## 1558   4876.7986
    ## 1559   5722.8957
    ## 1560   7092.9230
    ## 1561   1969.1010
    ## 1562   2218.7543
    ## 1563   2322.8699
    ## 1564   2826.3564
    ## 1565   3450.6964
    ## 1566   4269.1223
    ## 1567   4241.3563
    ## 1568   5089.0437
    ## 1569   5678.3483
    ## 1570   6601.4299
    ## 1571   6508.0857
    ## 1572   8458.2764
    ## 1573    734.7535
    ## 1574    774.3711
    ## 1575    767.2717
    ## 1576    908.9185
    ## 1577    950.7359
    ## 1578    843.7331
    ## 1579    682.2662
    ## 1580    617.7244
    ## 1581    644.1708
    ## 1582    816.5591
    ## 1583    927.7210
    ## 1584   1056.3801
    ## 1585   9979.5085
    ## 1586  11283.1779
    ## 1587  12477.1771
    ## 1588  14142.8509
    ## 1589  15895.1164
    ## 1590  17428.7485
    ## 1591  18232.4245
    ## 1592  21664.7877
    ## 1593  22705.0925
    ## 1594  26074.5314
    ## 1595  29478.9992
    ## 1596  33203.2613
    ## 1597  13990.4821
    ## 1598  14847.1271
    ## 1599  16173.1459
    ## 1600  19530.3656
    ## 1601  21806.0359
    ## 1602  24072.6321
    ## 1603  25009.5591
    ## 1604  29884.3504
    ## 1605  32003.9322
    ## 1606  35767.4330
    ## 1607  39097.0995
    ## 1608  42951.6531
    ## 1609   5716.7667
    ## 1610   6150.7730
    ## 1611   5603.3577
    ## 1612   5444.6196
    ## 1613   5703.4089
    ## 1614   6504.3397
    ## 1615   6920.2231
    ## 1616   7452.3990
    ## 1617   8137.0048
    ## 1618   9230.2407
    ## 1619   7727.0020
    ## 1620  10611.4630
    ## 1621   7689.7998
    ## 1622   9802.4665
    ## 1623   8422.9742
    ## 1624   9541.4742
    ## 1625  10505.2597
    ## 1626  13143.9510
    ## 1627  11152.4101
    ## 1628   9883.5846
    ## 1629  10733.9263
    ## 1630  10165.4952
    ## 1631   8605.0478
    ## 1632  11415.8057
    ## 1633    605.0665
    ## 1634    676.2854
    ## 1635    772.0492
    ## 1636    637.1233
    ## 1637    699.5016
    ## 1638    713.5371
    ## 1639    707.2358
    ## 1640    820.7994
    ## 1641    989.0231
    ## 1642   1385.8968
    ## 1643   1764.4567
    ## 1644   2441.5764
    ## 1645   1515.5923
    ## 1646   1827.0677
    ## 1647   2198.9563
    ## 1648   2649.7150
    ## 1649   3133.4093
    ## 1650   3682.8315
    ## 1651   4336.0321
    ## 1652   5107.1974
    ## 1653   6017.6548
    ## 1654   7110.6676
    ## 1655   4515.4876
    ## 1656   3025.3498
    ## 1657    781.7176
    ## 1658    804.8305
    ## 1659    825.6232
    ## 1660    862.4421
    ## 1661   1265.0470
    ## 1662   1829.7652
    ## 1663   1977.5570
    ## 1664   1971.7415
    ## 1665   1879.4967
    ## 1666   2117.4845
    ## 1667   2234.8208
    ## 1668   2280.7699
    ## 1669   1147.3888
    ## 1670   1311.9568
    ## 1671   1452.7258
    ## 1672   1777.0773
    ## 1673   1773.4983
    ## 1674   1588.6883
    ## 1675   1408.6786
    ## 1676   1213.3151
    ## 1677   1210.8846
    ## 1678   1071.3538
    ## 1679   1071.6139
    ## 1680   1271.2116
    ## 1681    406.8841
    ## 1682    518.7643
    ## 1683    527.2722
    ## 1684    569.7951
    ## 1685    799.3622
    ## 1686    685.5877
    ## 1687    788.8550
    ## 1688    706.1573
    ## 1689    693.4208
    ## 1690    792.4500
    ## 1691    672.0386
    ## 1692    469.7093

To do what we did previously in one single command, using the pipe:

``` r
gap_small_97 <- gapminder %>%
    select(year, country, gdpPercap) %>%
    filter(year == 1997)
```

The pipe operator can be read as "then" and makes the code a lot **more readable** than when nesting functions into each other, and avoids the creation of several intermediate objects.

From now on, we'll use this syntax.

Exercise 4 – Select the 2002 life expectancy observation for Eritrea (and remove the rest of the variables)

``` r
eritrea_2002 <- gapminder %>%
    select(year, country, lifeExp) %>%
    filter(country == "Eritrea", year == 2002)
```

#### Create new variables with `mutate()`

Have a look at what the verb `mutate()` can do with `?mutate`.

Let's see what the two following variables can be used for:

``` r
gapminder %>%
    select(gdpPercap, pop)
```

    ##        gdpPercap        pop
    ## 1       779.4453    8425333
    ## 2       820.8530    9240934
    ## 3       853.1007   10267083
    ## 4       836.1971   11537966
    ## 5       739.9811   13079460
    ## 6       786.1134   14880372
    ## 7       978.0114   12881816
    ## 8       852.3959   13867957
    ## 9       649.3414   16317921
    ## 10      635.3414   22227415
    ## 11      726.7341   25268405
    ## 12      974.5803   31889923
    ## 13     1601.0561    1282697
    ## 14     1942.2842    1476505
    ## 15     2312.8890    1728137
    ## 16     2760.1969    1984060
    ## 17     3313.4222    2263554
    ## 18     3533.0039    2509048
    ## 19     3630.8807    2780097
    ## 20     3738.9327    3075321
    ## 21     2497.4379    3326498
    ## 22     3193.0546    3428038
    ## 23     4604.2117    3508512
    ## 24     5937.0295    3600523
    ## 25     2449.0082    9279525
    ## 26     3013.9760   10270856
    ## 27     2550.8169   11000948
    ## 28     3246.9918   12760499
    ## 29     4182.6638   14760787
    ## 30     4910.4168   17152804
    ## 31     5745.1602   20033753
    ## 32     5681.3585   23254956
    ## 33     5023.2166   26298373
    ## 34     4797.2951   29072015
    ## 35     5288.0404   31287142
    ## 36     6223.3675   33333216
    ## 37     3520.6103    4232095
    ## 38     3827.9405    4561361
    ## 39     4269.2767    4826015
    ## 40     5522.7764    5247469
    ## 41     5473.2880    5894858
    ## 42     3008.6474    6162675
    ## 43     2756.9537    7016384
    ## 44     2430.2083    7874230
    ## 45     2627.8457    8735988
    ## 46     2277.1409    9875024
    ## 47     2773.2873   10866106
    ## 48     4797.2313   12420476
    ## 49     5911.3151   17876956
    ## 50     6856.8562   19610538
    ## 51     7133.1660   21283783
    ## 52     8052.9530   22934225
    ## 53     9443.0385   24779799
    ## 54    10079.0267   26983828
    ## 55     8997.8974   29341374
    ## 56     9139.6714   31620918
    ## 57     9308.4187   33958947
    ## 58    10967.2820   36203463
    ## 59     8797.6407   38331121
    ## 60    12779.3796   40301927
    ## 61    10039.5956    8691212
    ## 62    10949.6496    9712569
    ## 63    12217.2269   10794968
    ## 64    14526.1246   11872264
    ## 65    16788.6295   13177000
    ## 66    18334.1975   14074100
    ## 67    19477.0093   15184200
    ## 68    21888.8890   16257249
    ## 69    23424.7668   17481977
    ## 70    26997.9366   18565243
    ## 71    30687.7547   19546792
    ## 72    34435.3674   20434176
    ## 73     6137.0765    6927772
    ## 74     8842.5980    6965860
    ## 75    10750.7211    7129864
    ## 76    12834.6024    7376998
    ## 77    16661.6256    7544201
    ## 78    19749.4223    7568430
    ## 79    21597.0836    7574613
    ## 80    23687.8261    7578903
    ## 81    27042.0187    7914969
    ## 82    29095.9207    8069876
    ## 83    32417.6077    8148312
    ## 84    36126.4927    8199783
    ## 85     9867.0848     120447
    ## 86    11635.7995     138655
    ## 87    12753.2751     171863
    ## 88    14804.6727     202182
    ## 89    18268.6584     230800
    ## 90    19340.1020     297410
    ## 91    19211.1473     377967
    ## 92    18524.0241     454612
    ## 93    19035.5792     529491
    ## 94    20292.0168     598561
    ## 95    23403.5593     656397
    ## 96    29796.0483     708573
    ## 97      684.2442   46886859
    ## 98      661.6375   51365468
    ## 99      686.3416   56839289
    ## 100     721.1861   62821884
    ## 101     630.2336   70759295
    ## 102     659.8772   80428306
    ## 103     676.9819   93074406
    ## 104     751.9794  103764241
    ## 105     837.8102  113704579
    ## 106     972.7700  123315288
    ## 107    1136.3904  135656790
    ## 108    1391.2538  150448339
    ## 109    8343.1051    8730405
    ## 110    9714.9606    8989111
    ## 111   10991.2068    9218400
    ## 112   13149.0412    9556500
    ## 113   16672.1436    9709100
    ## 114   19117.9745    9821800
    ## 115   20979.8459    9856303
    ## 116   22525.5631    9870200
    ## 117   25575.5707   10045622
    ## 118   27561.1966   10199787
    ## 119   30485.8838   10311970
    ## 120   33692.6051   10392226
    ## 121    1062.7522    1738315
    ## 122     959.6011    1925173
    ## 123     949.4991    2151895
    ## 124    1035.8314    2427334
    ## 125    1085.7969    2761407
    ## 126    1029.1613    3168267
    ## 127    1277.8976    3641603
    ## 128    1225.8560    4243788
    ## 129    1191.2077    4981671
    ## 130    1232.9753    6066080
    ## 131    1372.8779    7026113
    ## 132    1441.2849    8078314
    ## 133    2677.3263    2883315
    ## 134    2127.6863    3211738
    ## 135    2180.9725    3593918
    ## 136    2586.8861    4040665
    ## 137    2980.3313    4565872
    ## 138    3548.0978    5079716
    ## 139    3156.5105    5642224
    ## 140    2753.6915    6156369
    ## 141    2961.6997    6893451
    ## 142    3326.1432    7693188
    ## 143    3413.2627    8445134
    ## 144    3822.1371    9119152
    ## 145     973.5332    2791000
    ## 146    1353.9892    3076000
    ## 147    1709.6837    3349000
    ## 148    2172.3524    3585000
    ## 149    2860.1698    3819000
    ## 150    3528.4813    4086000
    ## 151    4126.6132    4172693
    ## 152    4314.1148    4338977
    ## 153    2546.7814    4256013
    ## 154    4766.3559    3607000
    ## 155    6018.9752    4165416
    ## 156    7446.2988    4552198
    ## 157     851.2411     442308
    ## 158     918.2325     474639
    ## 159     983.6540     512764
    ## 160    1214.7093     553541
    ## 161    2263.6111     619351
    ## 162    3214.8578     781472
    ## 163    4551.1421     970347
    ## 164    6205.8839    1151184
    ## 165    7954.1116    1342614
    ## 166    8647.1423    1536536
    ## 167   11003.6051    1630347
    ## 168   12569.8518    1639131
    ## 169    2108.9444   56602560
    ## 170    2487.3660   65551171
    ## 171    3336.5858   76039390
    ## 172    3429.8644   88049823
    ## 173    4985.7115  100840058
    ## 174    6660.1187  114313951
    ## 175    7030.8359  128962939
    ## 176    7807.0958  142938076
    ## 177    6950.2830  155975974
    ## 178    7957.9808  168546719
    ## 179    8131.2128  179914212
    ## 180    9065.8008  190010647
    ## 181    2444.2866    7274900
    ## 182    3008.6707    7651254
    ## 183    4254.3378    8012946
    ## 184    5577.0028    8310226
    ## 185    6597.4944    8576200
    ## 186    7612.2404    8797022
    ## 187    8224.1916    8892098
    ## 188    8239.8548    8971958
    ## 189    6302.6234    8658506
    ## 190    5970.3888    8066057
    ## 191    7696.7777    7661799
    ## 192   10680.7928    7322858
    ## 193     543.2552    4469979
    ## 194     617.1835    4713416
    ## 195     722.5120    4919632
    ## 196     794.8266    5127935
    ## 197     854.7360    5433886
    ## 198     743.3870    5889574
    ## 199     807.1986    6634596
    ## 200     912.0631    7586551
    ## 201     931.7528    8878303
    ## 202     946.2950   10352843
    ## 203    1037.6452   12251209
    ## 204    1217.0330   14326203
    ## 205     339.2965    2445618
    ## 206     379.5646    2667518
    ## 207     355.2032    2961915
    ## 208     412.9775    3330989
    ## 209     464.0995    3529983
    ## 210     556.1033    3834415
    ## 211     559.6032    4580410
    ## 212     621.8188    5126023
    ## 213     631.6999    5809236
    ## 214     463.1151    6121610
    ## 215     446.4035    7021078
    ## 216     430.0707    8390505
    ## 217     368.4693    4693836
    ## 218     434.0383    5322536
    ## 219     496.9136    6083619
    ## 220     523.4323    6960067
    ## 221     421.6240    7450606
    ## 222     524.9722    6978607
    ## 223     624.4755    7272485
    ## 224     683.8956    8371791
    ## 225     682.3032   10150094
    ## 226     734.2852   11782962
    ## 227     896.2260   12926707
    ## 228    1713.7787   14131858
    ## 229    1172.6677    5009067
    ## 230    1313.0481    5359923
    ## 231    1399.6074    5793633
    ## 232    1508.4531    6335506
    ## 233    1684.1465    7021028
    ## 234    1783.4329    7959865
    ## 235    2367.9833    9250831
    ## 236    2602.6642   10780667
    ## 237    1793.1633   12467171
    ## 238    1694.3375   14195809
    ## 239    1934.0114   15929988
    ## 240    2042.0952   17696293
    ## 241   11367.1611   14785584
    ## 242   12489.9501   17010154
    ## 243   13462.4855   18985849
    ## 244   16076.5880   20819767
    ## 245   18970.5709   22284500
    ## 246   22090.8831   23796400
    ## 247   22898.7921   25201900
    ## 248   26626.5150   26549700
    ## 249   26342.8843   28523502
    ## 250   28954.9259   30305843
    ## 251   33328.9651   31902268
    ## 252   36319.2350   33390141
    ## 253    1071.3107    1291695
    ## 254    1190.8443    1392284
    ## 255    1193.0688    1523478
    ## 256    1136.0566    1733638
    ## 257    1070.0133    1927260
    ## 258    1109.3743    2167533
    ## 259     956.7530    2476971
    ## 260     844.8764    2840009
    ## 261     747.9055    3265124
    ## 262     740.5063    3696513
    ## 263     738.6906    4048013
    ## 264     706.0165    4369038
    ## 265    1178.6659    2682462
    ## 266    1308.4956    2894855
    ## 267    1389.8176    3150417
    ## 268    1196.8106    3495967
    ## 269    1104.1040    3899068
    ## 270    1133.9850    4388260
    ## 271     797.9081    4875118
    ## 272     952.3861    5498955
    ## 273    1058.0643    6429417
    ## 274    1004.9614    7562011
    ## 275    1156.1819    8835739
    ## 276    1704.0637   10238807
    ## 277    3939.9788    6377619
    ## 278    4315.6227    7048426
    ## 279    4519.0943    7961258
    ## 280    5106.6543    8858908
    ## 281    5494.0244    9717524
    ## 282    4756.7638   10599793
    ## 283    5095.6657   11487112
    ## 284    5547.0638   12463354
    ## 285    7596.1260   13572994
    ## 286   10118.0532   14599929
    ## 287   10778.7838   15497046
    ## 288   13171.6388   16284741
    ## 289     400.4486  556263528
    ## 290     575.9870  637408000
    ## 291     487.6740  665770000
    ## 292     612.7057  754550000
    ## 293     676.9001  862030000
    ## 294     741.2375  943455000
    ## 295     962.4214 1000281000
    ## 296    1378.9040 1084035000
    ## 297    1655.7842 1164970000
    ## 298    2289.2341 1230075000
    ## 299    3119.2809 1280400000
    ## 300    4959.1149 1318683096
    ## 301    2144.1151   12350771
    ## 302    2323.8056   14485993
    ## 303    2492.3511   17009885
    ## 304    2678.7298   19764027
    ## 305    3264.6600   22542890
    ## 306    3815.8079   25094412
    ## 307    4397.5757   27764644
    ## 308    4903.2191   30964245
    ## 309    5444.6486   34202721
    ## 310    6117.3617   37657830
    ## 311    5755.2600   41008227
    ## 312    7006.5804   44227550
    ## 313    1102.9909     153936
    ## 314    1211.1485     170928
    ## 315    1406.6483     191689
    ## 316    1876.0296     217378
    ## 317    1937.5777     250027
    ## 318    1172.6030     304739
    ## 319    1267.1001     348643
    ## 320    1315.9808     395114
    ## 321    1246.9074     454429
    ## 322    1173.6182     527982
    ## 323    1075.8116     614382
    ## 324     986.1479     710960
    ## 325     780.5423   14100005
    ## 326     905.8602   15577932
    ## 327     896.3146   17486434
    ## 328     861.5932   19941073
    ## 329     904.8961   23007669
    ## 330     795.7573   26480870
    ## 331     673.7478   30646495
    ## 332     672.7748   35481645
    ## 333     457.7192   41672143
    ## 334     312.1884   47798986
    ## 335     241.1659   55379852
    ## 336     277.5519   64606759
    ## 337    2125.6214     854885
    ## 338    2315.0566     940458
    ## 339    2464.7832    1047924
    ## 340    2677.9396    1179760
    ## 341    3213.1527    1340458
    ## 342    3259.1790    1536769
    ## 343    4879.5075    1774735
    ## 344    4201.1949    2064095
    ## 345    4016.2395    2409073
    ## 346    3484.1644    2800947
    ## 347    3484.0620    3328795
    ## 348    3632.5578    3800610
    ## 349    2627.0095     926317
    ## 350    2990.0108    1112300
    ## 351    3460.9370    1345187
    ## 352    4161.7278    1588717
    ## 353    5118.1469    1834796
    ## 354    5926.8770    2108457
    ## 355    5262.7348    2424367
    ## 356    5629.9153    2799811
    ## 357    6160.4163    3173216
    ## 358    6677.0453    3518107
    ## 359    7723.4472    3834934
    ## 360    9645.0614    4133884
    ## 361    1388.5947    2977019
    ## 362    1500.8959    3300000
    ## 363    1728.8694    3832408
    ## 364    2052.0505    4744870
    ## 365    2378.2011    6071696
    ## 366    2517.7365    7459574
    ## 367    2602.7102    9025951
    ## 368    2156.9561   10761098
    ## 369    1648.0738   12772596
    ## 370    1786.2654   14625967
    ## 371    1648.8008   16252726
    ## 372    1544.7501   18013409
    ## 373    3119.2365    3882229
    ## 374    4338.2316    3991242
    ## 375    5477.8900    4076557
    ## 376    6960.2979    4174366
    ## 377    9164.0901    4225310
    ## 378   11305.3852    4318673
    ## 379   13221.8218    4413368
    ## 380   13822.5839    4484310
    ## 381    8447.7949    4494013
    ## 382    9875.6045    4444595
    ## 383   11628.3890    4481020
    ## 384   14619.2227    4493312
    ## 385    5586.5388    6007797
    ## 386    6092.1744    6640752
    ## 387    5180.7559    7254373
    ## 388    5690.2680    8139332
    ## 389    5305.4453    8831348
    ## 390    6380.4950    9537988
    ## 391    7316.9181    9789224
    ## 392    7532.9248   10239839
    ## 393    5592.8440   10723260
    ## 394    5431.9904   10983007
    ## 395    6340.6467   11226999
    ## 396    8948.1029   11416987
    ## 397    6876.1403    9125183
    ## 398    8256.3439    9513758
    ## 399   10136.8671    9620282
    ## 400   11399.4449    9835109
    ## 401   13108.4536    9862158
    ## 402   14800.1606   10161915
    ## 403   15377.2285   10303704
    ## 404   16310.4434   10311597
    ## 405   14297.0212   10315702
    ## 406   16048.5142   10300707
    ## 407   17596.2102   10256295
    ## 408   22833.3085   10228744
    ## 409    9692.3852    4334000
    ## 410   11099.6593    4487831
    ## 411   13583.3135    4646899
    ## 412   15937.2112    4838800
    ## 413   18866.2072    4991596
    ## 414   20422.9015    5088419
    ## 415   21688.0405    5117810
    ## 416   25116.1758    5127024
    ## 417   26406.7399    5171393
    ## 418   29804.3457    5283663
    ## 419   32166.5001    5374693
    ## 420   35278.4187    5468120
    ## 421    2669.5295      63149
    ## 422    2864.9691      71851
    ## 423    3020.9893      89898
    ## 424    3020.0505     127617
    ## 425    3694.2124     178848
    ## 426    3081.7610     228694
    ## 427    2879.4681     305991
    ## 428    2880.1026     311025
    ## 429    2377.1562     384156
    ## 430    1895.0170     417908
    ## 431    1908.2609     447416
    ## 432    2082.4816     496374
    ## 433    1397.7171    2491346
    ## 434    1544.4030    2923186
    ## 435    1662.1374    3453434
    ## 436    1653.7230    4049146
    ## 437    2189.8745    4671329
    ## 438    2681.9889    5302800
    ## 439    2861.0924    5968349
    ## 440    2899.8422    6655297
    ## 441    3044.2142    7351181
    ## 442    3614.1013    7992357
    ## 443    4563.8082    8650322
    ## 444    6025.3748    9319622
    ## 445    3522.1107    3548753
    ## 446    3780.5467    4058385
    ## 447    4086.1141    4681707
    ## 448    4579.0742    5432424
    ## 449    5280.9947    6298651
    ## 450    6679.6233    7278866
    ## 451    7213.7913    8365850
    ## 452    6481.7770    9545158
    ## 453    7103.7026   10748394
    ## 454    7429.4559   11911819
    ## 455    5773.0445   12921234
    ## 456    6873.2623   13755680
    ## 457    1418.8224   22223309
    ## 458    1458.9153   25009741
    ## 459    1693.3359   28173309
    ## 460    1814.8807   31681188
    ## 461    2024.0081   34807417
    ## 462    2785.4936   38783863
    ## 463    3503.7296   45681811
    ## 464    3885.4607   52799062
    ## 465    3794.7552   59402198
    ## 466    4173.1818   66134291
    ## 467    4754.6044   73312559
    ## 468    5581.1810   80264543
    ## 469    3048.3029    2042865
    ## 470    3421.5232    2355805
    ## 471    3776.8036    2747687
    ## 472    4358.5954    3232927
    ## 473    4520.2460    3790903
    ## 474    5138.9224    4282586
    ## 475    4098.3442    4474873
    ## 476    4140.4421    4842194
    ## 477    4444.2317    5274649
    ## 478    5154.8255    5783439
    ## 479    5351.5687    6353681
    ## 480    5728.3535    6939688
    ## 481     375.6431     216964
    ## 482     426.0964     232922
    ## 483     582.8420     249220
    ## 484     915.5960     259864
    ## 485     672.4123     277603
    ## 486     958.5668     192675
    ## 487     927.8253     285483
    ## 488     966.8968     341244
    ## 489    1132.0550     387838
    ## 490    2814.4808     439971
    ## 491    7703.4959     495627
    ## 492   12154.0897     551201
    ## 493     328.9406    1438760
    ## 494     344.1619    1542611
    ## 495     380.9958    1666618
    ## 496     468.7950    1820319
    ## 497     514.3242    2260187
    ## 498     505.7538    2512642
    ## 499     524.8758    2637297
    ## 500     521.1341    2915959
    ## 501     582.8585    3668440
    ## 502     913.4708    4058319
    ## 503     765.3500    4414865
    ## 504     641.3695    4906585
    ## 505     362.1463   20860941
    ## 506     378.9042   22815614
    ## 507     419.4564   25145372
    ## 508     516.1186   27860297
    ## 509     566.2439   30770372
    ## 510     556.8084   34617799
    ## 511     577.8607   38111756
    ## 512     573.7413   42999530
    ## 513     421.3535   52088559
    ## 514     515.8894   59861301
    ## 515     530.0535   67946797
    ## 516     690.8056   76511887
    ## 517    6424.5191    4090500
    ## 518    7545.4154    4324000
    ## 519    9371.8426    4491443
    ## 520   10921.6363    4605744
    ## 521   14358.8759    4639657
    ## 522   15605.4228    4738902
    ## 523   18533.1576    4826933
    ## 524   21141.0122    4931729
    ## 525   20647.1650    5041039
    ## 526   23723.9502    5134406
    ## 527   28204.5906    5193039
    ## 528   33207.0844    5238460
    ## 529    7029.8093   42459667
    ## 530    8662.8349   44310863
    ## 531   10560.4855   47124000
    ## 532   12999.9177   49569000
    ## 533   16107.1917   51732000
    ## 534   18292.6351   53165019
    ## 535   20293.8975   54433565
    ## 536   22066.4421   55630100
    ## 537   24703.7961   57374179
    ## 538   25889.7849   58623428
    ## 539   28926.0323   59925035
    ## 540   30470.0167   61083916
    ## 541    4293.4765     420702
    ## 542    4976.1981     434904
    ## 543    6631.4592     455661
    ## 544    8358.7620     489004
    ## 545   11401.9484     537977
    ## 546   21745.5733     706367
    ## 547   15113.3619     753874
    ## 548   11864.4084     880397
    ## 549   13522.1575     985739
    ## 550   14722.8419    1126189
    ## 551   12521.7139    1299304
    ## 552   13206.4845    1454867
    ## 553     485.2307     284320
    ## 554     520.9267     323150
    ## 555     599.6503     374020
    ## 556     734.7829     439593
    ## 557     756.0868     517101
    ## 558     884.7553     608274
    ## 559     835.8096     715523
    ## 560     611.6589     848406
    ## 561     665.6244    1025384
    ## 562     653.7302    1235767
    ## 563     660.5856    1457766
    ## 564     752.7497    1688359
    ## 565    7144.1144   69145952
    ## 566   10187.8267   71019069
    ## 567   12902.4629   73739117
    ## 568   14745.6256   76368453
    ## 569   18016.1803   78717088
    ## 570   20512.9212   78160773
    ## 571   22031.5327   78335266
    ## 572   24639.1857   77718298
    ## 573   26505.3032   80597764
    ## 574   27788.8842   82011073
    ## 575   30035.8020   82350671
    ## 576   32170.3744   82400996
    ## 577     911.2989    5581001
    ## 578    1043.5615    6391288
    ## 579    1190.0411    7355248
    ## 580    1125.6972    8490213
    ## 581    1178.2237    9354120
    ## 582     993.2240   10538093
    ## 583     876.0326   11400338
    ## 584     847.0061   14168101
    ## 585     925.0602   16278738
    ## 586    1005.2458   18418288
    ## 587    1111.9846   20550751
    ## 588    1327.6089   22873338
    ## 589    3530.6901    7733250
    ## 590    4916.2999    8096218
    ## 591    6017.1907    8448233
    ## 592    8513.0970    8716441
    ## 593   12724.8296    8888628
    ## 594   14195.5243    9308479
    ## 595   15268.4209    9786480
    ## 596   16120.5284    9974490
    ## 597   17541.4963   10325429
    ## 598   18747.6981   10502372
    ## 599   22514.2548   10603863
    ## 600   27538.4119   10706290
    ## 601    2428.2378    3146381
    ## 602    2617.1560    3640876
    ## 603    2750.3644    4208858
    ## 604    3242.5311    4690773
    ## 605    4031.4083    5149581
    ## 606    4879.9927    5703430
    ## 607    4820.4948    6395630
    ## 608    4246.4860    7326406
    ## 609    4439.4508    8486949
    ## 610    4684.3138    9803875
    ## 611    4858.3475   11178650
    ## 612    5186.0500   12572928
    ## 613     510.1965    2664249
    ## 614     576.2670    2876726
    ## 615     686.3737    3140003
    ## 616     708.7595    3451418
    ## 617     741.6662    3811387
    ## 618     874.6859    4227026
    ## 619     857.2504    4710497
    ## 620     805.5725    5650262
    ## 621     794.3484    6990574
    ## 622     869.4498    8048834
    ## 623     945.5836    8807818
    ## 624     942.6542    9947814
    ## 625     299.8503     580653
    ## 626     431.7905     601095
    ## 627     522.0344     627820
    ## 628     715.5806     601287
    ## 629     820.2246     625361
    ## 630     764.7260     745228
    ## 631     838.1240     825987
    ## 632     736.4154     927524
    ## 633     745.5399    1050938
    ## 634     796.6645    1193708
    ## 635     575.7047    1332459
    ## 636     579.2317    1472041
    ## 637    1840.3669    3201488
    ## 638    1726.8879    3507701
    ## 639    1796.5890    3880130
    ## 640    1452.0577    4318137
    ## 641    1654.4569    4698301
    ## 642    1874.2989    4908554
    ## 643    2011.1595    5198399
    ## 644    1823.0160    5756203
    ## 645    1456.3095    6326682
    ## 646    1341.7269    6913545
    ## 647    1270.3649    7607651
    ## 648    1201.6372    8502814
    ## 649    2194.9262    1517453
    ## 650    2220.4877    1770390
    ## 651    2291.1568    2090162
    ## 652    2538.2694    2500689
    ## 653    2529.8423    2965146
    ## 654    3203.2081    3055235
    ## 655    3121.7608    3669448
    ## 656    3023.0967    4372203
    ## 657    3081.6946    5077347
    ## 658    3160.4549    5867957
    ## 659    3099.7287    6677328
    ## 660    3548.3308    7483763
    ## 661    3054.4212    2125900
    ## 662    3629.0765    2736300
    ## 663    4692.6483    3305200
    ## 664    6197.9628    3722800
    ## 665    8315.9281    4115700
    ## 666   11186.1413    4583700
    ## 667   14560.5305    5264500
    ## 668   20038.4727    5584510
    ## 669   24757.6030    5829696
    ## 670   28377.6322    6495918
    ## 671   30209.0152    6762476
    ## 672   39724.9787    6980412
    ## 673    5263.6738    9504000
    ## 674    6040.1800    9839000
    ## 675    7550.3599   10063000
    ## 676    9326.6447   10223422
    ## 677   10168.6561   10394091
    ## 678   11674.8374   10637171
    ## 679   12545.9907   10705535
    ## 680   12986.4800   10612740
    ## 681   10535.6285   10348684
    ## 682   11712.7768   10244684
    ## 683   14843.9356   10083313
    ## 684   18008.9444    9956108
    ## 685    7267.6884     147962
    ## 686    9244.0014     165110
    ## 687   10350.1591     182053
    ## 688   13319.8957     198676
    ## 689   15798.0636     209275
    ## 690   19654.9625     221823
    ## 691   23269.6075     233997
    ## 692   26923.2063     244676
    ## 693   25144.3920     259012
    ## 694   28061.0997     271192
    ## 695   31163.2020     288030
    ## 696   36180.7892     301931
    ## 697     546.5657  372000000
    ## 698     590.0620  409000000
    ## 699     658.3472  454000000
    ## 700     700.7706  506000000
    ## 701     724.0325  567000000
    ## 702     813.3373  634000000
    ## 703     855.7235  708000000
    ## 704     976.5127  788000000
    ## 705    1164.4068  872000000
    ## 706    1458.8174  959000000
    ## 707    1746.7695 1034172547
    ## 708    2452.2104 1110396331
    ## 709     749.6817   82052000
    ## 710     858.9003   90124000
    ## 711     849.2898   99028000
    ## 712     762.4318  109343000
    ## 713    1111.1079  121282000
    ## 714    1382.7021  136725000
    ## 715    1516.8730  153343000
    ## 716    1748.3570  169276000
    ## 717    2383.1409  184816000
    ## 718    3119.3356  199278000
    ## 719    2873.9129  211060000
    ## 720    3540.6516  223547000
    ## 721    3035.3260   17272000
    ## 722    3290.2576   19792000
    ## 723    4187.3298   22874000
    ## 724    5906.7318   26538000
    ## 725    9613.8186   30614000
    ## 726   11888.5951   35480679
    ## 727    7608.3346   43072751
    ## 728    6642.8814   51889696
    ## 729    7235.6532   60397973
    ## 730    8263.5903   63327987
    ## 731    9240.7620   66907826
    ## 732   11605.7145   69453570
    ## 733    4129.7661    5441766
    ## 734    6229.3336    6248643
    ## 735    8341.7378    7240260
    ## 736    8931.4598    8519282
    ## 737    9576.0376   10061506
    ## 738   14688.2351   11882916
    ## 739   14517.9071   14173318
    ## 740   11643.5727   16543189
    ## 741    3745.6407   17861905
    ## 742    3076.2398   20775703
    ## 743    4390.7173   24001816
    ## 744    4471.0619   27499638
    ## 745    5210.2803    2952156
    ## 746    5599.0779    2878220
    ## 747    6631.5973    2830000
    ## 748    7655.5690    2900100
    ## 749    9530.7729    3024400
    ## 750   11150.9811    3271900
    ## 751   12618.3214    3480000
    ## 752   13872.8665    3539900
    ## 753   17558.8155    3557761
    ## 754   24521.9471    3667233
    ## 755   34077.0494    3879155
    ## 756   40675.9964    4109086
    ## 757    4086.5221    1620914
    ## 758    5385.2785    1944401
    ## 759    7105.6307    2310904
    ## 760    8393.7414    2693585
    ## 761   12786.9322    3095893
    ## 762   13306.6192    3495918
    ## 763   15367.0292    3858421
    ## 764   17122.4799    4203148
    ## 765   18051.5225    4936550
    ## 766   20896.6092    5531387
    ## 767   21905.5951    6029529
    ## 768   25523.2771    6426679
    ## 769    4931.4042   47666000
    ## 770    6248.6562   49182000
    ## 771    8243.5823   50843200
    ## 772   10022.4013   52667100
    ## 773   12269.2738   54365564
    ## 774   14255.9847   56059245
    ## 775   16537.4835   56535636
    ## 776   19207.2348   56729703
    ## 777   22013.6449   56840847
    ## 778   24675.0245   57479469
    ## 779   27968.0982   57926999
    ## 780   28569.7197   58147733
    ## 781    2898.5309    1426095
    ## 782    4756.5258    1535090
    ## 783    5246.1075    1665128
    ## 784    6124.7035    1861096
    ## 785    7433.8893    1997616
    ## 786    6650.1956    2156814
    ## 787    6068.0513    2298309
    ## 788    6351.2375    2326606
    ## 789    7404.9237    2378618
    ## 790    7121.9247    2531311
    ## 791    6994.7749    2664659
    ## 792    7320.8803    2780132
    ## 793    3216.9563   86459025
    ## 794    4317.6944   91563009
    ## 795    6576.6495   95831757
    ## 796    9847.7886  100825279
    ## 797   14778.7864  107188273
    ## 798   16610.3770  113872473
    ## 799   19384.1057  118454974
    ## 800   22375.9419  122091325
    ## 801   26824.8951  124329269
    ## 802   28816.5850  125956499
    ## 803   28604.5919  127065841
    ## 804   31656.0681  127467972
    ## 805    1546.9078     607914
    ## 806    1886.0806     746559
    ## 807    2348.0092     933559
    ## 808    2741.7963    1255058
    ## 809    2110.8563    1613551
    ## 810    2852.3516    1937652
    ## 811    4161.4160    2347031
    ## 812    4448.6799    2820042
    ## 813    3431.5936    3867409
    ## 814    3645.3796    4526235
    ## 815    3844.9172    5307470
    ## 816    4519.4612    6053193
    ## 817     853.5409    6464046
    ## 818     944.4383    7454779
    ## 819     896.9664    8678557
    ## 820    1056.7365   10191512
    ## 821    1222.3600   12044785
    ## 822    1267.6132   14500404
    ## 823    1348.2258   17661452
    ## 824    1361.9369   21198082
    ## 825    1341.9217   25020539
    ## 826    1360.4850   28263827
    ## 827    1287.5147   31386842
    ## 828    1463.2493   35610177
    ## 829    1088.2778    8865488
    ## 830    1571.1347    9411381
    ## 831    1621.6936   10917494
    ## 832    2143.5406   12617009
    ## 833    3701.6215   14781241
    ## 834    4106.3012   16325320
    ## 835    4106.5253   17647518
    ## 836    4106.4923   19067554
    ## 837    3726.0635   20711375
    ## 838    1690.7568   21585105
    ## 839    1646.7582   22215365
    ## 840    1593.0655   23301725
    ## 841    1030.5922   20947571
    ## 842    1487.5935   22611552
    ## 843    1536.3444   26420307
    ## 844    2029.2281   30131000
    ## 845    3030.8767   33505000
    ## 846    4657.2210   36436000
    ## 847    5622.9425   39326000
    ## 848    8533.0888   41622000
    ## 849   12104.2787   43805450
    ## 850   15993.5280   46173816
    ## 851   19233.9882   47969150
    ## 852   23348.1397   49044790
    ## 853  108382.3529     160000
    ## 854  113523.1329     212846
    ## 855   95458.1118     358266
    ## 856   80894.8833     575003
    ## 857  109347.8670     841934
    ## 858   59265.4771    1140357
    ## 859   31354.0357    1497494
    ## 860   28118.4300    1891487
    ## 861   34932.9196    1418095
    ## 862   40300.6200    1765345
    ## 863   35110.1057    2111561
    ## 864   47306.9898    2505559
    ## 865    4834.8041    1439529
    ## 866    6089.7869    1647412
    ## 867    5714.5606    1886848
    ## 868    6006.9830    2186894
    ## 869    7486.3843    2680018
    ## 870    8659.6968    3115787
    ## 871    7640.5195    3086876
    ## 872    5377.0913    3089353
    ## 873    6890.8069    3219994
    ## 874    8754.9639    3430388
    ## 875    9313.9388    3677780
    ## 876   10461.0587    3921278
    ## 877     298.8462     748747
    ## 878     335.9971     813338
    ## 879     411.8006     893143
    ## 880     498.6390     996380
    ## 881     496.5816    1116779
    ## 882     745.3695    1251524
    ## 883     797.2631    1411807
    ## 884     773.9932    1599200
    ## 885     977.4863    1803195
    ## 886    1186.1480    1982823
    ## 887    1275.1846    2046772
    ## 888    1569.3314    2012649
    ## 889     575.5730     863308
    ## 890     620.9700     975950
    ## 891     634.1952    1112796
    ## 892     713.6036    1279406
    ## 893     803.0055    1482628
    ## 894     640.3224    1703617
    ## 895     572.1996    1956875
    ## 896     506.1139    2269414
    ## 897     636.6229    1912974
    ## 898     609.1740    2200725
    ## 899     531.4824    2814651
    ## 900     414.5073    3193942
    ## 901    2387.5481    1019729
    ## 902    3448.2844    1201578
    ## 903    6757.0308    1441863
    ## 904   18772.7517    1759224
    ## 905   21011.4972    2183877
    ## 906   21951.2118    2721783
    ## 907   17364.2754    3344074
    ## 908   11770.5898    3799845
    ## 909    9640.1385    4364501
    ## 910    9467.4461    4759670
    ## 911    9534.6775    5368585
    ## 912   12057.4993    6036914
    ## 913    1443.0117    4762912
    ## 914    1589.2027    5181679
    ## 915    1643.3871    5703324
    ## 916    1634.0473    6334556
    ## 917    1748.5630    7082430
    ## 918    1544.2286    8007166
    ## 919    1302.8787    9171477
    ## 920    1155.4419   10568642
    ## 921    1040.6762   12210395
    ## 922     986.2959   14165114
    ## 923     894.6371   16473477
    ## 924    1044.7701   19167654
    ## 925     369.1651    2917802
    ## 926     416.3698    3221238
    ## 927     427.9011    3628608
    ## 928     495.5148    4147252
    ## 929     584.6220    4730997
    ## 930     663.2237    5637246
    ## 931     632.8039    6502825
    ## 932     635.5174    7824747
    ## 933     563.2000   10014249
    ## 934     692.2758   10419991
    ## 935     665.4231   11824495
    ## 936     759.3499   13327079
    ## 937    1831.1329    6748378
    ## 938    1810.0670    7739235
    ## 939    2036.8849    8906385
    ## 940    2277.7424   10154878
    ## 941    2849.0948   11441462
    ## 942    3827.9216   12845381
    ## 943    4920.3560   14441916
    ## 944    5249.8027   16331785
    ## 945    7277.9128   18319502
    ## 946   10132.9096   20476091
    ## 947   10206.9779   22662365
    ## 948   12451.6558   24821286
    ## 949     452.3370    3838168
    ## 950     490.3822    4241884
    ## 951     496.1743    4690372
    ## 952     545.0099    5212416
    ## 953     581.3689    5828158
    ## 954     686.3953    6491649
    ## 955     618.0141    6998256
    ## 956     684.1716    7634008
    ## 957     739.0144    8416215
    ## 958     790.2580    9384984
    ## 959     951.4098   10580176
    ## 960    1042.5816   12031795
    ## 961     743.1159    1022556
    ## 962     846.1203    1076852
    ## 963    1055.8960    1146757
    ## 964    1421.1452    1230542
    ## 965    1586.8518    1332786
    ## 966    1497.4922    1456688
    ## 967    1481.1502    1622136
    ## 968    1421.6036    1841240
    ## 969    1361.3698    2119465
    ## 970    1483.1361    2444741
    ## 971    1579.0195    2828858
    ## 972    1803.1515    3270065
    ## 973    1967.9557     516556
    ## 974    2034.0380     609816
    ## 975    2529.0675     701016
    ## 976    2475.3876     789309
    ## 977    2575.4842     851334
    ## 978    3710.9830     913025
    ## 979    3688.0377     992040
    ## 980    4783.5869    1042663
    ## 981    6058.2538    1096202
    ## 982    7425.7053    1149818
    ## 983    9021.8159    1200206
    ## 984   10956.9911    1250882
    ## 985    3478.1255   30144317
    ## 986    4131.5466   35015548
    ## 987    4581.6094   41121485
    ## 988    5754.7339   47995559
    ## 989    6809.4067   55984294
    ## 990    7674.9291   63759976
    ## 991    9611.1475   71640904
    ## 992    8688.1560   80122492
    ## 993    9472.3843   88111030
    ## 994    9767.2975   95895146
    ## 995   10742.4405  102479927
    ## 996   11977.5750  108700891
    ## 997     786.5669     800663
    ## 998     912.6626     882134
    ## 999    1056.3540    1010280
    ## 1000   1226.0411    1149500
    ## 1001   1421.7420    1320500
    ## 1002   1647.5117    1528000
    ## 1003   2000.6031    1756032
    ## 1004   2338.0083    2015133
    ## 1005   1785.4020    2312802
    ## 1006   1902.2521    2494803
    ## 1007   2140.7393    2674234
    ## 1008   3095.7723    2874127
    ## 1009   2647.5856     413834
    ## 1010   3682.2599     442829
    ## 1011   4649.5938     474528
    ## 1012   5907.8509     501035
    ## 1013   7778.4140     527678
    ## 1014   9595.9299     560073
    ## 1015  11222.5876     562548
    ## 1016  11732.5102     569473
    ## 1017   7003.3390     621621
    ## 1018   6465.6133     692651
    ## 1019   6557.1943     720230
    ## 1020   9253.8961     684736
    ## 1021   1688.2036    9939217
    ## 1022   1642.0023   11406350
    ## 1023   1566.3535   13056604
    ## 1024   1711.0448   14770296
    ## 1025   1930.1950   16660670
    ## 1026   2370.6200   18396941
    ## 1027   2702.6204   20198730
    ## 1028   2755.0470   22987397
    ## 1029   2948.0473   25798239
    ## 1030   2982.1019   28529501
    ## 1031   3258.4956   31167783
    ## 1032   3820.1752   33757175
    ## 1033    468.5260    6446316
    ## 1034    495.5868    7038035
    ## 1035    556.6864    7788944
    ## 1036    566.6692    8680909
    ## 1037    724.9178    9809596
    ## 1038    502.3197   11127868
    ## 1039    462.2114   12587223
    ## 1040    389.8762   12891952
    ## 1041    410.8968   13160731
    ## 1042    472.3461   16603334
    ## 1043    633.6179   18473780
    ## 1044    823.6856   19951656
    ## 1045    331.0000   20092996
    ## 1046    350.0000   21731844
    ## 1047    388.0000   23634436
    ## 1048    349.0000   25870271
    ## 1049    357.0000   28466390
    ## 1050    371.0000   31528087
    ## 1051    424.0000   34680442
    ## 1052    385.0000   38028578
    ## 1053    347.0000   40546538
    ## 1054    415.0000   43247867
    ## 1055    611.0000   45598081
    ## 1056    944.0000   47761980
    ## 1057   2423.7804     485831
    ## 1058   2621.4481     548080
    ## 1059   3173.2156     621392
    ## 1060   3793.6948     706640
    ## 1061   3746.0809     821782
    ## 1062   3876.4860     977026
    ## 1063   4191.1005    1099010
    ## 1064   3693.7313    1278184
    ## 1065   3804.5380    1554253
    ## 1066   3899.5243    1774766
    ## 1067   4072.3248    1972153
    ## 1068   4811.0604    2055080
    ## 1069    545.8657    9182536
    ## 1070    597.9364    9682338
    ## 1071    652.3969   10332057
    ## 1072    676.4422   11261690
    ## 1073    674.7881   12412593
    ## 1074    694.1124   13933198
    ## 1075    718.3731   15796314
    ## 1076    775.6325   17917180
    ## 1077    897.7404   20326209
    ## 1078   1010.8921   23001113
    ## 1079   1057.2063   25873917
    ## 1080   1091.3598   28901790
    ## 1081   8941.5719   10381988
    ## 1082  11276.1934   11026383
    ## 1083  12790.8496   11805689
    ## 1084  15363.2514   12596822
    ## 1085  18794.7457   13329874
    ## 1086  21209.0592   13852989
    ## 1087  21399.4605   14310401
    ## 1088  23651.3236   14665278
    ## 1089  26790.9496   15174244
    ## 1090  30246.1306   15604464
    ## 1091  33724.7578   16122830
    ## 1092  36797.9333   16570613
    ## 1093  10556.5757    1994794
    ## 1094  12247.3953    2229407
    ## 1095  13175.6780    2488550
    ## 1096  14463.9189    2728150
    ## 1097  16046.0373    2929100
    ## 1098  16233.7177    3164900
    ## 1099  17632.4104    3210650
    ## 1100  19007.1913    3317166
    ## 1101  18363.3249    3437674
    ## 1102  21050.4138    3676187
    ## 1103  23189.8014    3908037
    ## 1104  25185.0091    4115771
    ## 1105   3112.3639    1165790
    ## 1106   3457.4159    1358828
    ## 1107   3634.3644    1590597
    ## 1108   4643.3935    1865490
    ## 1109   4688.5933    2182908
    ## 1110   5486.3711    2554598
    ## 1111   3470.3382    2979423
    ## 1112   2955.9844    3344353
    ## 1113   2170.1517    4017939
    ## 1114   2253.0230    4609572
    ## 1115   2474.5488    5146848
    ## 1116   2749.3210    5675356
    ## 1117    761.8794    3379468
    ## 1118    835.5234    3692184
    ## 1119    997.7661    4076008
    ## 1120   1054.3849    4534062
    ## 1121    954.2092    5060262
    ## 1122    808.8971    5682086
    ## 1123    909.7221    6437188
    ## 1124    668.3000    7332638
    ## 1125    581.1827    8392818
    ## 1126    580.3052    9666252
    ## 1127    601.0745   11140655
    ## 1128    619.6769   12894865
    ## 1129   1077.2819   33119096
    ## 1130   1100.5926   37173340
    ## 1131   1150.9275   41871351
    ## 1132   1014.5141   47287752
    ## 1133   1698.3888   53740085
    ## 1134   1981.9518   62209173
    ## 1135   1576.9738   73039376
    ## 1136   1385.0296   81551520
    ## 1137   1619.8482   93364244
    ## 1138   1624.9413  106207839
    ## 1139   1615.2864  119901274
    ## 1140   2013.9773  135031164
    ## 1141  10095.4217    3327728
    ## 1142  11653.9730    3491938
    ## 1143  13450.4015    3638919
    ## 1144  16361.8765    3786019
    ## 1145  18965.0555    3933004
    ## 1146  23311.3494    4043205
    ## 1147  26298.6353    4114787
    ## 1148  31540.9748    4186147
    ## 1149  33965.6611    4286357
    ## 1150  41283.1643    4405672
    ## 1151  44683.9753    4535591
    ## 1152  49357.1902    4627926
    ## 1153   1828.2303     507833
    ## 1154   2242.7466     561977
    ## 1155   2924.6381     628164
    ## 1156   4720.9427     714775
    ## 1157  10618.0385     829050
    ## 1158  11848.3439    1004533
    ## 1159  12954.7910    1301048
    ## 1160  18115.2231    1593882
    ## 1161  18616.7069    1915208
    ## 1162  19702.0558    2283635
    ## 1163  19774.8369    2713462
    ## 1164  22316.1929    3204897
    ## 1165    684.5971   41346560
    ## 1166    747.0835   46679944
    ## 1167    803.3427   53100671
    ## 1168    942.4083   60641899
    ## 1169   1049.9390   69325921
    ## 1170   1175.9212   78152686
    ## 1171   1443.4298   91462088
    ## 1172   1704.6866  105186881
    ## 1173   1971.8295  120065004
    ## 1174   2049.3505  135564834
    ## 1175   2092.7124  153403524
    ## 1176   2605.9476  169270617
    ## 1177   2480.3803     940080
    ## 1178   2961.8009    1063506
    ## 1179   3536.5403    1215725
    ## 1180   4421.0091    1405486
    ## 1181   5364.2497    1616384
    ## 1182   5351.9121    1839782
    ## 1183   7009.6016    2036305
    ## 1184   7034.7792    2253639
    ## 1185   6618.7431    2484997
    ## 1186   7113.6923    2734531
    ## 1187   7356.0319    2990875
    ## 1188   9809.1856    3242173
    ## 1189   1952.3087    1555876
    ## 1190   2046.1547    1770902
    ## 1191   2148.0271    2009813
    ## 1192   2299.3763    2287985
    ## 1193   2523.3380    2614104
    ## 1194   3248.3733    2984494
    ## 1195   4258.5036    3366439
    ## 1196   3998.8757    3886512
    ## 1197   4196.4111    4483945
    ## 1198   4247.4003    5154123
    ## 1199   3783.6742    5884491
    ## 1200   4172.8385    6667147
    ## 1201   3758.5234    8025700
    ## 1202   4245.2567    9146100
    ## 1203   4957.0380   10516500
    ## 1204   5788.0933   12132200
    ## 1205   5937.8273   13954700
    ## 1206   6281.2909   15990099
    ## 1207   6434.5018   18125129
    ## 1208   6360.9434   20195924
    ## 1209   4446.3809   22430449
    ## 1210   5838.3477   24748122
    ## 1211   5909.0201   26769436
    ## 1212   7408.9056   28674757
    ## 1213   1272.8810   22438691
    ## 1214   1547.9448   26072194
    ## 1215   1649.5522   30325264
    ## 1216   1814.1274   35356600
    ## 1217   1989.3741   40850141
    ## 1218   2373.2043   46850962
    ## 1219   2603.2738   53456774
    ## 1220   2189.6350   60017788
    ## 1221   2279.3240   67185766
    ## 1222   2536.5349   75012988
    ## 1223   2650.9211   82995088
    ## 1224   3190.4810   91077287
    ## 1225   4029.3297   25730551
    ## 1226   4734.2530   28235346
    ## 1227   5338.7521   30329617
    ## 1228   6557.1528   31785378
    ## 1229   8006.5070   33039545
    ## 1230   9508.1415   34621254
    ## 1231   8451.5310   36227381
    ## 1232   9082.3512   37740710
    ## 1233   7738.8812   38370697
    ## 1234  10159.5837   38654957
    ## 1235  12002.2391   38625976
    ## 1236  15389.9247   38518241
    ## 1237   3068.3199    8526050
    ## 1238   3774.5717    8817650
    ## 1239   4727.9549    9019800
    ## 1240   6361.5180    9103000
    ## 1241   9022.2474    8970450
    ## 1242  10172.4857    9662600
    ## 1243  11753.8429    9859650
    ## 1244  13039.3088    9915289
    ## 1245  16207.2666    9927680
    ## 1246  17641.0316   10156415
    ## 1247  19970.9079   10433867
    ## 1248  20509.6478   10642836
    ## 1249   3081.9598    2227000
    ## 1250   3907.1562    2260000
    ## 1251   5108.3446    2448046
    ## 1252   6929.2777    2648961
    ## 1253   9123.0417    2847132
    ## 1254   9770.5249    3080828
    ## 1255  10330.9891    3279001
    ## 1256  12281.3419    3444468
    ## 1257  14641.5871    3585176
    ## 1258  16999.4333    3759430
    ## 1259  18855.6062    3859606
    ## 1260  19328.7090    3942491
    ## 1261   2718.8853     257700
    ## 1262   2769.4518     308700
    ## 1263   3173.7233     358900
    ## 1264   4021.1757     414024
    ## 1265   5047.6586     461633
    ## 1266   4319.8041     492095
    ## 1267   5267.2194     517810
    ## 1268   5303.3775     562035
    ## 1269   6101.2558     622191
    ## 1270   6071.9414     684810
    ## 1271   6316.1652     743981
    ## 1272   7670.1226     798094
    ## 1273   3144.6132   16630000
    ## 1274   3943.3702   17829327
    ## 1275   4734.9976   18680721
    ## 1276   6470.8665   19284814
    ## 1277   8011.4144   20662648
    ## 1278   9356.3972   21658597
    ## 1279   9605.3141   22356726
    ## 1280   9696.2733   22686371
    ## 1281   6598.4099   22797027
    ## 1282   7346.5476   22562458
    ## 1283   7885.3601   22404337
    ## 1284  10808.4756   22276056
    ## 1285    493.3239    2534927
    ## 1286    540.2894    2822082
    ## 1287    597.4731    3051242
    ## 1288    510.9637    3451079
    ## 1289    590.5807    3992121
    ## 1290    670.0806    4657072
    ## 1291    881.5706    5507565
    ## 1292    847.9912    6349365
    ## 1293    737.0686    7290203
    ## 1294    589.9445    7212583
    ## 1295    785.6538    7852401
    ## 1296    863.0885    8860588
    ## 1297    879.5836      60011
    ## 1298    860.7369      61325
    ## 1299   1071.5511      65345
    ## 1300   1384.8406      70787
    ## 1301   1532.9853      76595
    ## 1302   1737.5617      86796
    ## 1303   1890.2181      98593
    ## 1304   1516.5255     110812
    ## 1305   1428.7778     125911
    ## 1306   1339.0760     145608
    ## 1307   1353.0924     170372
    ## 1308   1598.4351     199579
    ## 1309   6459.5548    4005677
    ## 1310   8157.5912    4419650
    ## 1311  11626.4197    4943029
    ## 1312  16903.0489    5618198
    ## 1313  24837.4287    6472756
    ## 1314  34167.7626    8128505
    ## 1315  33693.1753   11254672
    ## 1316  21198.2614   14619745
    ## 1317  24841.6178   16945857
    ## 1318  20586.6902   21229759
    ## 1319  19014.5412   24501530
    ## 1320  21654.8319   27601038
    ## 1321   1450.3570    2755589
    ## 1322   1567.6530    3054547
    ## 1323   1654.9887    3430243
    ## 1324   1612.4046    3965841
    ## 1325   1597.7121    4588696
    ## 1326   1561.7691    5260855
    ## 1327   1518.4800    6147783
    ## 1328   1441.7207    7171347
    ## 1329   1367.8994    8307920
    ## 1330   1392.3683    9535314
    ## 1331   1519.6353   10870037
    ## 1332   1712.4721   12267493
    ## 1333   3581.4594    6860147
    ## 1334   4981.0909    7271135
    ## 1335   6289.6292    7616060
    ## 1336   7991.7071    7971222
    ## 1337  10522.0675    8313288
    ## 1338  12980.6696    8686367
    ## 1339  15181.0927    9032824
    ## 1340  15870.8785    9230783
    ## 1341   9325.0682    9826397
    ## 1342   7914.3203   10336594
    ## 1343   7236.0753   10111559
    ## 1344   9786.5347   10150265
    ## 1345    879.7877    2143249
    ## 1346   1004.4844    2295678
    ## 1347   1116.6399    2467895
    ## 1348   1206.0435    2662190
    ## 1349   1353.7598    2879013
    ## 1350   1348.2852    3140897
    ## 1351   1465.0108    3464522
    ## 1352   1294.4478    3868905
    ## 1353   1068.6963    4260884
    ## 1354    574.6482    4578212
    ## 1355    699.4897    5359092
    ## 1356    862.5408    6144562
    ## 1357   2315.1382    1127000
    ## 1358   2843.1044    1445929
    ## 1359   3674.7356    1750200
    ## 1360   4977.4185    1977600
    ## 1361   8597.7562    2152400
    ## 1362  11210.0895    2325300
    ## 1363  15169.1611    2651869
    ## 1364  18861.5308    2794552
    ## 1365  24769.8912    3235865
    ## 1366  33519.4766    3802309
    ## 1367  36023.1054    4197776
    ## 1368  47143.1796    4553009
    ## 1369   5074.6591    3558137
    ## 1370   6093.2630    3844277
    ## 1371   7481.1076    4237384
    ## 1372   8412.9024    4442238
    ## 1373   9674.1676    4593433
    ## 1374  10922.6640    4827803
    ## 1375  11348.5459    5048043
    ## 1376  12037.2676    5199318
    ## 1377   9498.4677    5302888
    ## 1378  12126.2306    5383010
    ## 1379  13638.7784    5410052
    ## 1380  18678.3144    5447502
    ## 1381   4215.0417    1489518
    ## 1382   5862.2766    1533070
    ## 1383   7402.3034    1582962
    ## 1384   9405.4894    1646912
    ## 1385  12383.4862    1694510
    ## 1386  15277.0302    1746919
    ## 1387  17866.7218    1861252
    ## 1388  18678.5349    1945870
    ## 1389  14214.7168    1999210
    ## 1390  17161.1073    2011612
    ## 1391  20660.0194    2011497
    ## 1392  25768.2576    2009245
    ## 1393   1135.7498    2526994
    ## 1394   1258.1474    2780415
    ## 1395   1369.4883    3080153
    ## 1396   1284.7332    3428839
    ## 1397   1254.5761    3840161
    ## 1398   1450.9925    4353666
    ## 1399   1176.8070    5828892
    ## 1400   1093.2450    6921858
    ## 1401    926.9603    6099799
    ## 1402    930.5964    6633514
    ## 1403    882.0818    7753310
    ## 1404    926.1411    9118773
    ## 1405   4725.2955   14264935
    ## 1406   5487.1042   16151549
    ## 1407   5768.7297   18356657
    ## 1408   7114.4780   20997321
    ## 1409   7765.9626   23935810
    ## 1410   8028.6514   27129932
    ## 1411   8568.2662   31140029
    ## 1412   7825.8234   35933379
    ## 1413   7225.0693   39964159
    ## 1414   7479.1882   42835005
    ## 1415   7710.9464   44433622
    ## 1416   9269.6578   43997828
    ## 1417   3834.0347   28549870
    ## 1418   4564.8024   29841614
    ## 1419   5693.8439   31158061
    ## 1420   7993.5123   32850275
    ## 1421  10638.7513   34513161
    ## 1422  13236.9212   36439000
    ## 1423  13926.1700   37983310
    ## 1424  15764.9831   38880702
    ## 1425  18603.0645   39549438
    ## 1426  20445.2990   39855442
    ## 1427  24835.4717   40152517
    ## 1428  28821.0637   40448191
    ## 1429   1083.5320    7982342
    ## 1430   1072.5466    9128546
    ## 1431   1074.4720   10421936
    ## 1432   1135.5143   11737396
    ## 1433   1213.3955   13016733
    ## 1434   1348.7757   14116836
    ## 1435   1648.0798   15410151
    ## 1436   1876.7668   16495304
    ## 1437   2153.7392   17587060
    ## 1438   2664.4773   18698655
    ## 1439   3015.3788   19576783
    ## 1440   3970.0954   20378239
    ## 1441   1615.9911    8504667
    ## 1442   1770.3371    9753392
    ## 1443   1959.5938   11183227
    ## 1444   1687.9976   12716129
    ## 1445   1659.6528   14597019
    ## 1446   2202.9884   17104986
    ## 1447   1895.5441   20367053
    ## 1448   1507.8192   24725960
    ## 1449   1492.1970   28227588
    ## 1450   1632.2108   32160729
    ## 1451   1993.3983   37090298
    ## 1452   2602.3950   42292929
    ## 1453   1148.3766     290243
    ## 1454   1244.7084     326741
    ## 1455   1856.1821     370006
    ## 1456   2613.1017     420690
    ## 1457   3364.8366     480105
    ## 1458   3781.4106     551425
    ## 1459   3895.3840     649901
    ## 1460   3984.8398     779348
    ## 1461   3553.0224     962344
    ## 1462   3876.7685    1054486
    ## 1463   4128.1169    1130269
    ## 1464   4513.4806    1133066
    ## 1465   8527.8447    7124673
    ## 1466   9911.8782    7363802
    ## 1467  12329.4419    7561588
    ## 1468  15258.2970    7867931
    ## 1469  17832.0246    8122293
    ## 1470  18855.7252    8251648
    ## 1471  20667.3812    8325260
    ## 1472  23586.9293    8421403
    ## 1473  23880.0168    8718867
    ## 1474  25266.5950    8897619
    ## 1475  29341.6309    8954175
    ## 1476  33859.7484    9031088
    ## 1477  14734.2327    4815000
    ## 1478  17909.4897    5126000
    ## 1479  20431.0927    5666000
    ## 1480  22966.1443    6063000
    ## 1481  27195.1130    6401400
    ## 1482  26982.2905    6316424
    ## 1483  28397.7151    6468126
    ## 1484  30281.7046    6649942
    ## 1485  31871.5303    6995447
    ## 1486  32135.3230    7193761
    ## 1487  34480.9577    7361757
    ## 1488  37506.4191    7554661
    ## 1489   1643.4854    3661549
    ## 1490   2117.2349    4149908
    ## 1491   2193.0371    4834621
    ## 1492   1881.9236    5680812
    ## 1493   2571.4230    6701172
    ## 1494   3195.4846    7932503
    ## 1495   3761.8377    9410494
    ## 1496   3116.7743   11242847
    ## 1497   3340.5428   13219062
    ## 1498   4014.2390   15081016
    ## 1499   4090.9253   17155814
    ## 1500   4184.5481   19314747
    ## 1501   1206.9479    8550362
    ## 1502   1507.8613   10164215
    ## 1503   1822.8790   11918938
    ## 1504   2643.8587   13648692
    ## 1505   4062.5239   15226039
    ## 1506   5596.5198   16785196
    ## 1507   7426.3548   18501390
    ## 1508  11054.5618   19757799
    ## 1509  15215.6579   20686918
    ## 1510  20206.8210   21628605
    ## 1511  23235.4233   22454239
    ## 1512  28718.2768   23174294
    ## 1513    716.6501    8322925
    ## 1514    698.5356    9452826
    ## 1515    722.0038   10863958
    ## 1516    848.2187   12607312
    ## 1517    915.9851   14706593
    ## 1518    962.4923   17129565
    ## 1519    874.2426   19844382
    ## 1520    831.8221   23040630
    ## 1521    825.6825   26605473
    ## 1522    789.1862   30686889
    ## 1523    899.0742   34593779
    ## 1524   1107.4822   38139640
    ## 1525    757.7974   21289402
    ## 1526    793.5774   25041917
    ## 1527   1002.1992   29263397
    ## 1528   1295.4607   34024249
    ## 1529   1524.3589   39276153
    ## 1530   1961.2246   44148285
    ## 1531   2393.2198   48827160
    ## 1532   2982.6538   52910342
    ## 1533   4616.8965   56667095
    ## 1534   5852.6255   60216677
    ## 1535   5913.1875   62806748
    ## 1536   7458.3963   65068149
    ## 1537    859.8087    1219113
    ## 1538    925.9083    1357445
    ## 1539   1067.5348    1528098
    ## 1540   1477.5968    1735550
    ## 1541   1649.6602    2056351
    ## 1542   1532.7770    2308582
    ## 1543   1344.5780    2644765
    ## 1544   1202.2014    3154264
    ## 1545   1034.2989    3747553
    ## 1546    982.2869    4320890
    ## 1547    886.2206    4977378
    ## 1548    882.9699    5701579
    ## 1549   3023.2719     662850
    ## 1550   4100.3934     764900
    ## 1551   4997.5240     887498
    ## 1552   5621.3685     960155
    ## 1553   6619.5514     975199
    ## 1554   7899.5542    1039009
    ## 1555   9119.5286    1116479
    ## 1556   7388.5978    1191336
    ## 1557   7370.9909    1183669
    ## 1558   8792.5731    1138101
    ## 1559  11460.6002    1101832
    ## 1560  18008.5092    1056608
    ## 1561   1468.4756    3647735
    ## 1562   1395.2325    3950849
    ## 1563   1660.3032    4286552
    ## 1564   1932.3602    4786986
    ## 1565   2753.2860    5303507
    ## 1566   3120.8768    6005061
    ## 1567   3560.2332    6734098
    ## 1568   3810.4193    7724976
    ## 1569   4332.7202    8523077
    ## 1570   4876.7986    9231669
    ## 1571   5722.8957    9770575
    ## 1572   7092.9230   10276158
    ## 1573   1969.1010   22235677
    ## 1574   2218.7543   25670939
    ## 1575   2322.8699   29788695
    ## 1576   2826.3564   33411317
    ## 1577   3450.6964   37492953
    ## 1578   4269.1223   42404033
    ## 1579   4241.3563   47328791
    ## 1580   5089.0437   52881328
    ## 1581   5678.3483   58179144
    ## 1582   6601.4299   63047647
    ## 1583   6508.0857   67308928
    ## 1584   8458.2764   71158647
    ## 1585    734.7535    5824797
    ## 1586    774.3711    6675501
    ## 1587    767.2717    7688797
    ## 1588    908.9185    8900294
    ## 1589    950.7359   10190285
    ## 1590    843.7331   11457758
    ## 1591    682.2662   12939400
    ## 1592    617.7244   15283050
    ## 1593    644.1708   18252190
    ## 1594    816.5591   21210254
    ## 1595    927.7210   24739869
    ## 1596   1056.3801   29170398
    ## 1597   9979.5085   50430000
    ## 1598  11283.1779   51430000
    ## 1599  12477.1771   53292000
    ## 1600  14142.8509   54959000
    ## 1601  15895.1164   56079000
    ## 1602  17428.7485   56179000
    ## 1603  18232.4245   56339704
    ## 1604  21664.7877   56981620
    ## 1605  22705.0925   57866349
    ## 1606  26074.5314   58808266
    ## 1607  29478.9992   59912431
    ## 1608  33203.2613   60776238
    ## 1609  13990.4821  157553000
    ## 1610  14847.1271  171984000
    ## 1611  16173.1459  186538000
    ## 1612  19530.3656  198712000
    ## 1613  21806.0359  209896000
    ## 1614  24072.6321  220239000
    ## 1615  25009.5591  232187835
    ## 1616  29884.3504  242803533
    ## 1617  32003.9322  256894189
    ## 1618  35767.4330  272911760
    ## 1619  39097.0995  287675526
    ## 1620  42951.6531  301139947
    ## 1621   5716.7667    2252965
    ## 1622   6150.7730    2424959
    ## 1623   5603.3577    2598466
    ## 1624   5444.6196    2748579
    ## 1625   5703.4089    2829526
    ## 1626   6504.3397    2873520
    ## 1627   6920.2231    2953997
    ## 1628   7452.3990    3045153
    ## 1629   8137.0048    3149262
    ## 1630   9230.2407    3262838
    ## 1631   7727.0020    3363085
    ## 1632  10611.4630    3447496
    ## 1633   7689.7998    5439568
    ## 1634   9802.4665    6702668
    ## 1635   8422.9742    8143375
    ## 1636   9541.4742    9709552
    ## 1637  10505.2597   11515649
    ## 1638  13143.9510   13503563
    ## 1639  11152.4101   15620766
    ## 1640   9883.5846   17910182
    ## 1641  10733.9263   20265563
    ## 1642  10165.4952   22374398
    ## 1643   8605.0478   24287670
    ## 1644  11415.8057   26084662
    ## 1645    605.0665   26246839
    ## 1646    676.2854   28998543
    ## 1647    772.0492   33796140
    ## 1648    637.1233   39463910
    ## 1649    699.5016   44655014
    ## 1650    713.5371   50533506
    ## 1651    707.2358   56142181
    ## 1652    820.7994   62826491
    ## 1653    989.0231   69940728
    ## 1654   1385.8968   76048996
    ## 1655   1764.4567   80908147
    ## 1656   2441.5764   85262356
    ## 1657   1515.5923    1030585
    ## 1658   1827.0677    1070439
    ## 1659   2198.9563    1133134
    ## 1660   2649.7150    1142636
    ## 1661   3133.4093    1089572
    ## 1662   3682.8315    1261091
    ## 1663   4336.0321    1425876
    ## 1664   5107.1974    1691210
    ## 1665   6017.6548    2104779
    ## 1666   7110.6676    2826046
    ## 1667   4515.4876    3389578
    ## 1668   3025.3498    4018332
    ## 1669    781.7176    4963829
    ## 1670    804.8305    5498090
    ## 1671    825.6232    6120081
    ## 1672    862.4421    6740785
    ## 1673   1265.0470    7407075
    ## 1674   1829.7652    8403990
    ## 1675   1977.5570    9657618
    ## 1676   1971.7415   11219340
    ## 1677   1879.4967   13367997
    ## 1678   2117.4845   15826497
    ## 1679   2234.8208   18701257
    ## 1680   2280.7699   22211743
    ## 1681   1147.3888    2672000
    ## 1682   1311.9568    3016000
    ## 1683   1452.7258    3421000
    ## 1684   1777.0773    3900000
    ## 1685   1773.4983    4506497
    ## 1686   1588.6883    5216550
    ## 1687   1408.6786    6100407
    ## 1688   1213.3151    7272406
    ## 1689   1210.8846    8381163
    ## 1690   1071.3538    9417789
    ## 1691   1071.6139   10595811
    ## 1692   1271.2116   11746035
    ## 1693    406.8841    3080907
    ## 1694    518.7643    3646340
    ## 1695    527.2722    4277736
    ## 1696    569.7951    4995432
    ## 1697    799.3622    5861135
    ## 1698    685.5877    6642107
    ## 1699    788.8550    7636524
    ## 1700    706.1573    9216418
    ## 1701    693.4208   10704340
    ## 1702    792.4500   11404948
    ## 1703    672.0386   11926563
    ## 1704    469.7093   12311143

Exercise 5 – use `mutate()` to create a `gdp` variable

Name your new dataset `gap_gdp`. When finished, `dim(gap_gdp)` should result in `1704 7`.

Hint: use the `*` operator within `mutate()`.

``` r
gap_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop)
dim(gap_gdp)
```

    ## [1] 1704    7

``` r
head(gap_gdp)
```

    ##       country year      pop continent lifeExp gdpPercap         gdp
    ## 1 Afghanistan 1952  8425333      Asia  28.801  779.4453  6567086330
    ## 2 Afghanistan 1957  9240934      Asia  30.332  820.8530  7585448670
    ## 3 Afghanistan 1962 10267083      Asia  31.997  853.1007  8758855797
    ## 4 Afghanistan 1967 11537966      Asia  34.020  836.1971  9648014150
    ## 5 Afghanistan 1972 13079460      Asia  36.088  739.9811  9678553274
    ## 6 Afghanistan 1977 14880372      Asia  38.438  786.1134 11697659231

Reuse a variable computed by 'mutate()' straight away:

``` r
(gap_gdp <- gapminder %>%
    mutate(gdp = gdpPercap * pop, gdpMil = gdp / 10^6))
```

    ##                       country year        pop continent  lifeExp
    ## 1                 Afghanistan 1952    8425333      Asia 28.80100
    ## 2                 Afghanistan 1957    9240934      Asia 30.33200
    ## 3                 Afghanistan 1962   10267083      Asia 31.99700
    ## 4                 Afghanistan 1967   11537966      Asia 34.02000
    ## 5                 Afghanistan 1972   13079460      Asia 36.08800
    ## 6                 Afghanistan 1977   14880372      Asia 38.43800
    ## 7                 Afghanistan 1982   12881816      Asia 39.85400
    ## 8                 Afghanistan 1987   13867957      Asia 40.82200
    ## 9                 Afghanistan 1992   16317921      Asia 41.67400
    ## 10                Afghanistan 1997   22227415      Asia 41.76300
    ## 11                Afghanistan 2002   25268405      Asia 42.12900
    ## 12                Afghanistan 2007   31889923      Asia 43.82800
    ## 13                    Albania 1952    1282697    Europe 55.23000
    ## 14                    Albania 1957    1476505    Europe 59.28000
    ## 15                    Albania 1962    1728137    Europe 64.82000
    ## 16                    Albania 1967    1984060    Europe 66.22000
    ## 17                    Albania 1972    2263554    Europe 67.69000
    ## 18                    Albania 1977    2509048    Europe 68.93000
    ## 19                    Albania 1982    2780097    Europe 70.42000
    ## 20                    Albania 1987    3075321    Europe 72.00000
    ## 21                    Albania 1992    3326498    Europe 71.58100
    ## 22                    Albania 1997    3428038    Europe 72.95000
    ## 23                    Albania 2002    3508512    Europe 75.65100
    ## 24                    Albania 2007    3600523    Europe 76.42300
    ## 25                    Algeria 1952    9279525    Africa 43.07700
    ## 26                    Algeria 1957   10270856    Africa 45.68500
    ## 27                    Algeria 1962   11000948    Africa 48.30300
    ## 28                    Algeria 1967   12760499    Africa 51.40700
    ## 29                    Algeria 1972   14760787    Africa 54.51800
    ## 30                    Algeria 1977   17152804    Africa 58.01400
    ## 31                    Algeria 1982   20033753    Africa 61.36800
    ## 32                    Algeria 1987   23254956    Africa 65.79900
    ## 33                    Algeria 1992   26298373    Africa 67.74400
    ## 34                    Algeria 1997   29072015    Africa 69.15200
    ## 35                    Algeria 2002   31287142    Africa 70.99400
    ## 36                    Algeria 2007   33333216    Africa 72.30100
    ## 37                     Angola 1952    4232095    Africa 30.01500
    ## 38                     Angola 1957    4561361    Africa 31.99900
    ## 39                     Angola 1962    4826015    Africa 34.00000
    ## 40                     Angola 1967    5247469    Africa 35.98500
    ## 41                     Angola 1972    5894858    Africa 37.92800
    ## 42                     Angola 1977    6162675    Africa 39.48300
    ## 43                     Angola 1982    7016384    Africa 39.94200
    ## 44                     Angola 1987    7874230    Africa 39.90600
    ## 45                     Angola 1992    8735988    Africa 40.64700
    ## 46                     Angola 1997    9875024    Africa 40.96300
    ## 47                     Angola 2002   10866106    Africa 41.00300
    ## 48                     Angola 2007   12420476    Africa 42.73100
    ## 49                  Argentina 1952   17876956  Americas 62.48500
    ## 50                  Argentina 1957   19610538  Americas 64.39900
    ## 51                  Argentina 1962   21283783  Americas 65.14200
    ## 52                  Argentina 1967   22934225  Americas 65.63400
    ## 53                  Argentina 1972   24779799  Americas 67.06500
    ## 54                  Argentina 1977   26983828  Americas 68.48100
    ## 55                  Argentina 1982   29341374  Americas 69.94200
    ## 56                  Argentina 1987   31620918  Americas 70.77400
    ## 57                  Argentina 1992   33958947  Americas 71.86800
    ## 58                  Argentina 1997   36203463  Americas 73.27500
    ## 59                  Argentina 2002   38331121  Americas 74.34000
    ## 60                  Argentina 2007   40301927  Americas 75.32000
    ## 61                  Australia 1952    8691212   Oceania 69.12000
    ## 62                  Australia 1957    9712569   Oceania 70.33000
    ## 63                  Australia 1962   10794968   Oceania 70.93000
    ## 64                  Australia 1967   11872264   Oceania 71.10000
    ## 65                  Australia 1972   13177000   Oceania 71.93000
    ## 66                  Australia 1977   14074100   Oceania 73.49000
    ## 67                  Australia 1982   15184200   Oceania 74.74000
    ## 68                  Australia 1987   16257249   Oceania 76.32000
    ## 69                  Australia 1992   17481977   Oceania 77.56000
    ## 70                  Australia 1997   18565243   Oceania 78.83000
    ## 71                  Australia 2002   19546792   Oceania 80.37000
    ## 72                  Australia 2007   20434176   Oceania 81.23500
    ## 73                    Austria 1952    6927772    Europe 66.80000
    ## 74                    Austria 1957    6965860    Europe 67.48000
    ## 75                    Austria 1962    7129864    Europe 69.54000
    ## 76                    Austria 1967    7376998    Europe 70.14000
    ## 77                    Austria 1972    7544201    Europe 70.63000
    ## 78                    Austria 1977    7568430    Europe 72.17000
    ## 79                    Austria 1982    7574613    Europe 73.18000
    ## 80                    Austria 1987    7578903    Europe 74.94000
    ## 81                    Austria 1992    7914969    Europe 76.04000
    ## 82                    Austria 1997    8069876    Europe 77.51000
    ## 83                    Austria 2002    8148312    Europe 78.98000
    ## 84                    Austria 2007    8199783    Europe 79.82900
    ## 85                    Bahrain 1952     120447      Asia 50.93900
    ## 86                    Bahrain 1957     138655      Asia 53.83200
    ## 87                    Bahrain 1962     171863      Asia 56.92300
    ## 88                    Bahrain 1967     202182      Asia 59.92300
    ## 89                    Bahrain 1972     230800      Asia 63.30000
    ## 90                    Bahrain 1977     297410      Asia 65.59300
    ## 91                    Bahrain 1982     377967      Asia 69.05200
    ## 92                    Bahrain 1987     454612      Asia 70.75000
    ## 93                    Bahrain 1992     529491      Asia 72.60100
    ## 94                    Bahrain 1997     598561      Asia 73.92500
    ## 95                    Bahrain 2002     656397      Asia 74.79500
    ## 96                    Bahrain 2007     708573      Asia 75.63500
    ## 97                 Bangladesh 1952   46886859      Asia 37.48400
    ## 98                 Bangladesh 1957   51365468      Asia 39.34800
    ## 99                 Bangladesh 1962   56839289      Asia 41.21600
    ## 100                Bangladesh 1967   62821884      Asia 43.45300
    ## 101                Bangladesh 1972   70759295      Asia 45.25200
    ## 102                Bangladesh 1977   80428306      Asia 46.92300
    ## 103                Bangladesh 1982   93074406      Asia 50.00900
    ## 104                Bangladesh 1987  103764241      Asia 52.81900
    ## 105                Bangladesh 1992  113704579      Asia 56.01800
    ## 106                Bangladesh 1997  123315288      Asia 59.41200
    ## 107                Bangladesh 2002  135656790      Asia 62.01300
    ## 108                Bangladesh 2007  150448339      Asia 64.06200
    ## 109                   Belgium 1952    8730405    Europe 68.00000
    ## 110                   Belgium 1957    8989111    Europe 69.24000
    ## 111                   Belgium 1962    9218400    Europe 70.25000
    ## 112                   Belgium 1967    9556500    Europe 70.94000
    ## 113                   Belgium 1972    9709100    Europe 71.44000
    ## 114                   Belgium 1977    9821800    Europe 72.80000
    ## 115                   Belgium 1982    9856303    Europe 73.93000
    ## 116                   Belgium 1987    9870200    Europe 75.35000
    ## 117                   Belgium 1992   10045622    Europe 76.46000
    ## 118                   Belgium 1997   10199787    Europe 77.53000
    ## 119                   Belgium 2002   10311970    Europe 78.32000
    ## 120                   Belgium 2007   10392226    Europe 79.44100
    ## 121                     Benin 1952    1738315    Africa 38.22300
    ## 122                     Benin 1957    1925173    Africa 40.35800
    ## 123                     Benin 1962    2151895    Africa 42.61800
    ## 124                     Benin 1967    2427334    Africa 44.88500
    ## 125                     Benin 1972    2761407    Africa 47.01400
    ## 126                     Benin 1977    3168267    Africa 49.19000
    ## 127                     Benin 1982    3641603    Africa 50.90400
    ## 128                     Benin 1987    4243788    Africa 52.33700
    ## 129                     Benin 1992    4981671    Africa 53.91900
    ## 130                     Benin 1997    6066080    Africa 54.77700
    ## 131                     Benin 2002    7026113    Africa 54.40600
    ## 132                     Benin 2007    8078314    Africa 56.72800
    ## 133                   Bolivia 1952    2883315  Americas 40.41400
    ## 134                   Bolivia 1957    3211738  Americas 41.89000
    ## 135                   Bolivia 1962    3593918  Americas 43.42800
    ## 136                   Bolivia 1967    4040665  Americas 45.03200
    ## 137                   Bolivia 1972    4565872  Americas 46.71400
    ## 138                   Bolivia 1977    5079716  Americas 50.02300
    ## 139                   Bolivia 1982    5642224  Americas 53.85900
    ## 140                   Bolivia 1987    6156369  Americas 57.25100
    ## 141                   Bolivia 1992    6893451  Americas 59.95700
    ## 142                   Bolivia 1997    7693188  Americas 62.05000
    ## 143                   Bolivia 2002    8445134  Americas 63.88300
    ## 144                   Bolivia 2007    9119152  Americas 65.55400
    ## 145    Bosnia and Herzegovina 1952    2791000    Europe 53.82000
    ## 146    Bosnia and Herzegovina 1957    3076000    Europe 58.45000
    ## 147    Bosnia and Herzegovina 1962    3349000    Europe 61.93000
    ## 148    Bosnia and Herzegovina 1967    3585000    Europe 64.79000
    ## 149    Bosnia and Herzegovina 1972    3819000    Europe 67.45000
    ## 150    Bosnia and Herzegovina 1977    4086000    Europe 69.86000
    ## 151    Bosnia and Herzegovina 1982    4172693    Europe 70.69000
    ## 152    Bosnia and Herzegovina 1987    4338977    Europe 71.14000
    ## 153    Bosnia and Herzegovina 1992    4256013    Europe 72.17800
    ## 154    Bosnia and Herzegovina 1997    3607000    Europe 73.24400
    ## 155    Bosnia and Herzegovina 2002    4165416    Europe 74.09000
    ## 156    Bosnia and Herzegovina 2007    4552198    Europe 74.85200
    ## 157                  Botswana 1952     442308    Africa 47.62200
    ## 158                  Botswana 1957     474639    Africa 49.61800
    ## 159                  Botswana 1962     512764    Africa 51.52000
    ## 160                  Botswana 1967     553541    Africa 53.29800
    ## 161                  Botswana 1972     619351    Africa 56.02400
    ## 162                  Botswana 1977     781472    Africa 59.31900
    ## 163                  Botswana 1982     970347    Africa 61.48400
    ## 164                  Botswana 1987    1151184    Africa 63.62200
    ## 165                  Botswana 1992    1342614    Africa 62.74500
    ## 166                  Botswana 1997    1536536    Africa 52.55600
    ## 167                  Botswana 2002    1630347    Africa 46.63400
    ## 168                  Botswana 2007    1639131    Africa 50.72800
    ## 169                    Brazil 1952   56602560  Americas 50.91700
    ## 170                    Brazil 1957   65551171  Americas 53.28500
    ## 171                    Brazil 1962   76039390  Americas 55.66500
    ## 172                    Brazil 1967   88049823  Americas 57.63200
    ## 173                    Brazil 1972  100840058  Americas 59.50400
    ## 174                    Brazil 1977  114313951  Americas 61.48900
    ## 175                    Brazil 1982  128962939  Americas 63.33600
    ## 176                    Brazil 1987  142938076  Americas 65.20500
    ## 177                    Brazil 1992  155975974  Americas 67.05700
    ## 178                    Brazil 1997  168546719  Americas 69.38800
    ## 179                    Brazil 2002  179914212  Americas 71.00600
    ## 180                    Brazil 2007  190010647  Americas 72.39000
    ## 181                  Bulgaria 1952    7274900    Europe 59.60000
    ## 182                  Bulgaria 1957    7651254    Europe 66.61000
    ## 183                  Bulgaria 1962    8012946    Europe 69.51000
    ## 184                  Bulgaria 1967    8310226    Europe 70.42000
    ## 185                  Bulgaria 1972    8576200    Europe 70.90000
    ## 186                  Bulgaria 1977    8797022    Europe 70.81000
    ## 187                  Bulgaria 1982    8892098    Europe 71.08000
    ## 188                  Bulgaria 1987    8971958    Europe 71.34000
    ## 189                  Bulgaria 1992    8658506    Europe 71.19000
    ## 190                  Bulgaria 1997    8066057    Europe 70.32000
    ## 191                  Bulgaria 2002    7661799    Europe 72.14000
    ## 192                  Bulgaria 2007    7322858    Europe 73.00500
    ## 193              Burkina Faso 1952    4469979    Africa 31.97500
    ## 194              Burkina Faso 1957    4713416    Africa 34.90600
    ## 195              Burkina Faso 1962    4919632    Africa 37.81400
    ## 196              Burkina Faso 1967    5127935    Africa 40.69700
    ## 197              Burkina Faso 1972    5433886    Africa 43.59100
    ## 198              Burkina Faso 1977    5889574    Africa 46.13700
    ## 199              Burkina Faso 1982    6634596    Africa 48.12200
    ## 200              Burkina Faso 1987    7586551    Africa 49.55700
    ## 201              Burkina Faso 1992    8878303    Africa 50.26000
    ## 202              Burkina Faso 1997   10352843    Africa 50.32400
    ## 203              Burkina Faso 2002   12251209    Africa 50.65000
    ## 204              Burkina Faso 2007   14326203    Africa 52.29500
    ## 205                   Burundi 1952    2445618    Africa 39.03100
    ## 206                   Burundi 1957    2667518    Africa 40.53300
    ## 207                   Burundi 1962    2961915    Africa 42.04500
    ## 208                   Burundi 1967    3330989    Africa 43.54800
    ## 209                   Burundi 1972    3529983    Africa 44.05700
    ## 210                   Burundi 1977    3834415    Africa 45.91000
    ## 211                   Burundi 1982    4580410    Africa 47.47100
    ## 212                   Burundi 1987    5126023    Africa 48.21100
    ## 213                   Burundi 1992    5809236    Africa 44.73600
    ## 214                   Burundi 1997    6121610    Africa 45.32600
    ## 215                   Burundi 2002    7021078    Africa 47.36000
    ## 216                   Burundi 2007    8390505    Africa 49.58000
    ## 217                  Cambodia 1952    4693836      Asia 39.41700
    ## 218                  Cambodia 1957    5322536      Asia 41.36600
    ## 219                  Cambodia 1962    6083619      Asia 43.41500
    ## 220                  Cambodia 1967    6960067      Asia 45.41500
    ## 221                  Cambodia 1972    7450606      Asia 40.31700
    ## 222                  Cambodia 1977    6978607      Asia 31.22000
    ## 223                  Cambodia 1982    7272485      Asia 50.95700
    ## 224                  Cambodia 1987    8371791      Asia 53.91400
    ## 225                  Cambodia 1992   10150094      Asia 55.80300
    ## 226                  Cambodia 1997   11782962      Asia 56.53400
    ## 227                  Cambodia 2002   12926707      Asia 56.75200
    ## 228                  Cambodia 2007   14131858      Asia 59.72300
    ## 229                  Cameroon 1952    5009067    Africa 38.52300
    ## 230                  Cameroon 1957    5359923    Africa 40.42800
    ## 231                  Cameroon 1962    5793633    Africa 42.64300
    ## 232                  Cameroon 1967    6335506    Africa 44.79900
    ## 233                  Cameroon 1972    7021028    Africa 47.04900
    ## 234                  Cameroon 1977    7959865    Africa 49.35500
    ## 235                  Cameroon 1982    9250831    Africa 52.96100
    ## 236                  Cameroon 1987   10780667    Africa 54.98500
    ## 237                  Cameroon 1992   12467171    Africa 54.31400
    ## 238                  Cameroon 1997   14195809    Africa 52.19900
    ## 239                  Cameroon 2002   15929988    Africa 49.85600
    ## 240                  Cameroon 2007   17696293    Africa 50.43000
    ## 241                    Canada 1952   14785584  Americas 68.75000
    ## 242                    Canada 1957   17010154  Americas 69.96000
    ## 243                    Canada 1962   18985849  Americas 71.30000
    ## 244                    Canada 1967   20819767  Americas 72.13000
    ## 245                    Canada 1972   22284500  Americas 72.88000
    ## 246                    Canada 1977   23796400  Americas 74.21000
    ## 247                    Canada 1982   25201900  Americas 75.76000
    ## 248                    Canada 1987   26549700  Americas 76.86000
    ## 249                    Canada 1992   28523502  Americas 77.95000
    ## 250                    Canada 1997   30305843  Americas 78.61000
    ## 251                    Canada 2002   31902268  Americas 79.77000
    ## 252                    Canada 2007   33390141  Americas 80.65300
    ## 253  Central African Republic 1952    1291695    Africa 35.46300
    ## 254  Central African Republic 1957    1392284    Africa 37.46400
    ## 255  Central African Republic 1962    1523478    Africa 39.47500
    ## 256  Central African Republic 1967    1733638    Africa 41.47800
    ## 257  Central African Republic 1972    1927260    Africa 43.45700
    ## 258  Central African Republic 1977    2167533    Africa 46.77500
    ## 259  Central African Republic 1982    2476971    Africa 48.29500
    ## 260  Central African Republic 1987    2840009    Africa 50.48500
    ## 261  Central African Republic 1992    3265124    Africa 49.39600
    ## 262  Central African Republic 1997    3696513    Africa 46.06600
    ## 263  Central African Republic 2002    4048013    Africa 43.30800
    ## 264  Central African Republic 2007    4369038    Africa 44.74100
    ## 265                      Chad 1952    2682462    Africa 38.09200
    ## 266                      Chad 1957    2894855    Africa 39.88100
    ## 267                      Chad 1962    3150417    Africa 41.71600
    ## 268                      Chad 1967    3495967    Africa 43.60100
    ## 269                      Chad 1972    3899068    Africa 45.56900
    ## 270                      Chad 1977    4388260    Africa 47.38300
    ## 271                      Chad 1982    4875118    Africa 49.51700
    ## 272                      Chad 1987    5498955    Africa 51.05100
    ## 273                      Chad 1992    6429417    Africa 51.72400
    ## 274                      Chad 1997    7562011    Africa 51.57300
    ## 275                      Chad 2002    8835739    Africa 50.52500
    ## 276                      Chad 2007   10238807    Africa 50.65100
    ## 277                     Chile 1952    6377619  Americas 54.74500
    ## 278                     Chile 1957    7048426  Americas 56.07400
    ## 279                     Chile 1962    7961258  Americas 57.92400
    ## 280                     Chile 1967    8858908  Americas 60.52300
    ## 281                     Chile 1972    9717524  Americas 63.44100
    ## 282                     Chile 1977   10599793  Americas 67.05200
    ## 283                     Chile 1982   11487112  Americas 70.56500
    ## 284                     Chile 1987   12463354  Americas 72.49200
    ## 285                     Chile 1992   13572994  Americas 74.12600
    ## 286                     Chile 1997   14599929  Americas 75.81600
    ## 287                     Chile 2002   15497046  Americas 77.86000
    ## 288                     Chile 2007   16284741  Americas 78.55300
    ## 289                     China 1952  556263528      Asia 44.00000
    ## 290                     China 1957  637408000      Asia 50.54896
    ## 291                     China 1962  665770000      Asia 44.50136
    ## 292                     China 1967  754550000      Asia 58.38112
    ## 293                     China 1972  862030000      Asia 63.11888
    ## 294                     China 1977  943455000      Asia 63.96736
    ## 295                     China 1982 1000281000      Asia 65.52500
    ## 296                     China 1987 1084035000      Asia 67.27400
    ## 297                     China 1992 1164970000      Asia 68.69000
    ## 298                     China 1997 1230075000      Asia 70.42600
    ## 299                     China 2002 1280400000      Asia 72.02800
    ## 300                     China 2007 1318683096      Asia 72.96100
    ## 301                  Colombia 1952   12350771  Americas 50.64300
    ## 302                  Colombia 1957   14485993  Americas 55.11800
    ## 303                  Colombia 1962   17009885  Americas 57.86300
    ## 304                  Colombia 1967   19764027  Americas 59.96300
    ## 305                  Colombia 1972   22542890  Americas 61.62300
    ## 306                  Colombia 1977   25094412  Americas 63.83700
    ## 307                  Colombia 1982   27764644  Americas 66.65300
    ## 308                  Colombia 1987   30964245  Americas 67.76800
    ## 309                  Colombia 1992   34202721  Americas 68.42100
    ## 310                  Colombia 1997   37657830  Americas 70.31300
    ## 311                  Colombia 2002   41008227  Americas 71.68200
    ## 312                  Colombia 2007   44227550  Americas 72.88900
    ## 313                   Comoros 1952     153936    Africa 40.71500
    ## 314                   Comoros 1957     170928    Africa 42.46000
    ## 315                   Comoros 1962     191689    Africa 44.46700
    ## 316                   Comoros 1967     217378    Africa 46.47200
    ## 317                   Comoros 1972     250027    Africa 48.94400
    ## 318                   Comoros 1977     304739    Africa 50.93900
    ## 319                   Comoros 1982     348643    Africa 52.93300
    ## 320                   Comoros 1987     395114    Africa 54.92600
    ## 321                   Comoros 1992     454429    Africa 57.93900
    ## 322                   Comoros 1997     527982    Africa 60.66000
    ## 323                   Comoros 2002     614382    Africa 62.97400
    ## 324                   Comoros 2007     710960    Africa 65.15200
    ## 325           Congo Dem. Rep. 1952   14100005    Africa 39.14300
    ## 326           Congo Dem. Rep. 1957   15577932    Africa 40.65200
    ## 327           Congo Dem. Rep. 1962   17486434    Africa 42.12200
    ## 328           Congo Dem. Rep. 1967   19941073    Africa 44.05600
    ## 329           Congo Dem. Rep. 1972   23007669    Africa 45.98900
    ## 330           Congo Dem. Rep. 1977   26480870    Africa 47.80400
    ## 331           Congo Dem. Rep. 1982   30646495    Africa 47.78400
    ## 332           Congo Dem. Rep. 1987   35481645    Africa 47.41200
    ## 333           Congo Dem. Rep. 1992   41672143    Africa 45.54800
    ## 334           Congo Dem. Rep. 1997   47798986    Africa 42.58700
    ## 335           Congo Dem. Rep. 2002   55379852    Africa 44.96600
    ## 336           Congo Dem. Rep. 2007   64606759    Africa 46.46200
    ## 337                Congo Rep. 1952     854885    Africa 42.11100
    ## 338                Congo Rep. 1957     940458    Africa 45.05300
    ## 339                Congo Rep. 1962    1047924    Africa 48.43500
    ## 340                Congo Rep. 1967    1179760    Africa 52.04000
    ## 341                Congo Rep. 1972    1340458    Africa 54.90700
    ## 342                Congo Rep. 1977    1536769    Africa 55.62500
    ## 343                Congo Rep. 1982    1774735    Africa 56.69500
    ## 344                Congo Rep. 1987    2064095    Africa 57.47000
    ## 345                Congo Rep. 1992    2409073    Africa 56.43300
    ## 346                Congo Rep. 1997    2800947    Africa 52.96200
    ## 347                Congo Rep. 2002    3328795    Africa 52.97000
    ## 348                Congo Rep. 2007    3800610    Africa 55.32200
    ## 349                Costa Rica 1952     926317  Americas 57.20600
    ## 350                Costa Rica 1957    1112300  Americas 60.02600
    ## 351                Costa Rica 1962    1345187  Americas 62.84200
    ## 352                Costa Rica 1967    1588717  Americas 65.42400
    ## 353                Costa Rica 1972    1834796  Americas 67.84900
    ## 354                Costa Rica 1977    2108457  Americas 70.75000
    ## 355                Costa Rica 1982    2424367  Americas 73.45000
    ## 356                Costa Rica 1987    2799811  Americas 74.75200
    ## 357                Costa Rica 1992    3173216  Americas 75.71300
    ## 358                Costa Rica 1997    3518107  Americas 77.26000
    ## 359                Costa Rica 2002    3834934  Americas 78.12300
    ## 360                Costa Rica 2007    4133884  Americas 78.78200
    ## 361             Cote d'Ivoire 1952    2977019    Africa 40.47700
    ## 362             Cote d'Ivoire 1957    3300000    Africa 42.46900
    ## 363             Cote d'Ivoire 1962    3832408    Africa 44.93000
    ## 364             Cote d'Ivoire 1967    4744870    Africa 47.35000
    ## 365             Cote d'Ivoire 1972    6071696    Africa 49.80100
    ## 366             Cote d'Ivoire 1977    7459574    Africa 52.37400
    ## 367             Cote d'Ivoire 1982    9025951    Africa 53.98300
    ## 368             Cote d'Ivoire 1987   10761098    Africa 54.65500
    ## 369             Cote d'Ivoire 1992   12772596    Africa 52.04400
    ## 370             Cote d'Ivoire 1997   14625967    Africa 47.99100
    ## 371             Cote d'Ivoire 2002   16252726    Africa 46.83200
    ## 372             Cote d'Ivoire 2007   18013409    Africa 48.32800
    ## 373                   Croatia 1952    3882229    Europe 61.21000
    ## 374                   Croatia 1957    3991242    Europe 64.77000
    ## 375                   Croatia 1962    4076557    Europe 67.13000
    ## 376                   Croatia 1967    4174366    Europe 68.50000
    ## 377                   Croatia 1972    4225310    Europe 69.61000
    ## 378                   Croatia 1977    4318673    Europe 70.64000
    ## 379                   Croatia 1982    4413368    Europe 70.46000
    ## 380                   Croatia 1987    4484310    Europe 71.52000
    ## 381                   Croatia 1992    4494013    Europe 72.52700
    ## 382                   Croatia 1997    4444595    Europe 73.68000
    ## 383                   Croatia 2002    4481020    Europe 74.87600
    ## 384                   Croatia 2007    4493312    Europe 75.74800
    ## 385                      Cuba 1952    6007797  Americas 59.42100
    ## 386                      Cuba 1957    6640752  Americas 62.32500
    ## 387                      Cuba 1962    7254373  Americas 65.24600
    ## 388                      Cuba 1967    8139332  Americas 68.29000
    ## 389                      Cuba 1972    8831348  Americas 70.72300
    ## 390                      Cuba 1977    9537988  Americas 72.64900
    ## 391                      Cuba 1982    9789224  Americas 73.71700
    ## 392                      Cuba 1987   10239839  Americas 74.17400
    ## 393                      Cuba 1992   10723260  Americas 74.41400
    ## 394                      Cuba 1997   10983007  Americas 76.15100
    ## 395                      Cuba 2002   11226999  Americas 77.15800
    ## 396                      Cuba 2007   11416987  Americas 78.27300
    ## 397            Czech Republic 1952    9125183    Europe 66.87000
    ## 398            Czech Republic 1957    9513758    Europe 69.03000
    ## 399            Czech Republic 1962    9620282    Europe 69.90000
    ## 400            Czech Republic 1967    9835109    Europe 70.38000
    ## 401            Czech Republic 1972    9862158    Europe 70.29000
    ## 402            Czech Republic 1977   10161915    Europe 70.71000
    ## 403            Czech Republic 1982   10303704    Europe 70.96000
    ## 404            Czech Republic 1987   10311597    Europe 71.58000
    ## 405            Czech Republic 1992   10315702    Europe 72.40000
    ## 406            Czech Republic 1997   10300707    Europe 74.01000
    ## 407            Czech Republic 2002   10256295    Europe 75.51000
    ## 408            Czech Republic 2007   10228744    Europe 76.48600
    ## 409                   Denmark 1952    4334000    Europe 70.78000
    ## 410                   Denmark 1957    4487831    Europe 71.81000
    ## 411                   Denmark 1962    4646899    Europe 72.35000
    ## 412                   Denmark 1967    4838800    Europe 72.96000
    ## 413                   Denmark 1972    4991596    Europe 73.47000
    ## 414                   Denmark 1977    5088419    Europe 74.69000
    ## 415                   Denmark 1982    5117810    Europe 74.63000
    ## 416                   Denmark 1987    5127024    Europe 74.80000
    ## 417                   Denmark 1992    5171393    Europe 75.33000
    ## 418                   Denmark 1997    5283663    Europe 76.11000
    ## 419                   Denmark 2002    5374693    Europe 77.18000
    ## 420                   Denmark 2007    5468120    Europe 78.33200
    ## 421                  Djibouti 1952      63149    Africa 34.81200
    ## 422                  Djibouti 1957      71851    Africa 37.32800
    ## 423                  Djibouti 1962      89898    Africa 39.69300
    ## 424                  Djibouti 1967     127617    Africa 42.07400
    ## 425                  Djibouti 1972     178848    Africa 44.36600
    ## 426                  Djibouti 1977     228694    Africa 46.51900
    ## 427                  Djibouti 1982     305991    Africa 48.81200
    ## 428                  Djibouti 1987     311025    Africa 50.04000
    ## 429                  Djibouti 1992     384156    Africa 51.60400
    ## 430                  Djibouti 1997     417908    Africa 53.15700
    ## 431                  Djibouti 2002     447416    Africa 53.37300
    ## 432                  Djibouti 2007     496374    Africa 54.79100
    ## 433        Dominican Republic 1952    2491346  Americas 45.92800
    ## 434        Dominican Republic 1957    2923186  Americas 49.82800
    ## 435        Dominican Republic 1962    3453434  Americas 53.45900
    ## 436        Dominican Republic 1967    4049146  Americas 56.75100
    ## 437        Dominican Republic 1972    4671329  Americas 59.63100
    ## 438        Dominican Republic 1977    5302800  Americas 61.78800
    ## 439        Dominican Republic 1982    5968349  Americas 63.72700
    ## 440        Dominican Republic 1987    6655297  Americas 66.04600
    ## 441        Dominican Republic 1992    7351181  Americas 68.45700
    ## 442        Dominican Republic 1997    7992357  Americas 69.95700
    ## 443        Dominican Republic 2002    8650322  Americas 70.84700
    ## 444        Dominican Republic 2007    9319622  Americas 72.23500
    ## 445                   Ecuador 1952    3548753  Americas 48.35700
    ## 446                   Ecuador 1957    4058385  Americas 51.35600
    ## 447                   Ecuador 1962    4681707  Americas 54.64000
    ## 448                   Ecuador 1967    5432424  Americas 56.67800
    ## 449                   Ecuador 1972    6298651  Americas 58.79600
    ## 450                   Ecuador 1977    7278866  Americas 61.31000
    ## 451                   Ecuador 1982    8365850  Americas 64.34200
    ## 452                   Ecuador 1987    9545158  Americas 67.23100
    ## 453                   Ecuador 1992   10748394  Americas 69.61300
    ## 454                   Ecuador 1997   11911819  Americas 72.31200
    ## 455                   Ecuador 2002   12921234  Americas 74.17300
    ## 456                   Ecuador 2007   13755680  Americas 74.99400
    ## 457                     Egypt 1952   22223309    Africa 41.89300
    ## 458                     Egypt 1957   25009741    Africa 44.44400
    ## 459                     Egypt 1962   28173309    Africa 46.99200
    ## 460                     Egypt 1967   31681188    Africa 49.29300
    ## 461                     Egypt 1972   34807417    Africa 51.13700
    ## 462                     Egypt 1977   38783863    Africa 53.31900
    ## 463                     Egypt 1982   45681811    Africa 56.00600
    ## 464                     Egypt 1987   52799062    Africa 59.79700
    ## 465                     Egypt 1992   59402198    Africa 63.67400
    ## 466                     Egypt 1997   66134291    Africa 67.21700
    ## 467                     Egypt 2002   73312559    Africa 69.80600
    ## 468                     Egypt 2007   80264543    Africa 71.33800
    ## 469               El Salvador 1952    2042865  Americas 45.26200
    ## 470               El Salvador 1957    2355805  Americas 48.57000
    ## 471               El Salvador 1962    2747687  Americas 52.30700
    ## 472               El Salvador 1967    3232927  Americas 55.85500
    ## 473               El Salvador 1972    3790903  Americas 58.20700
    ## 474               El Salvador 1977    4282586  Americas 56.69600
    ## 475               El Salvador 1982    4474873  Americas 56.60400
    ## 476               El Salvador 1987    4842194  Americas 63.15400
    ## 477               El Salvador 1992    5274649  Americas 66.79800
    ## 478               El Salvador 1997    5783439  Americas 69.53500
    ## 479               El Salvador 2002    6353681  Americas 70.73400
    ## 480               El Salvador 2007    6939688  Americas 71.87800
    ## 481         Equatorial Guinea 1952     216964    Africa 34.48200
    ## 482         Equatorial Guinea 1957     232922    Africa 35.98300
    ## 483         Equatorial Guinea 1962     249220    Africa 37.48500
    ## 484         Equatorial Guinea 1967     259864    Africa 38.98700
    ## 485         Equatorial Guinea 1972     277603    Africa 40.51600
    ## 486         Equatorial Guinea 1977     192675    Africa 42.02400
    ## 487         Equatorial Guinea 1982     285483    Africa 43.66200
    ## 488         Equatorial Guinea 1987     341244    Africa 45.66400
    ## 489         Equatorial Guinea 1992     387838    Africa 47.54500
    ## 490         Equatorial Guinea 1997     439971    Africa 48.24500
    ## 491         Equatorial Guinea 2002     495627    Africa 49.34800
    ## 492         Equatorial Guinea 2007     551201    Africa 51.57900
    ## 493                   Eritrea 1952    1438760    Africa 35.92800
    ## 494                   Eritrea 1957    1542611    Africa 38.04700
    ## 495                   Eritrea 1962    1666618    Africa 40.15800
    ## 496                   Eritrea 1967    1820319    Africa 42.18900
    ## 497                   Eritrea 1972    2260187    Africa 44.14200
    ## 498                   Eritrea 1977    2512642    Africa 44.53500
    ## 499                   Eritrea 1982    2637297    Africa 43.89000
    ## 500                   Eritrea 1987    2915959    Africa 46.45300
    ## 501                   Eritrea 1992    3668440    Africa 49.99100
    ## 502                   Eritrea 1997    4058319    Africa 53.37800
    ## 503                   Eritrea 2002    4414865    Africa 55.24000
    ## 504                   Eritrea 2007    4906585    Africa 58.04000
    ## 505                  Ethiopia 1952   20860941    Africa 34.07800
    ## 506                  Ethiopia 1957   22815614    Africa 36.66700
    ## 507                  Ethiopia 1962   25145372    Africa 40.05900
    ## 508                  Ethiopia 1967   27860297    Africa 42.11500
    ## 509                  Ethiopia 1972   30770372    Africa 43.51500
    ## 510                  Ethiopia 1977   34617799    Africa 44.51000
    ## 511                  Ethiopia 1982   38111756    Africa 44.91600
    ## 512                  Ethiopia 1987   42999530    Africa 46.68400
    ## 513                  Ethiopia 1992   52088559    Africa 48.09100
    ## 514                  Ethiopia 1997   59861301    Africa 49.40200
    ## 515                  Ethiopia 2002   67946797    Africa 50.72500
    ## 516                  Ethiopia 2007   76511887    Africa 52.94700
    ## 517                   Finland 1952    4090500    Europe 66.55000
    ## 518                   Finland 1957    4324000    Europe 67.49000
    ## 519                   Finland 1962    4491443    Europe 68.75000
    ## 520                   Finland 1967    4605744    Europe 69.83000
    ## 521                   Finland 1972    4639657    Europe 70.87000
    ## 522                   Finland 1977    4738902    Europe 72.52000
    ## 523                   Finland 1982    4826933    Europe 74.55000
    ## 524                   Finland 1987    4931729    Europe 74.83000
    ## 525                   Finland 1992    5041039    Europe 75.70000
    ## 526                   Finland 1997    5134406    Europe 77.13000
    ## 527                   Finland 2002    5193039    Europe 78.37000
    ## 528                   Finland 2007    5238460    Europe 79.31300
    ## 529                    France 1952   42459667    Europe 67.41000
    ## 530                    France 1957   44310863    Europe 68.93000
    ## 531                    France 1962   47124000    Europe 70.51000
    ## 532                    France 1967   49569000    Europe 71.55000
    ## 533                    France 1972   51732000    Europe 72.38000
    ## 534                    France 1977   53165019    Europe 73.83000
    ## 535                    France 1982   54433565    Europe 74.89000
    ## 536                    France 1987   55630100    Europe 76.34000
    ## 537                    France 1992   57374179    Europe 77.46000
    ## 538                    France 1997   58623428    Europe 78.64000
    ## 539                    France 2002   59925035    Europe 79.59000
    ## 540                    France 2007   61083916    Europe 80.65700
    ## 541                     Gabon 1952     420702    Africa 37.00300
    ## 542                     Gabon 1957     434904    Africa 38.99900
    ## 543                     Gabon 1962     455661    Africa 40.48900
    ## 544                     Gabon 1967     489004    Africa 44.59800
    ## 545                     Gabon 1972     537977    Africa 48.69000
    ## 546                     Gabon 1977     706367    Africa 52.79000
    ## 547                     Gabon 1982     753874    Africa 56.56400
    ## 548                     Gabon 1987     880397    Africa 60.19000
    ## 549                     Gabon 1992     985739    Africa 61.36600
    ## 550                     Gabon 1997    1126189    Africa 60.46100
    ## 551                     Gabon 2002    1299304    Africa 56.76100
    ## 552                     Gabon 2007    1454867    Africa 56.73500
    ## 553                    Gambia 1952     284320    Africa 30.00000
    ## 554                    Gambia 1957     323150    Africa 32.06500
    ## 555                    Gambia 1962     374020    Africa 33.89600
    ## 556                    Gambia 1967     439593    Africa 35.85700
    ## 557                    Gambia 1972     517101    Africa 38.30800
    ## 558                    Gambia 1977     608274    Africa 41.84200
    ## 559                    Gambia 1982     715523    Africa 45.58000
    ## 560                    Gambia 1987     848406    Africa 49.26500
    ## 561                    Gambia 1992    1025384    Africa 52.64400
    ## 562                    Gambia 1997    1235767    Africa 55.86100
    ## 563                    Gambia 2002    1457766    Africa 58.04100
    ## 564                    Gambia 2007    1688359    Africa 59.44800
    ## 565                   Germany 1952   69145952    Europe 67.50000
    ## 566                   Germany 1957   71019069    Europe 69.10000
    ## 567                   Germany 1962   73739117    Europe 70.30000
    ## 568                   Germany 1967   76368453    Europe 70.80000
    ## 569                   Germany 1972   78717088    Europe 71.00000
    ## 570                   Germany 1977   78160773    Europe 72.50000
    ## 571                   Germany 1982   78335266    Europe 73.80000
    ## 572                   Germany 1987   77718298    Europe 74.84700
    ## 573                   Germany 1992   80597764    Europe 76.07000
    ## 574                   Germany 1997   82011073    Europe 77.34000
    ## 575                   Germany 2002   82350671    Europe 78.67000
    ## 576                   Germany 2007   82400996    Europe 79.40600
    ## 577                     Ghana 1952    5581001    Africa 43.14900
    ## 578                     Ghana 1957    6391288    Africa 44.77900
    ## 579                     Ghana 1962    7355248    Africa 46.45200
    ## 580                     Ghana 1967    8490213    Africa 48.07200
    ## 581                     Ghana 1972    9354120    Africa 49.87500
    ## 582                     Ghana 1977   10538093    Africa 51.75600
    ## 583                     Ghana 1982   11400338    Africa 53.74400
    ## 584                     Ghana 1987   14168101    Africa 55.72900
    ## 585                     Ghana 1992   16278738    Africa 57.50100
    ## 586                     Ghana 1997   18418288    Africa 58.55600
    ## 587                     Ghana 2002   20550751    Africa 58.45300
    ## 588                     Ghana 2007   22873338    Africa 60.02200
    ## 589                    Greece 1952    7733250    Europe 65.86000
    ## 590                    Greece 1957    8096218    Europe 67.86000
    ## 591                    Greece 1962    8448233    Europe 69.51000
    ## 592                    Greece 1967    8716441    Europe 71.00000
    ## 593                    Greece 1972    8888628    Europe 72.34000
    ## 594                    Greece 1977    9308479    Europe 73.68000
    ## 595                    Greece 1982    9786480    Europe 75.24000
    ## 596                    Greece 1987    9974490    Europe 76.67000
    ## 597                    Greece 1992   10325429    Europe 77.03000
    ## 598                    Greece 1997   10502372    Europe 77.86900
    ## 599                    Greece 2002   10603863    Europe 78.25600
    ## 600                    Greece 2007   10706290    Europe 79.48300
    ## 601                 Guatemala 1952    3146381  Americas 42.02300
    ## 602                 Guatemala 1957    3640876  Americas 44.14200
    ## 603                 Guatemala 1962    4208858  Americas 46.95400
    ## 604                 Guatemala 1967    4690773  Americas 50.01600
    ## 605                 Guatemala 1972    5149581  Americas 53.73800
    ## 606                 Guatemala 1977    5703430  Americas 56.02900
    ## 607                 Guatemala 1982    6395630  Americas 58.13700
    ## 608                 Guatemala 1987    7326406  Americas 60.78200
    ## 609                 Guatemala 1992    8486949  Americas 63.37300
    ## 610                 Guatemala 1997    9803875  Americas 66.32200
    ## 611                 Guatemala 2002   11178650  Americas 68.97800
    ## 612                 Guatemala 2007   12572928  Americas 70.25900
    ## 613                    Guinea 1952    2664249    Africa 33.60900
    ## 614                    Guinea 1957    2876726    Africa 34.55800
    ## 615                    Guinea 1962    3140003    Africa 35.75300
    ## 616                    Guinea 1967    3451418    Africa 37.19700
    ## 617                    Guinea 1972    3811387    Africa 38.84200
    ## 618                    Guinea 1977    4227026    Africa 40.76200
    ## 619                    Guinea 1982    4710497    Africa 42.89100
    ## 620                    Guinea 1987    5650262    Africa 45.55200
    ## 621                    Guinea 1992    6990574    Africa 48.57600
    ## 622                    Guinea 1997    8048834    Africa 51.45500
    ## 623                    Guinea 2002    8807818    Africa 53.67600
    ## 624                    Guinea 2007    9947814    Africa 56.00700
    ## 625             Guinea-Bissau 1952     580653    Africa 32.50000
    ## 626             Guinea-Bissau 1957     601095    Africa 33.48900
    ## 627             Guinea-Bissau 1962     627820    Africa 34.48800
    ## 628             Guinea-Bissau 1967     601287    Africa 35.49200
    ## 629             Guinea-Bissau 1972     625361    Africa 36.48600
    ## 630             Guinea-Bissau 1977     745228    Africa 37.46500
    ## 631             Guinea-Bissau 1982     825987    Africa 39.32700
    ## 632             Guinea-Bissau 1987     927524    Africa 41.24500
    ## 633             Guinea-Bissau 1992    1050938    Africa 43.26600
    ## 634             Guinea-Bissau 1997    1193708    Africa 44.87300
    ## 635             Guinea-Bissau 2002    1332459    Africa 45.50400
    ## 636             Guinea-Bissau 2007    1472041    Africa 46.38800
    ## 637                     Haiti 1952    3201488  Americas 37.57900
    ## 638                     Haiti 1957    3507701  Americas 40.69600
    ## 639                     Haiti 1962    3880130  Americas 43.59000
    ## 640                     Haiti 1967    4318137  Americas 46.24300
    ## 641                     Haiti 1972    4698301  Americas 48.04200
    ## 642                     Haiti 1977    4908554  Americas 49.92300
    ## 643                     Haiti 1982    5198399  Americas 51.46100
    ## 644                     Haiti 1987    5756203  Americas 53.63600
    ## 645                     Haiti 1992    6326682  Americas 55.08900
    ## 646                     Haiti 1997    6913545  Americas 56.67100
    ## 647                     Haiti 2002    7607651  Americas 58.13700
    ## 648                     Haiti 2007    8502814  Americas 60.91600
    ## 649                  Honduras 1952    1517453  Americas 41.91200
    ## 650                  Honduras 1957    1770390  Americas 44.66500
    ## 651                  Honduras 1962    2090162  Americas 48.04100
    ## 652                  Honduras 1967    2500689  Americas 50.92400
    ## 653                  Honduras 1972    2965146  Americas 53.88400
    ## 654                  Honduras 1977    3055235  Americas 57.40200
    ## 655                  Honduras 1982    3669448  Americas 60.90900
    ## 656                  Honduras 1987    4372203  Americas 64.49200
    ## 657                  Honduras 1992    5077347  Americas 66.39900
    ## 658                  Honduras 1997    5867957  Americas 67.65900
    ## 659                  Honduras 2002    6677328  Americas 68.56500
    ## 660                  Honduras 2007    7483763  Americas 70.19800
    ## 661           Hong Kong China 1952    2125900      Asia 60.96000
    ## 662           Hong Kong China 1957    2736300      Asia 64.75000
    ## 663           Hong Kong China 1962    3305200      Asia 67.65000
    ## 664           Hong Kong China 1967    3722800      Asia 70.00000
    ## 665           Hong Kong China 1972    4115700      Asia 72.00000
    ## 666           Hong Kong China 1977    4583700      Asia 73.60000
    ## 667           Hong Kong China 1982    5264500      Asia 75.45000
    ## 668           Hong Kong China 1987    5584510      Asia 76.20000
    ## 669           Hong Kong China 1992    5829696      Asia 77.60100
    ## 670           Hong Kong China 1997    6495918      Asia 80.00000
    ## 671           Hong Kong China 2002    6762476      Asia 81.49500
    ## 672           Hong Kong China 2007    6980412      Asia 82.20800
    ## 673                   Hungary 1952    9504000    Europe 64.03000
    ## 674                   Hungary 1957    9839000    Europe 66.41000
    ## 675                   Hungary 1962   10063000    Europe 67.96000
    ## 676                   Hungary 1967   10223422    Europe 69.50000
    ## 677                   Hungary 1972   10394091    Europe 69.76000
    ## 678                   Hungary 1977   10637171    Europe 69.95000
    ## 679                   Hungary 1982   10705535    Europe 69.39000
    ## 680                   Hungary 1987   10612740    Europe 69.58000
    ## 681                   Hungary 1992   10348684    Europe 69.17000
    ## 682                   Hungary 1997   10244684    Europe 71.04000
    ## 683                   Hungary 2002   10083313    Europe 72.59000
    ## 684                   Hungary 2007    9956108    Europe 73.33800
    ## 685                   Iceland 1952     147962    Europe 72.49000
    ## 686                   Iceland 1957     165110    Europe 73.47000
    ## 687                   Iceland 1962     182053    Europe 73.68000
    ## 688                   Iceland 1967     198676    Europe 73.73000
    ## 689                   Iceland 1972     209275    Europe 74.46000
    ## 690                   Iceland 1977     221823    Europe 76.11000
    ## 691                   Iceland 1982     233997    Europe 76.99000
    ## 692                   Iceland 1987     244676    Europe 77.23000
    ## 693                   Iceland 1992     259012    Europe 78.77000
    ## 694                   Iceland 1997     271192    Europe 78.95000
    ## 695                   Iceland 2002     288030    Europe 80.50000
    ## 696                   Iceland 2007     301931    Europe 81.75700
    ## 697                     India 1952  372000000      Asia 37.37300
    ## 698                     India 1957  409000000      Asia 40.24900
    ## 699                     India 1962  454000000      Asia 43.60500
    ## 700                     India 1967  506000000      Asia 47.19300
    ## 701                     India 1972  567000000      Asia 50.65100
    ## 702                     India 1977  634000000      Asia 54.20800
    ## 703                     India 1982  708000000      Asia 56.59600
    ## 704                     India 1987  788000000      Asia 58.55300
    ## 705                     India 1992  872000000      Asia 60.22300
    ## 706                     India 1997  959000000      Asia 61.76500
    ## 707                     India 2002 1034172547      Asia 62.87900
    ## 708                     India 2007 1110396331      Asia 64.69800
    ## 709                 Indonesia 1952   82052000      Asia 37.46800
    ## 710                 Indonesia 1957   90124000      Asia 39.91800
    ## 711                 Indonesia 1962   99028000      Asia 42.51800
    ## 712                 Indonesia 1967  109343000      Asia 45.96400
    ## 713                 Indonesia 1972  121282000      Asia 49.20300
    ## 714                 Indonesia 1977  136725000      Asia 52.70200
    ## 715                 Indonesia 1982  153343000      Asia 56.15900
    ## 716                 Indonesia 1987  169276000      Asia 60.13700
    ## 717                 Indonesia 1992  184816000      Asia 62.68100
    ## 718                 Indonesia 1997  199278000      Asia 66.04100
    ## 719                 Indonesia 2002  211060000      Asia 68.58800
    ## 720                 Indonesia 2007  223547000      Asia 70.65000
    ## 721                      Iran 1952   17272000      Asia 44.86900
    ## 722                      Iran 1957   19792000      Asia 47.18100
    ## 723                      Iran 1962   22874000      Asia 49.32500
    ## 724                      Iran 1967   26538000      Asia 52.46900
    ## 725                      Iran 1972   30614000      Asia 55.23400
    ## 726                      Iran 1977   35480679      Asia 57.70200
    ## 727                      Iran 1982   43072751      Asia 59.62000
    ## 728                      Iran 1987   51889696      Asia 63.04000
    ## 729                      Iran 1992   60397973      Asia 65.74200
    ## 730                      Iran 1997   63327987      Asia 68.04200
    ## 731                      Iran 2002   66907826      Asia 69.45100
    ## 732                      Iran 2007   69453570      Asia 70.96400
    ## 733                      Iraq 1952    5441766      Asia 45.32000
    ## 734                      Iraq 1957    6248643      Asia 48.43700
    ## 735                      Iraq 1962    7240260      Asia 51.45700
    ## 736                      Iraq 1967    8519282      Asia 54.45900
    ## 737                      Iraq 1972   10061506      Asia 56.95000
    ## 738                      Iraq 1977   11882916      Asia 60.41300
    ## 739                      Iraq 1982   14173318      Asia 62.03800
    ## 740                      Iraq 1987   16543189      Asia 65.04400
    ## 741                      Iraq 1992   17861905      Asia 59.46100
    ## 742                      Iraq 1997   20775703      Asia 58.81100
    ## 743                      Iraq 2002   24001816      Asia 57.04600
    ## 744                      Iraq 2007   27499638      Asia 59.54500
    ## 745                   Ireland 1952    2952156    Europe 66.91000
    ## 746                   Ireland 1957    2878220    Europe 68.90000
    ## 747                   Ireland 1962    2830000    Europe 70.29000
    ## 748                   Ireland 1967    2900100    Europe 71.08000
    ## 749                   Ireland 1972    3024400    Europe 71.28000
    ## 750                   Ireland 1977    3271900    Europe 72.03000
    ## 751                   Ireland 1982    3480000    Europe 73.10000
    ## 752                   Ireland 1987    3539900    Europe 74.36000
    ## 753                   Ireland 1992    3557761    Europe 75.46700
    ## 754                   Ireland 1997    3667233    Europe 76.12200
    ## 755                   Ireland 2002    3879155    Europe 77.78300
    ## 756                   Ireland 2007    4109086    Europe 78.88500
    ## 757                    Israel 1952    1620914      Asia 65.39000
    ## 758                    Israel 1957    1944401      Asia 67.84000
    ## 759                    Israel 1962    2310904      Asia 69.39000
    ## 760                    Israel 1967    2693585      Asia 70.75000
    ## 761                    Israel 1972    3095893      Asia 71.63000
    ## 762                    Israel 1977    3495918      Asia 73.06000
    ## 763                    Israel 1982    3858421      Asia 74.45000
    ## 764                    Israel 1987    4203148      Asia 75.60000
    ## 765                    Israel 1992    4936550      Asia 76.93000
    ## 766                    Israel 1997    5531387      Asia 78.26900
    ## 767                    Israel 2002    6029529      Asia 79.69600
    ## 768                    Israel 2007    6426679      Asia 80.74500
    ## 769                     Italy 1952   47666000    Europe 65.94000
    ## 770                     Italy 1957   49182000    Europe 67.81000
    ## 771                     Italy 1962   50843200    Europe 69.24000
    ## 772                     Italy 1967   52667100    Europe 71.06000
    ## 773                     Italy 1972   54365564    Europe 72.19000
    ## 774                     Italy 1977   56059245    Europe 73.48000
    ## 775                     Italy 1982   56535636    Europe 74.98000
    ## 776                     Italy 1987   56729703    Europe 76.42000
    ## 777                     Italy 1992   56840847    Europe 77.44000
    ## 778                     Italy 1997   57479469    Europe 78.82000
    ## 779                     Italy 2002   57926999    Europe 80.24000
    ## 780                     Italy 2007   58147733    Europe 80.54600
    ## 781                   Jamaica 1952    1426095  Americas 58.53000
    ## 782                   Jamaica 1957    1535090  Americas 62.61000
    ## 783                   Jamaica 1962    1665128  Americas 65.61000
    ## 784                   Jamaica 1967    1861096  Americas 67.51000
    ## 785                   Jamaica 1972    1997616  Americas 69.00000
    ## 786                   Jamaica 1977    2156814  Americas 70.11000
    ## 787                   Jamaica 1982    2298309  Americas 71.21000
    ## 788                   Jamaica 1987    2326606  Americas 71.77000
    ## 789                   Jamaica 1992    2378618  Americas 71.76600
    ## 790                   Jamaica 1997    2531311  Americas 72.26200
    ## 791                   Jamaica 2002    2664659  Americas 72.04700
    ## 792                   Jamaica 2007    2780132  Americas 72.56700
    ## 793                     Japan 1952   86459025      Asia 63.03000
    ## 794                     Japan 1957   91563009      Asia 65.50000
    ## 795                     Japan 1962   95831757      Asia 68.73000
    ## 796                     Japan 1967  100825279      Asia 71.43000
    ## 797                     Japan 1972  107188273      Asia 73.42000
    ## 798                     Japan 1977  113872473      Asia 75.38000
    ## 799                     Japan 1982  118454974      Asia 77.11000
    ## 800                     Japan 1987  122091325      Asia 78.67000
    ## 801                     Japan 1992  124329269      Asia 79.36000
    ## 802                     Japan 1997  125956499      Asia 80.69000
    ## 803                     Japan 2002  127065841      Asia 82.00000
    ## 804                     Japan 2007  127467972      Asia 82.60300
    ## 805                    Jordan 1952     607914      Asia 43.15800
    ## 806                    Jordan 1957     746559      Asia 45.66900
    ## 807                    Jordan 1962     933559      Asia 48.12600
    ## 808                    Jordan 1967    1255058      Asia 51.62900
    ## 809                    Jordan 1972    1613551      Asia 56.52800
    ## 810                    Jordan 1977    1937652      Asia 61.13400
    ## 811                    Jordan 1982    2347031      Asia 63.73900
    ## 812                    Jordan 1987    2820042      Asia 65.86900
    ## 813                    Jordan 1992    3867409      Asia 68.01500
    ## 814                    Jordan 1997    4526235      Asia 69.77200
    ## 815                    Jordan 2002    5307470      Asia 71.26300
    ## 816                    Jordan 2007    6053193      Asia 72.53500
    ## 817                     Kenya 1952    6464046    Africa 42.27000
    ## 818                     Kenya 1957    7454779    Africa 44.68600
    ## 819                     Kenya 1962    8678557    Africa 47.94900
    ## 820                     Kenya 1967   10191512    Africa 50.65400
    ## 821                     Kenya 1972   12044785    Africa 53.55900
    ## 822                     Kenya 1977   14500404    Africa 56.15500
    ## 823                     Kenya 1982   17661452    Africa 58.76600
    ## 824                     Kenya 1987   21198082    Africa 59.33900
    ## 825                     Kenya 1992   25020539    Africa 59.28500
    ## 826                     Kenya 1997   28263827    Africa 54.40700
    ## 827                     Kenya 2002   31386842    Africa 50.99200
    ## 828                     Kenya 2007   35610177    Africa 54.11000
    ## 829           Korea Dem. Rep. 1952    8865488      Asia 50.05600
    ## 830           Korea Dem. Rep. 1957    9411381      Asia 54.08100
    ## 831           Korea Dem. Rep. 1962   10917494      Asia 56.65600
    ## 832           Korea Dem. Rep. 1967   12617009      Asia 59.94200
    ## 833           Korea Dem. Rep. 1972   14781241      Asia 63.98300
    ## 834           Korea Dem. Rep. 1977   16325320      Asia 67.15900
    ## 835           Korea Dem. Rep. 1982   17647518      Asia 69.10000
    ## 836           Korea Dem. Rep. 1987   19067554      Asia 70.64700
    ## 837           Korea Dem. Rep. 1992   20711375      Asia 69.97800
    ## 838           Korea Dem. Rep. 1997   21585105      Asia 67.72700
    ## 839           Korea Dem. Rep. 2002   22215365      Asia 66.66200
    ## 840           Korea Dem. Rep. 2007   23301725      Asia 67.29700
    ## 841                Korea Rep. 1952   20947571      Asia 47.45300
    ## 842                Korea Rep. 1957   22611552      Asia 52.68100
    ## 843                Korea Rep. 1962   26420307      Asia 55.29200
    ## 844                Korea Rep. 1967   30131000      Asia 57.71600
    ## 845                Korea Rep. 1972   33505000      Asia 62.61200
    ## 846                Korea Rep. 1977   36436000      Asia 64.76600
    ## 847                Korea Rep. 1982   39326000      Asia 67.12300
    ## 848                Korea Rep. 1987   41622000      Asia 69.81000
    ## 849                Korea Rep. 1992   43805450      Asia 72.24400
    ## 850                Korea Rep. 1997   46173816      Asia 74.64700
    ## 851                Korea Rep. 2002   47969150      Asia 77.04500
    ## 852                Korea Rep. 2007   49044790      Asia 78.62300
    ## 853                    Kuwait 1952     160000      Asia 55.56500
    ## 854                    Kuwait 1957     212846      Asia 58.03300
    ## 855                    Kuwait 1962     358266      Asia 60.47000
    ## 856                    Kuwait 1967     575003      Asia 64.62400
    ## 857                    Kuwait 1972     841934      Asia 67.71200
    ## 858                    Kuwait 1977    1140357      Asia 69.34300
    ## 859                    Kuwait 1982    1497494      Asia 71.30900
    ## 860                    Kuwait 1987    1891487      Asia 74.17400
    ## 861                    Kuwait 1992    1418095      Asia 75.19000
    ## 862                    Kuwait 1997    1765345      Asia 76.15600
    ## 863                    Kuwait 2002    2111561      Asia 76.90400
    ## 864                    Kuwait 2007    2505559      Asia 77.58800
    ## 865                   Lebanon 1952    1439529      Asia 55.92800
    ## 866                   Lebanon 1957    1647412      Asia 59.48900
    ## 867                   Lebanon 1962    1886848      Asia 62.09400
    ## 868                   Lebanon 1967    2186894      Asia 63.87000
    ## 869                   Lebanon 1972    2680018      Asia 65.42100
    ## 870                   Lebanon 1977    3115787      Asia 66.09900
    ## 871                   Lebanon 1982    3086876      Asia 66.98300
    ## 872                   Lebanon 1987    3089353      Asia 67.92600
    ## 873                   Lebanon 1992    3219994      Asia 69.29200
    ## 874                   Lebanon 1997    3430388      Asia 70.26500
    ## 875                   Lebanon 2002    3677780      Asia 71.02800
    ## 876                   Lebanon 2007    3921278      Asia 71.99300
    ## 877                   Lesotho 1952     748747    Africa 42.13800
    ## 878                   Lesotho 1957     813338    Africa 45.04700
    ## 879                   Lesotho 1962     893143    Africa 47.74700
    ## 880                   Lesotho 1967     996380    Africa 48.49200
    ## 881                   Lesotho 1972    1116779    Africa 49.76700
    ## 882                   Lesotho 1977    1251524    Africa 52.20800
    ## 883                   Lesotho 1982    1411807    Africa 55.07800
    ## 884                   Lesotho 1987    1599200    Africa 57.18000
    ## 885                   Lesotho 1992    1803195    Africa 59.68500
    ## 886                   Lesotho 1997    1982823    Africa 55.55800
    ## 887                   Lesotho 2002    2046772    Africa 44.59300
    ## 888                   Lesotho 2007    2012649    Africa 42.59200
    ## 889                   Liberia 1952     863308    Africa 38.48000
    ## 890                   Liberia 1957     975950    Africa 39.48600
    ## 891                   Liberia 1962    1112796    Africa 40.50200
    ## 892                   Liberia 1967    1279406    Africa 41.53600
    ## 893                   Liberia 1972    1482628    Africa 42.61400
    ## 894                   Liberia 1977    1703617    Africa 43.76400
    ## 895                   Liberia 1982    1956875    Africa 44.85200
    ## 896                   Liberia 1987    2269414    Africa 46.02700
    ## 897                   Liberia 1992    1912974    Africa 40.80200
    ## 898                   Liberia 1997    2200725    Africa 42.22100
    ## 899                   Liberia 2002    2814651    Africa 43.75300
    ## 900                   Liberia 2007    3193942    Africa 45.67800
    ## 901                     Libya 1952    1019729    Africa 42.72300
    ## 902                     Libya 1957    1201578    Africa 45.28900
    ## 903                     Libya 1962    1441863    Africa 47.80800
    ## 904                     Libya 1967    1759224    Africa 50.22700
    ## 905                     Libya 1972    2183877    Africa 52.77300
    ## 906                     Libya 1977    2721783    Africa 57.44200
    ## 907                     Libya 1982    3344074    Africa 62.15500
    ## 908                     Libya 1987    3799845    Africa 66.23400
    ## 909                     Libya 1992    4364501    Africa 68.75500
    ## 910                     Libya 1997    4759670    Africa 71.55500
    ## 911                     Libya 2002    5368585    Africa 72.73700
    ## 912                     Libya 2007    6036914    Africa 73.95200
    ## 913                Madagascar 1952    4762912    Africa 36.68100
    ## 914                Madagascar 1957    5181679    Africa 38.86500
    ## 915                Madagascar 1962    5703324    Africa 40.84800
    ## 916                Madagascar 1967    6334556    Africa 42.88100
    ## 917                Madagascar 1972    7082430    Africa 44.85100
    ## 918                Madagascar 1977    8007166    Africa 46.88100
    ## 919                Madagascar 1982    9171477    Africa 48.96900
    ## 920                Madagascar 1987   10568642    Africa 49.35000
    ## 921                Madagascar 1992   12210395    Africa 52.21400
    ## 922                Madagascar 1997   14165114    Africa 54.97800
    ## 923                Madagascar 2002   16473477    Africa 57.28600
    ## 924                Madagascar 2007   19167654    Africa 59.44300
    ## 925                    Malawi 1952    2917802    Africa 36.25600
    ## 926                    Malawi 1957    3221238    Africa 37.20700
    ## 927                    Malawi 1962    3628608    Africa 38.41000
    ## 928                    Malawi 1967    4147252    Africa 39.48700
    ## 929                    Malawi 1972    4730997    Africa 41.76600
    ## 930                    Malawi 1977    5637246    Africa 43.76700
    ## 931                    Malawi 1982    6502825    Africa 45.64200
    ## 932                    Malawi 1987    7824747    Africa 47.45700
    ## 933                    Malawi 1992   10014249    Africa 49.42000
    ## 934                    Malawi 1997   10419991    Africa 47.49500
    ## 935                    Malawi 2002   11824495    Africa 45.00900
    ## 936                    Malawi 2007   13327079    Africa 48.30300
    ## 937                  Malaysia 1952    6748378      Asia 48.46300
    ## 938                  Malaysia 1957    7739235      Asia 52.10200
    ## 939                  Malaysia 1962    8906385      Asia 55.73700
    ## 940                  Malaysia 1967   10154878      Asia 59.37100
    ## 941                  Malaysia 1972   11441462      Asia 63.01000
    ## 942                  Malaysia 1977   12845381      Asia 65.25600
    ## 943                  Malaysia 1982   14441916      Asia 68.00000
    ## 944                  Malaysia 1987   16331785      Asia 69.50000
    ## 945                  Malaysia 1992   18319502      Asia 70.69300
    ## 946                  Malaysia 1997   20476091      Asia 71.93800
    ## 947                  Malaysia 2002   22662365      Asia 73.04400
    ## 948                  Malaysia 2007   24821286      Asia 74.24100
    ## 949                      Mali 1952    3838168    Africa 33.68500
    ## 950                      Mali 1957    4241884    Africa 35.30700
    ## 951                      Mali 1962    4690372    Africa 36.93600
    ## 952                      Mali 1967    5212416    Africa 38.48700
    ## 953                      Mali 1972    5828158    Africa 39.97700
    ## 954                      Mali 1977    6491649    Africa 41.71400
    ## 955                      Mali 1982    6998256    Africa 43.91600
    ## 956                      Mali 1987    7634008    Africa 46.36400
    ## 957                      Mali 1992    8416215    Africa 48.38800
    ## 958                      Mali 1997    9384984    Africa 49.90300
    ## 959                      Mali 2002   10580176    Africa 51.81800
    ## 960                      Mali 2007   12031795    Africa 54.46700
    ## 961                Mauritania 1952    1022556    Africa 40.54300
    ## 962                Mauritania 1957    1076852    Africa 42.33800
    ## 963                Mauritania 1962    1146757    Africa 44.24800
    ## 964                Mauritania 1967    1230542    Africa 46.28900
    ## 965                Mauritania 1972    1332786    Africa 48.43700
    ## 966                Mauritania 1977    1456688    Africa 50.85200
    ## 967                Mauritania 1982    1622136    Africa 53.59900
    ## 968                Mauritania 1987    1841240    Africa 56.14500
    ## 969                Mauritania 1992    2119465    Africa 58.33300
    ## 970                Mauritania 1997    2444741    Africa 60.43000
    ## 971                Mauritania 2002    2828858    Africa 62.24700
    ## 972                Mauritania 2007    3270065    Africa 64.16400
    ## 973                 Mauritius 1952     516556    Africa 50.98600
    ## 974                 Mauritius 1957     609816    Africa 58.08900
    ## 975                 Mauritius 1962     701016    Africa 60.24600
    ## 976                 Mauritius 1967     789309    Africa 61.55700
    ## 977                 Mauritius 1972     851334    Africa 62.94400
    ## 978                 Mauritius 1977     913025    Africa 64.93000
    ## 979                 Mauritius 1982     992040    Africa 66.71100
    ## 980                 Mauritius 1987    1042663    Africa 68.74000
    ## 981                 Mauritius 1992    1096202    Africa 69.74500
    ## 982                 Mauritius 1997    1149818    Africa 70.73600
    ## 983                 Mauritius 2002    1200206    Africa 71.95400
    ## 984                 Mauritius 2007    1250882    Africa 72.80100
    ## 985                    Mexico 1952   30144317  Americas 50.78900
    ## 986                    Mexico 1957   35015548  Americas 55.19000
    ## 987                    Mexico 1962   41121485  Americas 58.29900
    ## 988                    Mexico 1967   47995559  Americas 60.11000
    ## 989                    Mexico 1972   55984294  Americas 62.36100
    ## 990                    Mexico 1977   63759976  Americas 65.03200
    ## 991                    Mexico 1982   71640904  Americas 67.40500
    ## 992                    Mexico 1987   80122492  Americas 69.49800
    ## 993                    Mexico 1992   88111030  Americas 71.45500
    ## 994                    Mexico 1997   95895146  Americas 73.67000
    ## 995                    Mexico 2002  102479927  Americas 74.90200
    ## 996                    Mexico 2007  108700891  Americas 76.19500
    ## 997                  Mongolia 1952     800663      Asia 42.24400
    ## 998                  Mongolia 1957     882134      Asia 45.24800
    ## 999                  Mongolia 1962    1010280      Asia 48.25100
    ## 1000                 Mongolia 1967    1149500      Asia 51.25300
    ## 1001                 Mongolia 1972    1320500      Asia 53.75400
    ## 1002                 Mongolia 1977    1528000      Asia 55.49100
    ## 1003                 Mongolia 1982    1756032      Asia 57.48900
    ## 1004                 Mongolia 1987    2015133      Asia 60.22200
    ## 1005                 Mongolia 1992    2312802      Asia 61.27100
    ## 1006                 Mongolia 1997    2494803      Asia 63.62500
    ## 1007                 Mongolia 2002    2674234      Asia 65.03300
    ## 1008                 Mongolia 2007    2874127      Asia 66.80300
    ## 1009               Montenegro 1952     413834    Europe 59.16400
    ## 1010               Montenegro 1957     442829    Europe 61.44800
    ## 1011               Montenegro 1962     474528    Europe 63.72800
    ## 1012               Montenegro 1967     501035    Europe 67.17800
    ## 1013               Montenegro 1972     527678    Europe 70.63600
    ## 1014               Montenegro 1977     560073    Europe 73.06600
    ## 1015               Montenegro 1982     562548    Europe 74.10100
    ## 1016               Montenegro 1987     569473    Europe 74.86500
    ## 1017               Montenegro 1992     621621    Europe 75.43500
    ## 1018               Montenegro 1997     692651    Europe 75.44500
    ## 1019               Montenegro 2002     720230    Europe 73.98100
    ## 1020               Montenegro 2007     684736    Europe 74.54300
    ## 1021                  Morocco 1952    9939217    Africa 42.87300
    ## 1022                  Morocco 1957   11406350    Africa 45.42300
    ## 1023                  Morocco 1962   13056604    Africa 47.92400
    ## 1024                  Morocco 1967   14770296    Africa 50.33500
    ## 1025                  Morocco 1972   16660670    Africa 52.86200
    ## 1026                  Morocco 1977   18396941    Africa 55.73000
    ## 1027                  Morocco 1982   20198730    Africa 59.65000
    ## 1028                  Morocco 1987   22987397    Africa 62.67700
    ## 1029                  Morocco 1992   25798239    Africa 65.39300
    ## 1030                  Morocco 1997   28529501    Africa 67.66000
    ## 1031                  Morocco 2002   31167783    Africa 69.61500
    ## 1032                  Morocco 2007   33757175    Africa 71.16400
    ## 1033               Mozambique 1952    6446316    Africa 31.28600
    ## 1034               Mozambique 1957    7038035    Africa 33.77900
    ## 1035               Mozambique 1962    7788944    Africa 36.16100
    ## 1036               Mozambique 1967    8680909    Africa 38.11300
    ## 1037               Mozambique 1972    9809596    Africa 40.32800
    ## 1038               Mozambique 1977   11127868    Africa 42.49500
    ## 1039               Mozambique 1982   12587223    Africa 42.79500
    ## 1040               Mozambique 1987   12891952    Africa 42.86100
    ## 1041               Mozambique 1992   13160731    Africa 44.28400
    ## 1042               Mozambique 1997   16603334    Africa 46.34400
    ## 1043               Mozambique 2002   18473780    Africa 44.02600
    ## 1044               Mozambique 2007   19951656    Africa 42.08200
    ## 1045                  Myanmar 1952   20092996      Asia 36.31900
    ## 1046                  Myanmar 1957   21731844      Asia 41.90500
    ## 1047                  Myanmar 1962   23634436      Asia 45.10800
    ## 1048                  Myanmar 1967   25870271      Asia 49.37900
    ## 1049                  Myanmar 1972   28466390      Asia 53.07000
    ## 1050                  Myanmar 1977   31528087      Asia 56.05900
    ## 1051                  Myanmar 1982   34680442      Asia 58.05600
    ## 1052                  Myanmar 1987   38028578      Asia 58.33900
    ## 1053                  Myanmar 1992   40546538      Asia 59.32000
    ## 1054                  Myanmar 1997   43247867      Asia 60.32800
    ## 1055                  Myanmar 2002   45598081      Asia 59.90800
    ## 1056                  Myanmar 2007   47761980      Asia 62.06900
    ## 1057                  Namibia 1952     485831    Africa 41.72500
    ## 1058                  Namibia 1957     548080    Africa 45.22600
    ## 1059                  Namibia 1962     621392    Africa 48.38600
    ## 1060                  Namibia 1967     706640    Africa 51.15900
    ## 1061                  Namibia 1972     821782    Africa 53.86700
    ## 1062                  Namibia 1977     977026    Africa 56.43700
    ## 1063                  Namibia 1982    1099010    Africa 58.96800
    ## 1064                  Namibia 1987    1278184    Africa 60.83500
    ## 1065                  Namibia 1992    1554253    Africa 61.99900
    ## 1066                  Namibia 1997    1774766    Africa 58.90900
    ## 1067                  Namibia 2002    1972153    Africa 51.47900
    ## 1068                  Namibia 2007    2055080    Africa 52.90600
    ## 1069                    Nepal 1952    9182536      Asia 36.15700
    ## 1070                    Nepal 1957    9682338      Asia 37.68600
    ## 1071                    Nepal 1962   10332057      Asia 39.39300
    ## 1072                    Nepal 1967   11261690      Asia 41.47200
    ## 1073                    Nepal 1972   12412593      Asia 43.97100
    ## 1074                    Nepal 1977   13933198      Asia 46.74800
    ## 1075                    Nepal 1982   15796314      Asia 49.59400
    ## 1076                    Nepal 1987   17917180      Asia 52.53700
    ## 1077                    Nepal 1992   20326209      Asia 55.72700
    ## 1078                    Nepal 1997   23001113      Asia 59.42600
    ## 1079                    Nepal 2002   25873917      Asia 61.34000
    ## 1080                    Nepal 2007   28901790      Asia 63.78500
    ## 1081              Netherlands 1952   10381988    Europe 72.13000
    ## 1082              Netherlands 1957   11026383    Europe 72.99000
    ## 1083              Netherlands 1962   11805689    Europe 73.23000
    ## 1084              Netherlands 1967   12596822    Europe 73.82000
    ## 1085              Netherlands 1972   13329874    Europe 73.75000
    ## 1086              Netherlands 1977   13852989    Europe 75.24000
    ## 1087              Netherlands 1982   14310401    Europe 76.05000
    ## 1088              Netherlands 1987   14665278    Europe 76.83000
    ## 1089              Netherlands 1992   15174244    Europe 77.42000
    ## 1090              Netherlands 1997   15604464    Europe 78.03000
    ## 1091              Netherlands 2002   16122830    Europe 78.53000
    ## 1092              Netherlands 2007   16570613    Europe 79.76200
    ## 1093              New Zealand 1952    1994794   Oceania 69.39000
    ## 1094              New Zealand 1957    2229407   Oceania 70.26000
    ## 1095              New Zealand 1962    2488550   Oceania 71.24000
    ## 1096              New Zealand 1967    2728150   Oceania 71.52000
    ## 1097              New Zealand 1972    2929100   Oceania 71.89000
    ## 1098              New Zealand 1977    3164900   Oceania 72.22000
    ## 1099              New Zealand 1982    3210650   Oceania 73.84000
    ## 1100              New Zealand 1987    3317166   Oceania 74.32000
    ## 1101              New Zealand 1992    3437674   Oceania 76.33000
    ## 1102              New Zealand 1997    3676187   Oceania 77.55000
    ## 1103              New Zealand 2002    3908037   Oceania 79.11000
    ## 1104              New Zealand 2007    4115771   Oceania 80.20400
    ## 1105                Nicaragua 1952    1165790  Americas 42.31400
    ## 1106                Nicaragua 1957    1358828  Americas 45.43200
    ## 1107                Nicaragua 1962    1590597  Americas 48.63200
    ## 1108                Nicaragua 1967    1865490  Americas 51.88400
    ## 1109                Nicaragua 1972    2182908  Americas 55.15100
    ## 1110                Nicaragua 1977    2554598  Americas 57.47000
    ## 1111                Nicaragua 1982    2979423  Americas 59.29800
    ## 1112                Nicaragua 1987    3344353  Americas 62.00800
    ## 1113                Nicaragua 1992    4017939  Americas 65.84300
    ## 1114                Nicaragua 1997    4609572  Americas 68.42600
    ## 1115                Nicaragua 2002    5146848  Americas 70.83600
    ## 1116                Nicaragua 2007    5675356  Americas 72.89900
    ## 1117                    Niger 1952    3379468    Africa 37.44400
    ## 1118                    Niger 1957    3692184    Africa 38.59800
    ## 1119                    Niger 1962    4076008    Africa 39.48700
    ## 1120                    Niger 1967    4534062    Africa 40.11800
    ## 1121                    Niger 1972    5060262    Africa 40.54600
    ## 1122                    Niger 1977    5682086    Africa 41.29100
    ## 1123                    Niger 1982    6437188    Africa 42.59800
    ## 1124                    Niger 1987    7332638    Africa 44.55500
    ## 1125                    Niger 1992    8392818    Africa 47.39100
    ## 1126                    Niger 1997    9666252    Africa 51.31300
    ## 1127                    Niger 2002   11140655    Africa 54.49600
    ## 1128                    Niger 2007   12894865    Africa 56.86700
    ## 1129                  Nigeria 1952   33119096    Africa 36.32400
    ## 1130                  Nigeria 1957   37173340    Africa 37.80200
    ## 1131                  Nigeria 1962   41871351    Africa 39.36000
    ## 1132                  Nigeria 1967   47287752    Africa 41.04000
    ## 1133                  Nigeria 1972   53740085    Africa 42.82100
    ## 1134                  Nigeria 1977   62209173    Africa 44.51400
    ## 1135                  Nigeria 1982   73039376    Africa 45.82600
    ## 1136                  Nigeria 1987   81551520    Africa 46.88600
    ## 1137                  Nigeria 1992   93364244    Africa 47.47200
    ## 1138                  Nigeria 1997  106207839    Africa 47.46400
    ## 1139                  Nigeria 2002  119901274    Africa 46.60800
    ## 1140                  Nigeria 2007  135031164    Africa 46.85900
    ## 1141                   Norway 1952    3327728    Europe 72.67000
    ## 1142                   Norway 1957    3491938    Europe 73.44000
    ## 1143                   Norway 1962    3638919    Europe 73.47000
    ## 1144                   Norway 1967    3786019    Europe 74.08000
    ## 1145                   Norway 1972    3933004    Europe 74.34000
    ## 1146                   Norway 1977    4043205    Europe 75.37000
    ## 1147                   Norway 1982    4114787    Europe 75.97000
    ## 1148                   Norway 1987    4186147    Europe 75.89000
    ## 1149                   Norway 1992    4286357    Europe 77.32000
    ## 1150                   Norway 1997    4405672    Europe 78.32000
    ## 1151                   Norway 2002    4535591    Europe 79.05000
    ## 1152                   Norway 2007    4627926    Europe 80.19600
    ## 1153                     Oman 1952     507833      Asia 37.57800
    ## 1154                     Oman 1957     561977      Asia 40.08000
    ## 1155                     Oman 1962     628164      Asia 43.16500
    ## 1156                     Oman 1967     714775      Asia 46.98800
    ## 1157                     Oman 1972     829050      Asia 52.14300
    ## 1158                     Oman 1977    1004533      Asia 57.36700
    ## 1159                     Oman 1982    1301048      Asia 62.72800
    ## 1160                     Oman 1987    1593882      Asia 67.73400
    ## 1161                     Oman 1992    1915208      Asia 71.19700
    ## 1162                     Oman 1997    2283635      Asia 72.49900
    ## 1163                     Oman 2002    2713462      Asia 74.19300
    ## 1164                     Oman 2007    3204897      Asia 75.64000
    ## 1165                 Pakistan 1952   41346560      Asia 43.43600
    ## 1166                 Pakistan 1957   46679944      Asia 45.55700
    ## 1167                 Pakistan 1962   53100671      Asia 47.67000
    ## 1168                 Pakistan 1967   60641899      Asia 49.80000
    ## 1169                 Pakistan 1972   69325921      Asia 51.92900
    ## 1170                 Pakistan 1977   78152686      Asia 54.04300
    ## 1171                 Pakistan 1982   91462088      Asia 56.15800
    ## 1172                 Pakistan 1987  105186881      Asia 58.24500
    ## 1173                 Pakistan 1992  120065004      Asia 60.83800
    ## 1174                 Pakistan 1997  135564834      Asia 61.81800
    ## 1175                 Pakistan 2002  153403524      Asia 63.61000
    ## 1176                 Pakistan 2007  169270617      Asia 65.48300
    ## 1177                   Panama 1952     940080  Americas 55.19100
    ## 1178                   Panama 1957    1063506  Americas 59.20100
    ## 1179                   Panama 1962    1215725  Americas 61.81700
    ## 1180                   Panama 1967    1405486  Americas 64.07100
    ## 1181                   Panama 1972    1616384  Americas 66.21600
    ## 1182                   Panama 1977    1839782  Americas 68.68100
    ## 1183                   Panama 1982    2036305  Americas 70.47200
    ## 1184                   Panama 1987    2253639  Americas 71.52300
    ## 1185                   Panama 1992    2484997  Americas 72.46200
    ## 1186                   Panama 1997    2734531  Americas 73.73800
    ## 1187                   Panama 2002    2990875  Americas 74.71200
    ## 1188                   Panama 2007    3242173  Americas 75.53700
    ## 1189                 Paraguay 1952    1555876  Americas 62.64900
    ## 1190                 Paraguay 1957    1770902  Americas 63.19600
    ## 1191                 Paraguay 1962    2009813  Americas 64.36100
    ## 1192                 Paraguay 1967    2287985  Americas 64.95100
    ## 1193                 Paraguay 1972    2614104  Americas 65.81500
    ## 1194                 Paraguay 1977    2984494  Americas 66.35300
    ## 1195                 Paraguay 1982    3366439  Americas 66.87400
    ## 1196                 Paraguay 1987    3886512  Americas 67.37800
    ## 1197                 Paraguay 1992    4483945  Americas 68.22500
    ## 1198                 Paraguay 1997    5154123  Americas 69.40000
    ## 1199                 Paraguay 2002    5884491  Americas 70.75500
    ## 1200                 Paraguay 2007    6667147  Americas 71.75200
    ## 1201                     Peru 1952    8025700  Americas 43.90200
    ## 1202                     Peru 1957    9146100  Americas 46.26300
    ## 1203                     Peru 1962   10516500  Americas 49.09600
    ## 1204                     Peru 1967   12132200  Americas 51.44500
    ## 1205                     Peru 1972   13954700  Americas 55.44800
    ## 1206                     Peru 1977   15990099  Americas 58.44700
    ## 1207                     Peru 1982   18125129  Americas 61.40600
    ## 1208                     Peru 1987   20195924  Americas 64.13400
    ## 1209                     Peru 1992   22430449  Americas 66.45800
    ## 1210                     Peru 1997   24748122  Americas 68.38600
    ## 1211                     Peru 2002   26769436  Americas 69.90600
    ## 1212                     Peru 2007   28674757  Americas 71.42100
    ## 1213              Philippines 1952   22438691      Asia 47.75200
    ## 1214              Philippines 1957   26072194      Asia 51.33400
    ## 1215              Philippines 1962   30325264      Asia 54.75700
    ## 1216              Philippines 1967   35356600      Asia 56.39300
    ## 1217              Philippines 1972   40850141      Asia 58.06500
    ## 1218              Philippines 1977   46850962      Asia 60.06000
    ## 1219              Philippines 1982   53456774      Asia 62.08200
    ## 1220              Philippines 1987   60017788      Asia 64.15100
    ## 1221              Philippines 1992   67185766      Asia 66.45800
    ## 1222              Philippines 1997   75012988      Asia 68.56400
    ## 1223              Philippines 2002   82995088      Asia 70.30300
    ## 1224              Philippines 2007   91077287      Asia 71.68800
    ## 1225                   Poland 1952   25730551    Europe 61.31000
    ## 1226                   Poland 1957   28235346    Europe 65.77000
    ## 1227                   Poland 1962   30329617    Europe 67.64000
    ## 1228                   Poland 1967   31785378    Europe 69.61000
    ## 1229                   Poland 1972   33039545    Europe 70.85000
    ## 1230                   Poland 1977   34621254    Europe 70.67000
    ## 1231                   Poland 1982   36227381    Europe 71.32000
    ## 1232                   Poland 1987   37740710    Europe 70.98000
    ## 1233                   Poland 1992   38370697    Europe 70.99000
    ## 1234                   Poland 1997   38654957    Europe 72.75000
    ## 1235                   Poland 2002   38625976    Europe 74.67000
    ## 1236                   Poland 2007   38518241    Europe 75.56300
    ## 1237                 Portugal 1952    8526050    Europe 59.82000
    ## 1238                 Portugal 1957    8817650    Europe 61.51000
    ## 1239                 Portugal 1962    9019800    Europe 64.39000
    ## 1240                 Portugal 1967    9103000    Europe 66.60000
    ## 1241                 Portugal 1972    8970450    Europe 69.26000
    ## 1242                 Portugal 1977    9662600    Europe 70.41000
    ## 1243                 Portugal 1982    9859650    Europe 72.77000
    ## 1244                 Portugal 1987    9915289    Europe 74.06000
    ## 1245                 Portugal 1992    9927680    Europe 74.86000
    ## 1246                 Portugal 1997   10156415    Europe 75.97000
    ## 1247                 Portugal 2002   10433867    Europe 77.29000
    ## 1248                 Portugal 2007   10642836    Europe 78.09800
    ## 1249              Puerto Rico 1952    2227000  Americas 64.28000
    ## 1250              Puerto Rico 1957    2260000  Americas 68.54000
    ## 1251              Puerto Rico 1962    2448046  Americas 69.62000
    ## 1252              Puerto Rico 1967    2648961  Americas 71.10000
    ## 1253              Puerto Rico 1972    2847132  Americas 72.16000
    ## 1254              Puerto Rico 1977    3080828  Americas 73.44000
    ## 1255              Puerto Rico 1982    3279001  Americas 73.75000
    ## 1256              Puerto Rico 1987    3444468  Americas 74.63000
    ## 1257              Puerto Rico 1992    3585176  Americas 73.91100
    ## 1258              Puerto Rico 1997    3759430  Americas 74.91700
    ## 1259              Puerto Rico 2002    3859606  Americas 77.77800
    ## 1260              Puerto Rico 2007    3942491  Americas 78.74600
    ## 1261                  Reunion 1952     257700    Africa 52.72400
    ## 1262                  Reunion 1957     308700    Africa 55.09000
    ## 1263                  Reunion 1962     358900    Africa 57.66600
    ## 1264                  Reunion 1967     414024    Africa 60.54200
    ## 1265                  Reunion 1972     461633    Africa 64.27400
    ## 1266                  Reunion 1977     492095    Africa 67.06400
    ## 1267                  Reunion 1982     517810    Africa 69.88500
    ## 1268                  Reunion 1987     562035    Africa 71.91300
    ## 1269                  Reunion 1992     622191    Africa 73.61500
    ## 1270                  Reunion 1997     684810    Africa 74.77200
    ## 1271                  Reunion 2002     743981    Africa 75.74400
    ## 1272                  Reunion 2007     798094    Africa 76.44200
    ## 1273                  Romania 1952   16630000    Europe 61.05000
    ## 1274                  Romania 1957   17829327    Europe 64.10000
    ## 1275                  Romania 1962   18680721    Europe 66.80000
    ## 1276                  Romania 1967   19284814    Europe 66.80000
    ## 1277                  Romania 1972   20662648    Europe 69.21000
    ## 1278                  Romania 1977   21658597    Europe 69.46000
    ## 1279                  Romania 1982   22356726    Europe 69.66000
    ## 1280                  Romania 1987   22686371    Europe 69.53000
    ## 1281                  Romania 1992   22797027    Europe 69.36000
    ## 1282                  Romania 1997   22562458    Europe 69.72000
    ## 1283                  Romania 2002   22404337    Europe 71.32200
    ## 1284                  Romania 2007   22276056    Europe 72.47600
    ## 1285                   Rwanda 1952    2534927    Africa 40.00000
    ## 1286                   Rwanda 1957    2822082    Africa 41.50000
    ## 1287                   Rwanda 1962    3051242    Africa 43.00000
    ## 1288                   Rwanda 1967    3451079    Africa 44.10000
    ## 1289                   Rwanda 1972    3992121    Africa 44.60000
    ## 1290                   Rwanda 1977    4657072    Africa 45.00000
    ## 1291                   Rwanda 1982    5507565    Africa 46.21800
    ## 1292                   Rwanda 1987    6349365    Africa 44.02000
    ## 1293                   Rwanda 1992    7290203    Africa 23.59900
    ## 1294                   Rwanda 1997    7212583    Africa 36.08700
    ## 1295                   Rwanda 2002    7852401    Africa 43.41300
    ## 1296                   Rwanda 2007    8860588    Africa 46.24200
    ## 1297    Sao Tome and Principe 1952      60011    Africa 46.47100
    ## 1298    Sao Tome and Principe 1957      61325    Africa 48.94500
    ## 1299    Sao Tome and Principe 1962      65345    Africa 51.89300
    ## 1300    Sao Tome and Principe 1967      70787    Africa 54.42500
    ## 1301    Sao Tome and Principe 1972      76595    Africa 56.48000
    ## 1302    Sao Tome and Principe 1977      86796    Africa 58.55000
    ## 1303    Sao Tome and Principe 1982      98593    Africa 60.35100
    ## 1304    Sao Tome and Principe 1987     110812    Africa 61.72800
    ## 1305    Sao Tome and Principe 1992     125911    Africa 62.74200
    ## 1306    Sao Tome and Principe 1997     145608    Africa 63.30600
    ## 1307    Sao Tome and Principe 2002     170372    Africa 64.33700
    ## 1308    Sao Tome and Principe 2007     199579    Africa 65.52800
    ## 1309             Saudi Arabia 1952    4005677      Asia 39.87500
    ## 1310             Saudi Arabia 1957    4419650      Asia 42.86800
    ## 1311             Saudi Arabia 1962    4943029      Asia 45.91400
    ## 1312             Saudi Arabia 1967    5618198      Asia 49.90100
    ## 1313             Saudi Arabia 1972    6472756      Asia 53.88600
    ## 1314             Saudi Arabia 1977    8128505      Asia 58.69000
    ## 1315             Saudi Arabia 1982   11254672      Asia 63.01200
    ## 1316             Saudi Arabia 1987   14619745      Asia 66.29500
    ## 1317             Saudi Arabia 1992   16945857      Asia 68.76800
    ## 1318             Saudi Arabia 1997   21229759      Asia 70.53300
    ## 1319             Saudi Arabia 2002   24501530      Asia 71.62600
    ## 1320             Saudi Arabia 2007   27601038      Asia 72.77700
    ## 1321                  Senegal 1952    2755589    Africa 37.27800
    ## 1322                  Senegal 1957    3054547    Africa 39.32900
    ## 1323                  Senegal 1962    3430243    Africa 41.45400
    ## 1324                  Senegal 1967    3965841    Africa 43.56300
    ## 1325                  Senegal 1972    4588696    Africa 45.81500
    ## 1326                  Senegal 1977    5260855    Africa 48.87900
    ## 1327                  Senegal 1982    6147783    Africa 52.37900
    ## 1328                  Senegal 1987    7171347    Africa 55.76900
    ## 1329                  Senegal 1992    8307920    Africa 58.19600
    ## 1330                  Senegal 1997    9535314    Africa 60.18700
    ## 1331                  Senegal 2002   10870037    Africa 61.60000
    ## 1332                  Senegal 2007   12267493    Africa 63.06200
    ## 1333                   Serbia 1952    6860147    Europe 57.99600
    ## 1334                   Serbia 1957    7271135    Europe 61.68500
    ## 1335                   Serbia 1962    7616060    Europe 64.53100
    ## 1336                   Serbia 1967    7971222    Europe 66.91400
    ## 1337                   Serbia 1972    8313288    Europe 68.70000
    ## 1338                   Serbia 1977    8686367    Europe 70.30000
    ## 1339                   Serbia 1982    9032824    Europe 70.16200
    ## 1340                   Serbia 1987    9230783    Europe 71.21800
    ## 1341                   Serbia 1992    9826397    Europe 71.65900
    ## 1342                   Serbia 1997   10336594    Europe 72.23200
    ## 1343                   Serbia 2002   10111559    Europe 73.21300
    ## 1344                   Serbia 2007   10150265    Europe 74.00200
    ## 1345             Sierra Leone 1952    2143249    Africa 30.33100
    ## 1346             Sierra Leone 1957    2295678    Africa 31.57000
    ## 1347             Sierra Leone 1962    2467895    Africa 32.76700
    ## 1348             Sierra Leone 1967    2662190    Africa 34.11300
    ## 1349             Sierra Leone 1972    2879013    Africa 35.40000
    ## 1350             Sierra Leone 1977    3140897    Africa 36.78800
    ## 1351             Sierra Leone 1982    3464522    Africa 38.44500
    ## 1352             Sierra Leone 1987    3868905    Africa 40.00600
    ## 1353             Sierra Leone 1992    4260884    Africa 38.33300
    ## 1354             Sierra Leone 1997    4578212    Africa 39.89700
    ## 1355             Sierra Leone 2002    5359092    Africa 41.01200
    ## 1356             Sierra Leone 2007    6144562    Africa 42.56800
    ## 1357                Singapore 1952    1127000      Asia 60.39600
    ## 1358                Singapore 1957    1445929      Asia 63.17900
    ## 1359                Singapore 1962    1750200      Asia 65.79800
    ## 1360                Singapore 1967    1977600      Asia 67.94600
    ## 1361                Singapore 1972    2152400      Asia 69.52100
    ## 1362                Singapore 1977    2325300      Asia 70.79500
    ## 1363                Singapore 1982    2651869      Asia 71.76000
    ## 1364                Singapore 1987    2794552      Asia 73.56000
    ## 1365                Singapore 1992    3235865      Asia 75.78800
    ## 1366                Singapore 1997    3802309      Asia 77.15800
    ## 1367                Singapore 2002    4197776      Asia 78.77000
    ## 1368                Singapore 2007    4553009      Asia 79.97200
    ## 1369          Slovak Republic 1952    3558137    Europe 64.36000
    ## 1370          Slovak Republic 1957    3844277    Europe 67.45000
    ## 1371          Slovak Republic 1962    4237384    Europe 70.33000
    ## 1372          Slovak Republic 1967    4442238    Europe 70.98000
    ## 1373          Slovak Republic 1972    4593433    Europe 70.35000
    ## 1374          Slovak Republic 1977    4827803    Europe 70.45000
    ## 1375          Slovak Republic 1982    5048043    Europe 70.80000
    ## 1376          Slovak Republic 1987    5199318    Europe 71.08000
    ## 1377          Slovak Republic 1992    5302888    Europe 71.38000
    ## 1378          Slovak Republic 1997    5383010    Europe 72.71000
    ## 1379          Slovak Republic 2002    5410052    Europe 73.80000
    ## 1380          Slovak Republic 2007    5447502    Europe 74.66300
    ## 1381                 Slovenia 1952    1489518    Europe 65.57000
    ## 1382                 Slovenia 1957    1533070    Europe 67.85000
    ## 1383                 Slovenia 1962    1582962    Europe 69.15000
    ## 1384                 Slovenia 1967    1646912    Europe 69.18000
    ## 1385                 Slovenia 1972    1694510    Europe 69.82000
    ## 1386                 Slovenia 1977    1746919    Europe 70.97000
    ## 1387                 Slovenia 1982    1861252    Europe 71.06300
    ## 1388                 Slovenia 1987    1945870    Europe 72.25000
    ## 1389                 Slovenia 1992    1999210    Europe 73.64000
    ## 1390                 Slovenia 1997    2011612    Europe 75.13000
    ## 1391                 Slovenia 2002    2011497    Europe 76.66000
    ## 1392                 Slovenia 2007    2009245    Europe 77.92600
    ## 1393                  Somalia 1952    2526994    Africa 32.97800
    ## 1394                  Somalia 1957    2780415    Africa 34.97700
    ## 1395                  Somalia 1962    3080153    Africa 36.98100
    ## 1396                  Somalia 1967    3428839    Africa 38.97700
    ## 1397                  Somalia 1972    3840161    Africa 40.97300
    ## 1398                  Somalia 1977    4353666    Africa 41.97400
    ## 1399                  Somalia 1982    5828892    Africa 42.95500
    ## 1400                  Somalia 1987    6921858    Africa 44.50100
    ## 1401                  Somalia 1992    6099799    Africa 39.65800
    ## 1402                  Somalia 1997    6633514    Africa 43.79500
    ## 1403                  Somalia 2002    7753310    Africa 45.93600
    ## 1404                  Somalia 2007    9118773    Africa 48.15900
    ## 1405             South Africa 1952   14264935    Africa 45.00900
    ## 1406             South Africa 1957   16151549    Africa 47.98500
    ## 1407             South Africa 1962   18356657    Africa 49.95100
    ## 1408             South Africa 1967   20997321    Africa 51.92700
    ## 1409             South Africa 1972   23935810    Africa 53.69600
    ## 1410             South Africa 1977   27129932    Africa 55.52700
    ## 1411             South Africa 1982   31140029    Africa 58.16100
    ## 1412             South Africa 1987   35933379    Africa 60.83400
    ## 1413             South Africa 1992   39964159    Africa 61.88800
    ## 1414             South Africa 1997   42835005    Africa 60.23600
    ## 1415             South Africa 2002   44433622    Africa 53.36500
    ## 1416             South Africa 2007   43997828    Africa 49.33900
    ## 1417                    Spain 1952   28549870    Europe 64.94000
    ## 1418                    Spain 1957   29841614    Europe 66.66000
    ## 1419                    Spain 1962   31158061    Europe 69.69000
    ## 1420                    Spain 1967   32850275    Europe 71.44000
    ## 1421                    Spain 1972   34513161    Europe 73.06000
    ## 1422                    Spain 1977   36439000    Europe 74.39000
    ## 1423                    Spain 1982   37983310    Europe 76.30000
    ## 1424                    Spain 1987   38880702    Europe 76.90000
    ## 1425                    Spain 1992   39549438    Europe 77.57000
    ## 1426                    Spain 1997   39855442    Europe 78.77000
    ## 1427                    Spain 2002   40152517    Europe 79.78000
    ## 1428                    Spain 2007   40448191    Europe 80.94100
    ## 1429                Sri Lanka 1952    7982342      Asia 57.59300
    ## 1430                Sri Lanka 1957    9128546      Asia 61.45600
    ## 1431                Sri Lanka 1962   10421936      Asia 62.19200
    ## 1432                Sri Lanka 1967   11737396      Asia 64.26600
    ## 1433                Sri Lanka 1972   13016733      Asia 65.04200
    ## 1434                Sri Lanka 1977   14116836      Asia 65.94900
    ## 1435                Sri Lanka 1982   15410151      Asia 68.75700
    ## 1436                Sri Lanka 1987   16495304      Asia 69.01100
    ## 1437                Sri Lanka 1992   17587060      Asia 70.37900
    ## 1438                Sri Lanka 1997   18698655      Asia 70.45700
    ## 1439                Sri Lanka 2002   19576783      Asia 70.81500
    ## 1440                Sri Lanka 2007   20378239      Asia 72.39600
    ## 1441                    Sudan 1952    8504667    Africa 38.63500
    ## 1442                    Sudan 1957    9753392    Africa 39.62400
    ## 1443                    Sudan 1962   11183227    Africa 40.87000
    ## 1444                    Sudan 1967   12716129    Africa 42.85800
    ## 1445                    Sudan 1972   14597019    Africa 45.08300
    ## 1446                    Sudan 1977   17104986    Africa 47.80000
    ## 1447                    Sudan 1982   20367053    Africa 50.33800
    ## 1448                    Sudan 1987   24725960    Africa 51.74400
    ## 1449                    Sudan 1992   28227588    Africa 53.55600
    ## 1450                    Sudan 1997   32160729    Africa 55.37300
    ## 1451                    Sudan 2002   37090298    Africa 56.36900
    ## 1452                    Sudan 2007   42292929    Africa 58.55600
    ## 1453                Swaziland 1952     290243    Africa 41.40700
    ## 1454                Swaziland 1957     326741    Africa 43.42400
    ## 1455                Swaziland 1962     370006    Africa 44.99200
    ## 1456                Swaziland 1967     420690    Africa 46.63300
    ## 1457                Swaziland 1972     480105    Africa 49.55200
    ## 1458                Swaziland 1977     551425    Africa 52.53700
    ## 1459                Swaziland 1982     649901    Africa 55.56100
    ## 1460                Swaziland 1987     779348    Africa 57.67800
    ## 1461                Swaziland 1992     962344    Africa 58.47400
    ## 1462                Swaziland 1997    1054486    Africa 54.28900
    ## 1463                Swaziland 2002    1130269    Africa 43.86900
    ## 1464                Swaziland 2007    1133066    Africa 39.61300
    ## 1465                   Sweden 1952    7124673    Europe 71.86000
    ## 1466                   Sweden 1957    7363802    Europe 72.49000
    ## 1467                   Sweden 1962    7561588    Europe 73.37000
    ## 1468                   Sweden 1967    7867931    Europe 74.16000
    ## 1469                   Sweden 1972    8122293    Europe 74.72000
    ## 1470                   Sweden 1977    8251648    Europe 75.44000
    ## 1471                   Sweden 1982    8325260    Europe 76.42000
    ## 1472                   Sweden 1987    8421403    Europe 77.19000
    ## 1473                   Sweden 1992    8718867    Europe 78.16000
    ## 1474                   Sweden 1997    8897619    Europe 79.39000
    ## 1475                   Sweden 2002    8954175    Europe 80.04000
    ## 1476                   Sweden 2007    9031088    Europe 80.88400
    ## 1477              Switzerland 1952    4815000    Europe 69.62000
    ## 1478              Switzerland 1957    5126000    Europe 70.56000
    ## 1479              Switzerland 1962    5666000    Europe 71.32000
    ## 1480              Switzerland 1967    6063000    Europe 72.77000
    ## 1481              Switzerland 1972    6401400    Europe 73.78000
    ## 1482              Switzerland 1977    6316424    Europe 75.39000
    ## 1483              Switzerland 1982    6468126    Europe 76.21000
    ## 1484              Switzerland 1987    6649942    Europe 77.41000
    ## 1485              Switzerland 1992    6995447    Europe 78.03000
    ## 1486              Switzerland 1997    7193761    Europe 79.37000
    ## 1487              Switzerland 2002    7361757    Europe 80.62000
    ## 1488              Switzerland 2007    7554661    Europe 81.70100
    ## 1489                    Syria 1952    3661549      Asia 45.88300
    ## 1490                    Syria 1957    4149908      Asia 48.28400
    ## 1491                    Syria 1962    4834621      Asia 50.30500
    ## 1492                    Syria 1967    5680812      Asia 53.65500
    ## 1493                    Syria 1972    6701172      Asia 57.29600
    ## 1494                    Syria 1977    7932503      Asia 61.19500
    ## 1495                    Syria 1982    9410494      Asia 64.59000
    ## 1496                    Syria 1987   11242847      Asia 66.97400
    ## 1497                    Syria 1992   13219062      Asia 69.24900
    ## 1498                    Syria 1997   15081016      Asia 71.52700
    ## 1499                    Syria 2002   17155814      Asia 73.05300
    ## 1500                    Syria 2007   19314747      Asia 74.14300
    ## 1501                   Taiwan 1952    8550362      Asia 58.50000
    ## 1502                   Taiwan 1957   10164215      Asia 62.40000
    ## 1503                   Taiwan 1962   11918938      Asia 65.20000
    ## 1504                   Taiwan 1967   13648692      Asia 67.50000
    ## 1505                   Taiwan 1972   15226039      Asia 69.39000
    ## 1506                   Taiwan 1977   16785196      Asia 70.59000
    ## 1507                   Taiwan 1982   18501390      Asia 72.16000
    ## 1508                   Taiwan 1987   19757799      Asia 73.40000
    ## 1509                   Taiwan 1992   20686918      Asia 74.26000
    ## 1510                   Taiwan 1997   21628605      Asia 75.25000
    ## 1511                   Taiwan 2002   22454239      Asia 76.99000
    ## 1512                   Taiwan 2007   23174294      Asia 78.40000
    ## 1513                 Tanzania 1952    8322925    Africa 41.21500
    ## 1514                 Tanzania 1957    9452826    Africa 42.97400
    ## 1515                 Tanzania 1962   10863958    Africa 44.24600
    ## 1516                 Tanzania 1967   12607312    Africa 45.75700
    ## 1517                 Tanzania 1972   14706593    Africa 47.62000
    ## 1518                 Tanzania 1977   17129565    Africa 49.91900
    ## 1519                 Tanzania 1982   19844382    Africa 50.60800
    ## 1520                 Tanzania 1987   23040630    Africa 51.53500
    ## 1521                 Tanzania 1992   26605473    Africa 50.44000
    ## 1522                 Tanzania 1997   30686889    Africa 48.46600
    ## 1523                 Tanzania 2002   34593779    Africa 49.65100
    ## 1524                 Tanzania 2007   38139640    Africa 52.51700
    ## 1525                 Thailand 1952   21289402      Asia 50.84800
    ## 1526                 Thailand 1957   25041917      Asia 53.63000
    ## 1527                 Thailand 1962   29263397      Asia 56.06100
    ## 1528                 Thailand 1967   34024249      Asia 58.28500
    ## 1529                 Thailand 1972   39276153      Asia 60.40500
    ## 1530                 Thailand 1977   44148285      Asia 62.49400
    ## 1531                 Thailand 1982   48827160      Asia 64.59700
    ## 1532                 Thailand 1987   52910342      Asia 66.08400
    ## 1533                 Thailand 1992   56667095      Asia 67.29800
    ## 1534                 Thailand 1997   60216677      Asia 67.52100
    ## 1535                 Thailand 2002   62806748      Asia 68.56400
    ## 1536                 Thailand 2007   65068149      Asia 70.61600
    ## 1537                     Togo 1952    1219113    Africa 38.59600
    ## 1538                     Togo 1957    1357445    Africa 41.20800
    ## 1539                     Togo 1962    1528098    Africa 43.92200
    ## 1540                     Togo 1967    1735550    Africa 46.76900
    ## 1541                     Togo 1972    2056351    Africa 49.75900
    ## 1542                     Togo 1977    2308582    Africa 52.88700
    ## 1543                     Togo 1982    2644765    Africa 55.47100
    ## 1544                     Togo 1987    3154264    Africa 56.94100
    ## 1545                     Togo 1992    3747553    Africa 58.06100
    ## 1546                     Togo 1997    4320890    Africa 58.39000
    ## 1547                     Togo 2002    4977378    Africa 57.56100
    ## 1548                     Togo 2007    5701579    Africa 58.42000
    ## 1549      Trinidad and Tobago 1952     662850  Americas 59.10000
    ## 1550      Trinidad and Tobago 1957     764900  Americas 61.80000
    ## 1551      Trinidad and Tobago 1962     887498  Americas 64.90000
    ## 1552      Trinidad and Tobago 1967     960155  Americas 65.40000
    ## 1553      Trinidad and Tobago 1972     975199  Americas 65.90000
    ## 1554      Trinidad and Tobago 1977    1039009  Americas 68.30000
    ## 1555      Trinidad and Tobago 1982    1116479  Americas 68.83200
    ## 1556      Trinidad and Tobago 1987    1191336  Americas 69.58200
    ## 1557      Trinidad and Tobago 1992    1183669  Americas 69.86200
    ## 1558      Trinidad and Tobago 1997    1138101  Americas 69.46500
    ## 1559      Trinidad and Tobago 2002    1101832  Americas 68.97600
    ## 1560      Trinidad and Tobago 2007    1056608  Americas 69.81900
    ## 1561                  Tunisia 1952    3647735    Africa 44.60000
    ## 1562                  Tunisia 1957    3950849    Africa 47.10000
    ## 1563                  Tunisia 1962    4286552    Africa 49.57900
    ## 1564                  Tunisia 1967    4786986    Africa 52.05300
    ## 1565                  Tunisia 1972    5303507    Africa 55.60200
    ## 1566                  Tunisia 1977    6005061    Africa 59.83700
    ## 1567                  Tunisia 1982    6734098    Africa 64.04800
    ## 1568                  Tunisia 1987    7724976    Africa 66.89400
    ## 1569                  Tunisia 1992    8523077    Africa 70.00100
    ## 1570                  Tunisia 1997    9231669    Africa 71.97300
    ## 1571                  Tunisia 2002    9770575    Africa 73.04200
    ## 1572                  Tunisia 2007   10276158    Africa 73.92300
    ## 1573                   Turkey 1952   22235677    Europe 43.58500
    ## 1574                   Turkey 1957   25670939    Europe 48.07900
    ## 1575                   Turkey 1962   29788695    Europe 52.09800
    ## 1576                   Turkey 1967   33411317    Europe 54.33600
    ## 1577                   Turkey 1972   37492953    Europe 57.00500
    ## 1578                   Turkey 1977   42404033    Europe 59.50700
    ## 1579                   Turkey 1982   47328791    Europe 61.03600
    ## 1580                   Turkey 1987   52881328    Europe 63.10800
    ## 1581                   Turkey 1992   58179144    Europe 66.14600
    ## 1582                   Turkey 1997   63047647    Europe 68.83500
    ## 1583                   Turkey 2002   67308928    Europe 70.84500
    ## 1584                   Turkey 2007   71158647    Europe 71.77700
    ## 1585                   Uganda 1952    5824797    Africa 39.97800
    ## 1586                   Uganda 1957    6675501    Africa 42.57100
    ## 1587                   Uganda 1962    7688797    Africa 45.34400
    ## 1588                   Uganda 1967    8900294    Africa 48.05100
    ## 1589                   Uganda 1972   10190285    Africa 51.01600
    ## 1590                   Uganda 1977   11457758    Africa 50.35000
    ## 1591                   Uganda 1982   12939400    Africa 49.84900
    ## 1592                   Uganda 1987   15283050    Africa 51.50900
    ## 1593                   Uganda 1992   18252190    Africa 48.82500
    ## 1594                   Uganda 1997   21210254    Africa 44.57800
    ## 1595                   Uganda 2002   24739869    Africa 47.81300
    ## 1596                   Uganda 2007   29170398    Africa 51.54200
    ## 1597           United Kingdom 1952   50430000    Europe 69.18000
    ## 1598           United Kingdom 1957   51430000    Europe 70.42000
    ## 1599           United Kingdom 1962   53292000    Europe 70.76000
    ## 1600           United Kingdom 1967   54959000    Europe 71.36000
    ## 1601           United Kingdom 1972   56079000    Europe 72.01000
    ## 1602           United Kingdom 1977   56179000    Europe 72.76000
    ## 1603           United Kingdom 1982   56339704    Europe 74.04000
    ## 1604           United Kingdom 1987   56981620    Europe 75.00700
    ## 1605           United Kingdom 1992   57866349    Europe 76.42000
    ## 1606           United Kingdom 1997   58808266    Europe 77.21800
    ## 1607           United Kingdom 2002   59912431    Europe 78.47100
    ## 1608           United Kingdom 2007   60776238    Europe 79.42500
    ## 1609            United States 1952  157553000  Americas 68.44000
    ## 1610            United States 1957  171984000  Americas 69.49000
    ## 1611            United States 1962  186538000  Americas 70.21000
    ## 1612            United States 1967  198712000  Americas 70.76000
    ## 1613            United States 1972  209896000  Americas 71.34000
    ## 1614            United States 1977  220239000  Americas 73.38000
    ## 1615            United States 1982  232187835  Americas 74.65000
    ## 1616            United States 1987  242803533  Americas 75.02000
    ## 1617            United States 1992  256894189  Americas 76.09000
    ## 1618            United States 1997  272911760  Americas 76.81000
    ## 1619            United States 2002  287675526  Americas 77.31000
    ## 1620            United States 2007  301139947  Americas 78.24200
    ## 1621                  Uruguay 1952    2252965  Americas 66.07100
    ## 1622                  Uruguay 1957    2424959  Americas 67.04400
    ## 1623                  Uruguay 1962    2598466  Americas 68.25300
    ## 1624                  Uruguay 1967    2748579  Americas 68.46800
    ## 1625                  Uruguay 1972    2829526  Americas 68.67300
    ## 1626                  Uruguay 1977    2873520  Americas 69.48100
    ## 1627                  Uruguay 1982    2953997  Americas 70.80500
    ## 1628                  Uruguay 1987    3045153  Americas 71.91800
    ## 1629                  Uruguay 1992    3149262  Americas 72.75200
    ## 1630                  Uruguay 1997    3262838  Americas 74.22300
    ## 1631                  Uruguay 2002    3363085  Americas 75.30700
    ## 1632                  Uruguay 2007    3447496  Americas 76.38400
    ## 1633                Venezuela 1952    5439568  Americas 55.08800
    ## 1634                Venezuela 1957    6702668  Americas 57.90700
    ## 1635                Venezuela 1962    8143375  Americas 60.77000
    ## 1636                Venezuela 1967    9709552  Americas 63.47900
    ## 1637                Venezuela 1972   11515649  Americas 65.71200
    ## 1638                Venezuela 1977   13503563  Americas 67.45600
    ## 1639                Venezuela 1982   15620766  Americas 68.55700
    ## 1640                Venezuela 1987   17910182  Americas 70.19000
    ## 1641                Venezuela 1992   20265563  Americas 71.15000
    ## 1642                Venezuela 1997   22374398  Americas 72.14600
    ## 1643                Venezuela 2002   24287670  Americas 72.76600
    ## 1644                Venezuela 2007   26084662  Americas 73.74700
    ## 1645                  Vietnam 1952   26246839      Asia 40.41200
    ## 1646                  Vietnam 1957   28998543      Asia 42.88700
    ## 1647                  Vietnam 1962   33796140      Asia 45.36300
    ## 1648                  Vietnam 1967   39463910      Asia 47.83800
    ## 1649                  Vietnam 1972   44655014      Asia 50.25400
    ## 1650                  Vietnam 1977   50533506      Asia 55.76400
    ## 1651                  Vietnam 1982   56142181      Asia 58.81600
    ## 1652                  Vietnam 1987   62826491      Asia 62.82000
    ## 1653                  Vietnam 1992   69940728      Asia 67.66200
    ## 1654                  Vietnam 1997   76048996      Asia 70.67200
    ## 1655                  Vietnam 2002   80908147      Asia 73.01700
    ## 1656                  Vietnam 2007   85262356      Asia 74.24900
    ## 1657       West Bank and Gaza 1952    1030585      Asia 43.16000
    ## 1658       West Bank and Gaza 1957    1070439      Asia 45.67100
    ## 1659       West Bank and Gaza 1962    1133134      Asia 48.12700
    ## 1660       West Bank and Gaza 1967    1142636      Asia 51.63100
    ## 1661       West Bank and Gaza 1972    1089572      Asia 56.53200
    ## 1662       West Bank and Gaza 1977    1261091      Asia 60.76500
    ## 1663       West Bank and Gaza 1982    1425876      Asia 64.40600
    ## 1664       West Bank and Gaza 1987    1691210      Asia 67.04600
    ## 1665       West Bank and Gaza 1992    2104779      Asia 69.71800
    ## 1666       West Bank and Gaza 1997    2826046      Asia 71.09600
    ## 1667       West Bank and Gaza 2002    3389578      Asia 72.37000
    ## 1668       West Bank and Gaza 2007    4018332      Asia 73.42200
    ## 1669               Yemen Rep. 1952    4963829      Asia 32.54800
    ## 1670               Yemen Rep. 1957    5498090      Asia 33.97000
    ## 1671               Yemen Rep. 1962    6120081      Asia 35.18000
    ## 1672               Yemen Rep. 1967    6740785      Asia 36.98400
    ## 1673               Yemen Rep. 1972    7407075      Asia 39.84800
    ## 1674               Yemen Rep. 1977    8403990      Asia 44.17500
    ## 1675               Yemen Rep. 1982    9657618      Asia 49.11300
    ## 1676               Yemen Rep. 1987   11219340      Asia 52.92200
    ## 1677               Yemen Rep. 1992   13367997      Asia 55.59900
    ## 1678               Yemen Rep. 1997   15826497      Asia 58.02000
    ## 1679               Yemen Rep. 2002   18701257      Asia 60.30800
    ## 1680               Yemen Rep. 2007   22211743      Asia 62.69800
    ## 1681                   Zambia 1952    2672000    Africa 42.03800
    ## 1682                   Zambia 1957    3016000    Africa 44.07700
    ## 1683                   Zambia 1962    3421000    Africa 46.02300
    ## 1684                   Zambia 1967    3900000    Africa 47.76800
    ## 1685                   Zambia 1972    4506497    Africa 50.10700
    ## 1686                   Zambia 1977    5216550    Africa 51.38600
    ## 1687                   Zambia 1982    6100407    Africa 51.82100
    ## 1688                   Zambia 1987    7272406    Africa 50.82100
    ## 1689                   Zambia 1992    8381163    Africa 46.10000
    ## 1690                   Zambia 1997    9417789    Africa 40.23800
    ## 1691                   Zambia 2002   10595811    Africa 39.19300
    ## 1692                   Zambia 2007   11746035    Africa 42.38400
    ## 1693                 Zimbabwe 1952    3080907    Africa 48.45100
    ## 1694                 Zimbabwe 1957    3646340    Africa 50.46900
    ## 1695                 Zimbabwe 1962    4277736    Africa 52.35800
    ## 1696                 Zimbabwe 1967    4995432    Africa 53.99500
    ## 1697                 Zimbabwe 1972    5861135    Africa 55.63500
    ## 1698                 Zimbabwe 1977    6642107    Africa 57.67400
    ## 1699                 Zimbabwe 1982    7636524    Africa 60.36300
    ## 1700                 Zimbabwe 1987    9216418    Africa 62.35100
    ## 1701                 Zimbabwe 1992   10704340    Africa 60.37700
    ## 1702                 Zimbabwe 1997   11404948    Africa 46.80900
    ## 1703                 Zimbabwe 2002   11926563    Africa 39.98900
    ## 1704                 Zimbabwe 2007   12311143    Africa 43.48700
    ##        gdpPercap          gdp       gdpMil
    ## 1       779.4453 6.567086e+09 6.567086e+03
    ## 2       820.8530 7.585449e+09 7.585449e+03
    ## 3       853.1007 8.758856e+09 8.758856e+03
    ## 4       836.1971 9.648014e+09 9.648014e+03
    ## 5       739.9811 9.678553e+09 9.678553e+03
    ## 6       786.1134 1.169766e+10 1.169766e+04
    ## 7       978.0114 1.259856e+10 1.259856e+04
    ## 8       852.3959 1.182099e+10 1.182099e+04
    ## 9       649.3414 1.059590e+10 1.059590e+04
    ## 10      635.3414 1.412200e+10 1.412200e+04
    ## 11      726.7341 1.836341e+10 1.836341e+04
    ## 12      974.5803 3.107929e+10 3.107929e+04
    ## 13     1601.0561 2.053670e+09 2.053670e+03
    ## 14     1942.2842 2.867792e+09 2.867792e+03
    ## 15     2312.8890 3.996989e+09 3.996989e+03
    ## 16     2760.1969 5.476396e+09 5.476396e+03
    ## 17     3313.4222 7.500110e+09 7.500110e+03
    ## 18     3533.0039 8.864476e+09 8.864476e+03
    ## 19     3630.8807 1.009420e+10 1.009420e+04
    ## 20     3738.9327 1.149842e+10 1.149842e+04
    ## 21     2497.4379 8.307722e+09 8.307722e+03
    ## 22     3193.0546 1.094591e+10 1.094591e+04
    ## 23     4604.2117 1.615393e+10 1.615393e+04
    ## 24     5937.0295 2.137641e+10 2.137641e+04
    ## 25     2449.0082 2.272563e+10 2.272563e+04
    ## 26     3013.9760 3.095611e+10 3.095611e+04
    ## 27     2550.8169 2.806140e+10 2.806140e+04
    ## 28     3246.9918 4.143324e+10 4.143324e+04
    ## 29     4182.6638 6.173941e+10 6.173941e+04
    ## 30     4910.4168 8.422742e+10 8.422742e+04
    ## 31     5745.1602 1.150971e+11 1.150971e+05
    ## 32     5681.3585 1.321197e+11 1.321197e+05
    ## 33     5023.2166 1.321024e+11 1.321024e+05
    ## 34     4797.2951 1.394670e+11 1.394670e+05
    ## 35     5288.0404 1.654477e+11 1.654477e+05
    ## 36     6223.3675 2.074449e+11 2.074449e+05
    ## 37     3520.6103 1.489956e+10 1.489956e+04
    ## 38     3827.9405 1.746062e+10 1.746062e+04
    ## 39     4269.2767 2.060359e+10 2.060359e+04
    ## 40     5522.7764 2.898060e+10 2.898060e+04
    ## 41     5473.2880 3.226426e+10 3.226426e+04
    ## 42     3008.6474 1.854132e+10 1.854132e+04
    ## 43     2756.9537 1.934385e+10 1.934385e+04
    ## 44     2430.2083 1.913602e+10 1.913602e+04
    ## 45     2627.8457 2.295683e+10 2.295683e+04
    ## 46     2277.1409 2.248682e+10 2.248682e+04
    ## 47     2773.2873 3.013483e+10 3.013483e+04
    ## 48     4797.2313 5.958390e+10 5.958390e+04
    ## 49     5911.3151 1.056763e+11 1.056763e+05
    ## 50     6856.8562 1.344666e+11 1.344666e+05
    ## 51     7133.1660 1.518208e+11 1.518208e+05
    ## 52     8052.9530 1.846882e+11 1.846882e+05
    ## 53     9443.0385 2.339966e+11 2.339966e+05
    ## 54    10079.0267 2.719707e+11 2.719707e+05
    ## 55     8997.8974 2.640107e+11 2.640107e+05
    ## 56     9139.6714 2.890048e+11 2.890048e+05
    ## 57     9308.4187 3.161041e+11 3.161041e+05
    ## 58    10967.2820 3.970536e+11 3.970536e+05
    ## 59     8797.6407 3.372234e+11 3.372234e+05
    ## 60    12779.3796 5.150336e+11 5.150336e+05
    ## 61    10039.5956 8.725625e+10 8.725625e+04
    ## 62    10949.6496 1.063492e+11 1.063492e+05
    ## 63    12217.2269 1.318846e+11 1.318846e+05
    ## 64    14526.1246 1.724580e+11 1.724580e+05
    ## 65    16788.6295 2.212238e+11 2.212238e+05
    ## 66    18334.1975 2.580373e+11 2.580373e+05
    ## 67    19477.0093 2.957428e+11 2.957428e+05
    ## 68    21888.8890 3.558531e+11 3.558531e+05
    ## 69    23424.7668 4.095112e+11 4.095112e+05
    ## 70    26997.9366 5.012233e+11 5.012233e+05
    ## 71    30687.7547 5.998472e+11 5.998472e+05
    ## 72    34435.3674 7.036584e+11 7.036584e+05
    ## 73     6137.0765 4.251627e+10 4.251627e+04
    ## 74     8842.5980 6.159630e+10 6.159630e+04
    ## 75    10750.7211 7.665118e+10 7.665118e+04
    ## 76    12834.6024 9.468084e+10 9.468084e+04
    ## 77    16661.6256 1.256987e+11 1.256987e+05
    ## 78    19749.4223 1.494721e+11 1.494721e+05
    ## 79    21597.0836 1.635896e+11 1.635896e+05
    ## 80    23687.8261 1.795277e+11 1.795277e+05
    ## 81    27042.0187 2.140367e+11 2.140367e+05
    ## 82    29095.9207 2.348005e+11 2.348005e+05
    ## 83    32417.6077 2.641488e+11 2.641488e+05
    ## 84    36126.4927 2.962294e+11 2.962294e+05
    ## 85     9867.0848 1.188461e+09 1.188461e+03
    ## 86    11635.7995 1.613362e+09 1.613362e+03
    ## 87    12753.2751 2.191816e+09 2.191816e+03
    ## 88    14804.6727 2.993238e+09 2.993238e+03
    ## 89    18268.6584 4.216406e+09 4.216406e+03
    ## 90    19340.1020 5.751940e+09 5.751940e+03
    ## 91    19211.1473 7.261180e+09 7.261180e+03
    ## 92    18524.0241 8.421244e+09 8.421244e+03
    ## 93    19035.5792 1.007917e+10 1.007917e+04
    ## 94    20292.0168 1.214601e+10 1.214601e+04
    ## 95    23403.5593 1.536203e+10 1.536203e+04
    ## 96    29796.0483 2.111268e+10 2.111268e+04
    ## 97      684.2442 3.208206e+10 3.208206e+04
    ## 98      661.6375 3.398532e+10 3.398532e+04
    ## 99      686.3416 3.901117e+10 3.901117e+04
    ## 100     721.1861 4.530627e+10 4.530627e+04
    ## 101     630.2336 4.459489e+10 4.459489e+04
    ## 102     659.8772 5.307281e+10 5.307281e+04
    ## 103     676.9819 6.300969e+10 6.300969e+04
    ## 104     751.9794 7.802857e+10 7.802857e+04
    ## 105     837.8102 9.526285e+10 9.526285e+04
    ## 106     972.7700 1.199574e+11 1.199574e+05
    ## 107    1136.3904 1.541591e+11 1.541591e+05
    ## 108    1391.2538 2.093118e+11 2.093118e+05
    ## 109    8343.1051 7.283869e+10 7.283869e+04
    ## 110    9714.9606 8.732886e+10 8.732886e+04
    ## 111   10991.2068 1.013213e+11 1.013213e+05
    ## 112   13149.0412 1.256588e+11 1.256588e+05
    ## 113   16672.1436 1.618715e+11 1.618715e+05
    ## 114   19117.9745 1.877729e+11 1.877729e+05
    ## 115   20979.8459 2.067837e+11 2.067837e+05
    ## 116   22525.5631 2.223318e+11 2.223318e+05
    ## 117   25575.5707 2.569225e+11 2.569225e+05
    ## 118   27561.1966 2.811183e+11 2.811183e+05
    ## 119   30485.8838 3.143695e+11 3.143695e+05
    ## 120   33692.6051 3.501412e+11 3.501412e+05
    ## 121    1062.7522 1.847398e+09 1.847398e+03
    ## 122     959.6011 1.847398e+09 1.847398e+03
    ## 123     949.4991 2.043222e+09 2.043222e+03
    ## 124    1035.8314 2.514309e+09 2.514309e+03
    ## 125    1085.7969 2.998327e+09 2.998327e+03
    ## 126    1029.1613 3.260658e+09 3.260658e+03
    ## 127    1277.8976 4.653596e+09 4.653596e+03
    ## 128    1225.8560 5.202273e+09 5.202273e+03
    ## 129    1191.2077 5.934205e+09 5.934205e+03
    ## 130    1232.9753 7.479327e+09 7.479327e+03
    ## 131    1372.8779 9.645995e+09 9.645995e+03
    ## 132    1441.2849 1.164315e+10 1.164315e+04
    ## 133    2677.3263 7.719575e+09 7.719575e+03
    ## 134    2127.6863 6.833571e+09 6.833571e+03
    ## 135    2180.9725 7.838236e+09 7.838236e+03
    ## 136    2586.8861 1.045274e+10 1.045274e+04
    ## 137    2980.3313 1.360781e+10 1.360781e+04
    ## 138    3548.0978 1.802333e+10 1.802333e+04
    ## 139    3156.5105 1.780974e+10 1.780974e+04
    ## 140    2753.6915 1.695274e+10 1.695274e+04
    ## 141    2961.6997 2.041633e+10 2.041633e+04
    ## 142    3326.1432 2.558864e+10 2.558864e+04
    ## 143    3413.2627 2.882546e+10 2.882546e+04
    ## 144    3822.1371 3.485465e+10 3.485465e+04
    ## 145     973.5332 2.717131e+09 2.717131e+03
    ## 146    1353.9892 4.164871e+09 4.164871e+03
    ## 147    1709.6837 5.725731e+09 5.725731e+03
    ## 148    2172.3524 7.787883e+09 7.787883e+03
    ## 149    2860.1698 1.092299e+10 1.092299e+04
    ## 150    3528.4813 1.441737e+10 1.441737e+04
    ## 151    4126.6132 1.721909e+10 1.721909e+04
    ## 152    4314.1148 1.871884e+10 1.871884e+04
    ## 153    2546.7814 1.083913e+10 1.083913e+04
    ## 154    4766.3559 1.719225e+10 1.719225e+04
    ## 155    6018.9752 2.507154e+10 2.507154e+04
    ## 156    7446.2988 3.389703e+10 3.389703e+04
    ## 157     851.2411 3.765108e+08 3.765108e+02
    ## 158     918.2325 4.358290e+08 4.358290e+02
    ## 159     983.6540 5.043823e+08 5.043823e+02
    ## 160    1214.7093 6.723914e+08 6.723914e+02
    ## 161    2263.6111 1.401970e+09 1.401970e+03
    ## 162    3214.8578 2.512321e+09 2.512321e+03
    ## 163    4551.1421 4.416187e+09 4.416187e+03
    ## 164    6205.8839 7.144114e+09 7.144114e+03
    ## 165    7954.1116 1.067930e+10 1.067930e+04
    ## 166    8647.1423 1.328665e+10 1.328665e+04
    ## 167   11003.6051 1.793969e+10 1.793969e+04
    ## 168   12569.8518 2.060363e+10 2.060363e+04
    ## 169    2108.9444 1.193716e+11 1.193716e+05
    ## 170    2487.3660 1.630498e+11 1.630498e+05
    ## 171    3336.5858 2.537119e+11 2.537119e+05
    ## 172    3429.8644 3.019989e+11 3.019989e+05
    ## 173    4985.7115 5.027594e+11 5.027594e+05
    ## 174    6660.1187 7.613445e+11 7.613445e+05
    ## 175    7030.8359 9.067173e+11 9.067173e+05
    ## 176    7807.0958 1.115931e+12 1.115931e+06
    ## 177    6950.2830 1.084077e+12 1.084077e+06
    ## 178    7957.9808 1.341292e+12 1.341292e+06
    ## 179    8131.2128 1.462921e+12 1.462921e+06
    ## 180    9065.8008 1.722599e+12 1.722599e+06
    ## 181    2444.2866 1.778194e+10 1.778194e+04
    ## 182    3008.6707 2.302010e+10 2.302010e+04
    ## 183    4254.3378 3.408978e+10 3.408978e+04
    ## 184    5577.0028 4.634615e+10 4.634615e+04
    ## 185    6597.4944 5.658143e+10 5.658143e+04
    ## 186    7612.2404 6.696505e+10 6.696505e+04
    ## 187    8224.1916 7.313032e+10 7.313032e+04
    ## 188    8239.8548 7.392763e+10 7.392763e+04
    ## 189    6302.6234 5.457130e+10 5.457130e+04
    ## 190    5970.3888 4.815750e+10 4.815750e+04
    ## 191    7696.7777 5.897116e+10 5.897116e+04
    ## 192   10680.7928 7.821393e+10 7.821393e+04
    ## 193     543.2552 2.428340e+09 2.428340e+03
    ## 194     617.1835 2.909042e+09 2.909042e+03
    ## 195     722.5120 3.554493e+09 3.554493e+03
    ## 196     794.8266 4.075819e+09 4.075819e+03
    ## 197     854.7360 4.644538e+09 4.644538e+03
    ## 198     743.3870 4.378233e+09 4.378233e+03
    ## 199     807.1986 5.355437e+09 5.355437e+03
    ## 200     912.0631 6.919414e+09 6.919414e+03
    ## 201     931.7528 8.272383e+09 8.272383e+03
    ## 202     946.2950 9.796843e+09 9.796843e+03
    ## 203    1037.6452 1.271241e+10 1.271241e+04
    ## 204    1217.0330 1.743546e+10 1.743546e+04
    ## 205     339.2965 8.297895e+08 8.297895e+02
    ## 206     379.5646 1.012495e+09 1.012495e+03
    ## 207     355.2032 1.052082e+09 1.052082e+03
    ## 208     412.9775 1.375624e+09 1.375624e+03
    ## 209     464.0995 1.638263e+09 1.638263e+03
    ## 210     556.1033 2.132331e+09 2.132331e+03
    ## 211     559.6032 2.563212e+09 2.563212e+03
    ## 212     621.8188 3.187458e+09 3.187458e+03
    ## 213     631.6999 3.669694e+09 3.669694e+03
    ## 214     463.1151 2.835010e+09 2.835010e+03
    ## 215     446.4035 3.134234e+09 3.134234e+03
    ## 216     430.0707 3.608510e+09 3.608510e+03
    ## 217     368.4693 1.729534e+09 1.729534e+03
    ## 218     434.0383 2.310185e+09 2.310185e+03
    ## 219     496.9136 3.023033e+09 3.023033e+03
    ## 220     523.4323 3.643124e+09 3.643124e+03
    ## 221     421.6240 3.141354e+09 3.141354e+03
    ## 222     524.9722 3.663575e+09 3.663575e+03
    ## 223     624.4755 4.541489e+09 4.541489e+03
    ## 224     683.8956 5.725431e+09 5.725431e+03
    ## 225     682.3032 6.925441e+09 6.925441e+03
    ## 226     734.2852 8.652054e+09 8.652054e+03
    ## 227     896.2260 1.158525e+10 1.158525e+04
    ## 228    1713.7787 2.421888e+10 2.421888e+04
    ## 229    1172.6677 5.873971e+09 5.873971e+03
    ## 230    1313.0481 7.037837e+09 7.037837e+03
    ## 231    1399.6074 8.108812e+09 8.108812e+03
    ## 232    1508.4531 9.556814e+09 9.556814e+03
    ## 233    1684.1465 1.182444e+10 1.182444e+04
    ## 234    1783.4329 1.419588e+10 1.419588e+04
    ## 235    2367.9833 2.190581e+10 2.190581e+04
    ## 236    2602.6642 2.805846e+10 2.805846e+04
    ## 237    1793.1633 2.235567e+10 2.235567e+04
    ## 238    1694.3375 2.405249e+10 2.405249e+04
    ## 239    1934.0114 3.080878e+10 3.080878e+04
    ## 240    2042.0952 3.613752e+10 3.613752e+04
    ## 241   11367.1611 1.680701e+11 1.680701e+05
    ## 242   12489.9501 2.124560e+11 2.124560e+05
    ## 243   13462.4855 2.555967e+11 2.555967e+05
    ## 244   16076.5880 3.347108e+11 3.347108e+05
    ## 245   18970.5709 4.227497e+11 4.227497e+05
    ## 246   22090.8831 5.256835e+11 5.256835e+05
    ## 247   22898.7921 5.770931e+11 5.770931e+05
    ## 248   26626.5150 7.069260e+11 7.069260e+05
    ## 249   26342.8843 7.513913e+11 7.513913e+05
    ## 250   28954.9259 8.775034e+11 8.775034e+05
    ## 251   33328.9651 1.063270e+12 1.063270e+06
    ## 252   36319.2350 1.212704e+12 1.212704e+06
    ## 253    1071.3107 1.383807e+09 1.383807e+03
    ## 254    1190.8443 1.657994e+09 1.657994e+03
    ## 255    1193.0688 1.817614e+09 1.817614e+03
    ## 256    1136.0566 1.969511e+09 1.969511e+03
    ## 257    1070.0133 2.062194e+09 2.062194e+03
    ## 258    1109.3743 2.404605e+09 2.404605e+03
    ## 259     956.7530 2.369849e+09 2.369849e+03
    ## 260     844.8764 2.399456e+09 2.399456e+03
    ## 261     747.9055 2.442004e+09 2.442004e+03
    ## 262     740.5063 2.737291e+09 2.737291e+03
    ## 263     738.6906 2.990229e+09 2.990229e+03
    ## 264     706.0165 3.084613e+09 3.084613e+03
    ## 265    1178.6659 3.161727e+09 3.161727e+03
    ## 266    1308.4956 3.787905e+09 3.787905e+03
    ## 267    1389.8176 4.378505e+09 4.378505e+03
    ## 268    1196.8106 4.184010e+09 4.184010e+03
    ## 269    1104.1040 4.304977e+09 4.304977e+03
    ## 270    1133.9850 4.976221e+09 4.976221e+03
    ## 271     797.9081 3.889896e+09 3.889896e+03
    ## 272     952.3861 5.237128e+09 5.237128e+03
    ## 273    1058.0643 6.802737e+09 6.802737e+03
    ## 274    1004.9614 7.599529e+09 7.599529e+03
    ## 275    1156.1819 1.021572e+10 1.021572e+04
    ## 276    1704.0637 1.744758e+10 1.744758e+04
    ## 277    3939.9788 2.512768e+10 2.512768e+04
    ## 278    4315.6227 3.041835e+10 3.041835e+04
    ## 279    4519.0943 3.597768e+10 3.597768e+04
    ## 280    5106.6543 4.523938e+10 4.523938e+04
    ## 281    5494.0244 5.338831e+10 5.338831e+04
    ## 282    4756.7638 5.042071e+10 5.042071e+04
    ## 283    5095.6657 5.853448e+10 5.853448e+04
    ## 284    5547.0638 6.913502e+10 6.913502e+04
    ## 285    7596.1260 1.031022e+11 1.031022e+05
    ## 286   10118.0532 1.477229e+11 1.477229e+05
    ## 287   10778.7838 1.670393e+11 1.670393e+05
    ## 288   13171.6388 2.144967e+11 2.144967e+05
    ## 289     400.4486 2.227550e+11 2.227550e+05
    ## 290     575.9870 3.671387e+11 3.671387e+05
    ## 291     487.6740 3.246787e+11 3.246787e+05
    ## 292     612.7057 4.623171e+11 4.623171e+05
    ## 293     676.9001 5.835082e+11 5.835082e+05
    ## 294     741.2375 6.993242e+11 6.993242e+05
    ## 295     962.4214 9.626918e+11 9.626918e+05
    ## 296    1378.9040 1.494780e+12 1.494780e+06
    ## 297    1655.7842 1.928939e+12 1.928939e+06
    ## 298    2289.2341 2.815930e+12 2.815930e+06
    ## 299    3119.2809 3.993927e+12 3.993927e+06
    ## 300    4959.1149 6.539501e+12 6.539501e+06
    ## 301    2144.1151 2.648147e+10 2.648147e+04
    ## 302    2323.8056 3.366263e+10 3.366263e+04
    ## 303    2492.3511 4.239461e+10 4.239461e+04
    ## 304    2678.7298 5.294249e+10 5.294249e+04
    ## 305    3264.6600 7.359487e+10 7.359487e+04
    ## 306    3815.8079 9.575545e+10 9.575545e+04
    ## 307    4397.5757 1.220971e+11 1.220971e+05
    ## 308    4903.2191 1.518245e+11 1.518245e+05
    ## 309    5444.6486 1.862218e+11 1.862218e+05
    ## 310    6117.3617 2.303666e+11 2.303666e+05
    ## 311    5755.2600 2.360130e+11 2.360130e+05
    ## 312    7006.5804 3.098839e+11 3.098839e+05
    ## 313    1102.9909 1.697900e+08 1.697900e+02
    ## 314    1211.1485 2.070192e+08 2.070192e+02
    ## 315    1406.6483 2.696390e+08 2.696390e+02
    ## 316    1876.0296 4.078076e+08 4.078076e+02
    ## 317    1937.5777 4.844467e+08 4.844467e+02
    ## 318    1172.6030 3.573379e+08 3.573379e+02
    ## 319    1267.1001 4.417656e+08 4.417656e+02
    ## 320    1315.9808 5.199624e+08 5.199624e+02
    ## 321    1246.9074 5.666309e+08 5.666309e+02
    ## 322    1173.6182 6.196493e+08 6.196493e+02
    ## 323    1075.8116 6.609593e+08 6.609593e+02
    ## 324     986.1479 7.011117e+08 7.011117e+02
    ## 325     780.5423 1.100565e+10 1.100565e+04
    ## 326     905.8602 1.411143e+10 1.411143e+04
    ## 327     896.3146 1.567335e+10 1.567335e+04
    ## 328     861.5932 1.718109e+10 1.718109e+04
    ## 329     904.8961 2.081955e+10 2.081955e+04
    ## 330     795.7573 2.107235e+10 2.107235e+04
    ## 331     673.7478 2.064801e+10 2.064801e+04
    ## 332     672.7748 2.387116e+10 2.387116e+04
    ## 333     457.7192 1.907414e+10 1.907414e+04
    ## 334     312.1884 1.492229e+10 1.492229e+04
    ## 335     241.1659 1.335573e+10 1.335573e+04
    ## 336     277.5519 1.793173e+10 1.793173e+04
    ## 337    2125.6214 1.817162e+09 1.817162e+03
    ## 338    2315.0566 2.177213e+09 2.177213e+03
    ## 339    2464.7832 2.582905e+09 2.582905e+03
    ## 340    2677.9396 3.159326e+09 3.159326e+03
    ## 341    3213.1527 4.307096e+09 4.307096e+03
    ## 342    3259.1790 5.008605e+09 5.008605e+03
    ## 343    4879.5075 8.659833e+09 8.659833e+03
    ## 344    4201.1949 8.671665e+09 8.671665e+03
    ## 345    4016.2395 9.675414e+09 9.675414e+03
    ## 346    3484.1644 9.758960e+09 9.758960e+03
    ## 347    3484.0620 1.159773e+10 1.159773e+04
    ## 348    3632.5578 1.380594e+10 1.380594e+04
    ## 349    2627.0095 2.433444e+09 2.433444e+03
    ## 350    2990.0108 3.325789e+09 3.325789e+03
    ## 351    3460.9370 4.655607e+09 4.655607e+03
    ## 352    4161.7278 6.611808e+09 6.611808e+03
    ## 353    5118.1469 9.390756e+09 9.390756e+03
    ## 354    5926.8770 1.249657e+10 1.249657e+04
    ## 355    5262.7348 1.275880e+10 1.275880e+04
    ## 356    5629.9153 1.576270e+10 1.576270e+04
    ## 357    6160.4163 1.954833e+10 1.954833e+04
    ## 358    6677.0453 2.349056e+10 2.349056e+04
    ## 359    7723.4472 2.961891e+10 2.961891e+04
    ## 360    9645.0614 3.987157e+10 3.987157e+04
    ## 361    1388.5947 4.133873e+09 4.133873e+03
    ## 362    1500.8959 4.952957e+09 4.952957e+03
    ## 363    1728.8694 6.625733e+09 6.625733e+03
    ## 364    2052.0505 9.736713e+09 9.736713e+03
    ## 365    2378.2011 1.443971e+10 1.443971e+04
    ## 366    2517.7365 1.878124e+10 1.878124e+04
    ## 367    2602.7102 2.349193e+10 2.349193e+04
    ## 368    2156.9561 2.321122e+10 2.321122e+04
    ## 369    1648.0738 2.105018e+10 2.105018e+04
    ## 370    1786.2654 2.612586e+10 2.612586e+04
    ## 371    1648.8008 2.679751e+10 2.679751e+04
    ## 372    1544.7501 2.782622e+10 2.782622e+04
    ## 373    3119.2365 1.210959e+10 1.210959e+04
    ## 374    4338.2316 1.731493e+10 1.731493e+04
    ## 375    5477.8900 2.233093e+10 2.233093e+04
    ## 376    6960.2979 2.905483e+10 2.905483e+04
    ## 377    9164.0901 3.872112e+10 3.872112e+04
    ## 378   11305.3852 4.882426e+10 4.882426e+04
    ## 379   13221.8218 5.835277e+10 5.835277e+04
    ## 380   13822.5839 6.198475e+10 6.198475e+04
    ## 381    8447.7949 3.796450e+10 3.796450e+04
    ## 382    9875.6045 4.389306e+10 4.389306e+04
    ## 383   11628.3890 5.210704e+10 5.210704e+04
    ## 384   14619.2227 6.568873e+10 6.568873e+04
    ## 385    5586.5388 3.356279e+10 3.356279e+04
    ## 386    6092.1744 4.045662e+10 4.045662e+04
    ## 387    5180.7559 3.758314e+10 3.758314e+04
    ## 388    5690.2680 4.631498e+10 4.631498e+04
    ## 389    5305.4453 4.685423e+10 4.685423e+04
    ## 390    6380.4950 6.085708e+10 6.085708e+04
    ## 391    7316.9181 7.162695e+10 7.162695e+04
    ## 392    7532.9248 7.713594e+10 7.713594e+04
    ## 393    5592.8440 5.997352e+10 5.997352e+04
    ## 394    5431.9904 5.965959e+10 5.965959e+04
    ## 395    6340.6467 7.118643e+10 7.118643e+04
    ## 396    8948.1029 1.021604e+11 1.021604e+05
    ## 397    6876.1403 6.274604e+10 6.274604e+04
    ## 398    8256.3439 7.854886e+10 7.854886e+04
    ## 399   10136.8671 9.751952e+10 9.751952e+04
    ## 400   11399.4449 1.121148e+11 1.121148e+05
    ## 401   13108.4536 1.292776e+11 1.292776e+05
    ## 402   14800.1606 1.503980e+11 1.503980e+05
    ## 403   15377.2285 1.584424e+11 1.584424e+05
    ## 404   16310.4434 1.681867e+11 1.681867e+05
    ## 405   14297.0212 1.474838e+11 1.474838e+05
    ## 406   16048.5142 1.653110e+11 1.653110e+05
    ## 407   17596.2102 1.804719e+11 1.804719e+05
    ## 408   22833.3085 2.335561e+11 2.335561e+05
    ## 409    9692.3852 4.200680e+10 4.200680e+04
    ## 410   11099.6593 4.981340e+10 4.981340e+04
    ## 411   13583.3135 6.312029e+10 6.312029e+04
    ## 412   15937.2112 7.711698e+10 7.711698e+04
    ## 413   18866.2072 9.417248e+10 9.417248e+04
    ## 414   20422.9015 1.039203e+11 1.039203e+05
    ## 415   21688.0405 1.109953e+11 1.109953e+05
    ## 416   25116.1758 1.287712e+11 1.287712e+05
    ## 417   26406.7399 1.365596e+11 1.365596e+05
    ## 418   29804.3457 1.574761e+11 1.574761e+05
    ## 419   32166.5001 1.728851e+11 1.728851e+05
    ## 420   35278.4187 1.929066e+11 1.929066e+05
    ## 421    2669.5295 1.685781e+08 1.685781e+02
    ## 422    2864.9691 2.058509e+08 2.058509e+02
    ## 423    3020.9893 2.715809e+08 2.715809e+02
    ## 424    3020.0505 3.854098e+08 3.854098e+02
    ## 425    3694.2124 6.607025e+08 6.607025e+02
    ## 426    3081.7610 7.047803e+08 7.047803e+02
    ## 427    2879.4681 8.810913e+08 8.810913e+02
    ## 428    2880.1026 8.957839e+08 8.957839e+02
    ## 429    2377.1562 9.131988e+08 9.131988e+02
    ## 430    1895.0170 7.919428e+08 7.919428e+02
    ## 431    1908.2609 8.537864e+08 8.537864e+02
    ## 432    2082.4816 1.033690e+09 1.033690e+03
    ## 433    1397.7171 3.482197e+09 3.482197e+03
    ## 434    1544.4030 4.514577e+09 4.514577e+03
    ## 435    1662.1374 5.740082e+09 5.740082e+03
    ## 436    1653.7230 6.696166e+09 6.696166e+03
    ## 437    2189.8745 1.022962e+10 1.022962e+04
    ## 438    2681.9889 1.422205e+10 1.422205e+04
    ## 439    2861.0924 1.707600e+10 1.707600e+04
    ## 440    2899.8422 1.929931e+10 1.929931e+04
    ## 441    3044.2142 2.237857e+10 2.237857e+04
    ## 442    3614.1013 2.888519e+10 2.888519e+04
    ## 443    4563.8082 3.947841e+10 3.947841e+04
    ## 444    6025.3748 5.615422e+10 5.615422e+04
    ## 445    3522.1107 1.249910e+10 1.249910e+04
    ## 446    3780.5467 1.534291e+10 1.534291e+04
    ## 447    4086.1141 1.912999e+10 1.912999e+04
    ## 448    4579.0742 2.487547e+10 2.487547e+04
    ## 449    5280.9947 3.326314e+10 3.326314e+04
    ## 450    6679.6233 4.862008e+10 4.862008e+04
    ## 451    7213.7913 6.034950e+10 6.034950e+04
    ## 452    6481.7770 6.186959e+10 6.186959e+04
    ## 453    7103.7026 7.635339e+10 7.635339e+04
    ## 454    7429.4559 8.849833e+10 8.849833e+04
    ## 455    5773.0445 7.459486e+10 7.459486e+04
    ## 456    6873.2623 9.454640e+10 9.454640e+04
    ## 457    1418.8224 3.153093e+10 3.153093e+04
    ## 458    1458.9153 3.648709e+10 3.648709e+04
    ## 459    1693.3359 4.770687e+10 4.770687e+04
    ## 460    1814.8807 5.749758e+10 5.749758e+04
    ## 461    2024.0081 7.045050e+10 7.045050e+04
    ## 462    2785.4936 1.080322e+11 1.080322e+05
    ## 463    3503.7296 1.600567e+11 1.600567e+05
    ## 464    3885.4607 2.051487e+11 2.051487e+05
    ## 465    3794.7552 2.254168e+11 2.254168e+05
    ## 466    4173.1818 2.759904e+11 2.759904e+05
    ## 467    4754.6044 3.485722e+11 3.485722e+05
    ## 468    5581.1810 4.479709e+11 4.479709e+05
    ## 469    3048.3029 6.227271e+09 6.227271e+03
    ## 470    3421.5232 8.060442e+09 8.060442e+03
    ## 471    3776.8036 1.037747e+10 1.037747e+04
    ## 472    4358.5954 1.409102e+10 1.409102e+04
    ## 473    4520.2460 1.713581e+10 1.713581e+04
    ## 474    5138.9224 2.200788e+10 2.200788e+04
    ## 475    4098.3442 1.833957e+10 1.833957e+04
    ## 476    4140.4421 2.004882e+10 2.004882e+04
    ## 477    4444.2317 2.344176e+10 2.344176e+04
    ## 478    5154.8255 2.981262e+10 2.981262e+04
    ## 479    5351.5687 3.400216e+10 3.400216e+04
    ## 480    5728.3535 3.975299e+10 3.975299e+04
    ## 481     375.6431 8.150103e+07 8.150103e+01
    ## 482     426.0964 9.924723e+07 9.924723e+01
    ## 483     582.8420 1.452559e+08 1.452559e+02
    ## 484     915.5960 2.379304e+08 2.379304e+02
    ## 485     672.4123 1.866637e+08 1.866637e+02
    ## 486     958.5668 1.846919e+08 1.846919e+02
    ## 487     927.8253 2.648784e+08 2.648784e+02
    ## 488     966.8968 3.299477e+08 3.299477e+02
    ## 489    1132.0550 4.390540e+08 4.390540e+02
    ## 490    2814.4808 1.238290e+09 1.238290e+03
    ## 491    7703.4959 3.818061e+09 3.818061e+03
    ## 492   12154.0897 6.699346e+09 6.699346e+03
    ## 493     328.9406 4.732665e+08 4.732665e+02
    ## 494     344.1619 5.309079e+08 5.309079e+02
    ## 495     380.9958 6.349745e+08 6.349745e+02
    ## 496     468.7950 8.533564e+08 8.533564e+02
    ## 497     514.3242 1.162469e+09 1.162469e+03
    ## 498     505.7538 1.270778e+09 1.270778e+03
    ## 499     524.8758 1.384254e+09 1.384254e+03
    ## 500     521.1341 1.519606e+09 1.519606e+03
    ## 501     582.8585 2.138181e+09 2.138181e+03
    ## 502     913.4708 3.707156e+09 3.707156e+03
    ## 503     765.3500 3.378917e+09 3.378917e+03
    ## 504     641.3695 3.146934e+09 3.146934e+03
    ## 505     362.1463 7.554712e+09 7.554712e+03
    ## 506     378.9042 8.644931e+09 8.644931e+03
    ## 507     419.4564 1.054739e+10 1.054739e+04
    ## 508     516.1186 1.437922e+10 1.437922e+04
    ## 509     566.2439 1.742354e+10 1.742354e+04
    ## 510     556.8084 1.927548e+10 1.927548e+04
    ## 511     577.8607 2.202329e+10 2.202329e+04
    ## 512     573.7413 2.467061e+10 2.467061e+04
    ## 513     421.3535 2.194769e+10 2.194769e+04
    ## 514     515.8894 3.088181e+10 3.088181e+04
    ## 515     530.0535 3.601544e+10 3.601544e+04
    ## 516     690.8056 5.285484e+10 5.285484e+04
    ## 517    6424.5191 2.627950e+10 2.627950e+04
    ## 518    7545.4154 3.262638e+10 3.262638e+04
    ## 519    9371.8426 4.209310e+10 4.209310e+04
    ## 520   10921.6363 5.030226e+10 5.030226e+04
    ## 521   14358.8759 6.662026e+10 6.662026e+04
    ## 522   15605.4228 7.395257e+10 7.395257e+04
    ## 523   18533.1576 8.945831e+10 8.945831e+04
    ## 524   21141.0122 1.042617e+11 1.042617e+05
    ## 525   20647.1650 1.040832e+11 1.040832e+05
    ## 526   23723.9502 1.218084e+11 1.218084e+05
    ## 527   28204.5906 1.464675e+11 1.464675e+05
    ## 528   33207.0844 1.739540e+11 1.739540e+05
    ## 529    7029.8093 2.984834e+11 2.984834e+05
    ## 530    8662.8349 3.838577e+11 3.838577e+05
    ## 531   10560.4855 4.976523e+11 4.976523e+05
    ## 532   12999.9177 6.443929e+11 6.443929e+05
    ## 533   16107.1917 8.332572e+11 8.332572e+05
    ## 534   18292.6351 9.725283e+11 9.725283e+05
    ## 535   20293.8975 1.104669e+12 1.104669e+06
    ## 536   22066.4421 1.227558e+12 1.227558e+06
    ## 537   24703.7961 1.417360e+12 1.417360e+06
    ## 538   25889.7849 1.517748e+12 1.517748e+06
    ## 539   28926.0323 1.733394e+12 1.733394e+06
    ## 540   30470.0167 1.861228e+12 1.861228e+06
    ## 541    4293.4765 1.806274e+09 1.806274e+03
    ## 542    4976.1981 2.164168e+09 2.164168e+03
    ## 543    6631.4592 3.021697e+09 3.021697e+03
    ## 544    8358.7620 4.087468e+09 4.087468e+03
    ## 545   11401.9484 6.133986e+09 6.133986e+03
    ## 546   21745.5733 1.536036e+10 1.536036e+04
    ## 547   15113.3619 1.139357e+10 1.139357e+04
    ## 548   11864.4084 1.044539e+10 1.044539e+04
    ## 549   13522.1575 1.332932e+10 1.332932e+04
    ## 550   14722.8419 1.658070e+10 1.658070e+04
    ## 551   12521.7139 1.626951e+10 1.626951e+04
    ## 552   13206.4845 1.921368e+10 1.921368e+04
    ## 553     485.2307 1.379608e+08 1.379608e+02
    ## 554     520.9267 1.683375e+08 1.683375e+02
    ## 555     599.6503 2.242812e+08 2.242812e+02
    ## 556     734.7829 3.230054e+08 3.230054e+02
    ## 557     756.0868 3.909733e+08 3.909733e+02
    ## 558     884.7553 5.381736e+08 5.381736e+02
    ## 559     835.8096 5.980410e+08 5.980410e+02
    ## 560     611.6589 5.189350e+08 5.189350e+02
    ## 561     665.6244 6.825206e+08 6.825206e+02
    ## 562     653.7302 8.078582e+08 8.078582e+02
    ## 563     660.5856 9.629792e+08 9.629792e+02
    ## 564     752.7497 1.270912e+09 1.270912e+03
    ## 565    7144.1144 4.939866e+11 4.939866e+05
    ## 566   10187.8267 7.235300e+11 7.235300e+05
    ## 567   12902.4629 9.514162e+11 9.514162e+05
    ## 568   14745.6256 1.126101e+12 1.126101e+06
    ## 569   18016.1803 1.418181e+12 1.418181e+06
    ## 570   20512.9212 1.603306e+12 1.603306e+06
    ## 571   22031.5327 1.725846e+12 1.725846e+06
    ## 572   24639.1857 1.914916e+12 1.914916e+06
    ## 573   26505.3032 2.136268e+12 2.136268e+06
    ## 574   27788.8842 2.278996e+12 2.278996e+06
    ## 575   30035.8020 2.473468e+12 2.473468e+06
    ## 576   32170.3744 2.650871e+12 2.650871e+06
    ## 577     911.2989 5.085960e+09 5.085960e+03
    ## 578    1043.5615 6.669702e+09 6.669702e+03
    ## 579    1190.0411 8.753048e+09 8.753048e+03
    ## 580    1125.6972 9.557409e+09 9.557409e+03
    ## 581    1178.2237 1.102125e+10 1.102125e+04
    ## 582     993.2240 1.046669e+10 1.046669e+04
    ## 583     876.0326 9.987067e+09 9.987067e+03
    ## 584     847.0061 1.200047e+10 1.200047e+04
    ## 585     925.0602 1.505881e+10 1.505881e+04
    ## 586    1005.2458 1.851491e+10 1.851491e+04
    ## 587    1111.9846 2.285212e+10 2.285212e+04
    ## 588    1327.6089 3.036685e+10 3.036685e+04
    ## 589    3530.6901 2.730371e+10 2.730371e+04
    ## 590    4916.2999 3.980344e+10 3.980344e+04
    ## 591    6017.1907 5.083463e+10 5.083463e+04
    ## 592    8513.0970 7.420391e+10 7.420391e+04
    ## 593   12724.8296 1.131063e+11 1.131063e+05
    ## 594   14195.5243 1.321387e+11 1.321387e+05
    ## 595   15268.4209 1.494241e+11 1.494241e+05
    ## 596   16120.5284 1.607940e+11 1.607940e+05
    ## 597   17541.4963 1.811235e+11 1.811235e+05
    ## 598   18747.6981 1.968953e+11 1.968953e+05
    ## 599   22514.2548 2.387381e+11 2.387381e+05
    ## 600   27538.4119 2.948342e+11 2.948342e+05
    ## 601    2428.2378 7.640161e+09 7.640161e+03
    ## 602    2617.1560 9.528740e+09 9.528740e+03
    ## 603    2750.3644 1.157589e+10 1.157589e+04
    ## 604    3242.5311 1.520998e+10 1.520998e+04
    ## 605    4031.4083 2.076006e+10 2.076006e+04
    ## 606    4879.9927 2.783270e+10 2.783270e+04
    ## 607    4820.4948 3.083010e+10 3.083010e+04
    ## 608    4246.4860 3.111148e+10 3.111148e+04
    ## 609    4439.4508 3.767739e+10 3.767739e+04
    ## 610    4684.3138 4.592443e+10 4.592443e+04
    ## 611    4858.3475 5.430977e+10 5.430977e+04
    ## 612    5186.0500 6.520383e+10 6.520383e+04
    ## 613     510.1965 1.359290e+09 1.359290e+03
    ## 614     576.2670 1.657762e+09 1.657762e+03
    ## 615     686.3737 2.155215e+09 2.155215e+03
    ## 616     708.7595 2.446225e+09 2.446225e+03
    ## 617     741.6662 2.826777e+09 2.826777e+03
    ## 618     874.6859 3.697320e+09 3.697320e+03
    ## 619     857.2504 4.038075e+09 4.038075e+03
    ## 620     805.5725 4.551696e+09 4.551696e+03
    ## 621     794.3484 5.552952e+09 5.552952e+03
    ## 622     869.4498 6.998057e+09 6.998057e+03
    ## 623     945.5836 8.328528e+09 8.328528e+03
    ## 624     942.6542 9.377349e+09 9.377349e+03
    ## 625     299.8503 1.741090e+08 1.741090e+02
    ## 626     431.7905 2.595471e+08 2.595471e+02
    ## 627     522.0344 3.277436e+08 3.277436e+02
    ## 628     715.5806 4.302693e+08 4.302693e+02
    ## 629     820.2246 5.129365e+08 5.129365e+02
    ## 630     764.7260 5.698952e+08 5.698952e+02
    ## 631     838.1240 6.922795e+08 6.922795e+02
    ## 632     736.4154 6.830430e+08 6.830430e+02
    ## 633     745.5399 7.835162e+08 7.835162e+02
    ## 634     796.6645 9.509847e+08 9.509847e+02
    ## 635     575.7047 7.671029e+08 7.671029e+02
    ## 636     579.2317 8.526529e+08 8.526529e+02
    ## 637    1840.3669 5.891913e+09 5.891913e+03
    ## 638    1726.8879 6.057406e+09 6.057406e+03
    ## 639    1796.5890 6.970999e+09 6.970999e+03
    ## 640    1452.0577 6.270184e+09 6.270184e+03
    ## 641    1654.4569 7.773137e+09 7.773137e+03
    ## 642    1874.2989 9.200098e+09 9.200098e+03
    ## 643    2011.1595 1.045481e+10 1.045481e+04
    ## 644    1823.0160 1.049365e+10 1.049365e+04
    ## 645    1456.3095 9.213607e+09 9.213607e+03
    ## 646    1341.7269 9.276090e+09 9.276090e+03
    ## 647    1270.3649 9.664493e+09 9.664493e+03
    ## 648    1201.6372 1.021730e+10 1.021730e+04
    ## 649    2194.9262 3.330697e+09 3.330697e+03
    ## 650    2220.4877 3.931129e+09 3.931129e+03
    ## 651    2291.1568 4.788889e+09 4.788889e+03
    ## 652    2538.2694 6.347422e+09 6.347422e+03
    ## 653    2529.8423 7.501352e+09 7.501352e+03
    ## 654    3203.2081 9.786553e+09 9.786553e+03
    ## 655    3121.7608 1.145514e+10 1.145514e+04
    ## 656    3023.0967 1.321759e+10 1.321759e+04
    ## 657    3081.6946 1.564683e+10 1.564683e+04
    ## 658    3160.4549 1.854541e+10 1.854541e+04
    ## 659    3099.7287 2.069790e+10 2.069790e+04
    ## 660    3548.3308 2.655487e+10 2.655487e+04
    ## 661    3054.4212 6.493394e+09 6.493394e+03
    ## 662    3629.0765 9.930242e+09 9.930242e+03
    ## 663    4692.6483 1.551014e+10 1.551014e+04
    ## 664    6197.9628 2.307378e+10 2.307378e+04
    ## 665    8315.9281 3.422587e+10 3.422587e+04
    ## 666   11186.1413 5.127392e+10 5.127392e+04
    ## 667   14560.5305 7.665391e+10 7.665391e+04
    ## 668   20038.4727 1.119051e+11 1.119051e+05
    ## 669   24757.6030 1.443293e+11 1.443293e+05
    ## 670   28377.6322 1.843388e+11 1.843388e+05
    ## 671   30209.0152 2.042877e+11 2.042877e+05
    ## 672   39724.9787 2.772967e+11 2.772967e+05
    ## 673    5263.6738 5.002596e+10 5.002596e+04
    ## 674    6040.1800 5.942933e+10 5.942933e+04
    ## 675    7550.3599 7.597927e+10 7.597927e+04
    ## 676    9326.6447 9.535022e+10 9.535022e+04
    ## 677   10168.6561 1.056939e+11 1.056939e+05
    ## 678   11674.8374 1.241872e+11 1.241872e+05
    ## 679   12545.9907 1.343115e+11 1.343115e+05
    ## 680   12986.4800 1.378221e+11 1.378221e+05
    ## 681   10535.6285 1.090299e+11 1.090299e+05
    ## 682   11712.7768 1.199937e+11 1.199937e+05
    ## 683   14843.9356 1.496760e+11 1.496760e+05
    ## 684   18008.9444 1.792990e+11 1.792990e+05
    ## 685    7267.6884 1.075342e+09 1.075342e+03
    ## 686    9244.0014 1.526277e+09 1.526277e+03
    ## 687   10350.1591 1.884278e+09 1.884278e+03
    ## 688   13319.8957 2.646344e+09 2.646344e+03
    ## 689   15798.0636 3.306140e+09 3.306140e+03
    ## 690   19654.9625 4.359923e+09 4.359923e+03
    ## 691   23269.6075 5.445018e+09 5.445018e+03
    ## 692   26923.2063 6.587462e+09 6.587462e+03
    ## 693   25144.3920 6.512699e+09 6.512699e+03
    ## 694   28061.0997 7.609946e+09 7.609946e+03
    ## 695   31163.2020 8.975937e+09 8.975937e+03
    ## 696   36180.7892 1.092410e+10 1.092410e+04
    ## 697     546.5657 2.033225e+11 2.033225e+05
    ## 698     590.0620 2.413354e+11 2.413354e+05
    ## 699     658.3472 2.988896e+11 2.988896e+05
    ## 700     700.7706 3.545899e+11 3.545899e+05
    ## 701     724.0325 4.105264e+11 4.105264e+05
    ## 702     813.3373 5.156559e+11 5.156559e+05
    ## 703     855.7235 6.058523e+11 6.058523e+05
    ## 704     976.5127 7.694920e+11 7.694920e+05
    ## 705    1164.4068 1.015363e+12 1.015363e+06
    ## 706    1458.8174 1.399006e+12 1.399006e+06
    ## 707    1746.7695 1.806461e+12 1.806461e+06
    ## 708    2452.2104 2.722925e+12 2.722925e+06
    ## 709     749.6817 6.151288e+10 6.151288e+04
    ## 710     858.9003 7.740753e+10 7.740753e+04
    ## 711     849.2898 8.410347e+10 8.410347e+04
    ## 712     762.4318 8.336658e+10 8.336658e+04
    ## 713    1111.1079 1.347574e+11 1.347574e+05
    ## 714    1382.7021 1.890499e+11 1.890499e+05
    ## 715    1516.8730 2.326019e+11 2.326019e+05
    ## 716    1748.3570 2.959549e+11 2.959549e+05
    ## 717    2383.1409 4.404426e+11 4.404426e+05
    ## 718    3119.3356 6.216150e+11 6.216150e+05
    ## 719    2873.9129 6.065681e+11 6.065681e+05
    ## 720    3540.6516 7.915020e+11 7.915020e+05
    ## 721    3035.3260 5.242615e+10 5.242615e+04
    ## 722    3290.2576 6.512078e+10 6.512078e+04
    ## 723    4187.3298 9.578098e+10 9.578098e+04
    ## 724    5906.7318 1.567528e+11 1.567528e+05
    ## 725    9613.8186 2.943174e+11 2.943174e+05
    ## 726   11888.5951 4.218154e+11 4.218154e+05
    ## 727    7608.3346 3.277119e+11 3.277119e+05
    ## 728    6642.8814 3.446971e+11 3.446971e+05
    ## 729    7235.6532 4.370188e+11 4.370188e+05
    ## 730    8263.5903 5.233165e+11 5.233165e+05
    ## 731    9240.7620 6.182793e+11 6.182793e+05
    ## 732   11605.7145 8.060583e+11 8.060583e+05
    ## 733    4129.7661 2.247322e+10 2.247322e+04
    ## 734    6229.3336 3.892488e+10 3.892488e+04
    ## 735    8341.7378 6.039635e+10 6.039635e+04
    ## 736    8931.4598 7.608962e+10 7.608962e+04
    ## 737    9576.0376 9.634936e+10 9.634936e+04
    ## 738   14688.2351 1.745391e+11 1.745391e+05
    ## 739   14517.9071 2.057669e+11 2.057669e+05
    ## 740   11643.5727 1.926218e+11 1.926218e+05
    ## 741    3745.6407 6.690428e+10 6.690428e+04
    ## 742    3076.2398 6.391104e+10 6.391104e+04
    ## 743    4390.7173 1.053852e+11 1.053852e+05
    ## 744    4471.0619 1.229526e+11 1.229526e+05
    ## 745    5210.2803 1.538156e+10 1.538156e+04
    ## 746    5599.0779 1.611538e+10 1.611538e+04
    ## 747    6631.5973 1.876742e+10 1.876742e+04
    ## 748    7655.5690 2.220192e+10 2.220192e+04
    ## 749    9530.7729 2.882487e+10 2.882487e+04
    ## 750   11150.9811 3.648490e+10 3.648490e+04
    ## 751   12618.3214 4.391176e+10 4.391176e+04
    ## 752   13872.8665 4.910856e+10 4.910856e+04
    ## 753   17558.8155 6.247007e+10 6.247007e+04
    ## 754   24521.9471 8.992769e+10 8.992769e+04
    ## 755   34077.0494 1.321902e+11 1.321902e+05
    ## 756   40675.9964 1.671412e+11 1.671412e+05
    ## 757    4086.5221 6.623901e+09 6.623901e+03
    ## 758    5385.2785 1.047114e+10 1.047114e+04
    ## 759    7105.6307 1.642043e+10 1.642043e+04
    ## 760    8393.7414 2.260926e+10 2.260926e+04
    ## 761   12786.9322 3.958697e+10 3.958697e+04
    ## 762   13306.6192 4.651885e+10 4.651885e+04
    ## 763   15367.0292 5.929247e+10 5.929247e+04
    ## 764   17122.4799 7.196832e+10 7.196832e+04
    ## 765   18051.5225 8.911224e+10 8.911224e+04
    ## 766   20896.6092 1.155872e+11 1.155872e+05
    ## 767   21905.5951 1.320804e+11 1.320804e+05
    ## 768   25523.2771 1.640299e+11 1.640299e+05
    ## 769    4931.4042 2.350603e+11 2.350603e+05
    ## 770    6248.6562 3.073214e+11 3.073214e+05
    ## 771    8243.5823 4.191301e+11 4.191301e+05
    ## 772   10022.4013 5.278508e+11 5.278508e+05
    ## 773   12269.2738 6.670260e+11 6.670260e+05
    ## 774   14255.9847 7.991797e+11 7.991797e+05
    ## 775   16537.4835 9.349571e+11 9.349571e+05
    ## 776   19207.2348 1.089621e+12 1.089621e+06
    ## 777   22013.6449 1.251274e+12 1.251274e+06
    ## 778   24675.0245 1.418307e+12 1.418307e+06
    ## 779   27968.0982 1.620108e+12 1.620108e+06
    ## 780   28569.7197 1.661264e+12 1.661264e+06
    ## 781    2898.5309 4.133580e+09 4.133580e+03
    ## 782    4756.5258 7.301695e+09 7.301695e+03
    ## 783    5246.1075 8.735441e+09 8.735441e+03
    ## 784    6124.7035 1.139866e+10 1.139866e+04
    ## 785    7433.8893 1.485006e+10 1.485006e+04
    ## 786    6650.1956 1.434323e+10 1.434323e+04
    ## 787    6068.0513 1.394626e+10 1.394626e+04
    ## 788    6351.2375 1.477683e+10 1.477683e+04
    ## 789    7404.9237 1.761348e+10 1.761348e+04
    ## 790    7121.9247 1.802781e+10 1.802781e+04
    ## 791    6994.7749 1.863869e+10 1.863869e+04
    ## 792    7320.8803 2.035301e+10 2.035301e+04
    ## 793    3216.9563 2.781349e+11 2.781349e+05
    ## 794    4317.6944 3.953411e+11 3.953411e+05
    ## 795    6576.6495 6.302519e+11 6.302519e+05
    ## 796    9847.7886 9.929060e+11 9.929060e+05
    ## 797   14778.7864 1.584113e+12 1.584113e+06
    ## 798   16610.3770 1.891465e+12 1.891465e+06
    ## 799   19384.1057 2.296144e+12 2.296144e+06
    ## 800   22375.9419 2.731908e+12 2.731908e+06
    ## 801   26824.8951 3.335120e+12 3.335120e+06
    ## 802   28816.5850 3.629636e+12 3.629636e+06
    ## 803   28604.5919 3.634667e+12 3.634667e+06
    ## 804   31656.0681 4.035135e+12 4.035135e+06
    ## 805    1546.9078 9.403869e+08 9.403869e+02
    ## 806    1886.0806 1.408070e+09 1.408070e+03
    ## 807    2348.0092 2.192005e+09 2.192005e+03
    ## 808    2741.7963 3.441113e+09 3.441113e+03
    ## 809    2110.8563 3.405974e+09 3.405974e+03
    ## 810    2852.3516 5.526865e+09 5.526865e+03
    ## 811    4161.4160 9.766972e+09 9.766972e+03
    ## 812    4448.6799 1.254546e+10 1.254546e+04
    ## 813    3431.5936 1.327138e+10 1.327138e+04
    ## 814    3645.3796 1.649984e+10 1.649984e+04
    ## 815    3844.9172 2.040678e+10 2.040678e+04
    ## 816    4519.4612 2.735717e+10 2.735717e+04
    ## 817     853.5409 5.517328e+09 5.517328e+03
    ## 818     944.4383 7.040579e+09 7.040579e+03
    ## 819     896.9664 7.784374e+09 7.784374e+03
    ## 820    1056.7365 1.076974e+10 1.076974e+04
    ## 821    1222.3600 1.472306e+10 1.472306e+04
    ## 822    1267.6132 1.838090e+10 1.838090e+04
    ## 823    1348.2258 2.381163e+10 2.381163e+04
    ## 824    1361.9369 2.887045e+10 2.887045e+04
    ## 825    1341.9217 3.357560e+10 3.357560e+04
    ## 826    1360.4850 3.845251e+10 3.845251e+04
    ## 827    1287.5147 4.041102e+10 4.041102e+04
    ## 828    1463.2493 5.210657e+10 5.210657e+04
    ## 829    1088.2778 9.648113e+09 9.648113e+03
    ## 830    1571.1347 1.478655e+10 1.478655e+04
    ## 831    1621.6936 1.770483e+10 1.770483e+04
    ## 832    2143.5406 2.704507e+10 2.704507e+04
    ## 833    3701.6215 5.471456e+10 5.471456e+04
    ## 834    4106.3012 6.703668e+10 6.703668e+04
    ## 835    4106.5253 7.246998e+10 7.246998e+04
    ## 836    4106.4923 7.830076e+10 7.830076e+04
    ## 837    3726.0635 7.717190e+10 7.717190e+04
    ## 838    1690.7568 3.649516e+10 3.649516e+04
    ## 839    1646.7582 3.658333e+10 3.658333e+04
    ## 840    1593.0655 3.712117e+10 3.712117e+04
    ## 841    1030.5922 2.158840e+10 2.158840e+04
    ## 842    1487.5935 3.363680e+10 3.363680e+04
    ## 843    1536.3444 4.059069e+10 4.059069e+04
    ## 844    2029.2281 6.114267e+10 6.114267e+04
    ## 845    3030.8767 1.015495e+11 1.015495e+05
    ## 846    4657.2210 1.696905e+11 1.696905e+05
    ## 847    5622.9425 2.211278e+11 2.211278e+05
    ## 848    8533.0888 3.551642e+11 3.551642e+05
    ## 849   12104.2787 5.302334e+11 5.302334e+05
    ## 850   15993.5280 7.384822e+11 7.384822e+05
    ## 851   19233.9882 9.226381e+11 9.226381e+05
    ## 852   23348.1397 1.145105e+12 1.145105e+06
    ## 853  108382.3529 1.734118e+10 1.734118e+04
    ## 854  113523.1329 2.416294e+10 2.416294e+04
    ## 855   95458.1118 3.419940e+10 3.419940e+04
    ## 856   80894.8833 4.651480e+10 4.651480e+04
    ## 857  109347.8670 9.206369e+10 9.206369e+04
    ## 858   59265.4771 6.758380e+10 6.758380e+04
    ## 859   31354.0357 4.695248e+10 4.695248e+04
    ## 860   28118.4300 5.318564e+10 5.318564e+04
    ## 861   34932.9196 4.953820e+10 4.953820e+04
    ## 862   40300.6200 7.114450e+10 7.114450e+04
    ## 863   35110.1057 7.413713e+10 7.413713e+04
    ## 864   47306.9898 1.185305e+11 1.185305e+05
    ## 865    4834.8041 6.959841e+09 6.959841e+03
    ## 866    6089.7869 1.003239e+10 1.003239e+04
    ## 867    5714.5606 1.078251e+10 1.078251e+04
    ## 868    6006.9830 1.313664e+10 1.313664e+04
    ## 869    7486.3843 2.006364e+10 2.006364e+04
    ## 870    8659.6968 2.698177e+10 2.698177e+04
    ## 871    7640.5195 2.358534e+10 2.358534e+04
    ## 872    5377.0913 1.661173e+10 1.661173e+04
    ## 873    6890.8069 2.218836e+10 2.218836e+04
    ## 874    8754.9639 3.003292e+10 3.003292e+04
    ## 875    9313.9388 3.425462e+10 3.425462e+04
    ## 876   10461.0587 4.102072e+10 4.102072e+04
    ## 877     298.8462 2.237602e+08 2.237602e+02
    ## 878     335.9971 2.732792e+08 2.732792e+02
    ## 879     411.8006 3.677968e+08 3.677968e+02
    ## 880     498.6390 4.968340e+08 4.968340e+02
    ## 881     496.5816 5.545719e+08 5.545719e+02
    ## 882     745.3695 9.328479e+08 9.328479e+02
    ## 883     797.2631 1.125582e+09 1.125582e+03
    ## 884     773.9932 1.237770e+09 1.237770e+03
    ## 885     977.4863 1.762598e+09 1.762598e+03
    ## 886    1186.1480 2.351922e+09 2.351922e+03
    ## 887    1275.1846 2.610012e+09 2.610012e+03
    ## 888    1569.3314 3.158513e+09 3.158513e+03
    ## 889     575.5730 4.968968e+08 4.968968e+02
    ## 890     620.9700 6.060357e+08 6.060357e+02
    ## 891     634.1952 7.057298e+08 7.057298e+02
    ## 892     713.6036 9.129888e+08 9.129888e+02
    ## 893     803.0055 1.190558e+09 1.190558e+03
    ## 894     640.3224 1.090864e+09 1.090864e+03
    ## 895     572.1996 1.119723e+09 1.119723e+03
    ## 896     506.1139 1.148582e+09 1.148582e+03
    ## 897     636.6229 1.217843e+09 1.217843e+03
    ## 898     609.1740 1.340624e+09 1.340624e+03
    ## 899     531.4824 1.495937e+09 1.495937e+03
    ## 900     414.5073 1.323912e+09 1.323912e+03
    ## 901    2387.5481 2.434652e+09 2.434652e+03
    ## 902    3448.2844 4.143383e+09 4.143383e+03
    ## 903    6757.0308 9.742713e+09 9.742713e+03
    ## 904   18772.7517 3.302548e+10 3.302548e+04
    ## 905   21011.4972 4.588653e+10 4.588653e+04
    ## 906   21951.2118 5.974643e+10 5.974643e+04
    ## 907   17364.2754 5.806742e+10 5.806742e+04
    ## 908   11770.5898 4.472642e+10 4.472642e+04
    ## 909    9640.1385 4.207439e+10 4.207439e+04
    ## 910    9467.4461 4.506192e+10 4.506192e+04
    ## 911    9534.6775 5.118773e+10 5.118773e+04
    ## 912   12057.4993 7.279009e+10 7.279009e+04
    ## 913    1443.0117 6.872938e+09 6.872938e+03
    ## 914    1589.2027 8.234739e+09 8.234739e+03
    ## 915    1643.3871 9.372769e+09 9.372769e+03
    ## 916    1634.0473 1.035096e+10 1.035096e+04
    ## 917    1748.5630 1.238407e+10 1.238407e+04
    ## 918    1544.2286 1.236489e+10 1.236489e+04
    ## 919    1302.8787 1.194932e+10 1.194932e+04
    ## 920    1155.4419 1.221145e+10 1.221145e+04
    ## 921    1040.6762 1.270707e+10 1.270707e+04
    ## 922     986.2959 1.397099e+10 1.397099e+04
    ## 923     894.6371 1.473778e+10 1.473778e+04
    ## 924    1044.7701 2.002579e+10 2.002579e+04
    ## 925     369.1651 1.077151e+09 1.077151e+03
    ## 926     416.3698 1.341226e+09 1.341226e+03
    ## 927     427.9011 1.552685e+09 1.552685e+03
    ## 928     495.5148 2.055025e+09 2.055025e+03
    ## 929     584.6220 2.765845e+09 2.765845e+03
    ## 930     663.2237 3.738755e+09 3.738755e+03
    ## 931     632.8039 4.115013e+09 4.115013e+03
    ## 932     635.5174 4.972763e+09 4.972763e+03
    ## 933     563.2000 5.640025e+09 5.640025e+03
    ## 934     692.2758 7.213508e+09 7.213508e+03
    ## 935     665.4231 7.868292e+09 7.868292e+03
    ## 936     759.3499 1.011992e+10 1.011992e+04
    ## 937    1831.1329 1.235718e+10 1.235718e+04
    ## 938    1810.0670 1.400853e+10 1.400853e+04
    ## 939    2036.8849 1.814128e+10 1.814128e+04
    ## 940    2277.7424 2.313020e+10 2.313020e+04
    ## 941    2849.0948 3.259781e+10 3.259781e+04
    ## 942    3827.9216 4.917111e+10 4.917111e+04
    ## 943    4920.3560 7.105937e+10 7.105937e+04
    ## 944    5249.8027 8.573865e+10 8.573865e+04
    ## 945    7277.9128 1.333277e+11 1.333277e+05
    ## 946   10132.9096 2.074824e+11 2.074824e+05
    ## 947   10206.9779 2.313143e+11 2.313143e+05
    ## 948   12451.6558 3.090661e+11 3.090661e+05
    ## 949     452.3370 1.736145e+09 1.736145e+03
    ## 950     490.3822 2.080144e+09 2.080144e+03
    ## 951     496.1743 2.327242e+09 2.327242e+03
    ## 952     545.0099 2.840818e+09 2.840818e+03
    ## 953     581.3689 3.388310e+09 3.388310e+03
    ## 954     686.3953 4.455837e+09 4.455837e+03
    ## 955     618.0141 4.325021e+09 4.325021e+03
    ## 956     684.1716 5.222971e+09 5.222971e+03
    ## 957     739.0144 6.219704e+09 6.219704e+03
    ## 958     790.2580 7.416559e+09 7.416559e+03
    ## 959     951.4098 1.006608e+10 1.006608e+04
    ## 960    1042.5816 1.254413e+10 1.254413e+04
    ## 961     743.1159 7.598776e+08 7.598776e+02
    ## 962     846.1203 9.111463e+08 9.111463e+02
    ## 963    1055.8960 1.210856e+09 1.210856e+03
    ## 964    1421.1452 1.748779e+09 1.748779e+03
    ## 965    1586.8518 2.114934e+09 2.114934e+03
    ## 966    1497.4922 2.181379e+09 2.181379e+03
    ## 967    1481.1502 2.402627e+09 2.402627e+03
    ## 968    1421.6036 2.617513e+09 2.617513e+03
    ## 969    1361.3698 2.885376e+09 2.885376e+03
    ## 970    1483.1361 3.625884e+09 3.625884e+03
    ## 971    1579.0195 4.466822e+09 4.466822e+03
    ## 972    1803.1515 5.896423e+09 5.896423e+03
    ## 973    1967.9557 1.016559e+09 1.016559e+03
    ## 974    2034.0380 1.240389e+09 1.240389e+03
    ## 975    2529.0675 1.772917e+09 1.772917e+03
    ## 976    2475.3876 1.953846e+09 1.953846e+03
    ## 977    2575.4842 2.192597e+09 2.192597e+03
    ## 978    3710.9830 3.388220e+09 3.388220e+03
    ## 979    3688.0377 3.658681e+09 3.658681e+03
    ## 980    4783.5869 4.987669e+09 4.987669e+03
    ## 981    6058.2538 6.641070e+09 6.641070e+03
    ## 982    7425.7053 8.538210e+09 8.538210e+03
    ## 983    9021.8159 1.082804e+10 1.082804e+04
    ## 984   10956.9911 1.370590e+10 1.370590e+04
    ## 985    3478.1255 1.048457e+11 1.048457e+05
    ## 986    4131.5466 1.446684e+11 1.446684e+05
    ## 987    4581.6094 1.884026e+11 1.884026e+05
    ## 988    5754.7339 2.762017e+11 2.762017e+05
    ## 989    6809.4067 3.812198e+11 3.812198e+05
    ## 990    7674.9291 4.893533e+11 4.893533e+05
    ## 991    9611.1475 6.885513e+11 6.885513e+05
    ## 992    8688.1560 6.961167e+11 6.961167e+05
    ## 993    9472.3843 8.346215e+11 8.346215e+05
    ## 994    9767.2975 9.366364e+11 9.366364e+05
    ## 995   10742.4405 1.100885e+12 1.100885e+06
    ## 996   11977.5750 1.301973e+12 1.301973e+06
    ## 997     786.5669 6.297750e+08 6.297750e+02
    ## 998     912.6626 8.050907e+08 8.050907e+02
    ## 999    1056.3540 1.067213e+09 1.067213e+03
    ## 1000   1226.0411 1.409334e+09 1.409334e+03
    ## 1001   1421.7420 1.877410e+09 1.877410e+03
    ## 1002   1647.5117 2.517398e+09 2.517398e+03
    ## 1003   2000.6031 3.513123e+09 3.513123e+03
    ## 1004   2338.0083 4.711398e+09 4.711398e+03
    ## 1005   1785.4020 4.129281e+09 4.129281e+03
    ## 1006   1902.2521 4.745744e+09 4.745744e+03
    ## 1007   2140.7393 5.724838e+09 5.724838e+03
    ## 1008   3095.7723 8.897643e+09 8.897643e+03
    ## 1009   2647.5856 1.095661e+09 1.095661e+03
    ## 1010   3682.2599 1.630611e+09 1.630611e+03
    ## 1011   4649.5938 2.206362e+09 2.206362e+03
    ## 1012   5907.8509 2.960040e+09 2.960040e+03
    ## 1013   7778.4140 4.104498e+09 4.104498e+03
    ## 1014   9595.9299 5.374421e+09 5.374421e+03
    ## 1015  11222.5876 6.313244e+09 6.313244e+03
    ## 1016  11732.5102 6.681348e+09 6.681348e+03
    ## 1017   7003.3390 4.353423e+09 4.353423e+03
    ## 1018   6465.6133 4.478414e+09 4.478414e+03
    ## 1019   6557.1943 4.722688e+09 4.722688e+03
    ## 1020   9253.8961 6.336476e+09 6.336476e+03
    ## 1021   1688.2036 1.677942e+10 1.677942e+04
    ## 1022   1642.0023 1.872925e+10 1.872925e+04
    ## 1023   1566.3535 2.045126e+10 2.045126e+04
    ## 1024   1711.0448 2.527264e+10 2.527264e+04
    ## 1025   1930.1950 3.215834e+10 3.215834e+04
    ## 1026   2370.6200 4.361216e+10 4.361216e+04
    ## 1027   2702.6204 5.458950e+10 5.458950e+04
    ## 1028   2755.0470 6.333136e+10 6.333136e+04
    ## 1029   2948.0473 7.605443e+10 7.605443e+04
    ## 1030   2982.1019 8.507788e+10 8.507788e+04
    ## 1031   3258.4956 1.015601e+11 1.015601e+05
    ## 1032   3820.1752 1.289583e+11 1.289583e+05
    ## 1033    468.5260 3.020267e+09 3.020267e+03
    ## 1034    495.5868 3.487957e+09 3.487957e+03
    ## 1035    556.6864 4.335999e+09 4.335999e+03
    ## 1036    566.6692 4.919203e+09 4.919203e+03
    ## 1037    724.9178 7.111151e+09 7.111151e+03
    ## 1038    502.3197 5.589748e+09 5.589748e+03
    ## 1039    462.2114 5.817958e+09 5.817958e+03
    ## 1040    389.8762 5.026265e+09 5.026265e+03
    ## 1041    410.8968 5.407703e+09 5.407703e+03
    ## 1042    472.3461 7.842520e+09 7.842520e+03
    ## 1043    633.6179 1.170532e+10 1.170532e+04
    ## 1044    823.6856 1.643389e+10 1.643389e+04
    ## 1045    331.0000 6.650782e+09 6.650782e+03
    ## 1046    350.0000 7.606145e+09 7.606145e+03
    ## 1047    388.0000 9.170161e+09 9.170161e+03
    ## 1048    349.0000 9.028725e+09 9.028725e+03
    ## 1049    357.0000 1.016250e+10 1.016250e+04
    ## 1050    371.0000 1.169692e+10 1.169692e+04
    ## 1051    424.0000 1.470451e+10 1.470451e+04
    ## 1052    385.0000 1.464100e+10 1.464100e+04
    ## 1053    347.0000 1.406965e+10 1.406965e+04
    ## 1054    415.0000 1.794786e+10 1.794786e+04
    ## 1055    611.0000 2.786043e+10 2.786043e+04
    ## 1056    944.0000 4.508731e+10 4.508731e+04
    ## 1057   2423.7804 1.177548e+09 1.177548e+03
    ## 1058   2621.4481 1.436763e+09 1.436763e+03
    ## 1059   3173.2156 1.971811e+09 1.971811e+03
    ## 1060   3793.6948 2.680776e+09 2.680776e+03
    ## 1061   3746.0809 3.078462e+09 3.078462e+03
    ## 1062   3876.4860 3.787428e+09 3.787428e+03
    ## 1063   4191.1005 4.606061e+09 4.606061e+03
    ## 1064   3693.7313 4.721268e+09 4.721268e+03
    ## 1065   3804.5380 5.913215e+09 5.913215e+03
    ## 1066   3899.5243 6.920743e+09 6.920743e+03
    ## 1067   4072.3248 8.031247e+09 8.031247e+03
    ## 1068   4811.0604 9.887114e+09 9.887114e+03
    ## 1069    545.8657 5.012432e+09 5.012432e+03
    ## 1070    597.9364 5.789422e+09 5.789422e+03
    ## 1071    652.3969 6.740602e+09 6.740602e+03
    ## 1072    676.4422 7.617883e+09 7.617883e+03
    ## 1073    674.7881 8.375870e+09 8.375870e+03
    ## 1074    694.1124 9.671206e+09 9.671206e+03
    ## 1075    718.3731 1.134765e+10 1.134765e+04
    ## 1076    775.6325 1.389715e+10 1.389715e+04
    ## 1077    897.7404 1.824766e+10 1.824766e+04
    ## 1078   1010.8921 2.325164e+10 2.325164e+04
    ## 1079   1057.2063 2.735407e+10 2.735407e+04
    ## 1080   1091.3598 3.154225e+10 3.154225e+04
    ## 1081   8941.5719 9.283129e+10 9.283129e+04
    ## 1082  11276.1934 1.243356e+11 1.243356e+05
    ## 1083  12790.8496 1.510048e+11 1.510048e+05
    ## 1084  15363.2514 1.935281e+11 1.935281e+05
    ## 1085  18794.7457 2.505316e+11 2.505316e+05
    ## 1086  21209.0592 2.938089e+11 2.938089e+05
    ## 1087  21399.4605 3.062349e+11 3.062349e+05
    ## 1088  23651.3236 3.468532e+11 3.468532e+05
    ## 1089  26790.9496 4.065324e+11 4.065324e+05
    ## 1090  30246.1306 4.719747e+11 4.719747e+05
    ## 1091  33724.7578 5.437385e+11 5.437385e+05
    ## 1092  36797.9333 6.097643e+11 6.097643e+05
    ## 1093  10556.5757 2.105819e+10 2.105819e+04
    ## 1094  12247.3953 2.730443e+10 2.730443e+04
    ## 1095  13175.6780 3.278833e+10 3.278833e+04
    ## 1096  14463.9189 3.945974e+10 3.945974e+04
    ## 1097  16046.0373 4.700045e+10 4.700045e+04
    ## 1098  16233.7177 5.137809e+10 5.137809e+04
    ## 1099  17632.4104 5.661150e+10 5.661150e+04
    ## 1100  19007.1913 6.305001e+10 6.305001e+04
    ## 1101  18363.3249 6.312712e+10 6.312712e+04
    ## 1102  21050.4138 7.738526e+10 7.738526e+04
    ## 1103  23189.8014 9.062660e+10 9.062660e+04
    ## 1104  25185.0091 1.036557e+11 1.036557e+05
    ## 1105   3112.3639 3.628363e+09 3.628363e+03
    ## 1106   3457.4159 4.698034e+09 4.698034e+03
    ## 1107   3634.3644 5.780809e+09 5.780809e+03
    ## 1108   4643.3935 8.662204e+09 8.662204e+03
    ## 1109   4688.5933 1.023477e+10 1.023477e+04
    ## 1110   5486.3711 1.401547e+10 1.401547e+04
    ## 1111   3470.3382 1.033961e+10 1.033961e+04
    ## 1112   2955.9844 9.885855e+09 9.885855e+03
    ## 1113   2170.1517 8.719537e+09 8.719537e+03
    ## 1114   2253.0230 1.038547e+10 1.038547e+04
    ## 1115   2474.5488 1.273613e+10 1.273613e+04
    ## 1116   2749.3210 1.560338e+10 1.560338e+04
    ## 1117    761.8794 2.574747e+09 2.574747e+03
    ## 1118    835.5234 3.084906e+09 3.084906e+03
    ## 1119    997.7661 4.066903e+09 4.066903e+03
    ## 1120   1054.3849 4.780646e+09 4.780646e+03
    ## 1121    954.2092 4.828549e+09 4.828549e+03
    ## 1122    808.8971 4.596223e+09 4.596223e+03
    ## 1123    909.7221 5.856052e+09 5.856052e+03
    ## 1124    668.3000 4.900402e+09 4.900402e+03
    ## 1125    581.1827 4.877761e+09 4.877761e+03
    ## 1126    580.3052 5.609376e+09 5.609376e+03
    ## 1127    601.0745 6.696364e+09 6.696364e+03
    ## 1128    619.6769 7.990650e+09 7.990650e+03
    ## 1129   1077.2819 3.567860e+10 3.567860e+04
    ## 1130   1100.5926 4.091270e+10 4.091270e+04
    ## 1131   1150.9275 4.819089e+10 4.819089e+04
    ## 1132   1014.5141 4.797409e+10 4.797409e+04
    ## 1133   1698.3888 9.127156e+10 9.127156e+04
    ## 1134   1981.9518 1.232956e+11 1.232956e+05
    ## 1135   1576.9738 1.151812e+11 1.151812e+05
    ## 1136   1385.0296 1.129513e+11 1.129513e+05
    ## 1137   1619.8482 1.512359e+11 1.512359e+05
    ## 1138   1624.9413 1.725815e+11 1.725815e+05
    ## 1139   1615.2864 1.936749e+11 1.936749e+05
    ## 1140   2013.9773 2.719497e+11 2.719497e+05
    ## 1141  10095.4217 3.359482e+10 3.359482e+04
    ## 1142  11653.9730 4.069495e+10 4.069495e+04
    ## 1143  13450.4015 4.894492e+10 4.894492e+04
    ## 1144  16361.8765 6.194638e+10 6.194638e+04
    ## 1145  18965.0555 7.458964e+10 7.458964e+04
    ## 1146  23311.3494 9.425256e+10 9.425256e+04
    ## 1147  26298.6353 1.082133e+11 1.082133e+05
    ## 1148  31540.9748 1.320352e+11 1.320352e+05
    ## 1149  33965.6611 1.455889e+11 1.455889e+05
    ## 1150  41283.1643 1.818801e+11 1.818801e+05
    ## 1151  44683.9753 2.026682e+11 2.026682e+05
    ## 1152  49357.1902 2.284214e+11 2.284214e+05
    ## 1153   1828.2303 9.284357e+08 9.284357e+02
    ## 1154   2242.7466 1.260372e+09 1.260372e+03
    ## 1155   2924.6381 1.837152e+09 1.837152e+03
    ## 1156   4720.9427 3.374412e+09 3.374412e+03
    ## 1157  10618.0385 8.802885e+09 8.802885e+03
    ## 1158  11848.3439 1.190205e+10 1.190205e+04
    ## 1159  12954.7910 1.685480e+10 1.685480e+04
    ## 1160  18115.2231 2.887353e+10 2.887353e+04
    ## 1161  18616.7069 3.565487e+10 3.565487e+04
    ## 1162  19702.0558 4.499230e+10 4.499230e+04
    ## 1163  19774.8369 5.365827e+10 5.365827e+04
    ## 1164  22316.1929 7.152110e+10 7.152110e+04
    ## 1165    684.5971 2.830574e+10 2.830574e+04
    ## 1166    747.0835 3.487382e+10 3.487382e+04
    ## 1167    803.3427 4.265804e+10 4.265804e+04
    ## 1168    942.4083 5.714943e+10 5.714943e+04
    ## 1169   1049.9390 7.278799e+10 7.278799e+04
    ## 1170   1175.9212 9.190140e+10 9.190140e+04
    ## 1171   1443.4298 1.320191e+11 1.320191e+05
    ## 1172   1704.6866 1.793107e+11 1.793107e+05
    ## 1173   1971.8295 2.367477e+11 2.367477e+05
    ## 1174   2049.3505 2.778199e+11 2.778199e+05
    ## 1175   2092.7124 3.210295e+11 3.210295e+05
    ## 1176   2605.9476 4.411104e+11 4.411104e+05
    ## 1177   2480.3803 2.331756e+09 2.331756e+03
    ## 1178   2961.8009 3.149893e+09 3.149893e+03
    ## 1179   3536.5403 4.299460e+09 4.299460e+03
    ## 1180   4421.0091 6.213666e+09 6.213666e+03
    ## 1181   5364.2497 8.670687e+09 8.670687e+03
    ## 1182   5351.9121 9.846352e+09 9.846352e+03
    ## 1183   7009.6016 1.427369e+10 1.427369e+04
    ## 1184   7034.7792 1.585385e+10 1.585385e+04
    ## 1185   6618.7431 1.644756e+10 1.644756e+04
    ## 1186   7113.6923 1.945261e+10 1.945261e+04
    ## 1187   7356.0319 2.200097e+10 2.200097e+04
    ## 1188   9809.1856 3.180308e+10 3.180308e+04
    ## 1189   1952.3087 3.037550e+09 3.037550e+03
    ## 1190   2046.1547 3.623539e+09 3.623539e+03
    ## 1191   2148.0271 4.317133e+09 4.317133e+03
    ## 1192   2299.3763 5.260939e+09 5.260939e+03
    ## 1193   2523.3380 6.596268e+09 6.596268e+03
    ## 1194   3248.3733 9.694751e+09 9.694751e+03
    ## 1195   4258.5036 1.433599e+10 1.433599e+04
    ## 1196   3998.8757 1.554168e+10 1.554168e+04
    ## 1197   4196.4111 1.881648e+10 1.881648e+04
    ## 1198   4247.4003 2.189162e+10 2.189162e+04
    ## 1199   3783.6742 2.226500e+10 2.226500e+04
    ## 1200   4172.8385 2.782093e+10 2.782093e+04
    ## 1201   3758.5234 3.016478e+10 3.016478e+04
    ## 1202   4245.2567 3.882754e+10 3.882754e+04
    ## 1203   4957.0380 5.213069e+10 5.213069e+04
    ## 1204   5788.0933 7.022231e+10 7.022231e+04
    ## 1205   5937.8273 8.286060e+10 8.286060e+04
    ## 1206   6281.2909 1.004385e+11 1.004385e+05
    ## 1207   6434.5018 1.166262e+11 1.166262e+05
    ## 1208   6360.9434 1.284651e+11 1.284651e+05
    ## 1209   4446.3809 9.973432e+10 9.973432e+04
    ## 1210   5838.3477 1.444881e+11 1.444881e+05
    ## 1211   5909.0201 1.581811e+11 1.581811e+05
    ## 1212   7408.9056 2.124486e+11 2.124486e+05
    ## 1213   1272.8810 2.856178e+10 2.856178e+04
    ## 1214   1547.9448 4.035832e+10 4.035832e+04
    ## 1215   1649.5522 5.002310e+10 5.002310e+04
    ## 1216   1814.1274 6.414138e+10 6.414138e+04
    ## 1217   1989.3741 8.126621e+10 8.126621e+04
    ## 1218   2373.2043 1.111869e+11 1.111869e+05
    ## 1219   2603.2738 1.391626e+11 1.391626e+05
    ## 1220   2189.6350 1.314170e+11 1.314170e+05
    ## 1221   2279.3240 1.531381e+11 1.531381e+05
    ## 1222   2536.5349 1.902731e+11 1.902731e+05
    ## 1223   2650.9211 2.200134e+11 2.200134e+05
    ## 1224   3190.4810 2.905804e+11 2.905804e+05
    ## 1225   4029.3297 1.036769e+11 1.036769e+05
    ## 1226   4734.2530 1.336733e+11 1.336733e+05
    ## 1227   5338.7521 1.619223e+11 1.619223e+05
    ## 1228   6557.1528 2.084216e+11 2.084216e+05
    ## 1229   8006.5070 2.645313e+11 2.645313e+05
    ## 1230   9508.1415 3.291838e+11 3.291838e+05
    ## 1231   8451.5310 3.061768e+11 3.061768e+05
    ## 1232   9082.3512 3.427744e+11 3.427744e+05
    ## 1233   7738.8812 2.969463e+11 2.969463e+05
    ## 1234  10159.5837 3.927183e+11 3.927183e+05
    ## 1235  12002.2391 4.635982e+11 4.635982e+05
    ## 1236  15389.9247 5.927928e+11 5.927928e+05
    ## 1237   3068.3199 2.616065e+10 2.616065e+04
    ## 1238   3774.5717 3.328285e+10 3.328285e+04
    ## 1239   4727.9549 4.264521e+10 4.264521e+04
    ## 1240   6361.5180 5.790890e+10 5.790890e+04
    ## 1241   9022.2474 8.093362e+10 8.093362e+04
    ## 1242  10172.4857 9.829266e+10 9.829266e+04
    ## 1243  11753.8429 1.158888e+11 1.158888e+05
    ## 1244  13039.3088 1.292885e+11 1.292885e+05
    ## 1245  16207.2666 1.609006e+11 1.609006e+05
    ## 1246  17641.0316 1.791696e+11 1.791696e+05
    ## 1247  19970.9079 2.083738e+11 2.083738e+05
    ## 1248  20509.6478 2.182808e+11 2.182808e+05
    ## 1249   3081.9598 6.863524e+09 6.863524e+03
    ## 1250   3907.1562 8.830173e+09 8.830173e+03
    ## 1251   5108.3446 1.250546e+10 1.250546e+04
    ## 1252   6929.2777 1.835539e+10 1.835539e+04
    ## 1253   9123.0417 2.597450e+10 2.597450e+04
    ## 1254   9770.5249 3.010131e+10 3.010131e+04
    ## 1255  10330.9891 3.387532e+10 3.387532e+04
    ## 1256  12281.3419 4.230269e+10 4.230269e+04
    ## 1257  14641.5871 5.249267e+10 5.249267e+04
    ## 1258  16999.4333 6.390818e+10 6.390818e+04
    ## 1259  18855.6062 7.277521e+10 7.277521e+04
    ## 1260  19328.7090 7.620326e+10 7.620326e+04
    ## 1261   2718.8853 7.006567e+08 7.006567e+02
    ## 1262   2769.4518 8.549298e+08 8.549298e+02
    ## 1263   3173.7233 1.139049e+09 1.139049e+03
    ## 1264   4021.1757 1.664863e+09 1.664863e+03
    ## 1265   5047.6586 2.330166e+09 2.330166e+03
    ## 1266   4319.8041 2.125754e+09 2.125754e+03
    ## 1267   5267.2194 2.727419e+09 2.727419e+03
    ## 1268   5303.3775 2.980684e+09 2.980684e+03
    ## 1269   6101.2558 3.796146e+09 3.796146e+03
    ## 1270   6071.9414 4.158126e+09 4.158126e+03
    ## 1271   6316.1652 4.699107e+09 4.699107e+03
    ## 1272   7670.1226 6.121479e+09 6.121479e+03
    ## 1273   3144.6132 5.229492e+10 5.229492e+04
    ## 1274   3943.3702 7.030764e+10 7.030764e+04
    ## 1275   4734.9976 8.845317e+10 8.845317e+04
    ## 1276   6470.8665 1.247895e+11 1.247895e+05
    ## 1277   8011.4144 1.655370e+11 1.655370e+05
    ## 1278   9356.3972 2.026464e+11 2.026464e+05
    ## 1279   9605.3141 2.147434e+11 2.147434e+05
    ## 1280   9696.2733 2.199733e+11 2.199733e+05
    ## 1281   6598.4099 1.504241e+11 1.504241e+05
    ## 1282   7346.5476 1.657562e+11 1.657562e+05
    ## 1283   7885.3601 1.766663e+11 1.766663e+05
    ## 1284  10808.4756 2.407702e+11 2.407702e+05
    ## 1285    493.3239 1.250540e+09 1.250540e+03
    ## 1286    540.2894 1.524741e+09 1.524741e+03
    ## 1287    597.4731 1.823035e+09 1.823035e+03
    ## 1288    510.9637 1.763376e+09 1.763376e+03
    ## 1289    590.5807 2.357669e+09 2.357669e+03
    ## 1290    670.0806 3.120614e+09 3.120614e+03
    ## 1291    881.5706 4.855308e+09 4.855308e+03
    ## 1292    847.9912 5.384206e+09 5.384206e+03
    ## 1293    737.0686 5.373380e+09 5.373380e+03
    ## 1294    589.9445 4.255024e+09 4.255024e+03
    ## 1295    785.6538 6.169268e+09 6.169268e+03
    ## 1296    863.0885 7.647471e+09 7.647471e+03
    ## 1297    879.5836 5.278469e+07 5.278469e+01
    ## 1298    860.7369 5.278469e+07 5.278469e+01
    ## 1299   1071.5511 7.002051e+07 7.002051e+01
    ## 1300   1384.8406 9.802871e+07 9.802871e+01
    ## 1301   1532.9853 1.174190e+08 1.174190e+02
    ## 1302   1737.5617 1.508134e+08 1.508134e+02
    ## 1303   1890.2181 1.863623e+08 1.863623e+02
    ## 1304   1516.5255 1.680492e+08 1.680492e+02
    ## 1305   1428.7778 1.798988e+08 1.798988e+02
    ## 1306   1339.0760 1.949802e+08 1.949802e+02
    ## 1307   1353.0924 2.305291e+08 2.305291e+02
    ## 1308   1598.4351 3.190141e+08 3.190141e+02
    ## 1309   6459.5548 2.587489e+10 2.587489e+04
    ## 1310   8157.5912 3.605370e+10 3.605370e+04
    ## 1311  11626.4197 5.746973e+10 5.746973e+04
    ## 1312  16903.0489 9.496468e+10 9.496468e+04
    ## 1313  24837.4287 1.607666e+11 1.607666e+05
    ## 1314  34167.7626 2.777328e+11 2.777328e+05
    ## 1315  33693.1753 3.792056e+11 3.792056e+05
    ## 1316  21198.2614 3.099132e+11 3.099132e+05
    ## 1317  24841.6178 4.209625e+11 4.209625e+05
    ## 1318  20586.6902 4.370505e+11 4.370505e+05
    ## 1319  19014.5412 4.658854e+11 4.658854e+05
    ## 1320  21654.8319 5.976958e+11 5.976958e+05
    ## 1321   1450.3570 3.996588e+09 3.996588e+03
    ## 1322   1567.6530 4.788470e+09 4.788470e+03
    ## 1323   1654.9887 5.677013e+09 5.677013e+03
    ## 1324   1612.4046 6.394540e+09 6.394540e+03
    ## 1325   1597.7121 7.331415e+09 7.331415e+03
    ## 1326   1561.7691 8.216241e+09 8.216241e+03
    ## 1327   1518.4800 9.335285e+09 9.335285e+03
    ## 1328   1441.7207 1.033908e+10 1.033908e+04
    ## 1329   1367.8994 1.136440e+10 1.136440e+04
    ## 1330   1392.3683 1.327667e+10 1.327667e+04
    ## 1331   1519.6353 1.651849e+10 1.651849e+04
    ## 1332   1712.4721 2.100774e+10 2.100774e+04
    ## 1333   3581.4594 2.456934e+10 2.456934e+04
    ## 1334   4981.0909 3.621818e+10 3.621818e+04
    ## 1335   6289.6292 4.790219e+10 4.790219e+04
    ## 1336   7991.7071 6.370367e+10 6.370367e+04
    ## 1337  10522.0675 8.747298e+10 8.747298e+04
    ## 1338  12980.6696 1.127549e+11 1.127549e+05
    ## 1339  15181.0927 1.371281e+11 1.371281e+05
    ## 1340  15870.8785 1.465006e+11 1.465006e+05
    ## 1341   9325.0682 9.163182e+10 9.163182e+04
    ## 1342   7914.3203 8.180712e+10 8.180712e+04
    ## 1343   7236.0753 7.316800e+10 7.316800e+04
    ## 1344   9786.5347 9.933592e+10 9.933592e+04
    ## 1345    879.7877 1.885604e+09 1.885604e+03
    ## 1346   1004.4844 2.305973e+09 2.305973e+03
    ## 1347   1116.6399 2.755750e+09 2.755750e+03
    ## 1348   1206.0435 3.210717e+09 3.210717e+03
    ## 1349   1353.7598 3.897492e+09 3.897492e+03
    ## 1350   1348.2852 4.234825e+09 4.234825e+03
    ## 1351   1465.0108 5.075562e+09 5.075562e+03
    ## 1352   1294.4478 5.008096e+09 5.008096e+03
    ## 1353   1068.6963 4.553591e+09 4.553591e+03
    ## 1354    574.6482 2.630861e+09 2.630861e+03
    ## 1355    699.4897 3.748630e+09 3.748630e+03
    ## 1356    862.5408 5.299935e+09 5.299935e+03
    ## 1357   2315.1382 2.609161e+09 2.609161e+03
    ## 1358   2843.1044 4.110927e+09 4.110927e+03
    ## 1359   3674.7356 6.431522e+09 6.431522e+03
    ## 1360   4977.4185 9.843343e+09 9.843343e+03
    ## 1361   8597.7562 1.850581e+10 1.850581e+04
    ## 1362  11210.0895 2.606682e+10 2.606682e+04
    ## 1363  15169.1611 4.022663e+10 4.022663e+04
    ## 1364  18861.5308 5.270953e+10 5.270953e+04
    ## 1365  24769.8912 8.015202e+10 8.015202e+04
    ## 1366  33519.4766 1.274514e+11 1.274514e+05
    ## 1367  36023.1054 1.512169e+11 1.512169e+05
    ## 1368  47143.1796 2.146433e+11 2.146433e+05
    ## 1369   5074.6591 1.805633e+10 1.805633e+04
    ## 1370   6093.2630 2.342419e+10 2.342419e+04
    ## 1371   7481.1076 3.170033e+10 3.170033e+04
    ## 1372   8412.9024 3.737211e+10 3.737211e+04
    ## 1373   9674.1676 4.443764e+10 4.443764e+04
    ## 1374  10922.6640 5.273247e+10 5.273247e+04
    ## 1375  11348.5459 5.728795e+10 5.728795e+04
    ## 1376  12037.2676 6.258558e+10 6.258558e+04
    ## 1377   9498.4677 5.036931e+10 5.036931e+04
    ## 1378  12126.2306 6.527562e+10 6.527562e+04
    ## 1379  13638.7784 7.378650e+10 7.378650e+04
    ## 1380  18678.3144 1.017502e+11 1.017502e+05
    ## 1381   4215.0417 6.278381e+09 6.278381e+03
    ## 1382   5862.2766 8.987280e+09 8.987280e+03
    ## 1383   7402.3034 1.171756e+10 1.171756e+04
    ## 1384   9405.4894 1.549001e+10 1.549001e+04
    ## 1385  12383.4862 2.098394e+10 2.098394e+04
    ## 1386  15277.0302 2.668773e+10 2.668773e+04
    ## 1387  17866.7218 3.325447e+10 3.325447e+04
    ## 1388  18678.5349 3.634600e+10 3.634600e+04
    ## 1389  14214.7168 2.841820e+10 2.841820e+04
    ## 1390  17161.1073 3.452149e+10 3.452149e+04
    ## 1391  20660.0194 4.155757e+10 4.155757e+04
    ## 1392  25768.2576 5.177474e+10 5.177474e+04
    ## 1393   1135.7498 2.870033e+09 2.870033e+03
    ## 1394   1258.1474 3.498172e+09 3.498172e+03
    ## 1395   1369.4883 4.218234e+09 4.218234e+03
    ## 1396   1284.7332 4.405143e+09 4.405143e+03
    ## 1397   1254.5761 4.817774e+09 4.817774e+03
    ## 1398   1450.9925 6.317137e+09 6.317137e+03
    ## 1399   1176.8070 6.859481e+09 6.859481e+03
    ## 1400   1093.2450 7.567286e+09 7.567286e+03
    ## 1401    926.9603 5.654271e+09 5.654271e+03
    ## 1402    930.5964 6.173124e+09 6.173124e+03
    ## 1403    882.0818 6.839054e+09 6.839054e+03
    ## 1404    926.1411 8.445270e+09 8.445270e+03
    ## 1405   4725.2955 6.740603e+10 6.740603e+04
    ## 1406   5487.1042 8.862523e+10 8.862523e+04
    ## 1407   5768.7297 1.058946e+11 1.058946e+05
    ## 1408   7114.4780 1.493850e+11 1.493850e+05
    ## 1409   7765.9626 1.858846e+11 1.858846e+05
    ## 1410   8028.6514 2.178168e+11 2.178168e+05
    ## 1411   8568.2662 2.668161e+11 2.668161e+05
    ## 1412   7825.8234 2.812083e+11 2.812083e+05
    ## 1413   7225.0693 2.887438e+11 2.887438e+05
    ## 1414   7479.1882 3.203711e+11 3.203711e+05
    ## 1415   7710.9464 3.426253e+11 3.426253e+05
    ## 1416   9269.6578 4.078448e+11 4.078448e+05
    ## 1417   3834.0347 1.094612e+11 1.094612e+05
    ## 1418   4564.8024 1.362211e+11 1.362211e+05
    ## 1419   5693.8439 1.774091e+11 1.774091e+05
    ## 1420   7993.5123 2.625891e+11 2.625891e+05
    ## 1421  10638.7513 3.671769e+11 3.671769e+05
    ## 1422  13236.9212 4.823402e+11 4.823402e+05
    ## 1423  13926.1700 5.289620e+11 5.289620e+05
    ## 1424  15764.9831 6.129536e+11 6.129536e+05
    ## 1425  18603.0645 7.357407e+11 7.357407e+05
    ## 1426  20445.2990 8.148564e+11 8.148564e+05
    ## 1427  24835.4717 9.972067e+11 9.972067e+05
    ## 1428  28821.0637 1.165760e+12 1.165760e+06
    ## 1429   1083.5320 8.649123e+09 8.649123e+03
    ## 1430   1072.5466 9.790791e+09 9.790791e+03
    ## 1431   1074.4720 1.119808e+10 1.119808e+04
    ## 1432   1135.5143 1.332798e+10 1.332798e+04
    ## 1433   1213.3955 1.579445e+10 1.579445e+04
    ## 1434   1348.7757 1.904044e+10 1.904044e+04
    ## 1435   1648.0798 2.539716e+10 2.539716e+04
    ## 1436   1876.7668 3.095784e+10 3.095784e+04
    ## 1437   2153.7392 3.787794e+10 3.787794e+04
    ## 1438   2664.4773 4.982214e+10 4.982214e+04
    ## 1439   3015.3788 5.903142e+10 5.903142e+04
    ## 1440   3970.0954 8.090355e+10 8.090355e+04
    ## 1441   1615.9911 1.374347e+10 1.374347e+04
    ## 1442   1770.3371 1.726679e+10 1.726679e+04
    ## 1443   1959.5938 2.191458e+10 2.191458e+04
    ## 1444   1687.9976 2.146480e+10 2.146480e+04
    ## 1445   1659.6528 2.422598e+10 2.422598e+04
    ## 1446   2202.9884 3.768209e+10 3.768209e+04
    ## 1447   1895.5441 3.860665e+10 3.860665e+04
    ## 1448   1507.8192 3.728228e+10 3.728228e+04
    ## 1449   1492.1970 4.212112e+10 4.212112e+04
    ## 1450   1632.2108 5.249309e+10 5.249309e+04
    ## 1451   1993.3983 7.393574e+10 7.393574e+04
    ## 1452   2602.3950 1.100629e+11 1.100629e+05
    ## 1453   1148.3766 3.333083e+08 3.333083e+02
    ## 1454   1244.7084 4.066973e+08 4.066973e+02
    ## 1455   1856.1821 6.867985e+08 6.867985e+02
    ## 1456   2613.1017 1.099306e+09 1.099306e+03
    ## 1457   3364.8366 1.615475e+09 1.615475e+03
    ## 1458   3781.4106 2.085164e+09 2.085164e+03
    ## 1459   3895.3840 2.531614e+09 2.531614e+03
    ## 1460   3984.8398 3.105577e+09 3.105577e+03
    ## 1461   3553.0224 3.419230e+09 3.419230e+03
    ## 1462   3876.7685 4.087998e+09 4.087998e+03
    ## 1463   4128.1169 4.665883e+09 4.665883e+03
    ## 1464   4513.4806 5.114071e+09 5.114071e+03
    ## 1465   8527.8447 6.075810e+10 6.075810e+04
    ## 1466   9911.8782 7.298911e+10 7.298911e+04
    ## 1467  12329.4419 9.323016e+10 9.323016e+04
    ## 1468  15258.2970 1.200512e+11 1.200512e+05
    ## 1469  17832.0246 1.448369e+11 1.448369e+05
    ## 1470  18855.7252 1.555908e+11 1.555908e+05
    ## 1471  20667.3812 1.720613e+11 1.720613e+05
    ## 1472  23586.9293 1.986350e+11 1.986350e+05
    ## 1473  23880.0168 2.082067e+11 2.082067e+05
    ## 1474  25266.5950 2.248125e+11 2.248125e+05
    ## 1475  29341.6309 2.627301e+11 2.627301e+05
    ## 1476  33859.7484 3.057904e+11 3.057904e+05
    ## 1477  14734.2327 7.094533e+10 7.094533e+04
    ## 1478  17909.4897 9.180404e+10 9.180404e+04
    ## 1479  20431.0927 1.157626e+11 1.157626e+05
    ## 1480  22966.1443 1.392437e+11 1.392437e+05
    ## 1481  27195.1130 1.740868e+11 1.740868e+05
    ## 1482  26982.2905 1.704316e+11 1.704316e+05
    ## 1483  28397.7151 1.836800e+11 1.836800e+05
    ## 1484  30281.7046 2.013716e+11 2.013716e+05
    ## 1485  31871.5303 2.229556e+11 2.229556e+05
    ## 1486  32135.3230 2.311738e+11 2.311738e+05
    ## 1487  34480.9577 2.538404e+11 2.538404e+05
    ## 1488  37506.4191 2.833483e+11 2.833483e+05
    ## 1489   1643.4854 6.017702e+09 6.017702e+03
    ## 1490   2117.2349 8.786330e+09 8.786330e+03
    ## 1491   2193.0371 1.060250e+10 1.060250e+04
    ## 1492   1881.9236 1.069085e+10 1.069085e+04
    ## 1493   2571.4230 1.723155e+10 1.723155e+04
    ## 1494   3195.4846 2.534819e+10 2.534819e+04
    ## 1495   3761.8377 3.540075e+10 3.540075e+04
    ## 1496   3116.7743 3.504142e+10 3.504142e+04
    ## 1497   3340.5428 4.415884e+10 4.415884e+04
    ## 1498   4014.2390 6.053880e+10 6.053880e+04
    ## 1499   4090.9253 7.018315e+10 7.018315e+04
    ## 1500   4184.5481 8.082349e+10 8.082349e+04
    ## 1501   1206.9479 1.031984e+10 1.031984e+04
    ## 1502   1507.8613 1.532623e+10 1.532623e+04
    ## 1503   1822.8790 2.172678e+10 2.172678e+04
    ## 1504   2643.8587 3.608521e+10 3.608521e+04
    ## 1505   4062.5239 6.185615e+10 6.185615e+04
    ## 1506   5596.5198 9.393868e+10 9.393868e+04
    ## 1507   7426.3548 1.373979e+11 1.373979e+05
    ## 1508  11054.5618 2.184138e+11 2.184138e+05
    ## 1509  15215.6579 3.147651e+11 3.147651e+05
    ## 1510  20206.8210 4.370453e+11 4.370453e+05
    ## 1511  23235.4233 5.217337e+11 5.217337e+05
    ## 1512  28718.2768 6.655258e+11 6.655258e+05
    ## 1513    716.6501 5.964625e+09 5.964625e+03
    ## 1514    698.5356 6.603136e+09 6.603136e+03
    ## 1515    722.0038 7.843819e+09 7.843819e+03
    ## 1516    848.2187 1.069376e+10 1.069376e+04
    ## 1517    915.9851 1.347102e+10 1.347102e+04
    ## 1518    962.4923 1.648707e+10 1.648707e+04
    ## 1519    874.2426 1.734880e+10 1.734880e+04
    ## 1520    831.8221 1.916570e+10 1.916570e+04
    ## 1521    825.6825 2.196767e+10 2.196767e+04
    ## 1522    789.1862 2.421767e+10 2.421767e+04
    ## 1523    899.0742 3.110237e+10 3.110237e+04
    ## 1524   1107.4822 4.223897e+10 4.223897e+04
    ## 1525    757.7974 1.613305e+10 1.613305e+04
    ## 1526    793.5774 1.987270e+10 1.987270e+04
    ## 1527   1002.1992 2.932775e+10 2.932775e+04
    ## 1528   1295.4607 4.407708e+10 4.407708e+04
    ## 1529   1524.3589 5.987095e+10 5.987095e+04
    ## 1530   1961.2246 8.658470e+10 8.658470e+04
    ## 1531   2393.2198 1.168541e+11 1.168541e+05
    ## 1532   2982.6538 1.578132e+11 1.578132e+05
    ## 1533   4616.8965 2.616261e+11 2.616261e+05
    ## 1534   5852.6255 3.524257e+11 3.524257e+05
    ## 1535   5913.1875 3.713881e+11 3.713881e+05
    ## 1536   7458.3963 4.853040e+11 4.853040e+05
    ## 1537    859.8087 1.048204e+09 1.048204e+03
    ## 1538    925.9083 1.256870e+09 1.256870e+03
    ## 1539   1067.5348 1.631298e+09 1.631298e+03
    ## 1540   1477.5968 2.564443e+09 2.564443e+03
    ## 1541   1649.6602 3.392280e+09 3.392280e+03
    ## 1542   1532.7770 3.538541e+09 3.538541e+03
    ## 1543   1344.5780 3.556093e+09 3.556093e+03
    ## 1544   1202.2014 3.792060e+09 3.792060e+03
    ## 1545   1034.2989 3.876090e+09 3.876090e+03
    ## 1546    982.2869 4.244354e+09 4.244354e+03
    ## 1547    886.2206 4.411055e+09 4.411055e+03
    ## 1548    882.9699 5.034323e+09 5.034323e+03
    ## 1549   3023.2719 2.003976e+09 2.003976e+03
    ## 1550   4100.3934 3.136391e+09 3.136391e+03
    ## 1551   4997.5240 4.435293e+09 4.435293e+03
    ## 1552   5621.3685 5.397385e+09 5.397385e+03
    ## 1553   6619.5514 6.455380e+09 6.455380e+03
    ## 1554   7899.5542 8.207708e+09 8.207708e+03
    ## 1555   9119.5286 1.018176e+10 1.018176e+04
    ## 1556   7388.5978 8.802303e+09 8.802303e+03
    ## 1557   7370.9909 8.724813e+09 8.724813e+03
    ## 1558   8792.5731 1.000684e+10 1.000684e+04
    ## 1559  11460.6002 1.262766e+10 1.262766e+04
    ## 1560  18008.5092 1.902793e+10 1.902793e+04
    ## 1561   1468.4756 5.356610e+09 5.356610e+03
    ## 1562   1395.2325 5.512353e+09 5.512353e+03
    ## 1563   1660.3032 7.116976e+09 7.116976e+03
    ## 1564   1932.3602 9.250181e+09 9.250181e+03
    ## 1565   2753.2860 1.460207e+10 1.460207e+04
    ## 1566   3120.8768 1.874106e+10 1.874106e+04
    ## 1567   3560.2332 2.397496e+10 2.397496e+04
    ## 1568   3810.4193 2.943540e+10 2.943540e+04
    ## 1569   4332.7202 3.692811e+10 3.692811e+04
    ## 1570   4876.7986 4.502099e+10 4.502099e+04
    ## 1571   5722.8957 5.591598e+10 5.591598e+04
    ## 1572   7092.9230 7.288800e+10 7.288800e+04
    ## 1573   1969.1010 4.378429e+10 4.378429e+04
    ## 1574   2218.7543 5.695751e+10 5.695751e+04
    ## 1575   2322.8699 6.919526e+10 6.919526e+04
    ## 1576   2826.3564 9.443229e+10 9.443229e+04
    ## 1577   3450.6964 1.293768e+11 1.293768e+05
    ## 1578   4269.1223 1.810280e+11 1.810280e+05
    ## 1579   4241.3563 2.007383e+11 2.007383e+05
    ## 1580   5089.0437 2.691154e+11 2.691154e+05
    ## 1581   5678.3483 3.303614e+11 3.303614e+05
    ## 1582   6601.4299 4.162046e+11 4.162046e+05
    ## 1583   6508.0857 4.380523e+11 4.380523e+05
    ## 1584   8458.2764 6.018795e+11 6.018795e+05
    ## 1585    734.7535 4.279790e+09 4.279790e+03
    ## 1586    774.3711 5.169315e+09 5.169315e+03
    ## 1587    767.2717 5.899397e+09 5.899397e+03
    ## 1588    908.9185 8.089642e+09 8.089642e+03
    ## 1589    950.7359 9.688269e+09 9.688269e+03
    ## 1590    843.7331 9.667290e+09 9.667290e+03
    ## 1591    682.2662 8.828116e+09 8.828116e+03
    ## 1592    617.7244 9.440713e+09 9.440713e+03
    ## 1593    644.1708 1.175753e+10 1.175753e+04
    ## 1594    816.5591 1.731943e+10 1.731943e+04
    ## 1595    927.7210 2.295170e+10 2.295170e+04
    ## 1596   1056.3801 3.081503e+10 3.081503e+04
    ## 1597   9979.5085 5.032666e+11 5.032666e+05
    ## 1598  11283.1779 5.802938e+11 5.802938e+05
    ## 1599  12477.1771 6.649337e+11 6.649337e+05
    ## 1600  14142.8509 7.772769e+11 7.772769e+05
    ## 1601  15895.1164 8.913822e+11 8.913822e+05
    ## 1602  17428.7485 9.791297e+11 9.791297e+05
    ## 1603  18232.4245 1.027209e+12 1.027209e+06
    ## 1604  21664.7877 1.234495e+12 1.234495e+06
    ## 1605  22705.0925 1.313861e+12 1.313861e+06
    ## 1606  26074.5314 1.533398e+12 1.533398e+06
    ## 1607  29478.9992 1.766159e+12 1.766159e+06
    ## 1608  33203.2613 2.017969e+12 2.017969e+06
    ## 1609  13990.4821 2.204242e+12 2.204242e+06
    ## 1610  14847.1271 2.553468e+12 2.553468e+06
    ## 1611  16173.1459 3.016906e+12 3.016906e+06
    ## 1612  19530.3656 3.880918e+12 3.880918e+06
    ## 1613  21806.0359 4.577000e+12 4.577000e+06
    ## 1614  24072.6321 5.301732e+12 5.301732e+06
    ## 1615  25009.5591 5.806915e+12 5.806915e+06
    ## 1616  29884.3504 7.256026e+12 7.256026e+06
    ## 1617  32003.9322 8.221624e+12 8.221624e+06
    ## 1618  35767.4330 9.761353e+12 9.761353e+06
    ## 1619  39097.0995 1.124728e+13 1.124728e+07
    ## 1620  42951.6531 1.293446e+13 1.293446e+07
    ## 1621   5716.7667 1.287968e+10 1.287968e+04
    ## 1622   6150.7730 1.491537e+10 1.491537e+04
    ## 1623   5603.3577 1.456013e+10 1.456013e+04
    ## 1624   5444.6196 1.496497e+10 1.496497e+04
    ## 1625   5703.4089 1.613794e+10 1.613794e+04
    ## 1626   6504.3397 1.869035e+10 1.869035e+04
    ## 1627   6920.2231 2.044232e+10 2.044232e+04
    ## 1628   7452.3990 2.269370e+10 2.269370e+04
    ## 1629   8137.0048 2.562556e+10 2.562556e+04
    ## 1630   9230.2407 3.011678e+10 3.011678e+04
    ## 1631   7727.0020 2.598656e+10 2.598656e+04
    ## 1632  10611.4630 3.658298e+10 3.658298e+04
    ## 1633   7689.7998 4.182919e+10 4.182919e+04
    ## 1634   9802.4665 6.570268e+10 6.570268e+04
    ## 1635   8422.9742 6.859144e+10 6.859144e+04
    ## 1636   9541.4742 9.264344e+10 9.264344e+04
    ## 1637  10505.2597 1.209749e+11 1.209749e+05
    ## 1638  13143.9510 1.774902e+11 1.774902e+05
    ## 1639  11152.4101 1.742092e+11 1.742092e+05
    ## 1640   9883.5846 1.770168e+11 1.770168e+05
    ## 1641  10733.9263 2.175291e+11 2.175291e+05
    ## 1642  10165.4952 2.274468e+11 2.274468e+05
    ## 1643   8605.0478 2.089966e+11 2.089966e+05
    ## 1644  11415.8057 2.977774e+11 2.977774e+05
    ## 1645    605.0665 1.588108e+10 1.588108e+04
    ## 1646    676.2854 1.961129e+10 1.961129e+04
    ## 1647    772.0492 2.609228e+10 2.609228e+04
    ## 1648    637.1233 2.514338e+10 2.514338e+04
    ## 1649    699.5016 3.123626e+10 3.123626e+04
    ## 1650    713.5371 3.605753e+10 3.605753e+04
    ## 1651    707.2358 3.970576e+10 3.970576e+04
    ## 1652    820.7994 5.156795e+10 5.156795e+04
    ## 1653    989.0231 6.917300e+10 6.917300e+04
    ## 1654   1385.8968 1.053961e+11 1.053961e+05
    ## 1655   1764.4567 1.427589e+11 1.427589e+05
    ## 1656   2441.5764 2.081746e+11 2.081746e+05
    ## 1657   1515.5923 1.561947e+09 1.561947e+03
    ## 1658   1827.0677 1.955765e+09 1.955765e+03
    ## 1659   2198.9563 2.491712e+09 2.491712e+03
    ## 1660   2649.7150 3.027660e+09 3.027660e+03
    ## 1661   3133.4093 3.414075e+09 3.414075e+03
    ## 1662   3682.8315 4.644386e+09 4.644386e+03
    ## 1663   4336.0321 6.182644e+09 6.182644e+03
    ## 1664   5107.1974 8.637343e+09 8.637343e+03
    ## 1665   6017.6548 1.266583e+10 1.266583e+04
    ## 1666   7110.6676 2.009507e+10 2.009507e+04
    ## 1667   4515.4876 1.530560e+10 1.530560e+04
    ## 1668   3025.3498 1.215686e+10 1.215686e+04
    ## 1669    781.7176 3.880312e+09 3.880312e+03
    ## 1670    804.8305 4.425030e+09 4.425030e+03
    ## 1671    825.6232 5.052881e+09 5.052881e+03
    ## 1672    862.4421 5.813537e+09 5.813537e+03
    ## 1673   1265.0470 9.370298e+09 9.370298e+03
    ## 1674   1829.7652 1.537733e+10 1.537733e+04
    ## 1675   1977.5570 1.909849e+10 1.909849e+04
    ## 1676   1971.7415 2.212164e+10 2.212164e+04
    ## 1677   1879.4967 2.512511e+10 2.512511e+04
    ## 1678   2117.4845 3.351236e+10 3.351236e+04
    ## 1679   2234.8208 4.179396e+10 4.179396e+04
    ## 1680   2280.7699 5.065987e+10 5.065987e+04
    ## 1681   1147.3888 3.065823e+09 3.065823e+03
    ## 1682   1311.9568 3.956862e+09 3.956862e+03
    ## 1683   1452.7258 4.969775e+09 4.969775e+03
    ## 1684   1777.0773 6.930602e+09 6.930602e+03
    ## 1685   1773.4983 7.992265e+09 7.992265e+03
    ## 1686   1588.6883 8.287472e+09 8.287472e+03
    ## 1687   1408.6786 8.593513e+09 8.593513e+03
    ## 1688   1213.3151 8.823720e+09 8.823720e+03
    ## 1689   1210.8846 1.014862e+10 1.014862e+04
    ## 1690   1071.3538 1.008978e+10 1.008978e+04
    ## 1691   1071.6139 1.135462e+10 1.135462e+04
    ## 1692   1271.2116 1.493170e+10 1.493170e+04
    ## 1693    406.8841 1.253572e+09 1.253572e+03
    ## 1694    518.7643 1.891591e+09 1.891591e+03
    ## 1695    527.2722 2.255531e+09 2.255531e+03
    ## 1696    569.7951 2.846373e+09 2.846373e+03
    ## 1697    799.3622 4.685170e+09 4.685170e+03
    ## 1698    685.5877 4.553747e+09 4.553747e+03
    ## 1699    788.8550 6.024110e+09 6.024110e+03
    ## 1700    706.1573 6.508241e+09 6.508241e+03
    ## 1701    693.4208 7.422612e+09 7.422612e+03
    ## 1702    792.4500 9.037851e+09 9.037851e+03
    ## 1703    672.0386 8.015111e+09 8.015111e+03
    ## 1704    469.7093 5.782658e+09 5.782658e+03

#### `group_by()` and `summarise()`

`group_by()` changes the scope of each function from operating on the entire dataset to operating on it group-by-group. For example, to group by continents:

``` r
gap_continents <- gapminder %>%
    group_by(continent)
head(gap_continents)
```

    ## # A tibble: 6 x 6
    ## # Groups:   continent [1]
    ##   country      year      pop continent lifeExp gdpPercap
    ##   <fct>       <int>    <dbl> <fct>       <dbl>     <dbl>
    ## 1 Afghanistan  1952  8425333 Asia         28.8      779.
    ## 2 Afghanistan  1957  9240934 Asia         30.3      821.
    ## 3 Afghanistan  1962 10267083 Asia         32.0      853.
    ## 4 Afghanistan  1967 11537966 Asia         34.0      836.
    ## 5 Afghanistan  1972 13079460 Asia         36.1      740.
    ## 6 Afghanistan  1977 14880372 Asia         38.4      786.

`summarise()` collapses many values down to a single summary. For example, to find the mean life expectancy for the whole dataset:

``` r
gapminder %>%
  summarise(meanLE = mean(lifeExp))
```

    ##     meanLE
    ## 1 59.47444

Associating the two functions makes it more interesting. To find out the mean life expectancy for each continent in 2007, we can do the following:

``` r
gapminder %>% 
    filter(year == 2007) %>%
    group_by(continent) %>%
    summarise(meanLE = mean(lifeExp))
```

    ## # A tibble: 5 x 2
    ##   continent meanLE
    ##   <fct>      <dbl>
    ## 1 Africa      54.8
    ## 2 Americas    73.6
    ## 3 Asia        70.7
    ## 4 Europe      77.6
    ## 5 Oceania     80.7

Exercise 6 – group by country, and find out the maximum life expectancy ever recorded

Hint: `?max`

``` r
gapminder %>% 
    group_by(country) %>%
    summarise(maxLE = max(lifeExp))
```

    ## # A tibble: 142 x 2
    ##    country     maxLE
    ##    <fct>       <dbl>
    ##  1 Afghanistan  43.8
    ##  2 Albania      76.4
    ##  3 Algeria      72.3
    ##  4 Angola       42.7
    ##  5 Argentina    75.3
    ##  6 Australia    81.2
    ##  7 Austria      79.8
    ##  8 Bahrain      75.6
    ##  9 Bangladesh   64.1
    ## 10 Belgium      79.4
    ## # … with 132 more rows

#### More examples

Another example of new variable with `mutate()`:

``` r
starwars %>% 
  mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, bmi)
```

    ## # A tibble: 87 x 4
    ##    name               height  mass   bmi
    ##    <chr>               <int> <dbl> <dbl>
    ##  1 Luke Skywalker        172    77  26.0
    ##  2 C-3PO                 167    75  26.9
    ##  3 R2-D2                  96    32  34.7
    ##  4 Darth Vader           202   136  33.3
    ##  5 Leia Organa           150    49  21.8
    ##  6 Owen Lars             178   120  37.9
    ##  7 Beru Whitesun lars    165    75  27.5
    ##  8 R5-D4                  97    32  34.0
    ##  9 Biggs Darklighter     183    84  25.1
    ## 10 Obi-Wan Kenobi        182    77  23.2
    ## # … with 77 more rows

And a more complex processing of a dataset:

``` r
starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1)
```

    ## # A tibble: 9 x 3
    ##   species      n  mass
    ##   <chr>    <int> <dbl>
    ## 1 <NA>         5  48  
    ## 2 Droid        5  69.8
    ## 3 Gungan       3  74  
    ## 4 Human       35  82.8
    ## 5 Kaminoan     2  88  
    ## 6 Mirialan     2  53.1
    ## 7 Twi'lek      2  55  
    ## 8 Wookiee      2 124  
    ## 9 Zabrak       2  80

An example of data manipulation and data visualisation in the same command:

``` r
library(ggplot2)
gapminder %>% 
  filter(continent == "Europe") %>%
  group_by(year) %>% 
  summarise(sum = sum(pop)) %>% 
  ggplot(aes(x = year,
             y = sum)) +
  geom_line()
```

![](dplyr_files/figure-markdown_github/unnamed-chunk-25-1.png)

Close Rproject
--------------

If you want to close RStudio, you should save your project first.

-   File
-   close project (It will ask you if you want to save your history)
-   then, close RStudio

What next?
----------

Look at our compilation of resources: <https://gitlab.com/stragu/DSH/blob/master/R/usefullinks.md>
