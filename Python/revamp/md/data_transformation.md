# Python Data Transformation


## Setup

This workshop is all about data transformation and analysis. We need two things:
- Data transformation tools
- Data to transform

### Importing the tools (modules)

We'll use the popular module `pandas` for analysing data. To import this module, run


```python
import pandas as pd
```

Note that we use `as pd` to indicate that we'll access the tools via `pd.`, rather than `pandas.`. It's just a local nickname for convenience.

> If you encounter the **`ModuleNotFoundError`**:
> 1. Check that you haven't misspelt anything: we're using `import pandas as pd`
> 2. You've likely not installed this module yet. Follow the steps below
> #### Installing `pandas`
> Module installation depends on your Python installation.
>
> **For Anaconda installations**
>
> If you have an Anaconda installation (i.e., you installed Anaconda to get Python), run the following line:
>
> `!conda install pandas`
>
> **For other installations**
>
> If you *don't* (make **sure** you don't), then run 
>
> `!pip install pandas`

### Importing the data

Today we'll work with data from YouTube. You can find the data [here](https://raw.githubusercontent.com/uqlibrary/technology-training/master/Python/revamp/Global%20YouTube%20Statistics.csv).

**NEED NEW LINK WHEN MOVED TO PERMANENT LOCATION - i.e. NOT /PYTHON/REVAMP/**

Please download the data **to your project folder**.

Next, we need to bring it into Python.

Using the pandas function `pd.read_csv()`, we load the data by specifying its path. Because we're in the same folder, that's just its name:



```python
df_raw = pd.read_csv("Global_YouTube_Statistics.csv")
```

> If your data is stored online, you can specify a URL instead!

We won't work directly with `df_raw` - this serves as our backup. Instead, we'll copy it into a variable that we are happy to edit:


```python
df = df_raw.copy()
```

## Basic exploration

We can see the first $n$ rows with `df.head(n)`:


```python
df.head()
df.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Title</th>
      <th>uploads</th>
      <th>Country</th>
      <th>Abbreviation</th>
      <th>channel_type</th>
      <th>...</th>
      <th>subscribers_for_last_30_days</th>
      <th>created_year</th>
      <th>created_month</th>
      <th>created_date</th>
      <th>Gross tertiary education enrollment (%)</th>
      <th>Population</th>
      <th>Unemployment rate</th>
      <th>Urban_population</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>T-Series</td>
      <td>20082</td>
      <td>India</td>
      <td>IN</td>
      <td>Music</td>
      <td>...</td>
      <td>2000000.0</td>
      <td>2006.0</td>
      <td>Mar</td>
      <td>13.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>youtubemovies</td>
      <td>1</td>
      <td>United States</td>
      <td>US</td>
      <td>Games</td>
      <td>...</td>
      <td>NaN</td>
      <td>2006.0</td>
      <td>Mar</td>
      <td>5.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 28 columns</p>
</div>



And the last $n$ rows with `df.tail(n)`:


```python
df.tail()
df.tail(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Title</th>
      <th>uploads</th>
      <th>Country</th>
      <th>Abbreviation</th>
      <th>channel_type</th>
      <th>...</th>
      <th>subscribers_for_last_30_days</th>
      <th>created_year</th>
      <th>created_month</th>
      <th>created_date</th>
      <th>Gross tertiary education enrollment (%)</th>
      <th>Population</th>
      <th>Unemployment rate</th>
      <th>Urban_population</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>993</th>
      <td>994</td>
      <td>RobTopGames</td>
      <td>12300000</td>
      <td>3.741235e+08</td>
      <td>Gaming</td>
      <td>RobTopGames</td>
      <td>39</td>
      <td>Sweden</td>
      <td>SE</td>
      <td>Games</td>
      <td>...</td>
      <td>100000.0</td>
      <td>2012.0</td>
      <td>May</td>
      <td>9.0</td>
      <td>67.0</td>
      <td>1.028545e+07</td>
      <td>6.48</td>
      <td>9021165.0</td>
      <td>60.128161</td>
      <td>18.643501</td>
    </tr>
    <tr>
      <th>994</th>
      <td>995</td>
      <td>Make Joke Of</td>
      <td>12300000</td>
      <td>2.129774e+09</td>
      <td>Comedy</td>
      <td>Make Joke Of</td>
      <td>62</td>
      <td>India</td>
      <td>IN</td>
      <td>Comedy</td>
      <td>...</td>
      <td>100000.0</td>
      <td>2017.0</td>
      <td>Aug</td>
      <td>1.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 28 columns</p>
</div>



The column names with


```python
df.columns
```




    Index(['rank', 'Youtuber', 'subscribers', 'video views', 'category', 'Title',
           'uploads', 'Country', 'Abbreviation', 'channel_type',
           'video_views_rank', 'country_rank', 'channel_type_rank',
           'video_views_for_the_last_30_days', 'lowest_monthly_earnings',
           'highest_monthly_earnings', 'lowest_yearly_earnings',
           'highest_yearly_earnings', 'subscribers_for_last_30_days',
           'created_year', 'created_month', 'created_date',
           'Gross tertiary education enrollment (%)', 'Population',
           'Unemployment rate', 'Urban_population', 'Latitude', 'Longitude'],
          dtype='object')



And the 'shape' (rows, columns) of the data:


```python
df.shape
```




    (995, 28)



### Challenge

How might we find the total number of cells / data entries using `df.shape`? 

> Remember, to access one of the numbers in a list (or here, a tuple) we need to *index*: `mylist[5]` will access the sixth element of `mylist`, counting from 0.


```python
# Solution

N_cells = df.shape[0] * df.shape[1]

print(f"There are {N_cells} cells in this dataframe.")
```

    There are 27860 cells in this dataframe.
    

## Accessing data

How do we access individual rows or columns? A few methods. [A comprehensive guide is available](https://pandas.pydata.org/docs/user_guide/indexing.html)

### Accessing columns
Index with the column names. For example, to get the "Country" column,


```python
df["Country"]
```




    0               India
    1       United States
    2       United States
    3       United States
    4               India
                ...      
    990            Brazil
    991             India
    992    United Kingdom
    993            Sweden
    994             India
    Name: Country, Length: 995, dtype: object



Or multiple with a list of names:


```python
# Save the names in a list and then index
col_names = ["Youtuber", "Country"]
df[col_names]

# This is equivalent to
df[["Youtuber", "Country"]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Youtuber</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>T-Series</td>
      <td>India</td>
    </tr>
    <tr>
      <th>1</th>
      <td>YouTube Movies</td>
      <td>United States</td>
    </tr>
    <tr>
      <th>2</th>
      <td>MrBeast</td>
      <td>United States</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>United States</td>
    </tr>
    <tr>
      <th>4</th>
      <td>SET India</td>
      <td>India</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>990</th>
      <td>Natan por A�</td>
      <td>Brazil</td>
    </tr>
    <tr>
      <th>991</th>
      <td>Free Fire India Official</td>
      <td>India</td>
    </tr>
    <tr>
      <th>992</th>
      <td>Panda</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>993</th>
      <td>RobTopGames</td>
      <td>Sweden</td>
    </tr>
    <tr>
      <th>994</th>
      <td>Make Joke Of</td>
      <td>India</td>
    </tr>
  </tbody>
</table>
<p>995 rows × 2 columns</p>
</div>



These are all dataframes themselves, and operate like `df`. For example,


```python
df[["Youtuber", "Country"]].columns
```




    Index(['Youtuber', 'Country'], dtype='object')



### Accessing rows

The easiest way to get a selection of rows is by *slicing* with `df[start_row : end_row]`. Note that the last row is **not included**.



```python
df[20:25]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Title</th>
      <th>uploads</th>
      <th>Country</th>
      <th>Abbreviation</th>
      <th>channel_type</th>
      <th>...</th>
      <th>subscribers_for_last_30_days</th>
      <th>created_year</th>
      <th>created_month</th>
      <th>created_date</th>
      <th>Gross tertiary education enrollment (%)</th>
      <th>Population</th>
      <th>Unemployment rate</th>
      <th>Urban_population</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>20</th>
      <td>21</td>
      <td>HYBE LABELS</td>
      <td>71300000</td>
      <td>2.863457e+10</td>
      <td>Music</td>
      <td>HYBE LABELS</td>
      <td>1337</td>
      <td>South Korea</td>
      <td>KR</td>
      <td>Music</td>
      <td>...</td>
      <td>900000.0</td>
      <td>2008.0</td>
      <td>Jun</td>
      <td>4.0</td>
      <td>94.3</td>
      <td>5.170910e+07</td>
      <td>4.15</td>
      <td>42106719.0</td>
      <td>35.907757</td>
      <td>127.766922</td>
    </tr>
    <tr>
      <th>21</th>
      <td>22</td>
      <td>Zee TV</td>
      <td>70500000</td>
      <td>7.313905e+10</td>
      <td>Entertainment</td>
      <td>Zee TV</td>
      <td>129204</td>
      <td>India</td>
      <td>IN</td>
      <td>Entertainment</td>
      <td>...</td>
      <td>900000.0</td>
      <td>2005.0</td>
      <td>Dec</td>
      <td>11.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
    <tr>
      <th>22</th>
      <td>23</td>
      <td>Pinkfong Baby Shark - Kids' Songs &amp; Stories</td>
      <td>68200000</td>
      <td>3.884323e+10</td>
      <td>Education</td>
      <td>Pinkfong Baby Shark - Kids' Songs &amp; Stories</td>
      <td>2865</td>
      <td>United States</td>
      <td>US</td>
      <td>Education</td>
      <td>...</td>
      <td>600000.0</td>
      <td>2011.0</td>
      <td>Dec</td>
      <td>14.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
    <tr>
      <th>23</th>
      <td>24</td>
      <td>Canal KondZilla</td>
      <td>66500000</td>
      <td>3.677559e+10</td>
      <td>Music</td>
      <td>Canal KondZilla</td>
      <td>2572</td>
      <td>Brazil</td>
      <td>BR</td>
      <td>Music</td>
      <td>...</td>
      <td>NaN</td>
      <td>2012.0</td>
      <td>Mar</td>
      <td>21.0</td>
      <td>51.3</td>
      <td>2.125594e+08</td>
      <td>12.08</td>
      <td>183241641.0</td>
      <td>-14.235004</td>
      <td>-51.925280</td>
    </tr>
    <tr>
      <th>24</th>
      <td>25</td>
      <td>ChuChu TV Nursery Rhymes &amp; Kids Songs</td>
      <td>65900000</td>
      <td>4.575785e+10</td>
      <td>Education</td>
      <td>ChuChu TV Nursery Rhymes &amp; Kids Songs</td>
      <td>633</td>
      <td>India</td>
      <td>IN</td>
      <td>Education</td>
      <td>...</td>
      <td>500000.0</td>
      <td>2013.0</td>
      <td>Feb</td>
      <td>9.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 28 columns</p>
</div>



If you just want to get one row, we need to use `df.loc[]` or `df.iloc[]` (standing for .location and .indexlocation respectively). These let you access via the row label (for `.loc[]`) or row number (for `.iloc[]`). The labels always look like the first column, here they're the bold numbers **0**, **1**, **2** **...** **994**, but they **could be anything**. The row number is always a number.


```python
df.loc[20]
```




    rank                                                  21
    Youtuber                                     HYBE LABELS
    subscribers                                     71300000
    video views                                28634566938.0
    category                                           Music
    Title                                        HYBE LABELS
    uploads                                             1337
    Country                                      South Korea
    Abbreviation                                          KR
    channel_type                                       Music
    video_views_rank                                    46.0
    country_rank                                         3.0
    channel_type_rank                                    5.0
    video_views_for_the_last_30_days             598173000.0
    lowest_monthly_earnings                         149500.0
    highest_monthly_earnings                       2400000.0
    lowest_yearly_earnings                         1800000.0
    highest_yearly_earnings                       28700000.0
    subscribers_for_last_30_days                    900000.0
    created_year                                      2008.0
    created_month                                        Jun
    created_date                                         4.0
    Gross tertiary education enrollment (%)             94.3
    Population                                    51709098.0
    Unemployment rate                                   4.15
    Urban_population                              42106719.0
    Latitude                                       35.907757
    Longitude                                     127.766922
    Name: 20, dtype: object



#### Accessing rows by a condition

Finally, it's often useful to subset based on a certain condition. We put the condition in the index, usually based on a specific column. Here, we only select rows where the values in the column column `df["subscribers"]` are greater than 100 million:


```python
df[df["subscribers"] > 1e8]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Title</th>
      <th>uploads</th>
      <th>Country</th>
      <th>Abbreviation</th>
      <th>channel_type</th>
      <th>...</th>
      <th>subscribers_for_last_30_days</th>
      <th>created_year</th>
      <th>created_month</th>
      <th>created_date</th>
      <th>Gross tertiary education enrollment (%)</th>
      <th>Population</th>
      <th>Unemployment rate</th>
      <th>Urban_population</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>T-Series</td>
      <td>20082</td>
      <td>India</td>
      <td>IN</td>
      <td>Music</td>
      <td>...</td>
      <td>2000000.0</td>
      <td>2006.0</td>
      <td>Mar</td>
      <td>13.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>youtubemovies</td>
      <td>1</td>
      <td>United States</td>
      <td>US</td>
      <td>Games</td>
      <td>...</td>
      <td>NaN</td>
      <td>2006.0</td>
      <td>Mar</td>
      <td>5.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>MrBeast</td>
      <td>741</td>
      <td>United States</td>
      <td>US</td>
      <td>Entertainment</td>
      <td>...</td>
      <td>8000000.0</td>
      <td>2012.0</td>
      <td>Feb</td>
      <td>20.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>966</td>
      <td>United States</td>
      <td>US</td>
      <td>Education</td>
      <td>...</td>
      <td>1000000.0</td>
      <td>2006.0</td>
      <td>Sep</td>
      <td>1.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>SET India</td>
      <td>116536</td>
      <td>India</td>
      <td>IN</td>
      <td>Entertainment</td>
      <td>...</td>
      <td>1000000.0</td>
      <td>2006.0</td>
      <td>Sep</td>
      <td>20.0</td>
      <td>28.1</td>
      <td>1.366418e+09</td>
      <td>5.36</td>
      <td>471031528.0</td>
      <td>20.593684</td>
      <td>78.962880</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Music</td>
      <td>119000000</td>
      <td>0.000000e+00</td>
      <td>NaN</td>
      <td>Music</td>
      <td>0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Music</td>
      <td>...</td>
      <td>NaN</td>
      <td>2013.0</td>
      <td>Sep</td>
      <td>24.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>��� Kids Diana Show</td>
      <td>1111</td>
      <td>United States</td>
      <td>US</td>
      <td>Entertainment</td>
      <td>...</td>
      <td>NaN</td>
      <td>2015.0</td>
      <td>May</td>
      <td>12.0</td>
      <td>88.2</td>
      <td>3.282395e+08</td>
      <td>14.70</td>
      <td>270663028.0</td>
      <td>37.090240</td>
      <td>-95.712891</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>PewDiePie</td>
      <td>4716</td>
      <td>Japan</td>
      <td>JP</td>
      <td>Entertainment</td>
      <td>...</td>
      <td>NaN</td>
      <td>2010.0</td>
      <td>Apr</td>
      <td>29.0</td>
      <td>63.2</td>
      <td>1.262266e+08</td>
      <td>2.29</td>
      <td>115782416.0</td>
      <td>36.204824</td>
      <td>138.252924</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Like Nastya Vlog</td>
      <td>493</td>
      <td>Russia</td>
      <td>RU</td>
      <td>People</td>
      <td>...</td>
      <td>100000.0</td>
      <td>2016.0</td>
      <td>Jan</td>
      <td>14.0</td>
      <td>81.9</td>
      <td>1.443735e+08</td>
      <td>4.59</td>
      <td>107683889.0</td>
      <td>61.524010</td>
      <td>105.318756</td>
    </tr>
  </tbody>
</table>
<p>9 rows × 28 columns</p>
</div>



## Cleaning the data

This dataset has a lot of columns, most of which we won't be using today. Often, the first task in data analysis is cleaning unnecessary variables and observations from the data.

We use the tools from before but reassign our dataframe

Let's first make a backup of our dataframe, which we can restore if things go wrong

We can choose to remove certain columns with self-assignment:


```python
cols_to_keep = ["rank", "Youtuber", "category"]
df = df[cols_to_keep]
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>category</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>Film &amp; Animation</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>Entertainment</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>Education</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>Shows</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>990</th>
      <td>991</td>
      <td>Natan por A�</td>
      <td>Sports</td>
    </tr>
    <tr>
      <th>991</th>
      <td>992</td>
      <td>Free Fire India Official</td>
      <td>People &amp; Blogs</td>
    </tr>
    <tr>
      <th>992</th>
      <td>993</td>
      <td>Panda</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>993</th>
      <td>994</td>
      <td>RobTopGames</td>
      <td>Gaming</td>
    </tr>
    <tr>
      <th>994</th>
      <td>995</td>
      <td>Make Joke Of</td>
      <td>Comedy</td>
    </tr>
  </tbody>
</table>
<p>995 rows × 3 columns</p>
</div>



Similarly, we can choose to only keep specific rows by subsetting with a condition


```python
df = df[df["category"] == "Music"]
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>category</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>20</th>
      <td>21</td>
      <td>HYBE LABELS</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>965</th>
      <td>966</td>
      <td>Mundo Bita</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>966</th>
      <td>967</td>
      <td>Wave Music Bhakti</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>982</th>
      <td>983</td>
      <td>DisneyChannelUK</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>987</th>
      <td>988</td>
      <td>Avril Lavigne</td>
      <td>Music</td>
    </tr>
    <tr>
      <th>989</th>
      <td>990</td>
      <td>Migos ATL</td>
      <td>Music</td>
    </tr>
  </tbody>
</table>
<p>202 rows × 3 columns</p>
</div>



Here, we've reduced our dataset to three columns and filtered to only keep the *Music* category.

### Challenge

Let's clean our data for analysis later on. Firstly, we need to reset the dataframe back to the original, since we've reduced it too much!


```python
df = df_raw.copy()
```

Your challenge is to reduce the data by the following specifications:

- Only include the following categories
    - rank
    - Youtuber
    - subscribers
    - video views
    - category
    - Country
    - subscribers_for_last_30_days
- Only include YouTubers ranked in the top 20.

Once you've done this, notice that "nan" is one of the values for the categories

> `df["category"].unique()` lists all the unique entries in the "category" column


```python
df["category"].unique()
```




    array(['Music', 'Film & Animation', 'Entertainment', 'Education', 'Shows',
           nan, 'People & Blogs', 'Gaming', 'Sports', 'Howto & Style',
           'News & Politics', 'Comedy', 'Trailers', 'Nonprofits & Activism',
           'Science & Technology', 'Movies', 'Pets & Animals',
           'Autos & Vehicles', 'Travel & Events'], dtype=object)



Let's remove those using a special logical test, `pd.isna("category")`. This performs what ~~`df["category"] == nan`~~ *should*. You'll want to subset using this test.


```python
# Solution

# Keep only a few columns
cols_to_keep = ["rank", "Youtuber", "subscribers", "video views", "category", "Country", "subscribers_for_last_30_days"]
df = df[cols_to_keep]

# Keep only the rows with top 50 YouTubers
df = df[df["rank"] <= 20]

# Keep only the rows where the Category entry is not NA
df = df[pd.notna(df["category"])]

```

## Adding and Editing Columns
To change the values in a column, it's as simple as

```python
df["column name"] = # new value
```

For example, if I wanted to replace every category with "video", I could use


```python
# Create a copy so that we don't lose df
df_new = df.copy()

# Repalce values in "category" column with "video"
df_new["category"] = "video"

df_new
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>video</td>
      <td>India</td>
      <td>2000000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>video</td>
      <td>United States</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>video</td>
      <td>United States</td>
      <td>8000000.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>video</td>
      <td>United States</td>
      <td>1000000.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>video</td>
      <td>India</td>
      <td>1000000.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>video</td>
      <td>United States</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>video</td>
      <td>Japan</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>video</td>
      <td>Russia</td>
      <td>100000.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>video</td>
      <td>United States</td>
      <td>600000.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>video</td>
      <td>India</td>
      <td>1100000.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>video</td>
      <td>United States</td>
      <td>600000.0</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>video</td>
      <td>South Korea</td>
      <td>700000.0</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>video</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>video</td>
      <td>India</td>
      <td>1100000.0</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>video</td>
      <td>United Kingdom</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>video</td>
      <td>South Korea</td>
      <td>400000.0</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>video</td>
      <td>Canada</td>
      <td>100000.0</td>
    </tr>
  </tbody>
</table>
</div>



I could alternatively provide a whole column for the value (instead of "video):


```python
# Replace the values in "Country" with the values in "category"
df_new["Country"] = df_new["category"]
```

### Adding columns

Let's give it a go now with `df`.

We can add columns in a similar way, we just need to give an unused name:


```python
df["new_col"] = df["subscribers"]
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
      <th>new_col</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
      <td>245000000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>United States</td>
      <td>NaN</td>
      <td>170000000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>8000000.0</td>
      <td>166000000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>United States</td>
      <td>1000000.0</td>
      <td>162000000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
      <td>159000000</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>United States</td>
      <td>NaN</td>
      <td>112000000</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
      <td>111000000</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
      <td>106000000</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>98900000</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>96700000</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>96000000</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
      <td>89800000</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>86900000</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>83000000</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
      <td>80100000</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
      <td>75600000</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
      <td>71600000</td>
    </tr>
  </tbody>
</table>
</div>



We can also perform mathematical operations on them


```python
df["views_in_billions"] = round(df["video views"] / 1e9, 1)

df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
      <th>new_col</th>
      <th>views_in_billions</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
      <td>245000000</td>
      <td>228.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>United States</td>
      <td>NaN</td>
      <td>170000000</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>8000000.0</td>
      <td>166000000</td>
      <td>28.4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>United States</td>
      <td>1000000.0</td>
      <td>162000000</td>
      <td>164.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
      <td>159000000</td>
      <td>148.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>United States</td>
      <td>NaN</td>
      <td>112000000</td>
      <td>93.2</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
      <td>111000000</td>
      <td>29.1</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
      <td>106000000</td>
      <td>90.5</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>98900000</td>
      <td>77.2</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>96700000</td>
      <td>57.9</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>96000000</td>
      <td>77.4</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
      <td>89800000</td>
      <td>32.1</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>86900000</td>
      <td>24.1</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>83000000</td>
      <td>101.0</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
      <td>80100000</td>
      <td>26.2</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
      <td>75600000</td>
      <td>20.8</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
      <td>71600000</td>
      <td>30.6</td>
    </tr>
  </tbody>
</table>
</div>



#### Removing columns

A quick way to remove a column is with the `df.drop()` method:

> Once you've run this, you'll need to recreate those columns before you can delete them again - otherwise, you'll get an error!


```python
# Get rid of the columns
df = df.drop(columns = ["new_col", "views_in_billions"])

df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>United States</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>8000000.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>United States</td>
      <td>1000000.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>United States</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>600000.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>United States</td>
      <td>600000.0</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
    </tr>
  </tbody>
</table>
</div>



### Challenge

Create a new column called "%_new_subs" which stores the ratio of new subscribers (in "subscribers_for_last_30_days") and current subscribers (in "subscribers")

Once you've done this, try rounding it to two decimal places with `round()`.


```python
# Solution

df["%_new_subs"] = round(100 * df["subscribers_for_last_30_days"] / (df["subscribers"]), 2)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
      <th>%_new_subs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
      <td>0.82</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>United States</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>8000000.0</td>
      <td>4.82</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>United States</td>
      <td>1000000.0</td>
      <td>0.62</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
      <td>0.63</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>United States</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
      <td>0.09</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>0.61</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.14</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>0.62</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.33</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
      <td>0.53</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
      <td>0.14</td>
    </tr>
  </tbody>
</table>
</div>



Technically, it would be better to take the percentage from the total number of subscribers before the new ones joined. For this, we need to subtract the new subscribers from the current count:


```python
# Solution

old_subs = df["subscribers"] - df["subscribers_for_last_30_days"]

df["%_new_subs"] = round(100 * df["subscribers_for_last_30_days"] / old_subs, 2)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
      <th>%_new_subs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
      <td>0.82</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>United States</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>8000000.0</td>
      <td>5.06</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>United States</td>
      <td>1000000.0</td>
      <td>0.62</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
      <td>0.63</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>United States</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
      <td>0.09</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>0.61</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>United States</td>
      <td>600000.0</td>
      <td>0.63</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
      <td>0.53</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
      <td>0.14</td>
    </tr>
  </tbody>
</table>
</div>



## Interpreting Documentation

We're going to take a brief interlude from coding to examine documentation. Python is popular because it is versatile, and it's versatility has allowed hundreds of thousands of programmers to write shareable code in the form of **packages**.

### Intepreting the `pandas.unique()` documentation

The `pandas` documentation is hosted at [https://pandas.pydata.org/pandas-docs/version/2.1/reference/index.html](https://pandas.pydata.org/pandas-docs/version/2.1/reference/index.html). 

To begin with, let's look at interpreting a simple, general function. Go to [*General functions* > *pandas.unique*](https://pandas.pydata.org/pandas-docs/version/2.1/reference/api/pandas.unique.html)

|Section|Image|Description|
| --- | --- | --- |
| **Signature** | ![image.png](c3871dd0-7527-4879-857e-ce8e7ac194ed.png) | The signature tells us how to use the function. Here, we need to write `pd.unique( ... )` (remember we use `import pandas as pd`) and put `values` as the *argument* (input). See parameters for what `values` should be.|
| **Description** | ![image.png](d6099886-e05c-4b5e-b7f5-119f7154deab.png) | Next, we have a general description of how the function works. Don't worry if you don't understand some of the references (e.g. hash tables). |
| **Parameters** | ![image.png](3a1d08b5-2f0c-47e8-9cac-ae5de547c8d3.png) | The **parameters** section tells us what *values* is. It's described as *1d array-like*, which just means a 1D dataset, like a list, tuple, numpy array or pandas series.
| **Returns** | ![image.png](7e5877f4-5aac-4395-80d6-7c688c8784b4.png) | We see what type of object is returned, either a [numpy array](https://numpy.org/doc/stable/reference/generated/numpy.array.html) (a list of numbers for mathematics, i.e. a vector) or ExtensionArray (specified in the bullet points).
| **Examples** | ![image.png](1ee25a3f-d748-4a0c-b411-42cddf3e114f.png) | Finally, and perhaps most helpfully, there is a list of examples. |


> **Everything in pandas has documentation in this format**. The more you use it, the more intuitive it becomes

We can now use this function to determine the unique set of values in a given list. Let's try it:


```python
myList = [0,1,2,3,4]
pd.unique(myList)
```

    C:\Users\uqcwest5\AppData\Local\Temp\ipykernel_23672\1134000238.py:2: FutureWarning: unique with argument that is not not a Series, Index, ExtensionArray, or np.ndarray is deprecated and will raise in a future version.
      pd.unique(myList)
    




    array([0, 1, 2, 3, 4])



### Challenge

How might we use this function, `pd.unique`, to find the unique values in the "category" column of our datasest?


```python
# Solution
pd.unique(df["category"])
```




    array(['Music', 'Film & Animation', 'Entertainment', 'Education', 'Shows',
           'People & Blogs', 'Gaming', 'Sports', 'Howto & Style'],
          dtype=object)



### Methods

The function `pd.unique` lives in the top level of `pandas` - we only need to use `.` once, and we use it to access directly from `pd`. 

You may remember that we used something like this before, in the data cleaning challenge. We used
```python
df["category"].unique()
```
to get the unique values in the column *category*.

This seems to achieve the same outcome, so what's the difference? Looking at them side by side,

1. `pd.unique(df["category"])`
1. `df["category"].unique()`

we see that

1. `pd.unique(...)` lives inside `pd`
1. `df[...].unique()` lives inside `df[...]`

> How do we know? Because of the operator `.` - for example, `a.b` looks inside `a` for the value `b`

So, 
1. In the first case, the function `unique()` lives in the top level of pandas.
2. In the second, the *method* `unique()` lives inside the Series (dataframe column).

**They are defined separately**. Because they live in different places, it's never ambiguous which one is called. We call functions that live within variables *methods*, and variables that live within variables *attributes*. 

> Technically, they live within a more abstract data structure called a *class*; all specific dataframes (like `df`) are instances of a general *class* called `DataFrame`. Objects of the same class share methods and attributes.

#### Where can I find the documentation?

The documentation for methods like `df[...].unique()` is located beneath the class. `df` has the DataFrame class, and its columns have the Series class. So 

- The documentation for `df[...].unique()` will be found under `pd.Series.unique` (as will other column methods), and
- The documentation for all dataframe methods (e.g. `df.copy()`) are found under `pd.DataFrame.method_name`

### Challenge

We have two options here with different difficulty

#### Option 1 - Easier - `df.describe()`

Go to [*Series > pandas.DataFrame.describe*](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html)

Read the documentation on the `.describe` method.

**Challenge:** create a statistical summary of the data, presenting the 33rd, 50th and 66th percentiles.



```python
# Option 1 - Solution
df.describe(percentiles = [0.33, 0.5, 0.66])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>subscribers_for_last_30_days</th>
      <th>%_new_subs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>17.000000</td>
      <td>1.700000e+01</td>
      <td>1.700000e+01</td>
      <td>1.200000e+01</td>
      <td>12.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>10.117647</td>
      <td>1.182118e+08</td>
      <td>7.226780e+10</td>
      <td>1.391667e+06</td>
      <td>1.034167</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5.935932</td>
      <td>4.654253e+07</td>
      <td>6.108605e+10</td>
      <td>2.144107e+06</td>
      <td>1.315747</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>7.160000e+07</td>
      <td>0.000000e+00</td>
      <td>1.000000e+05</td>
      <td>0.090000</td>
    </tr>
    <tr>
      <th>33%</th>
      <td>7.280000</td>
      <td>9.153600e+07</td>
      <td>2.949207e+10</td>
      <td>6.000000e+05</td>
      <td>0.616300</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>10.000000</td>
      <td>9.890000e+07</td>
      <td>5.785629e+10</td>
      <td>8.500000e+05</td>
      <td>0.630000</td>
    </tr>
    <tr>
      <th>66%</th>
      <td>13.120000</td>
      <td>1.115600e+08</td>
      <td>8.473680e+10</td>
      <td>1.026000e+06</td>
      <td>0.797800</td>
    </tr>
    <tr>
      <th>max</th>
      <td>20.000000</td>
      <td>2.450000e+08</td>
      <td>2.280000e+11</td>
      <td>8.000000e+06</td>
      <td>5.060000</td>
    </tr>
  </tbody>
</table>
</div>



#### Option 2 - More difficult - `df.mask()`

Go to [*Series > pandas.Series.mask*](https://pandas.pydata.org/docs/reference/api/pandas.Series.mask.html)

Read the documentation on the `.mask` method. Essentially, it replaces values based on a certain condition.

**Challenge:** replace the values "United States" in the Country column with "USA" using `.mask`

> **Notes**
> - To use the method, try `df["Country"].mask(...)`
> - The condition in `cond` could be something like `df["subscribers"] < 100000000`


```python
# Option 2 Solution
df["Country"].mask(df["Country"] == "United States", "USA", inplace = True)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>Country</th>
      <th>subscribers_for_last_30_days</th>
      <th>%_new_subs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>T-Series</td>
      <td>245000000</td>
      <td>2.280000e+11</td>
      <td>Music</td>
      <td>India</td>
      <td>2000000.0</td>
      <td>0.82</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>YouTube Movies</td>
      <td>170000000</td>
      <td>0.000000e+00</td>
      <td>Film &amp; Animation</td>
      <td>USA</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>MrBeast</td>
      <td>166000000</td>
      <td>2.836884e+10</td>
      <td>Entertainment</td>
      <td>USA</td>
      <td>8000000.0</td>
      <td>5.06</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Cocomelon - Nursery Rhymes</td>
      <td>162000000</td>
      <td>1.640000e+11</td>
      <td>Education</td>
      <td>USA</td>
      <td>1000000.0</td>
      <td>0.62</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>SET India</td>
      <td>159000000</td>
      <td>1.480000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1000000.0</td>
      <td>0.63</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>��� Kids Diana Show</td>
      <td>112000000</td>
      <td>9.324704e+10</td>
      <td>People &amp; Blogs</td>
      <td>USA</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>Japan</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>Russia</td>
      <td>100000.0</td>
      <td>0.09</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Vlad and Niki</td>
      <td>98900000</td>
      <td>7.718017e+10</td>
      <td>Entertainment</td>
      <td>USA</td>
      <td>600000.0</td>
      <td>0.61</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11</td>
      <td>Zee Music Company</td>
      <td>96700000</td>
      <td>5.785629e+10</td>
      <td>Music</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12</td>
      <td>WWE</td>
      <td>96000000</td>
      <td>7.742847e+10</td>
      <td>Sports</td>
      <td>USA</td>
      <td>600000.0</td>
      <td>0.63</td>
    </tr>
    <tr>
      <th>13</th>
      <td>14</td>
      <td>BLACKPINK</td>
      <td>89800000</td>
      <td>3.214460e+10</td>
      <td>People &amp; Blogs</td>
      <td>South Korea</td>
      <td>700000.0</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>14</th>
      <td>15</td>
      <td>Goldmines</td>
      <td>86900000</td>
      <td>2.411823e+10</td>
      <td>Film &amp; Animation</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16</td>
      <td>Sony SAB</td>
      <td>83000000</td>
      <td>1.010000e+11</td>
      <td>Shows</td>
      <td>India</td>
      <td>1100000.0</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>16</th>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>United Kingdom</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>18</td>
      <td>BANGTANTV</td>
      <td>75600000</td>
      <td>2.082699e+10</td>
      <td>Music</td>
      <td>South Korea</td>
      <td>400000.0</td>
      <td>0.53</td>
    </tr>
    <tr>
      <th>19</th>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>Canada</td>
      <td>100000.0</td>
      <td>0.14</td>
    </tr>
  </tbody>
</table>
</div>



## Grouping, aggregating and summarising

Many data analysis tasks require grouping and aggregating. Questions like *"What is the average *x* for each country?"* or *"How many different *y* are in each category?"* all need aggregation, and most visualisations will too.

Let's aim to answer the following question of our top 20 dataset:

<center><i>What are the total number of views for each country?</i></center>

In the code below the key steps are outlined


```python
# Step 1: Select a variable to group by
df.groupby("Country")

# Step 2: Aggregate over that variable by applying .agg() and choosing a method (e.g. "sum")
df.groupby("Country").agg("sum")

# Step 3: Store that result in a new variable (as_index = False keeps "Country" as a column)
country_sums = df.groupby("Country", as_index = False).agg("sum")

# Look at the result
country_sums
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>rank</th>
      <th>Youtuber</th>
      <th>subscribers</th>
      <th>video views</th>
      <th>category</th>
      <th>subscribers_for_last_30_days</th>
      <th>%_new_subs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Canada</td>
      <td>20</td>
      <td>Justin Bieber</td>
      <td>71600000</td>
      <td>3.060812e+10</td>
      <td>Music</td>
      <td>100000.0</td>
      <td>0.14</td>
    </tr>
    <tr>
      <th>1</th>
      <td>India</td>
      <td>33</td>
      <td>T-SeriesSET IndiaZee Music CompanySony SAB</td>
      <td>583700000</td>
      <td>5.348563e+11</td>
      <td>MusicShowsMusicShows</td>
      <td>5200000.0</td>
      <td>3.94</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Japan</td>
      <td>8</td>
      <td>PewDiePie</td>
      <td>111000000</td>
      <td>2.905804e+10</td>
      <td>Gaming</td>
      <td>0.0</td>
      <td>0.00</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Russia</td>
      <td>9</td>
      <td>Like Nastya</td>
      <td>106000000</td>
      <td>9.047906e+10</td>
      <td>People &amp; Blogs</td>
      <td>100000.0</td>
      <td>0.09</td>
    </tr>
    <tr>
      <th>4</th>
      <td>South Korea</td>
      <td>32</td>
      <td>BLACKPINKBANGTANTV</td>
      <td>165400000</td>
      <td>5.297159e+10</td>
      <td>People &amp; BlogsMusic</td>
      <td>1100000.0</td>
      <td>1.32</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USA</td>
      <td>38</td>
      <td>YouTube MoviesMrBeastCocomelon - Nursery Rhyme...</td>
      <td>804900000</td>
      <td>4.402245e+11</td>
      <td>Film &amp; AnimationEntertainmentEducationPeople &amp;...</td>
      <td>10200000.0</td>
      <td>6.92</td>
    </tr>
    <tr>
      <th>6</th>
      <td>United Kingdom</td>
      <td>17</td>
      <td>5-Minute Crafts</td>
      <td>80100000</td>
      <td>2.623679e+10</td>
      <td>Howto &amp; Style</td>
      <td>0.0</td>
      <td>0.00</td>
    </tr>
  </tbody>
</table>
</div>



The code for `# Step 3` actually does all the required steps.

Let's do it again, but this time we can remove the columns we don't need:


```python
# List columns to keep
cols_to_keep = ["video views", "Country"]

# Groupby and aggregate
country_sums = df[cols_to_keep].groupby("Country", as_index = False).agg("sum")

country_sums
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>video views</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Canada</td>
      <td>3.060812e+10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>India</td>
      <td>5.348563e+11</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Japan</td>
      <td>2.905804e+10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Russia</td>
      <td>9.047906e+10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>South Korea</td>
      <td>5.297159e+10</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USA</td>
      <td>4.402245e+11</td>
    </tr>
    <tr>
      <th>6</th>
      <td>United Kingdom</td>
      <td>2.623679e+10</td>
    </tr>
  </tbody>
</table>
</div>



Finally, we can sort these results with `.sort_values`:


```python
country_sums = country_sums.sort_values("video views", ascending = False)

country_sums
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>video views</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>India</td>
      <td>5.348563e+11</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USA</td>
      <td>4.402245e+11</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Russia</td>
      <td>9.047906e+10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>South Korea</td>
      <td>5.297159e+10</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Canada</td>
      <td>3.060812e+10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Japan</td>
      <td>2.905804e+10</td>
    </tr>
    <tr>
      <th>6</th>
      <td>United Kingdom</td>
      <td>2.623679e+10</td>
    </tr>
  </tbody>
</table>
</div>



And if we *really* wanted, we could immediately plot them with `.plot()`:

> Comprehensive workshops on data visualisation are available which describe better ways to do this


```python
country_sums.plot(kind = "bar")
```




    <Axes: xlabel='Country'>




    
![png](output_73_1.png)
    


## Exporting data

Your pandas dataframes are not stored anywhere permanent, so when you close Python, they're gone!

We need to export the dataframe to a file in order to save it permanently. Usually, this is a .csv (Comma Separated Values) file.

Let's do so with our `country_sums` data. We need to use the method `.to_csv()`



```python
# Export data to file
country_sums.to_csv("country_views.csv")
```

Navigate to the folder where your Python script is located, and you should see a new .csv file with the data.

> If you can't find it, run 
> ```python
> import os
> print(os.getcwd())
> ```
> The result is the folder where you Python script - and therefore the outputted data - is located (the **current working directory**)

You don't have to output a .csv file. Other options include
- `.to_excel(" ... .xlsx")`
- `.to_pdf(" ... .pdf")`
- `.to_html(" ... .html")`
- etc.

### A note on file paths

File paths specify a location on your computer. This is made up of files and folders (directories), and every file lives nested inside a number of folders. For example, on  a Windows computer,

`C:\Users\your-username\Desktop\file1.pdf`

refers to a PDF that lives inside the folders Users -> your-username -> Desktop, all on the C hard drive.

We call this an **absolute file path**, because it specifies the complete location of the file (i.e., starting from C:\). You can also use **relative file paths**, which refer to a folder or lower. For example, if your Python script is located inside the folder *Users*, you can instead use

`your-username\Desktop\file1.pdf`

to refer to file1.pdf.

### Challenge

Our final challenge! We'll go back to the original data, starting from scratch again:


```python
# Create a new copy of the raw data
df_all = df_raw.copy()
```

Your goal is to answer the following question:

<center><i>Which are the top ten countries with the most subscribers in the past 30 days, <b>per capita</b>?</i></center>

Once answered, **export** the result to a csv file and **plot** it as a bar graph.

A few particulars:
- To find the per capita value, you'll need to divide the column `subscribers_for_last_30_days` by the column `Population`
- Using `.groupby()` and `.agg("sum")` will help find the values for each country
- The method `.head(10)` returns the top five rows of a dataframe

And don't forget to use `df_all` as we defined just above.


```python
# Solution

# Create a new copy of the raw data
df_all = df_raw.copy()

# Find the subs per capita for all countries
df_all["subs_per_cap"] = df_all["subscribers_for_last_30_days"] / df_all["Population"]

# Select the relevent columns
cols = ["Country", "subs_per_cap"]
df_all = df_all[cols]

# Group by and summarise
df_all = df_all.groupby("Country").agg("sum")

# Sort in descending order and only select 5
df_all = df_all.sort_values("subs_per_cap", ascending = False).head(10)

# Export to a .csv file
df_all.to_csv("top5.csv")

# Visualise
df_all.plot(kind = "bar")
```




    <Axes: xlabel='Country'>




    
![png](output_81_1.png)
    


## Appendix

### Advanced - A note on classes
Documentation is hard to read because it assumes you have a comprehensive understanding of Python data structures. One (*the most?*) important structure is the **class**. The Python documentation provides a [comprehensive overview](https://docs.python.org/3/tutorial/classes.html) (if gritty), here we have a brief description.

**What is a class**

In the world, we have abstract forms for specific objects. For example, a **table** is an abstract form, and they all have $n$ legs. Some have $n = 4$ legs, others have $n = 3$, and you might even find some with $n = 0$.

Here, we have an abstract form (table) with specific properties (number of legs) common to all different instances of the form (e.g. my dinner table). We can always describe how many legs a table has. So, we call table a form and n_legs a property of the form.

It's much the same in coding. We call the forms **classes**, which are data containers storing various attributes. We then make specific instances of the class. For example, if I made a **specific** variable called `my_dinner_table` and it had the class "table", I could access the number of legs it has with `my_dinner_table.n_legs`. These properties are called **attributes**.

Finally, classes can also contain special functions which act on the object and its attributes. These are called **methods**, and we access them with `my_dinner_table.method1()`, like we see above.

**Why is this relevant?**

Most variable 'types' are classes, like DataFrame, and the documentation is structured accordingly. We're currently using the **pandas** package, which has a number of *classes* (e.g. DataFrame) with hundreds of corresponding *methods* (functions) and *attributes* (variables). 

My dataframe, `df`, is an instance of the general class `DataFrame`. Some of the attributes include
```python
df.columns
df.shape
```
and some of the methods include
```python
df.copy()
df.describe()
```
A general familiarity with this will help us read documentation.
