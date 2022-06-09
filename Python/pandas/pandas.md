# Python data transformation and visualisation with pandas

This hands-on course -- directed at intermediate users -- looks at using the **pandas** module to transform and visualise tabular data.

## Setup

The easiest way to use Python 3, pandas and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

### Create a project

In order to keep everything nicely contained in one directory, and to find files more easily, we need to create a project.

-   Projects -\> New project...
-   New directory
-   Project name: "python_pandas"
-   Choose a location that suits you on your computer
-   Click "Create"

This will move our working directory to the directory we just created, and Python will look for files (and save files) in this same directory by default.

### Create a script

Spyder opens a temporary script automatically. You can save that as a file into our project directory:

-   File -\> Save as...
-   Make sure you are located in the project directory
-   Name the script "process.py"

Working in a script allows us to write code more comfortably, and save a process as a clearly defined list of commands that others can review and reuse.

## Introducing pandas

pandas is a Python module that introduces dataframes to Python. This variable type is the most suited when storing data coming from a spreadsheet.

However, pandas is not limited to importing and storing dataframes. Many functions from this module allow people to clean, transform and visualise data.

To be able to use the functions included in pandas, we have to first import it:

``` python
import pandas as pd
```

`pd` is the usual nickname for the pandas module.

## Importing data

Our data is a CO<sub>2</sub> emission dataset from Our World in Data: <https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv>

