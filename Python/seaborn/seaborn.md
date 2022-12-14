# Python data visualisation with seaborn

***Introduction***

## Setup

The easiest way to use Python 3, seaborn and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

### Create a project

In order to keep everything nicely contained in one directory, and to find files more easily, we need to create a project.

-   Projects -\> New project...
-   New directory
-   Project name: "python_seaborn"
-   Choose a location that suits you on your computer
-   Click "Create"

This will move our working directory to the directory we just created, and Python will look for files (and save files) in this same directory by default.

### Create a script

Spyder opens a temporary script automatically. You can save that as a file into our project directory:

-   File -\> Save as...
-   Make sure you are located in the project directory
-   Name the script "process.py"

Working in a script allows us to write code more comfortably, and save a process as a clearly defined list of commands that others can review and reuse.

### Introducing and installing seaborn

seaborn is a Python module useful for statistical data visualisation. It is a high-level module built upon another module called matplotlib. Effectively, seaborn is a more user friendly module which uses matplotlib in the background to do all the work. It is also possible to use matplotlib in directly, although it is less intuitive. matplotlib is modelled on MATLAB, so if you have MATLAB experience, then it should be easier to use.

To be able to use the functions included in seaborn, we'll need to import it first.

``` python
import seaborn as sns
```

> `sns` is the usual nickname for the seaborn, and writing out `seaborn. ...` every time we need to use a function gets cumbersome pretty quickly.

### Importing our data
To begin with, let's import a dataset to visualise. seaborn has some inbuilt data, we'll use the one called "tips". To import the data, we use the `sns.load_dataset( ... )` as follows:

``` python
tips = sns.load_dataset("tips")
```

> Notice that we have to start with `sns.`, since we're using a seaborn function.

Now that our data is stored in the variable `tips`, let's have a look at it to see what it contains. Simply run

``` python
tips
```

