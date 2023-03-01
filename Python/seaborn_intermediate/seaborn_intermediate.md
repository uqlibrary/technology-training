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

seaborn is a Python module useful for statistical data visualisation. It is a high-level module built upon another module called matplotlib. Effectively, seaborn is a more user friendly module which uses matplotlib in the background to do all the work. It is also possible to use matplotlib in directly, although it is less intuitive. Matplotlib is modelled on MATLAB, so if you have MATLAB experience, then it should be easier to use.

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

### Setting the theme

Let's set our theme so that our plots look nice. You can choose whichever preferences you would like (see Customisation -> Themes in [the introductory session](https://github.com/camwest5/technology-training/blob/ef4ed737c36d975cffd7672ee3a8ba3c7fcb6853/Python/seaborn_intro/seaborn_intro.md)). Our preference for today is

```python
sns.set_theme(context = "talk", style = "ticks")
```

### Cells

In this session, we're going to write a single plot over multiple lines for readability. To run those lines together, we can section off areas of our code to run called cells.

To start a cell, use the code `#%%`. You should see a horizontal bar marking the start of the cell and highlighted section of code (the cell). The cell will end before the next `#%%`, so if you need to close it too, place one at the end. Press **Ctrl + Return** to run the code in the cell, or Shift + Return to run the cell and move to the next. In our session we'll exclusively use **Ctrl + Return**.

> Note that running a cell is equivalent to highlight the code and pressing F9 (run selection or current line). Cells are advantageous as they both save time and allow us to rerun the same highlighted code.