It is available under a [CC-BY](https://creativecommons.org/licenses/by/4.0/) licence, an open licence that requires that any sharing or derivative of it needs to attribute the original source and authors.

[More information about the dataset](https://github.com/owid/co2-data) is included online, and the [codebook](https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv), which is important to understand what exactly are the variables in the dataset, is also available online.

We can import it directly with pandas, with:

``` python
df_raw = pd.read_csv('https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv')
```

Using the `type()` function confirms what type of variable the data is stored as:

``` python
type(df_raw)
```

This dataset is a fairly big one. We can investigate its size thanks to the `shape` attribute attached to all pandas dataframes:

``` python
df_raw.shape
```

The dataset contains dozens of columns. What are their names?

``` python
df_raw.columns
```

Let's subset our data to focus on a handful of variables.

## Subsetting data

We want to focus on only a few columns, especially since a lot of the data can be inferred from those.

We want to keep 8 columns:

-   The `iso_code`, which is very useful for matching several datasets without having to worry about variations in country names
-   `country`
-   `year`
-   `population`
-   `gdp`
-   The three main greenhouse gases, which according to the codebook are all in million tonnes of CO<sub>2</sub>-equivalent:
    -   `co2`
    -   `methane`
    -   `nitrous_oxide`

To only keep these columns, we can index the dataframe with a list of names:

``` python
keep = ['iso_code', 'country', 'year', 'population', 'gdp', 'co2', 'methane', 'nitrous_oxide']
df = df_raw[keep]
```

The other issue with the data is that it starts in the 18th century, but we might want to ignore early patchy data:

``` python
df = df[df.year >= 1900]
```

We can check that it has worked:

``` python
min(df.year)
```

It looks like the dataset is also consistently missing values for nitrous oxide and methane for the last few years.

### Challenge 1: remove recent patchy years

How can you remove the patchy years after 2018? Design an operation that is similar to removing the pre-1900 data.

Can you add a second command to check it has done the right thing?

Solution:

``` python
df = df[df.year < 2019]
max(df.year)
```

## Exploring data

To check what kind of data each column is stored as, we can use the `dtypes` attribute:

``` python
df.dtypes
```

The `describe()` method is useful for descriptive statistics about our numerical columns:

``` python
df.describe()
```

However, it will only show the two first ones and two last ones. We can focus on a specific column instead, for example one that was hidden previously:

``` python
df.co2.describe()
```

Or a categorical column:

``` python
df.country.describe()
```

> For a categorical column, the information shown is different: for example, how many unique values there are, and what the most common value is.

## More cleaning up

Which country does this maximum value belong to? Let's investigate by subsetting the data:

``` python
df[df.co2 == max(df.co2)]
```

We use a condition that will be checked against each row, and only the row that contains the maximum value will be returned.

What is this "OWID_WRL" country? It is the whole world. Many datasets have aggregate regions on top of single countries, which is something to keep in mind!

We can also find out that many rows do not have an ISO code at all, by using Spyder's data explorer, or by using two methods stringed together:

``` python
df.iso_code.isna().sum()
```

`isna()` returns the boolean values `True` or `False` depending on if the data is missing, and the `sum()` method can give a total of `True`s (because it converts `True` to 1, and `False` to 0).

Similarly, we can average boolean values to find the fraction of missing data:

``` python
df.iso_code.isna().mean()
```

Alternatively, pandas dataframes have a `count()` method to give a count of non-NA values for each column:

``` python
df.count()
```

We can see that quite a few rows have missing ISO codes, which for the most part indicates an aggregate region. So how do we remove all that superfluous data?

Again, by using a logical test. But first, check what will be removed:

``` python
df[df.iso_code.isna()].country.unique()
```

Now, use both conditions to remove aggregate regions:

``` python
df = df[(df.iso_code != 'OWID_WRL') & (df.iso_code.notna())]
```

We use two conditions at once:

1.  we want the ISO code to be *different* to "OWID_WRL";
2.  we want the ISO code to *not* be a missing value, thanks to the `notna()` method (which does the opposite to `isna()`).

By joining these two conditions with `&`, we only keep the rows that match *both conditions*.

We can now check what actual countries are left in the dataset, with the `unique()` method:

``` python
df.country.unique()
```

## Adding columns

Now that we have a clean dataset, we can expand it by calculating new interesting variables.

For example, we can first sum the three greenhouse gases (as they use the same unit), and then calculate how much CO<sub>2</sub>-equivalent is emitted per person. We can also add GDP per capita to the dataset.

For the total greenhouse gaz emissions in CO<sub>2</sub>e:

``` python
df['co2e'] = df[['co2', 'methane', 'nitrous_oxide']].sum(axis=1)
```

The operation is done row-wise: we use `axis=1` to specify that we apply the function in the column axis.

You can confirm by looking at the data that the NA values are skipped when calculating the sum. The help page for this method mentions the `skipna` argument, which is set to `True` by default:

``` python
df.sum?
```

    skipna : bool, default True
        Exclude NA/null values when computing the result.

And then, for the CO<sub>2</sub>e per capita and the GDP per capita:

``` python
df['co2e_pc'] = df.co2e / df.population
df['gdp_pc'] = df.gdp / df.population
```

We now have three extra columns in our dataset.

## Merging tables

It is common to want to merge two datasets from two different sources. To do that, you will need common data to match rows on.

We want to add the countries' Social Progress Index to our dataset.

> You can find out more about the SPI on their website: <https://www.socialprogress.org/>

The SPI dataset also has a three-letter code for the countries, which we can match to our existing `iso_code` column. We have an SPI for several different years, so we should match that column as well:

``` python
# read the data
spi = pd.read_csv('https://gist.githubusercontent.com/stragu/57b0a0750678bada09625d429a0f806b/raw/a18a454d7d225bd24074399a7ab79a4189e53501/spi.csv')
# merge on two columns
df_all = pd.merge(df, spi,
                  left_on=['iso_code', 'year'],
                  right_on=['country_code', 'year'])
```

We specified the two data frames, and which columns we wanted to merge on. However, we end up losing a lot of data. Looking at the documentation for the `merge()` function, we can see that there are many ways to merge tables, depending on what we want to keep:

``` python
pd.merge?
```

The `how` argument defines which kind of merge we want to do. Because we want to keep all of the data from `df`, we want to do a "left merge":

``` python
df_all = pd.merge(df, spi,
                  how='left',
                  left_on=['iso_code', 'year'],
                  right_on=['country_code', 'year'])
```

We can now "drop" the useless country_code column:

``` python
df_all.pop('country_code')
```

> Notice that the `pop` method is an "in-place" method: you don't need to reassign the variable.

## Summaries

The `aggregate()` method, which has a shorter alias `agg()`, allows creating summaries by applying a function to a column. In combination with the `groupby()` method, we can create summary tables. For example, to find the average SPI for each country, and then sort the values in descending order:

``` python
df_all.groupby('country').spi.agg('mean').sort_values(ascending=False)
```

If you want to export that summary table and use it outside Spyder, you can first save it as a variable, and then write it to a CSV file:

``` python
spi_sum = df_all.groupby('country').spi.agg('mean').sort_values(ascending=False)
# write to file
spi_sum.to_csv('spi_summary.csv')
```

> The CSV file should be found in your project directory, as it became the default working directory when we created the project.

## Visualising data

pandas integrates visualisation tools, thanks to the `plot()` method and its many arguments.

For example, to visualise the relationship between CO<sub>2</sub>e per capita and SPI:

``` python
df_all.plot(x='co2e_pc', y='spi')
```

The default kind of plot is a line plot, so let's change that to a scatterplot:

``` python
df_all.plot(x='co2e_pc', y='spi', kind='scatter')
```

Focusing on the latest year will guarantee that there only is one point per country:

``` python
df_all[df_all.year == 2016].plot(x='co2e_pc',
                                 y='spi',
                                 kind='scatter')
```

To visualise a third variable, GDP per capita, let's map it to the colour of the points, thanks to the `c` argument:

``` python
df_all[df_all.year == 2016].plot(x='co2e_pc',
                                 y='spi',
                                 c='gdp_pc',
                                 colormap='viridis',
                                 kind='scatter')
```

We can change the labels too:

``` python
df_all[df_all.year == 2016].plot(x='co2e_pc',
                                 y='spi',
                                 c='gdp_pc',
                                 colormap='viridis',
                                 kind='scatter',
                                 xlabel='GHG per capita (MT CO2e/yr)',
                                 ylabel='Social Progress Index')
```

If the x labels don't show, try this workaround: <https://github.com/pandas-dev/pandas/issues/36064#issuecomment-1011175535>

### Challenge 2: GHG timeline

How would you visualise global GHG emissions over the years, with one line per type of GHG?

We can subset the columns that matter to us, create a summary, and plot it:

``` python
sub = df_all[['year', 'co2', 'methane', 'nitrous_oxide']]
sub.groupby('year').agg('sum').plot(ylabel='MT CO2e')
```

Remember that the default `kind` of plot in this function is `'line'`, which works for this visualisation. And as we fed it a series variable with several columns, it automatically assigned a different colour to each one.

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a `.spydata` file if you want to (for example, if it takes a lot of time to process your data).

## Resources

-   [Official pandas documentation](https://pandas.pydata.org/)
    -   [Getting started](https://pandas.pydata.org/docs/getting_started/index.html)
    -   [10 Minutes to pandas](https://pandas.pydata.org/docs/user_guide/10min.html)
    -   [User guide](https://pandas.pydata.org/docs/user_guide/index.html)
-   More visualisation modules:
    -   [Altair](https://altair-viz.github.io/)
    -   [Bokeh](https://docs.bokeh.org/en/latest/)
    -   [Vega](https://vega.github.io/vega/)
    -   [Matplotlib](https://matplotlib.org/)
-   About our datasets:
    -   [Our World in Data](https://ourworldindata.org)
    -   [Social Progress Index](https://www.socialprogress.org)
-   Our [compilation of useful Python links](https://github.com/uqlibrary/technology-training/blob/master/Python/useful_links.md)