![image](https://user-images.githubusercontent.com/118239146/207469652-c4872136-1caa-42b9-a647-0fa5066efa2a.png)

Here we can see that our data is separated into six variables (columns):

1. `total_bill`
2. `tip`
3. `sex`
4. `smoker`
5. `day`
6. `size`

with 244 rows. It looks like this data contains statistics on the tips that a restaurant or cafe received in a week.

We can visualise different aspects of this data, and we will have different options depending on the types of variables we choose. Data can be categorical or numerical, and ordered or unordered, leading to a variety of visualisation possibilities. If you would like to explore this more, check out [From data to Viz](https://www.data-to-viz.com/), a tool which helps you to find the best option.

## Plotting

Before we begin, let's just quickly examine how the seaborn syntax works. Stored in the library are many functions like `lineplot()`, `boxplot()`, `scatterplot()` etc. which, when run with the correct inputs, which produce the plot that their name indicates. In general, most plots work as follows:

``` python
sns.plotfunction(data = <dataset>, x = <variable>, y = <variabale>, ... )
```

In essence, the steps are
1. Direct python to the seaborn library with `sns.`
2. Call the chosen plotting function, e.g. `sns.lineplot(`, `sns.boxplot(` etc.
3. Input the dataset, `sns.plotfunction(data = <dataset>`
4. Choose the variable(s), `sns.plotfunction(data = <dataset>, x = "<variable>", y = "<variabale>",`
5. Customise colours, sizes, shapes, all other features, with more arguments `sns.plotfunction(data = <dataset>, x = <variable>, y = <variabale>, ... )`

### Bar and Count Plots

Let's try this now with one of the simplest plots possible: `sns.countplot()`. This is a bar chart, with one categorical variable on the x-axis and a count of the number of times they occur on the y-axis. Let's examine the **day** variable. The steps are:

1. Direct python to seaborn: `sns.`
2. Call our plotting function: `sns.countplot(`
3. Input our data: `sns.countplot(data = tips`
4. Choose our variable(s): `sns.countplot(data = tips, x = "day")`

``` python
sns.countplot(data = tips, x = "day")
```

![image](https://user-images.githubusercontent.com/118239146/207475961-f6d9a545-f772-4030-af32-3765085272f5.png)

There it is! It looks like Friday is their quietest day.

There are a few ways we can add more information to bar plots. One common way is to group them by a third categorical variable. Let's add the variable **sex** to the data.

To produce a grouped plot by introducing the new variable we'll need to specify a way of identifying this variable, since both axes are already in use. A great tool is to group by *colour*, which we can do by specifying a variable to the argument `hue = `.

``` python
sns.countplot(data = tips, x = "day", hue = "sex")
```

![image](https://user-images.githubusercontent.com/118239146/207477038-eaa3dc93-9894-465a-80b8-389699c6646f.png)

`sns.countplot()` provides a simple and efficient way of producing a bar plot when the y-axis is the frequency of a variable, however, it is restricted to these limitations. Often, it is desirable to display a different variable on the y-axis, and for this, seaborn offers the `sns.barplot()` function.

The `sns.barplot()` function requires two variables, one categorical and one numerical. Let's compare our variables **day** and **total bill**. This time, we need to include the `y = ` argument too.

```python
sns.barplot(data = tips, x = "day", y = "total_bill")
```

![image](https://user-images.githubusercontent.com/118239146/207478554-0e1846bb-cd47-4d73-b9b1-7703b23b84ce.png)

Notice that seaborn has automatically taken the average **total bill** for each day of the week, and displayed confidence intervals too (the black lines). By inputting the variable **total bill**, seaborn recieves 244 data to plot, but can only plot 4 bars, so it has to aggregate them somehow. By default it takes the mean, however, the method can be specified with the `estimator = ` argument. For example, we could take the *sum*, displaying the total they earned each day.

```python
sns.barplot(data = tips, x = "day", y = "total_bill", estimator = sum)
```

![image](https://user-images.githubusercontent.com/118239146/207479800-7d0c5b7e-ef61-42ab-add0-2df7a5b325ce.png)

> Specifically, the input for `estimator = ` should be a function that seaborn can apply to each variable. Others include `min`, `max`, `median`, etc., and there are lots include in the mathematics module `numpy`, which should be imported as `import numpy as np`

The errorbars aren't so helpful here, so let's remove them. There are two ways to do this, depending on your version of seaborn:

1. If you have a version older than v0.12, then use `ci = 0`
2. If you have version v0.12 or later, then use `errorbar = None`

If you're not sure, try both and see which one works. Let's also group by our variable **smoker**.

``` python
sns.barplot(data = tips, x = "day", y = "total_bill", hue = "smoker", estimator = sum, ci = 0) # Prior to v0.12
sns.barplot(data = tips, x = "day", y = "total_bill", hue = "smoker", estimator = sum, errorbar = None) # v0.12 or later
```

### Scatter plots

Now, let's look at scatter plots. Perhaps the most common and versatile, these take two numerical variables and are called by the function `sns.scatterplot`. 
> There is also a variation, using the function `sns.stripplot()`, which takes one categorical and one numerical variable, but for now we will just examine scatter plots.

This time, let's compare **total bill** and **tip** to see if there might be a relationship between them.

```python
sns.scatterplot(data = tips, x = "total_bill", y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/207483060-50446354-8e26-46ce-892b-29a7c46bd80f.png)

Clear correlation looks a little dubious, but there might be a general trend. Like before, we can categorise by colour using `hue = `. Let's use our **time** category.

```python
sns.scatterplot(data = tips, x = "total_bill", y = "tip", hue = "time")
```

![image](https://user-images.githubusercontent.com/118239146/207484131-1af71bfe-3faf-4881-8889-cef3eea2fd7a.png)

Since each data point is plotted on the graph, each can be given the colour directly. seaborn recognises these as categorical variables and assigns corresponding colours (blue and orange are good for a discrete variable). Let's see what happens when we instead use **size**.

```python
sns.scatterplot(data = tips, x = "total_bill", y = "tip", hue = "size")
```

![image](https://user-images.githubusercontent.com/118239146/207484781-151635b1-b2f2-43d1-b30a-d44bda172808.png)

Here, seaborn chooses a different colour palette, one which suits ordered data. It is important to choose a colour palette that matches your data. We can do that with the `palette = ` argument. One of the [seaborn tutorials](https://seaborn.pydata.org/tutorial/color_palettes.html#palette-tutorial) offers a list of available palettes and some guidance on which ones to choose. Let's use *flare*.

``` python
sns.scatterplot(data = tips, x = "total_bill", y = "tip", hue = "size", palette = "flare")
```

![image](https://user-images.githubusercontent.com/118239146/207486382-143a24dd-a237-4e28-b374-c6dfc66fa0de.png)

Instead of using colour, there is also the possibility of altering the size of the markers, using `size = `. Let's see what happens if we use size instead of colour.

``` python
sns.scatterplot(data = tips, x = "total_bill", y = "tip", size = "size")
```

![image](https://user-images.githubusercontent.com/118239146/207486820-e3eba706-85b2-4ed5-b34c-a6f1bc68bd25.png)

While each point has been grouped by size, it isn't a very clear choice for this plot. In general, size doesn't work particularly well when there are lots of points. We could also group by marker style, using `style = `. Let's use colour to group by **size** and marker to group by **sex**.

``` python
sns.scatterplot(data = tips, x = "total_bill", y = "tip", hue = "size", style = "sex", palette = "flare")
```

![image](https://user-images.githubusercontent.com/118239146/207487270-0f43e3ee-0558-42ec-8174-fc4549c6c783.png)

Here, the marker style has been changed for the variable **sex**. Again, there's probably too much information here for good visualisation, so making good, tactful use of `hue = `, `size = ` and `style = ` is very important.

### Line plots

               _________________________________________________________________________________________________________________________________




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

![image](https://user-images.githubusercontent.com/118239146/205763808-9505a434-adf2-41a4-9008-aaefc9127e6e.png)

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
### Scatter Plot

A common visualisation is the scatter plot. The scatter plot takes two numerical variables and plots them on the x- and y-axes respectively. Let's examine GDP per capita and life expentancy. We can access this data from our dataframe with

```python
df['gdpPercap']
df['lifeExp']
```
> Notice that we use square brackets to select specific columns from our dataframes.

To plot them, we'll use the function `plt.scatter` as follows.

``` python
plt.scatter(df['gdpPercap'],df['lifeExp'])
```

As with before, let's add some labels. Don't forget to run all the plot code at the same time by selecting it all before presing F9.

``` python
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life Expectancy (years)')
```

![image](https://user-images.githubusercontent.com/118239146/204979072-70a3a28b-37ec-441b-be96-149e112235d1.png)

There is a lot of data there, so most points are overlapping. Let's change our markers from blue circles to black dots. Unlike with `plt.plot`, we can't simply type `'k.'` afterwards, as `plt.scatter` is expecting different arguments. Instead, we need to use `c = 'k'` for colour (k (key) = black) and `marker = 'k.'`. Let's also use `s = 3` to make them smaller.

```python
plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = 'k', marker = '.')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life Expectancy (years)')
```

![image](https://user-images.githubusercontent.com/118239146/204980440-54447664-6d27-44f0-8237-bdffffe80193.png)

Until this point, we could have just used `plt.plot` and achieved the same outcome. However, `plt.scatter` allows us to utilise color and size of the markers to communicate more information. Let's use colour to represent a third variable, like year. To group by year, we tell python to determine the colour based on the year variable, replacing our previous colour argument with `c = df['year']`.

```python
plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = df['year'], marker = '.')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life Expectancy (years)')
```

![image](https://user-images.githubusercontent.com/118239146/205767477-dc67a779-5261-4267-9fb6-4fefefb7fdbc.png)

Of course, we need to communicate what the colours represent. If our data is numerical and continuous (which time normally is), we can use a colourbar. If we include the line below with our previous plotting code, we produce a scale for our year.

```python
plt.colorbar()
```
> Note that the American spelling 'color' is required

![image](https://user-images.githubusercontent.com/118239146/205769560-665f2284-70f7-435a-8e7d-3b5fc742cdb1.png)

We don't initially need to pass any arguments into `plt.colorbar` because it automatically applies to our current plot. However, we can specify some properties, like location, orientation, size and label. Let's add a label.

``` python
plt.colorbar(label = 'Year')
```

![image](https://user-images.githubusercontent.com/118239146/205770607-0caa7309-9cef-4ff9-a434-7e5afb3f7b48.png)

> Some vector graphics viewers (svg and pdf) cause white bars to appear in the colorbar. This is a bug in the viewers. If this occurs, use the following workaround:
> ``` python
> cbar = colorbar()
> cbar.solids.set_edgecolor("face")
> draw()
> ```

You may want to use a different colour scheme. This can be chosen by the `cmap = ` argument within the `plt.scatter` function. A list of options are available [here](https://matplotlib.org/stable/gallery/color/colormap_reference.html), let's choose magma

``` python
plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = df['year'], marker = '.', cmap = 'magma')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life Expectancy (years)')
plt.colorbar(label = 'Year')
```

![image](https://user-images.githubusercontent.com/118239146/205786977-4324c0d0-99fe-48f6-90e9-80f37553f110.png)

We can similarly include our population variable in our plot, changing the *size* of each point. Here, we assign our population variable `df['pop']` to the size argument `s`. Since the population values are so huge, let's also scale them down by a factor of 1000000. All together, our code reads

``` python
plt.scatter(df['gdpPercap'],df['lifeExp'], s = df['pop']/1000000, c = df['year'], marker = '.', cmap = 'magma')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life Expectancy (years)')
plt.colorbar(label = 'Year')
```

![image](https://user-images.githubusercontent.com/118239146/205787031-f64145fe-4cfc-4742-bac4-bbf489e57b67.png)

As you can see, some points are now much bigger than others, representing the population size. In this case, with so many data points, its not particularly helpful, as it obscures some of the other data. Not all visualisation tools are going to be useful in all cases, and it can be harmful to try display too much in one plot. Often, simpler is more effective. For the next part, let's go back to our previous size argument, `s = 3`.

#### Advanced

Let's look at one final possibility. Often it is useful to group data into categorical groups, like *continent*, rather than numerical ones. We could try doing the same thing

```python
plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = df['continent'], marker = '.')
```
but we end up with the following error:

![image](https://user-images.githubusercontent.com/118239146/205770911-2d822a17-3388-403c-902e-d56d4d755cff.png)

This occurs because the colour argument `c = ` is expecting either a list of colours or a list/array of numbers. Before, when we input year, it could take those numbers and apply them to a scale. For continent, we can't do that. Instead, we'll need to assign a number to each continent. Through `pandas`, we can do this.

1. Specify the data type as *categorical* (`df.dtypes` shows us that continent is an `object` - we actually want it to be `category`)
2. Assign a unique number to each category using `.codes` (actually, the numbers are already assigned, we're just accessing them)
3. Assign the colour in the scatterplot to these numbers
4. Create the label

Firstly, we'll assign the continents to a new variable, changing the datatype to 'category'
```python
con = df['continent'].astype('category')
```
Next, we can access and assign to a variable a unique list of numbers applied to those categories through
```python
numcon = con.cat.codes
```
> We can use `cat.` because the datatype is categorical. `cat.codes` accesses the list of indices

We can now group the data by continent

```python
graph = plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = numcon, marker = '.')
```
> Notice that we assigned the plot to a variable, `graph`. This is very important as it allows us to access the colours for the legend.

Finally, we need to create the legend. Let's quickly examine what a legend requires: `plt.legend(*handles*,*labels*, ... )`. The first argument is a list of *handles* - the things to display, like colours, sizes or lines. The second argument is a list of *labels* - the text corresponding to each handle.

To access the handles, we'll use the function `legend_elements()`
```python
colours = graph.legend_elements()[0]
```
`<your plot>.legend_elements()` produces an array with the *handles* and *labels* which were given to the `plt.scatter` function. We only want the handles because the labels it gives numbers, not continents. We take the zeroth element (handles only) by inserting `[0]` afterwards. Effectively, this is a list of the colours.

For a corresponding list of the continents, we use
```python
labels = con.cat.categories
```
`cat.categories` operates in the opposite way to `cat.codes` - it takes the numbers and produces the strings. Putting this all together, our legend gets produced with `plt.legend(colours, labels, title = "Continent")`. All up, the code was

```python
con = df['continent'].astype('category')
numcon = con.cat.codes

graph = plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = numcon, marker = '.')

