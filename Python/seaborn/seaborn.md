# Python data visualisation with seaborn

This is an intermediate course which delves into data visualisation in python with the **seaborn** module. Beginning with some basic plot types and importing data using **pandas**, different visualisation possibilities are explored. Some customisation and technical details are also looked at near the end.

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

Before we begin, let's just quickly examine how the seaborn syntax works. There are two ways of plotting that seaborn offers: *figure-level* and *axes-level*. At the end we'll explore the differences in much greater depth, but here's a small summary.

Figure level plots interact with the *figure*, which is in essence the canvas or white space on which everything else is drawn. There are three functions for figure level plots

1. `sns.relplot( ... ` for relational plots like scatter or line graphs.
2. `sns.displot( ...` for distributions like histograms.
3. `sns.catplot( ...` for categorical plots, like bar graphs and boxplots.

Axes level plots interact with the *axes*, which is in essence the space allocated on the canvas for the actual plot. There are many axes level functions, such as `sns.lineplot( ...`, `sns.boxplot( ...`,  `sns.scatterplot( ...`. We won't make use of these, but we will examine them near the end. The diagram below summarises how the figure and axes level plots connect.

![image](https://user-images.githubusercontent.com/118239146/208792174-ff4ec064-ad30-47ff-99b4-45afd4bd7c63.png)


The syntax for most plots is as follows:

``` python
sns.plotfunction(data = <dataset>, x = <variable>, y = <variabale>, kind = <plottype>, ... )
```
> Note that the argument `kind = ` is only necessary for *figure level plots*. At the end, we'll look into greater depth at the differences between *figure* and *axes* level plots.

In essence, the steps are
1. Direct python to the seaborn library with `sns.`
2. Call the chosen plotting function, e.g. `sns.lineplot(`, `sns.boxplot(` etc.
3. Input the dataset, `sns.plotfunction(data = <dataset>`
4. Choose the variable(s), `sns.plotfunction(data = <dataset>, x = "<variable>", y = "<variable>",`
5. Specify your plot type (if figure level), `sns.plotfunction(data = <dataset>, x = "<variable>", y = "<variable>", kind = <plottype>,`
6. Customise colours, sizes, shapes, all other features, with more arguments `sns.plotfunction(data = <dataset>, x = <variable>, y = <variabale>, kind = <plottype>, ... )`

### Bar and Count Plots

Let's try this now with one of the simplest plots possible: `sns.catplot()` with `kind = "count"`. This is a bar chart, with one categorical variable on the x-axis and a count of the number of times they occur on the y-axis. Let's examine the **day** variable. The steps are:

1. Direct python to seaborn: `sns.`
2. Call our plotting function: `sns.catplot(`
3. Input our data: `sns.catplot(data = tips`
4. Choose our variable(s): `sns.catplot(data = tips, x = "day"`
5. Choose our plot type: `sns.catplot(data = tips, x = "day", kind = "count")`

``` python
sns.catplot(data = tips, x = "day", kind = "count")
```

![image](https://user-images.githubusercontent.com/118239146/208792365-400f2764-da02-4099-bc88-d5cb49551a32.png)

There it is! It looks like Friday is their quietest day.

There are a few ways we can add more information to bar plots. One common way is to group them by a third categorical variable. Let's add the variable **sex** to the data.

To produce a grouped plot by introducing the new variable we'll need to specify a way of identifying this variable, since both axes are already in use. A great tool is to group by *colour*, which we can do by specifying a variable to the argument `hue = `.

``` python
sns.catplot(data = tips, x = "day", kind = "count", hue = "sex")
```

![image](https://user-images.githubusercontent.com/118239146/208792423-8777cd70-2b65-48b4-b997-e0064c1ab333.png)

`kind = "count"` provides a simple and efficient way of producing a bar plot when the y-axis is the frequency of a variable, however, it is restricted to these limitations. Often, it is desirable to display a different variable on the y-axis, and for this, seaborn offers the `kind = "bar"` type.

The `kind = "bar"` argument needs our `sns.catplot()` function to have two variables, one categorical and one numerical. Let's compare our variables **day** and **total bill**. This time, we need to include the `y = ` argument too.

```python
sns.catplot(data = tips, x = "day", y = "total_bill", kind = "bar")
```

![image](https://user-images.githubusercontent.com/118239146/208792601-49cee96f-49fd-4b21-9f9d-9bb787e01219.png)

Notice that seaborn has automatically taken the average **total bill** for each day of the week, and displayed confidence intervals too (the black lines). By inputting the variable **total bill**, seaborn recieves 244 data to plot, but can only plot 4 bars, so it has to aggregate them somehow. By default it takes the mean, however, the method can be specified with the `estimator = ` argument. For example, we could take the *sum*, displaying the total they earned each day.

```python
sns.catplot(data = tips, x = "day", y = "total_bill", kind = "bar", estimator = sum)
```

![image](https://user-images.githubusercontent.com/118239146/208792588-8af0ba47-241a-4560-ad6b-924f5a7315a8.png)

> Specifically, the input for `estimator = ` should be a function that seaborn can apply to each variable. Others include `min`, `max`, `median`, etc., and there are lots include in the mathematics module `numpy`, which should be imported as `import numpy as np`

The errorbars aren't so helpful here, so let's remove them. There are two ways to do this, depending on your version of seaborn:

1. If you have a version older than v0.12, then use `ci = 0`
2. If you have version v0.12 or later, then use `errorbar = None`

If you're not sure, try both and see which one works. Let's also group by our variable **smoker**.

``` python
sns.catplot(data = tips, x = "day", y = "total_bill", kind = "bar", hue = "smoker", estimator = sum, ci = 0) # Prior to v0.12
sns.catplot(data = tips, x = "day", y = "total_bill", kind = "bar", hue = "smoker", estimator = sum, errorbar = None) # v0.12 or later
```

![image](https://user-images.githubusercontent.com/118239146/208792695-86a3ae84-1738-4143-b725-4f67f18e076b.png)

### Scatter plots

Now, let's look at scatter plots. Perhaps the most common and versatile, these take two numerical variables and are called by the function `sns.relplot()` with `kind = "scatter"`. 
> There is also a variation, using the function `kind = "strip"`, which takes one categorical and one numerical variable, but for now we will just examine scatter plots.

This time, let's compare **total bill** and **tip** to see if there might be a relationship between them.

```python
sns.relplot(data = tips, x = "total_bill", y = "tip", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208792911-affb90bd-d1ee-4e1b-8585-0cbe9867be22.png)

Clear correlation looks a little dubious, but there might be a general trend. Like before, we can categorise by colour using `hue = `. Let's use our **time** category.

```python
sns.relplot(data = tips, x = "total_bill", y = "tip", hue = "time", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208792986-9115757e-8a78-49da-8da1-dc1adfa20cfe.png)

Since each data point is plotted on the graph, each can be given the colour directly. seaborn recognises these as categorical variables and assigns corresponding colours (blue and orange are good for a discrete variable). Let's see what happens when we instead use **size**.

```python
sns.relplot(data = tips, x = "total_bill", y = "tip", hue = "size", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208793039-67a229df-42e5-4c7d-a7e1-0f8742cc82b5.png)

Here, seaborn chooses a different colour palette, one which suits ordered data. It is important to choose a colour palette that matches your data. We can do that with the `palette = ` argument. One of the [seaborn tutorials](https://seaborn.pydata.org/tutorial/color_palettes.html#palette-tutorial) offers a list of available palettes and some guidance on which ones to choose. Let's use *flare*.

``` python
sns.relplot(data = tips, x = "total_bill", y = "tip", hue = "size", palette = "flare", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208793115-9643aadb-fcc8-4b95-8354-a221bfc0ad84.png)

Instead of using colour, there is also the possibility of altering the size of the markers, using `size = `. Let's see what happens if we use size instead of colour.

``` python
sns.relplot(data = tips, x = "total_bill", y = "tip", size = "size", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208793160-82c5eea4-c814-4c74-b4f6-1489d01d907f.png)

While each point has been grouped by size, it isn't a very clear choice for this plot. In general, size doesn't work particularly well when there are lots of points. We could also group by marker style, using `style = `. Let's use colour to group by **size** and marker to group by **sex**.

``` python
sns.relplot(data = tips, x = "total_bill", y = "tip", hue = "size", style = "sex", palette = "flare", kind = "scatter")
```

![image](https://user-images.githubusercontent.com/118239146/208793213-bb9e1fe8-c187-4746-b610-f9209d40eac2.png)

Here, the marker style has been changed for the variable **sex**. Again, there's probably too much information here for good visualisation, so making good, tactful use of `hue = `, `size = ` and `style = ` is very important.

### Line plots

Finally, let's look at line plots. Line plots are useful for visualising certain continuous numerical data, but typically where no two points occupy the same *x* value (or certain specific configurations, like circles), unlike our scatter plot above. Imagine trying to draw a line between each data point above! Unfortunately, our **tips** data doesn't contain any suitable variables, so we'll need a new set. Let's import the dataset `flights`.

``` python
flights = sns.load_dataest("flights")
```

Let's have a look at what it contains

``` python
flights
```

![image](https://user-images.githubusercontent.com/118239146/207772174-f57f083b-d860-4448-bf3f-4925deab8efa.png)

Here, we can see that there are monthly passenger numbers from Jan 1949 to Dec 1960. Line plots are another type of relational plot, so we again want to use `sns.relplot()`, this time with `kind = "line"`. Let's see what happens if we assign year to the x-axis and passengers to the y-axis

``` python
sns.relplot(data = flights, x = "year", y = "passengers", kind = "line")
```

![image](https://user-images.githubusercontent.com/118239146/208793359-57c0801c-b78d-4350-ae69-6bd68f6ccca6.png)

Great! Clearly, passenger numbers increased steadily during the 50s. But hold on, our data has a different value for every month. What's going on? Well, seaborn recognises that each year has 12 entries, and aggregates them. By default, it takes the mean, but like before we can specify the method we want to use with the `estimator = ` argument. 

> Most statistical methods require the `numpy` module. After `import numpy as np`, the functions can be called, such as `np.median`, `np.mean`. For now, let's just leave it as the mean.

You'll also notice a faint blue shaded zone - this is the error/confidence interval. As with before, this can be adjusted using either

1. The `errorbar = ` argument (for versions v0.12+)
2. The `ci = ` argument (for versions before v0.12)

The default is a 95% confidence interval.

Let's narrow things down. Say we wanted to examine just December - we can do this by creating a new variable

``` python
flights_dec = flights[flights.month == "Dec"]
```

If you run `flights_dec`, you'll see that it only includes December's statistics

![image](https://user-images.githubusercontent.com/118239146/207773790-4ef6bfb0-fe12-44da-bcb2-c56c5df33051.png)

We can plot this data too, replacing the `data = ` argument:

``` python
sns.relplot(data = flights_dec, x = "year", y = "passengers", kind = "line")
```

![image](https://user-images.githubusercontent.com/118239146/208793397-a9207dc9-742f-4d51-9e44-2b58858d7676.png)

Now, we see that seaborn has removed the confidence interval because it hasn't had to do any statistical aggregation - every data point is plotted. What if we wanted to include multiple months? Well, let's look at our original dataset, grouping each month by `hue = `

``` python
sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
```

![image](https://user-images.githubusercontent.com/118239146/208793439-c2358bb1-94e6-416a-822a-519a74df79fb.png)

This looks a little too crowded because we have so many months, but we can still make some interesting observations. It looks like the middle of the year (cooler colours) sees consistantly more passengers than the start/end of the year (warmer colours).

## Customisation

We may want to customise of the features on our plot, such as axis labels, legend, tick marks and scale.

### Axis labels and titles

There are two ways to change axis labels. Firstly, notice that all our labels until now have been the name of the variable we feed in, so if we change the variable names, the plot will naturally follow. If we don't want to adjust the variables, though, we can make use of the `set()` function to set our various preferences. Firstly, we need to assign our plot to a variable. Let's use the flights plot we just produced.

``` python
flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
```

This assigns our plot to the variable `flights_plot`. If you look in variable explorer, it should be there as a `FacetGrid` object (this is how seaborn uses figures). Now, we want to assign the labels. Let's capitalise the current labels manually with the following code

```python
flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers")
```

> Both lines must be run **at the same time**

![image](https://user-images.githubusercontent.com/118239146/208797206-4819c7b0-440d-4829-8eff-3312e5a73988.png)

There we go - our axes have been renamed. Now, let's also include a title. Note that often figures are captioned in the text they are inserted into (such as a journal article) which means they do not require a title like this.

To include a title, we simply include `title = ` inside our `flights_plot.set(` function.

```python
flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
```

![image](https://user-images.githubusercontent.com/118239146/208797348-b2a78825-9ab2-400b-a30b-3ac98d052614.png)

A full list of parameters which can be set using `.set` are available [here](https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.set.html), which is the matplotlib documentation for the `.set()` command, since this is what seaborn is using.

We can also change the legend title. To do so, we'll need to access the legend that is stored in our `flights_plot` variable and change its title. We can do that by

1. Accessing the legend with `flights_plot._legend`
2. Changing the title by adding `.set_title("Month"`

All together, with our previous code, this reads

``` python
flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
flights_plot._legend.set_title("Month")
```

![image](https://user-images.githubusercontent.com/118239146/208798645-995bdcb6-0174-4703-84af-9feabc9cfe12.png)

### Themes

The function `sns.set_theme( ... )` includes a number of aesthetic possibilities for your plotting. First, let's just see what happens when we run it without any arguments, using our plot from before.

```python
sns.set_theme()

flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
flights_plot._legend.set_title("Month")
```

![image](https://user-images.githubusercontent.com/118239146/208799969-d422da48-03d3-4d44-88d7-58cb374442ef.png)

Notice that our graph now has a background with gridlines.

> `sns.set_theme() is global and will affect all seaborn and matplotlib plots produced

Let's examine some of the different arguments available

#### `sns.set_theme(context = "scaling", ... )`

The first parameter is `context = `, which defines the scaling of the graph. Here, you can either specify your own parameters in a `dict` (advanced) or choose from one of four presets

- `paper`
- `notebook`
- `talk`
- `poster`

> The default is always `notebook`

Let's see what happens if we choose `paper`

``` python
sns.set_theme(context = "paper")

flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
flights_plot._legend.set_title("Month")
```

![image](https://user-images.githubusercontent.com/118239146/208799766-544cb451-6bee-4ab4-8665-23d551c2f665.png)

Notice that all the text is smaller, suited for a journal article. `talk` and `poster` both increase the scale, with poster being the largest.
  
#### `sns.set_theme(style = "style choice", ... )`

Next we have `style = `, which defines the background colour and gridline choices. Again, it is possible to specify your own parameters in a `dict` (advanced), but there are also five presets available

- `darkgrid`
- `whitegrid`
- `dark`
- `white`
- `ticks`

Let's choose `whitegrid`

``` python
sns.set_theme(style = "whitegrid")

flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
flights_plot._legend.set_title("Month")
```

![image](https://user-images.githubusercontent.com/118239146/208800930-e0fca77f-fd59-4e32-be2f-03d10ed26c70.png)

Here, the background has become white and gridlines are still present.

#### `sns.set_theme(palette = "palette choice", ... )`

Here we have `palette = `, which we used before on our scatterplot. As mentioned earlier, it is important to choose a colour palette that corresponds to the data choice. There are [many options]([https://seaborn.pydata.org/generated/seaborn.color_palette.html#seaborn.color_palette](https://seaborn.pydata.org/tutorial/color_palettes.html#palette-tutorial)) available. However, since we are using a colour in our plotting function, it will override the general setting, so we won't be able to see any difference with the flight data we have been using.

Finally, there are a [few other options](https://seaborn.pydata.org/generated/seaborn.set_theme.html#seaborn.set_theme) available too, such as `font = ` for the font. 

## Behind the scenes

Now that we've examined a few different plot types, it's delving a little deeper into what seaborn is doing behind the scenes, because it will allow us to have greater control over the visualisations we ultimately create.

The module seaborn is built 'on top' of another - matplotlib - which is a popular data and mathematics visualisation module, modelled closely on MATLAB. seaborn actually takes all our commands and produces the plots using matplotlib. This is helpful for two reasons. Firstly, all matplotlib functions will work and apply to seaborn plots, so the modules are compatible (although we won't make use of this). Secondly, the structure of plots is the same, so understanding how seaborn plots are structured is the same as understanding how matplotlib plots are structured.

Let's examine how seaborn and matplotlib plots are structured. Firstly, what's called a `figure` class is created - essentially, this is like a variable which could contain any image. This is like a canvas for our plot. Inside the `figure` an `axes` object is created - this is like a blank set of axes drawn onto the canvas. It's inside the `axes` object that the plot is produced and customised. 

There are two ways that seaborn could produce a plot through matplotlib. After interpreting our inputs (the data, variables, other features), seaborn can either pass the information directly into an `axes` object, or interact with the `figure` class (the canvas itself). As you might expect, seaborn offers us both ways.

### Figure vs Axes level plots

Figure level plots interact directly with the figure, using a seaborn method that doesn't quite align with normal matplotlib plotting. Since it manipulates the canvas, it means that individual plots have easier customisation, such as legend position and multiple plots. These are the plots we have made so far.

Axes level plots interact directly with the drawn axes on a figure produced by matplotlib. Since they draw onto the axis, they cannot edit anything on the rest of the canvas. They interact easier with matplotlib and are marginally simpler to produce, but offer less simple customisability. They're most useful for complex figures which combine many different plots onto a single axes object, or when integration with matplotlib is particularly important.

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are not saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a .spydata file if you want to (for example, if it takes a lot of time to process your data).

Figures can be saved in one of two ways. Firstly, you can simply right click on the image and click save. Alternatively, seaborn offers the `.savefig()` command for figure level plots. Let's save our current figure in that way

``` python
sns.set_theme(style = "whitegrid")

flights_plot = sns.relplot(data = flights, x = "year", y = "passengers", hue = "month", kind = "line")
flights_plot.set(xlabel = "Year", ylabel = "Passengers", title = "Passengers per year since 1949")
flights_plot._legend.set_title("Month")

flights_plot.savefig("flights.png")
```

If you press the *Files* tab next to *Variable explorer* (not next to *Edit*), you should see your file saved there.

## Conclusion

As we have seen, seaborn is a powerful tool for visualising data efficiently and aesthetically. A range of other plot types and customisation is available, for inspiration have a look at the [seaborn gallery](https://seaborn.pydata.org/examples/index.html). If any of the content here was too challenging, you have other related issues you'd like to discuss or would simply like to learn more, we the technology training team would love to hear from you. You can contact us at

training@library.uq.edu.au

## Resources

- [Official seaborn documentation](https://seaborn.pydata.org/index.html)
- [Official matplotlib documentation](https://matplotlib.org/stable/index.html)
- Our [compilation of useful Python links](https://github.com/uqlibrary/technology-training/blob/master/Python/useful_links.md)
