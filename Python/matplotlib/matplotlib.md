# Python data visualisation with matplotlib

***Introduction***

## Setup

The easiest way to use Python 3, matplotlib and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

### Create a project

In order to keep everything nicely contained in one directory, and to find files more easily, we need to create a project.

-   Projects -\> New project...
-   New directory
-   Project name: "python_matplotlib"
-   Choose a location that suits you on your computer
-   Click "Create"

This will move our working directory to the directory we just created, and Python will look for files (and save files) in this same directory by default.

### Create a script

Spyder opens a temporary script automatically. You can save that as a file into our project directory:

-   File -\> Save as...
-   Make sure you are located in the project directory
-   Name the script "process.py"

Working in a script allows us to write code more comfortably, and save a process as a clearly defined list of commands that others can review and reuse.

### Introducing and installing matplotlib

`matplotlib` is a large Python module useful for data visualisation. Created by John D. Hunter in 2003, it parallels many features availble in MATLAB and is an extensive library of visualisation functions and submodules. 

`pyplot` is a submodule with functions that allow the most intuitive creation of most plots, and also contains some essential functions for all visualisation. 

While we could import the whole `matplotlib` module, we only need to use the `pyplot` submodule, so it makes sense just to import it directly.

To be able to use the functions included in pyplot, we have to first import it:

``` python
import matplotlib.pyplot as plt
```

`plt` is the usual nickname for the pyplot submodule, and writing out `matplotlib.pyplot...` every time we need to use a function gets cumbersome pretty quickly.

## The basics

To begin with, let's use the aptly named `plot()` function:

``` python
plt.plot()
```