colours = graph.legend_elements()[0]
labels = con.cat.categories

plt.legend(colours,labels,title = "Continent")
```

![image](https://user-images.githubusercontent.com/118239146/205785213-0232ae6b-a428-40e2-9a70-26fd60f7828f.png)

Finally, it's worth noting that these colours are made to look continuous, but our data is categorical and unordered, so it's unhelpful. We can change our choice of colours with the `cmap` argument. A good choice is in the qualitative sets, let's use 'Accent'

```python
con = df['continent'].astype('category')
numcon = con.cat.codes

graph = plt.scatter(df['gdpPercap'],df['lifeExp'], s = 3, c = numcon, marker = '.', cmap = 'Accent')

colours = graph.legend_elements()[0]
labels = con.cat.categories

plt.legend(colours,labels,title = "Continent")
```

![image](https://user-images.githubusercontent.com/118239146/205787214-b874bdda-da57-4bef-bba2-e22c07da4676.png)

Don't worry if this felt too advanced - there are some complex functions at work, this definitely isn't the easiest process. Take some time to have a look at what the individual parts of the code are doing.

### Line Plot

Did you notice a trend when we added colour to our scatterplot earlier? It appears that greater life expectancy corresponds to a lighter colour - a later year. If we want to examine the relationship between year and life expectancy more closely, we could use a line plot.

We actually produced one of these before, in the first section. For simplicity, let's start by only considering Australia's life expectancy and seeing what happens. To do this, create a new dataframe which isolates the Australia data

``` python
df_aus = df[df['country'] == 'Australia']
```

Let's summarise this briefly
1. `df['country'] == 'Australia` is a dataframe which has a `False` for all countries except Australia, which it assigns `True`
2. By putting this inside `df[ ... ]`, we're telling python which data to access. We're effectively saying *No* to all countries except Australia.

