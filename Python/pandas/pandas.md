# Python data transformation with pandas

This hands-on course – directed at intermediate users – looks at using the **pandas** module to transform and visualise tabular data.

## Setup

The easiest way to use Python 3, pandas and Spyder is to install the Anaconda Distribution, a data science platform for Windows, Linux and Mac OS X. Make sure you download the Individual Edition with Python 3: https://www.anaconda.com/products/individual

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder.

### Create a project

In order to keep everything nicely contained into one directory, and to find files more easily, we need to create a project.

* Projects -> New project...
* New directory
* Project name: "python_pandas"
* Choose a location that suits you on your computer
* Click "Create"

This will move our working directory to the directory we just created, and

### Create a script

Spyder opens a temporary script automatically. You can save that as a file into our project directory:

* File -> Save as...
* Make sure you are located in the project directory
* Name the script "process.py"

Working in a script allows us to write code more comfortably, and save a process as a clearly defined list of commands that others can review and reuse.

## Introducing pandas

pandas is a Python module that introduces dataframes to Python. This variable type is the most suited when storing data coming from a spreadsheet.

However, pandas is not limited to importing and storing dataframes. Many functions from this module allow people to clean, transform and visualise data.

To be able to use the functions included in pandas, we have to first import it:

```python
import pandas as pd
```

`pd` is the usual nickname for the pandas module.

## Importing data

Our data is a CO2 emission dataset from Our World in Data: https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv

It is available under a [CC-BY](https://creativecommons.org/licenses/by/4.0/) licence, an open licence that requires that any sharing or derivative of it needs to attribute the original source and authors.

More information about the dataset is included on [this page](https://github.com/owid/co2-data), and the codebook, which is important to understand what exactly are the variables in the dataset, is available here: https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv

We can import it directly with pandas, without:

```python
df = pd.read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
```

Using the `type()` function confirms what type of variable the data is stored as:

```python
type(df)
```

## Exploring data

This dataset is a fairly big one. We can investigate its size thanks to the `shape` attribute attached to all pandas dataframes:

```python
df.shape
```

38 columns is too much to look at. What are the column names?

```python
df.columns
```

Let's subset our data to focus on a handful of variables.

## Subsetting data

We want to focus on only a few columns, especially since a lot of the data can be inferred from those.

We want to keep 8 columns:

* The `iso_code`, which is very useful for matching several datasets without having to worry about variations in country names
* `country`
* `year`
* `population`
* `gdp`
* The three main greenhouse gases, which according to the codebook are all in million tonnes of CO2-equivalent:
    * `co2`
    * `methane`
    * `nitrous_oxide`

To only keep these columns, we can index the dataframes with a list of names:

```python
keep = ['iso_code', 'country', 'year', 'population', 'gdp', 'co2', 'methane', 'nitrous_oxide']
df_small = df.columns[keep]
```



## Visualising data

...

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a `.spydata` file if you want to (for example, if it takes a lot of time to process your data).

## Resources

* Official pandas website: https://pandas.pydata.org/