![image](https://user-images.githubusercontent.com/118239146/204414576-5047bd1b-83ad-4132-b51d-052ee2a37918.png)

Here, we gain a small insight into what `plot()` does - it produces a figure (the canvas/area) and axes. If we want to include anything else, we'll need to include it as arguments inside the brackets. Let's plot some basic data in the function

| days | sunshine (h) |
|---|---|
| 0 | 6 | 
| 1 | 4 | 
| 2 | 8 | 
| 3 | 5 | 

by assigning it to variable as follows

``` python
days = [0,1,2,3]
sunshine = [6,4,8,5]
plt.plot(days, sunshine)
```
![image](https://user-images.githubusercontent.com/118239146/204417297-291d7d2e-7e10-450a-aaaf-e5c4ae0016f3.png)

> We could have also done this simply by placing the lists into the function, `plt.plot([0,1,2,3],[6,4,8,5])`

Examining our figure, we see that *days* has been plotted on the x-axis and *sunshine* on the y-axis. This is because plot identifies the first argument as x-values and the second as y-values.
``` python
plt.plot(x, y, ...
```
> If only put one set of data in, it will be plotted on the y-axis at x = 0, 1, 2, ...

### Formatting

#### Colour and style

Let's look at some basic formatting. We can change the colour and style of our plotted line **within** the plot function as an argument after the data.

``` python
plt.plot(days, sunshine, 'r--')
```
![image](https://user-images.githubusercontent.com/118239146/204424300-a85fece6-1705-4074-ba4a-b535eda666db.png)

Here's how the formatting argument works.
1. It has to be a string, so we need to place everything inside quotation marks `' '`
2. The colour of the line is determined by letter, e.g. r = red, b = blue, g = green etc.
3. The style of the line is determined by a symbol or letter, e.g. -- = dashed, o = circle, * = star etc.

> To see a longer list of the colours and styles availble, type `help(plt.plot)` and scroll down.

#### Other keywords

There are also other arguments **within** the plot function that change the formatting of our line. These need to be called, and can also be found after running `help(plt.plot)` under `**kwargs` (keyword arguments). For example

``` python
plt.plot(days, sunshine, 'r--', linewidth = 2)
```

gives a thicker line, and

``` python
plt.plot(days, sunshine, 'ro', fillstyle = 'none')
```

gives hollow (as opposed to filled in) circles.

#### Other features

We can also format other aspects of our axes and figure with features like labels, a title and a legend. These are done **outside** `plt.plot` with other functions.

##### Labels
Axis labels and a title can be specified with the functions

```python
plt.xlabel('days')
plt.ylabel('sunshine (h)')
plt.title('Hours of sunshine per day')
```

![image](https://user-images.githubusercontent.com/118239146/204429698-a3157bd5-2c0b-4bed-a57a-e6a10a3914e3.png)

These should be placed **after** our previous `plt.plot` code and will produce a plot with these features
> When running multiple functions for a single plot, they **must** be run at the same time. To do this, select **all** the code to be run and press F9.

##### Legend

A legend can be similarly introduced, after our `plt.plot` function, as follows.

``` python
plt.legend(['Interpolated data'])
```

![image](https://user-images.githubusercontent.com/118239146/204429796-22cee710-2618-4c56-bd73-6796adeb239e.png)

Notice that this is similar to the previous features, however, our string is within square brackets making it a list. This is because `plt.legend` might need to have multiple labels for other lines, so it expects a list. We can choose the position of our legend with the argument `loc = ' '` and enter the position between the quotation marks. For example,

```python
plt.legend(['Interpolated data'], loc = 'lower right')
```

![image](https://user-images.githubusercontent.com/118239146/204429845-e0be447a-c1a9-45ce-8c19-c07d8091069a.png)

A full list of positions can be found under `help(plt.legend)`

##### Axes

The size of the axes is automatically determined by `plt.plot`, but we can manually override that with the `plt.axis()` function. Inside the function we need to put the dimensions of the axes in the format `plt.axis([x_min, x_max, y_min, y_max])`. Let's change ours to go from 0 to 5 on the x-axis and 0-10 on the y-axis.

``` python
plt.axis([0, 5, 0, 10])
```

![image](https://user-images.githubusercontent.com/118239146/204430360-772f689d-3c3d-4868-a8bd-fdaa4cfbb6f2.png)

## Plot types

Now that we've looked at the fundamentals of plotting with matplotlib, let's explore the different visualisation options availble. We're going to make use of the `pandas` module which we looked at in our [data transformation guide](https://github.com/uqlibrary/technology-training/blob/a0a1bdf568fa88dd282356043751b04186ce29ae/Python/pandas/pandas.md). This will allow us to import some real data which we can visualise in different ways.

### Importing `pandas` and the data

First, import the `pandas` module, similarly to how we imported `matplotlib.pyplot`. You might want to put this near the top of your code.

``` python
import pandas as pd
```

As usual, we use `pd` as the standard nickname for `pandas`.

Next, we'll import our data. In this session our data comes from https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv, which includes interesting statistics like population and GDP about most countries over time. It's called gapminder.

To import it directly, we run

``` python
df_raw = pd.read_csv('https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv')
```

If you look in *Variable Explorer*, you should now see a new variable `gapminder`, with type `DataFrame` and size `(1704, 6)`. `gapminder` is now the variable which stores our data. To get a sense of what this data looks like, simply run

``` python
df_raw
```

![image](https://user-images.githubusercontent.com/118239146/204963864-e9f2f77d-bf56-4b3f-ab84-9784ace925c9.png)

As you can see, there are six columns (variables)

1. `country`
2. `year`
3. `pop` (population)
4. `continent`
5. `lifeExp` (life expentancy)
6. `gdpPercap` (GDP per capita)

with 1703 rows.

We can visualise different aspects of this data, and we will have different options depending on the types of variables we choose. Data can be categorical or numerical, and ordered or unordered, leading to a variety of visualisation possibilities. If you would like to explore this more, check out [From data to Viz](https://www.data-to-viz.com/), a tool which helps you to find the best option.

Finally, let's copy the data into a new variable so that we can always go back to the original if something goes wrong.

``` python
df = df_raw
```

### Bar Chart

Let's start with the simple bar chart. It requires a categorical variable (like continent) and a numerical variable (like population). Firstly, let's simplify our data by just considering the year 2007.

``` python
df_bar = df[df.year == 2007]
```

Next, let's apply a `groupby` to summarise our data by continent.

``` python
df_bar = df_bar.groupby('continent', as_index = False).agg('mean')
```

Let's examine what just happened. By combining `groupby('continent',` and `agg('mean')`, we group the data by continent and take the average for each other column (i.e., average life expentancy in Africa, Asia ...; average population in Africa, Asia ...). `as_index = False` just allows us to access the `continent` column later (otherwise it would be the index, which is harder to use).

Now, let's plot the bar chart. Instead of using `plt.plot`, this time we'll use `plt.bar`.

``` python
plt.bar(df_bar['continent'], df_bar['pop'])
```