If you run `df_aus`, you should see

![image](https://user-images.githubusercontent.com/118239146/206355035-134d4e0e-33d8-4a4d-97a1-ac6d97ece29f.png)

Now, let's plot the year and life expectancy variables with the `plt.plot` function

```python
plt.plot(df_aus['year'],df_aus['lifeExp'])
```

![image](https://user-images.githubusercontent.com/118239146/206355453-e98df791-2cae-4c46-ae03-d1c90f6d83dd.png)

It looks like life expectancy increases pretty linearly with year. Notice that there are kinks in the line, easier to see at the beginning. What `plt.plot` does by default is *interpolate* a straight line between each data point. With more data, the line becomes smoother. We would expect this data to be continuous, so we can leave an interpolated line between points. 

Let's give our graph some labels and a title. Don't forget to run these, with `plt.plot`, at the same time.
``` python
plt.xlabel('Year')
plt.ylabel('Life Expectancy (years)')
plt.title('Life expectancy in Australia since 1950')
```

![image](https://user-images.githubusercontent.com/118239146/206356085-2d071249-31d2-4447-977a-af056582a9a4.png)

Let's add a few more countries, our close neighbours New Zealand and Indonesia. We could create one dataframe with all three if we liked, but we'd have to isolate them anyway when we plot, so let's just create two new datasets for the two new countries, the same way that we did for Australia

``` python
df_nzl = df[df['country'] == 'New Zealand']
df_idn = df[df['country'] == 'Indonesia']
```

To plot the lines, we can simply replicate what we did above for Australia - `plt.plot(df_aus['year'],df_aus['lifeExp'])` - for the new datasets `df_png` and `df_nzl`. Together, this reads

``` python
plt.plot(df_aus['year'],df_aus['lifeExp'])
plt.plot(df_nzl['year'],df_nzl['lifeExp'])
plt.plot(df_idn['year'],df_idn['lifeExp'])
```

We can add a title and labels as usual

``` python
plt.xlabel('Year')
plt.ylabel('Life Expectancy (years)')
plt.title('Life expectancy since 1950')
```

![image](https://user-images.githubusercontent.com/118239146/206358190-d4869c0e-ea22-4ff5-b7d6-4554dbe1623c.png)

We have a problem - which line corresponds to which country? This plot needs a legend. To do this, let's first label our plots and then use the `plt.legend` function. 

Within each plot function, we want to add the argument `plt.plot( ... , label = ' <countryname> ')`. This assigns the label for the legend to each line that we plot. All we need to do then is call the legend function, `plt.legend()`.

``` python
plt.plot(df_aus['year'],df_aus['lifeExp'], label = 'Australia')
plt.plot(df_nzl['year'],df_nzl['lifeExp'], label = 'New Zealand')
plt.plot(df_idn['year'],df_idn['lifeExp'], label = 'Indonesia')

plt.legend()

plt.xlabel('Year')
plt.ylabel('Life Expectancy (years)')
plt.title('Life expectancy since 1950')
```

![image](https://user-images.githubusercontent.com/118239146/206359167-7c1c548c-1794-4181-a16e-dbc854986fbb.png)

> There are four different ways to create a legend:
> 1. As above, labelling our plots
> 2. Assigning the plots to variables instead of labelling them: `plt.legend([line1, line2, line3], ['Australia','New Zealand','Indonesia'])`
> 3. Like 2., but keeping the `label = ` argument in `plt.plot`: `plt.legend([line1, line2, line3])`
> 4. Like in the introduction, just listing the labels: `plt.legend(['Australia', 'New Zealand', 'Indonesia'])`
>
> While 4. might look like the simplest, it can cause the most errors and relies on remembering the order of your plots. Thus, 1-3 are advised. 2-3 allow specific lines to be included/excluded and the order they appear to be customised.

Let's move the legend to a different position in the graph for clarity.
```python
plt.legend(loc = 'lower right')
```

Finally, let's include one more line - the global average. This will require the use of the `groupby` function which comes with `pandas`. Let's look at the code and then break it down

```python
df_globalAvg = df.groupby('year', as_index = False).agg('mean')
```


By combining `groupby('year',` and `agg('mean')`, we group the data by year and take the average for each other column (i.e., average life expentancy in Africa, Asia ...; average population in Africa, Asia ...). `as_index = False` just allows us to access the `year` column later (otherwise it would be the index, which is harder to use).

Now, what we have is a new variable `df_globalAvg` which contains the average of variable for each year, averaged over all countries. To plot it, we'll simply use

``` python
plt.plot(df_globalAvg['year'], df_globalAvg['lifeExp'], label = "Global Average")
```

Combining this line with our previous plots, labels and legend, our graph looks like

![image](https://user-images.githubusercontent.com/118239146/206362467-7de1e241-b993-43f0-8adb-6e8f88a9ef43.png)

> If "Global Average" didn't appear in your legend, check that `plt.legend` occurs *after* all `plt.plot` functions. Otherwise, the legend is being created before all the plots have, and it won't include the ones created after it.

We can adjust the colours and styles of the line within the plot function as before, and like with the scatterplot. Let's just change our global average to be a black, dashed, thick line

``` python
plt.plot(df_globalAvg['year'],df_globalAvg['lifeExp'],'k--', linewidth = 3, label = "Global Average")
```

![image](https://user-images.githubusercontent.com/118239146/206362910-c41c7cdd-2723-4790-bb60-8efed8550312.png)


### Bar Chart

Now, let's look at the simple bar chart. It requires a categorical variable (like continent) and a numerical variable (like population). Firstly, let's simplify our data by just considering the year 2004.

``` python
df_bar = df[df.year == 2004]
```

Next, let's apply a `groupby` to summarise our data by continent.

``` python
df_bar = df_bar.groupby('continent', as_index = False).agg('mean')
```

This functions identically to the previous groupby in the line plot. Now, let's plot the bar chart. Instead of using `plt.plot`, this time we'll use `plt.bar`.

``` python
plt.bar(df_bar['continent'], df_bar['pop'])
```

As with before, let's add some labels and a title. Don't forget to run all the plot code at the same time by selecting it all before presing F9.

``` python
plt.xlabel('Continent')
plt.ylabel('Population')
plt.title('Population per continent in 2007')
```

![image](https://user-images.githubusercontent.com/118239146/204972798-b2abbd3b-687d-43bc-9bfd-552102109377.png)

Let's include a third variable and create a stacked bar plot. Here, we'll compare the population in 1952 with the population in 2004 for Europe and Americas, with the year on the x-axis. Creating two variables, but this time selecting Europe and Americas,

``` python
df_bar52 = df[df.year == 1952]
df_bar07 = df[df.year == 2007]
```

Next, let's apply the same groupby as before

``` python
df_bar52 = df_bar52.groupby('continent', as_index = False).agg('mean')
df_bar07 = df_bar52.groupby('continent', as_index = False).agg('mean')
```

Finally, we can plot our bar graph. This time, we actually want to plot two graphs, one for 1952 and one for 
