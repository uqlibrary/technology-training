# Intermediate data visualisation in python with seaborn

This session takes an intermediate look at data visualisation in python with the package seaborn. If you haven't completed [the introductory session](https://github.com/camwest5/technology-training/blob/ef4ed737c36d975cffd7672ee3a8ba3c7fcb6853/Python/seaborn_intro/seaborn_intro.md), it is strongly advised you work through that material first, as the fundamentals of plotting with seaborn are covered there. This session continues from the foundation built in the introductory session and explores different, more specific forms of visualisation, using facets, regressions and other plotting types.

## Setup

The easiest way to use Python 3, seaborn and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

### Create a project

In order to keep everything nicely contained in one directory, and to find files more easily, we need to create a project.

-   Projects -\> New project...
-   New directory
-   Project name: "python_seaborn_intermediate"
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

Here we can see that our data is separated into seven variables (columns):

1. `total_bill`
2. `tip`
3. `sex`
4. `smoker`
5. `day`
6. `time`
7. `size`

with 244 rows. It looks like this data contains statistics on the tips that a restaurant or cafe received in a week.

We can visualise different aspects of this data, and we will have different options depending on the types of variables we choose. Data can be categorical or numerical, and ordered or unordered, leading to a variety of visualisation possibilities. If you would like to explore this more, check out [From data to Viz](https://www.data-to-viz.com/), a tool which helps you to find the best option.

In [the introductory session](https://github.com/camwest5/technology-training/blob/ef4ed737c36d975cffd7672ee3a8ba3c7fcb6853/Python/seaborn_intro/seaborn_intro.md) we explored the fundamentals of plotting with seaborn and some of the possible data visualisations tools available. Now, let's look at some more advanced possbilities that we can use.

## Facets

When data visualisations include multiple separate plots, where the difference in plots corresponds to a variable but the $x$ and $y$ axes stay the same, they are called facets. A common example is a series of otherwise identical plots for different snapshots in time or comparisons between categorical variables, such as population in various countries, with each country given by a separate facet in the overall figure.

The advantage of facetting is that each facet is a relatively 'clean' plot and comparison across the facetting variable is simple. This is quite easily achieved in seaborn, the steps are as follows

1. Use the function `sns.FacetGrid( ... )` to create the overall figure with the number of facets we want. These will appear as empty axes.
2. Assign the FacetGrid to a variable `facet1 = sns.FacetGrid( ... )`
3. Use the function `facet1.map_dataframe( ... )` to *map* a plot into each facet.

Let's walk through the process. Firstly, let's examine the `FacetGrid()` command

```python
sns.FacetGrid(data = <the dataset>, row = "<variable>", col = "<variable>", hue = "<variable>", ... )
```

Above is a summary of some of the important parameters (but by no means all of them) which we can use in the `FacetGrid()` function. We are always required to pass a dataset into the first argument, so let's do that and see what happens

```python
sns.FacetGrid(data = tips)
```

![image](https://user-images.githubusercontent.com/118239146/209023410-bbb1870f-05e0-4157-97e1-e89f039b30c5.png)

As you can see, a blank plot has been created. Since we didn't tell it how many facets to produce (using `row = ` and `col = `), it has only produced one, and since we haven't used `.map_dataframe()`, nothing has been plotted.

Let's choose to facet our columns by the `day` variable. To do this, we use

```python
sns.FacetGrid(data = tips, col = "day")
```

![image](https://user-images.githubusercontent.com/118239146/209023677-d8c1ac89-257b-4380-9fd4-31f0464be6be.png)

As you can see, there are now four separate plots, which correspond to the four days in our dataset (Thur, Fri, Sat, Sun). We'll see some labels when we map the data.

For now, let's not worry about our `row = ` field and map some data. We'll start by examining the `map_dataframe()` function

```python
<A FacetGrid>.map(<plotting function>, x ="<variable>", y ="<variable>")
```

In the first argument, we put an *axes-level* plotting function. This is the type of plot that will be plotted in each facet. For the rest, these are the inputs that will be passed to the plotting function.

> The plotting function **must** be an *axes-level* function (i.e., **not** `sns.relplot()`, `sns.displot()` or `sns.catplot()`). This is because the FacetGrid is already a *figure-level* plotting function, so we can only draw directly onto the axes, which is what an *axes-level* plot does. If we use a *figure-level* plot, it will make a new figure each time, producing four separate images. 
> 
> As a reminder, axes level plots include:
> - `sns.lineplot()`
> - `sns.boxplot()`
> - `sns.scatterplot()`
> - etc.

Let's make each facet a scatterplot comparing the total bill and tip size. First, we need to assign our FacetGrid from before to a variable

``` python
facet_1 = sns.FacetGrid(data = tips, col = "day")
```

And now we can run our mapping function

> Both lines **must** be run at the same time

``` python
facet_1 = sns.FacetGrid(data = tips, col = "day")
facet_1.map_dataframe(sns.scatterplot, x = "total_bill", y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/209025746-05ca1a2f-0259-4ce9-8928-cfca538458a4.png)

As with before, we can group by `hue = ` to include another variable. Let's include the `smoker` variable with colour. Note that we want to do this in the `FacetGrid()` function, since that manages the whole figure.

``` python
facet_1 = sns.FacetGrid(data = tips, col = "day", hue = "smoker")
facet_1.map_dataframe(sns.scatterplot, x = "total_bill", y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/209027915-db2910dd-855e-426b-a9f6-d4d44f6959f3.png)

Since we're grouping by colour, we'll need a legend too. Normally, this appears automatically, but not for FacetGrids. To produce the legend, we need to include a new line of code, `facet_1.add_legend()`.

``` python
facet_1 = sns.FacetGrid(data = tips, col = "day", hue = "smoker")
facet_1.map_dataframe(sns.scatterplot, x = "total_bill", y = "tip")
facet_1.add_legend()
```

![image](https://user-images.githubusercontent.com/118239146/209028621-30becd2a-4616-4161-8e59-cd19ffa56709.png)

> If you would prefer to group by `style = ` or `size = `, then you will need to do that in the `map_dataframe()` function instead. This has the disadvantage of not giving the legend a title, which is achieved by altering the legend function to read `facet_1.add_legend(title = "<insert title here>")`

Finally, we can also include a set of facets for the row. Let's use the `sex` variable

``` python
facet_1 = sns.FacetGrid(data = tips, row = "sex", col = "day", hue = "smoker")
facet_1.map_dataframe(sns.scatterplot, x = "total_bill", y = "tip")
facet_1.add_legend()
```

![image](https://user-images.githubusercontent.com/118239146/209028647-62257ff9-8aff-4ae9-9749-a4d2dc71f568.png)

As you can see, some facets work better than others, and its worth being prudent on how many variables to include. Having too many rows and columns could potentially hide trends that together are more obvious, as it can make the data sparse.

These plots can be customised further. If you would prefer to group by something other than `hue = `

> **A technical note for general plotting** - all *figure-level* plots are actually 1 x 1 FacetGrids! They have additional customisation options, however, so unless multiple plots like the above are required, `relplot()`, `catplot()` or `displot()` should be used instead.

## Regressions



## More graph types

### Geospatial data

## Conclusion