![image](https://user-images.githubusercontent.com/118239146/222050338-6ce48d9f-0c66-40d8-b38e-0f4f3e3bebef.png)

In this session, we'll include the **start** of a cell in every snippet, but not the end. If you have code which follows the snippet, you may need to insert an extra `#%%` to start a new cell below.

In [the introductory session](https://github.com/camwest5/technology-training/blob/ef4ed737c36d975cffd7672ee3a8ba3c7fcb6853/Python/seaborn_intro/seaborn_intro.md) we explored the fundamentals of plotting with seaborn and some of the possible data visualisations tools available. Now, let's look at some more advanced possbilities that we can use.

## Multiple plot figures

### Facets

When data visualisations include multiple separate plots, where the difference in plots corresponds to a variable but the $x$ and $y$ axes stay the same, they are called facets. For example, is a series of otherwise identical plots for different snapshots in time or comparisons between categorical variables, such as population, with each country given a different facet in the overall figure.

The advantage of facetting is that each facet is a relatively 'clean' plot and comparison across the facetting variable is simple. This is quite easily achieved in seaborn, simply by using the `row = ` and `col = ` parameters in any figure level plots.

Let's start by producing a scatter plot comparing the **total bill** and **tips** variables. 

``` python
#%%
sns.relplot(data = tips, 
            x = "total_bill", 
            y = "tip", 
            kind = "scatter")
```

> Remember to press Ctrl + Return to run the current cell

![image](https://user-images.githubusercontent.com/118239146/209038219-fa92f665-ba74-45fd-8cf0-dc4c498c62f9.png)

Now, let's separate each day into columns. To do this, we introduce `col = "day"`

``` python
#%%
sns.relplot(data = tips, 
            x = "total_bill", 
            y = "tip", 
            kind = "scatter",
            col = "day")         
```

![image](https://user-images.githubusercontent.com/118239146/209038390-f0bd351d-cc4f-4431-9400-46bfbe4e95f7.png)

As you can see, there are now four separate plots, which correspond to the four days in our dataset (Thur, Fri, Sat, Sun).

As with before, we can group by `hue = `, `size = ` or `style = ` to include another variable. Let's include the `smoker` variable with colour.

``` python
#%%
sns.relplot(data = tips, 
            x = "total_bill", 
            y = "tip", 
            kind = "scatter",
            col = "day",
            hue = "smoker")         
```

![image](https://user-images.githubusercontent.com/118239146/209038414-27f02805-3a7d-448f-ae7d-71f94ac7c2df.png)

We can also include a set of facets for the row. Let's use the `sex` variable

``` python
#%%
sns.relplot(data = tips, 
            x = "total_bill", 
            y = "tip", 
            kind = "scatter",
            col = "day",
            row = "sex",
            hue = "smoker")         
```

![image](https://user-images.githubusercontent.com/118239146/209038435-f5f838ac-cf64-454c-9473-734e693d860d.png)

As you can see, some facets work better than others, and its worth being prudent on how many variables to include. Having too many rows and columns could potentially hide trends that together are more obvious, as it can make the data sparse.

We're free to add any of the customisation that we could in [the introductory session](https://github.com/camwest5/technology-training/blob/ef4ed737c36d975cffd7672ee3a8ba3c7fcb6853/Python/seaborn_intro/seaborn_intro.md), as we are using the same function. Facetting works in the same way for any `sns.displot()` or `sns.catplot()` graphs too.

### Pair plots

Pair plots appear very similar to facet plots, and are in a way a subset of facetting. They are often a useful way of summarising all the numerical data. To understand them, let's first create one. 

``` python
#%%
sns.pairplot(data = tips)
```

![image](https://user-images.githubusercontent.com/118239146/209038580-67b7f144-9e6d-464a-b2df-fae6ac5fe5d4.png)

This is a large plot. What pairplot does is produce scatterplots for all numerical variables, on the non-diagonal facets, and produce histograms on the diagonal. These histograms show the count for the variable they represent (e.g., the centre histogram shows the distribution of tips).

This pairplot looks a little odd because the `size` variable is discrete. Nevertheless, it is still useful.

We can customise the pairplot in a few ways. Firstly, as with all our plots, we can group by colour, using `hue = `. Grouping by time,

```python
#%%
sns.pairplot(data = tips, 
             hue = "time")
```

![image](https://user-images.githubusercontent.com/118239146/209038688-c3e08a8e-6056-4f7f-863d-71e3dc3dfafe.png)

Notice that the distributions have changed from histograms to *layered kernel density estimates* (KDEs). If we want to go back to histograms, we could try with the parameter `kind = "hist"`

```python
#%%
sns.pairplot(data = tips, 
             hue = "time", 
             kind = "hist")
```

![image](https://user-images.githubusercontent.com/118239146/209038743-face6cab-3d76-4280-b028-8bd78f6177a9.png)

Althought this also changes our scatterplots to bivariate histograms. If we only want to adjust the diagonal, we can instead use `diag_kind = "hist"`

```python
#%%
sns.pairplot(data = tips, 
             hue = "time", 
             diag_kind = "hist")
```

![image](https://user-images.githubusercontent.com/118239146/209038900-0e59b2bd-4b8f-46bd-b7d1-384b4d67bfc4.png)

This yields stacked histograms and scatterplots. Let's say we wanted to have a bivariate histogram on the off diagonals and a KDE plot on the diagonal. We could do that by specifying `kind = "hist"` and `diag_kind = "kde"`

```python
#%%
sns.pairplot(data = tips, 
             hue = "time", 
             kind = "hist",
             diag_kind = "kde")
```
![image](https://user-images.githubusercontent.com/118239146/209039889-a11e51aa-67a2-4f94-9882-e2462e09ce24.png)

Finally, we can use the `corner = True` parameter to only visualise half of the figure

```python
#%%
sns.pairplot(data = tips, 
             hue = "time", 
             kind = "hist",
             diag_kind = "kde",
             corner = True)
```

> Don't forget a capital 'T' in `True`

![image](https://user-images.githubusercontent.com/118239146/209040294-de90e885-f2e9-4747-9ca1-ca164c7dd1cb.png)

### Joint plots

A third type of multi-plot visualisation is possible with the `sns.jointplot()` function. This visualisation plots distribution graphs along the axes of a bivariate plot (like a scatter plot or bivariate histogram). We can again compare our **total bill** and **tip** variables,

``` python
#%%
sns.jointplot(data = tips,
              x = "total_bill",
              y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/209043071-40ea07de-6646-4f97-8e15-e5f1b05f9aec.png)

If we group by a variable, say **smoker**, again using `hue = `, we see (like in the pair plots) a KDE distribution instead of a histogram

``` python
#%%
sns.jointplot(data = tips,
              x = "total_bill",
              y = "tip",
              hue = "smoker")
```

![image](https://user-images.githubusercontent.com/118239146/209043307-8600c823-0b81-4d76-bb90-41b31142b6b3.png)

We can change our plot types using the `kind = ` parameter as before. The options available are

- `scatter`, a scatter plot with histograms
- `kde`, a univariate and bivariate KDE plot
- `hist`, a univariate and bivariate histogram
- `hex`, a univariate and bivariate histogram with hexagonal bins
- `reg`, a scatter plot with a linear regression and histograms with a KDE
- `resid`, the residuals of a linear regression with histograms

Let's use `hist`. 

``` python
#%%
sns.jointplot(data = tips,
              x = "total_bill",
              y = "tip",
              hue = "smoker",
              kind = "hex")
```

![image](https://user-images.githubusercontent.com/118239146/209045268-2d1887d6-067c-4153-af25-a1721cfbb981.png)

Joint plots provide a powerful tool for analysing data, particularly different grouped data, because the distribution plots on the margin indicate whether specific variables group in certain sections. In this case, it looks like the smoker and non-smoker data are both distributed around the same means, with similar tails, indicating that there may not be a relationship between smoker and total bill or smoker and tip. One of the most important tools for this form of analysis, however, is linear regression, which we will now explore.

## Regressions

There are two plotting functions which will allow us to produce a regression easily in seaborn: `sns.lmplot` and `sns.regplot`. As you might expect, one is figure-level and one is axes-level. For consistency (and functionality), this session uses `sns.lmplot`, but the other functions similarly.

Let's start by taking the same data and producing a linear regression.

```
#%%
sns.lmplot(x = "total_bill",
           y = "tip",
           data = tips)
```

![image](https://user-images.githubusercontent.com/118239146/222052904-70438175-4038-4572-95eb-28815f81d87b.png)

Here, `sns.lmplot` has automatically produced a scatter plot with a linear regression, including a confidence interval. Clearly much of our data is falling outside the confidence interval, so its not necessarily the best model.

As with the facetting examples, we can use `hue`, `col` and `row` to include additional variables. For example,

```
#%%
sns.lmplot(x = "total_bill",
           y = "tip",
           data = tips,
           hue = "smoker",
           col = "day",
           row = "time")
```

assigns the `hue` parameter (colour) to the variable **smoker**, and facets according to `col = "day"` and `row = "time"`.

![image](https://user-images.githubusercontent.com/118239146/222053794-5c71b8b3-96a0-455e-acdc-70ad96533210.png)

*Unlike* our facetting examples, however, these all include a linear regression. By applying a regresion to facetted results, we may observe relationships which are otherwise hidden in the large sample. That being said, facetting has drawbacks, as it can also hide broader group trends. Depending on your data, both or either may be relevant.

The function `sns.lmplot` would be pretty limited if it only offered linear regressions. Luckily, there are a few different methods available. To change method requires including `<method_name> = True` as an attribute in the plotting function, like `hue = ` and `data = `. The possibilities are,

| Method                | Attribute             | Notes |
| ------                | ----                  | ----- |
| Linear                | N/A (default or all `False`) | Standard linear regression. | 
| Polynomial            | `order = <int>`       | Polynomial regression with specified order, e.g. `order = 3` is a third order polynomial fit. | 
| Logistic              | `logistic = True`     | For binary variable $y$. Computer intensive, so reduce `n_boot` or `ci` if too slow. |
| Lowess                | `lowess = True`       | Locally weighted linear regression. No confidence intervals (in seaborn). |
| Log-linear            | `logx = True`         | Linear regression of the form $y \sim \log(x)$, but still displays on the $x-y$ axes. Could highlight an exponential relationship. |

> For the logistic and lowess models, seaborn uses `statsmodels`, a python statistics module, behind the scenes.

Let's produce 

## More plot types

### Distributive plots

### Niche plots

### Geospatial data

## Creating palettes

## Conclusion


