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

## Distributive plots

You may remember that there are three functions for normal, figure-level plots:
- `sns.relplot` (relational plots, e.g. scatter plots, line plots)
- `sns.catplot` (categorical plots, e.g. bar plots, box plots)
- `sns.displot` (distributions, e.g. histograms, kernel density distributions)

We are yet to use the third type, `sns.displot`. These are distributions, which provide an alternative way to analyse data.

### Histograms

To begin with, let's produce a histogram showing us the distribution of the variable **total bill**

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            kind = "hist")
```

![image](https://user-images.githubusercontent.com/118239146/222332709-77ad7ce6-4530-43da-a6c9-372215244fbc.png)

Immediately, we can see that the data is skewed, with a mean likely higher than the median due to a longer rightward tail.

> Despite appearances, a histogram is *not* a bar plot, found in `sns.catplot`. A histogram is a distribution, where changing the number of bins (columns) can potentially reveal different results. Notice that **total bill** is numerical, something which wouldn't be possible with a bar plot (we would have a column for every number - that's a lot of columns!)

#### Changing statistic

While it appears simple, there are a lot of features available in `sns.displot`. In our previous plot, the statistic is *count* - the total number of observations. We can change that, using `stat = `, to any of the following options

- `count` - count, as seen above
- `frequency` - the number of observations divided by the bin width
- `probability` - normalises the observations such that bar heights sum to 1
- `density` - normalises such that the total area of the bars (all together) sums to 1

Depending on your version, you may also have access to

- `proportion` - almost identical to `probability`
- `percent` - normalises such that bar heights sum to 100

Let's use `probability` to normalise the histogram

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability")
```

![image](https://user-images.githubusercontent.com/118239146/223629130-4d800b6b-05b9-41d4-a01f-3cdaaf37e685.png)

#### Changing bin properties

Next, we can adjust the bin (column) properties, such as width, range and aesthetics.

Using `bins`, we can specify the number of bins used. Above, there are 14 - notice that if we reduce the number, perhaps to 7, we could draw some different conclusions.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability",
            bins = 7)
```

![image](https://user-images.githubusercontent.com/118239146/222336719-5f3a9363-154c-47ce-bfc4-96f9da018adc.png)

See how here the tail only decreases, while in the previous plot, the last bin is higher? Whatever choice we make, by grouping in bins, we always risk masking some data between bins. Similarly, we can increase the number to something high, say 50.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability",
            bins = 50)
```

![image](https://user-images.githubusercontent.com/118239146/222337133-d8db7b57-961a-454e-bf68-1399f8d5e344.png)

Here, the visualisation may be too sparse, making it harder to draw conclusions. Finding the best number of bins can be achieved algorithmically or manual aesthetic choice.

#### Cumulative histogram

Instead of visualising the individual observations, we could instead choose to view the cumulative observations. This may provide clarity on the general curve of the data, and could be especially useful for temporal data.

Creating a cumulative histogram is as simple as including the parameter `cumulative = True`.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability",
            cumulative = True)
```

![image](https://user-images.githubusercontent.com/118239146/222338046-474c2817-8661-4aa8-b94e-0ea35d8655a5.png)

Here we can see that there 60% of the data is below $20, just by looking at the cumulative distribution.

#### Overlaying histograms and histogram types

By including a third variable with `hue = `, we can produce multiple histograms separated by colour. Let's introduce the variable **time**.
```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability")
```

![image](https://user-images.githubusercontent.com/118239146/222338742-e777839b-9921-4d3f-b9b6-0154c2f70add.png)

Automatically, the times overlay. It looks like diners spend more in the evening than at lunch. The attribute `multiple = ` determines how the two plots are displayed:

- `"layer"` - overlayed, as above
- `"dodge"` - bars are interwoven/side-by-side, like prison bars
- `"stack"` - bars are stacked
- `"fill"` - stacked bars which all reach 1, displaying the probability of having one over another

Additionally, the attribute `element = ` provides alternatives to bars which still display the same visualisation. These possibilities are,

- `"bars"` - as above.
- `"step"` - a continuous outline, maintaining the vertical structure of the bins.
- `"poly"` - a continuous outline formed by straight lines between data points.

Let's combine `multiple = "stack"` and `element = "step"`
```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability",
            multiple = "stack",
            element = "step")
```

![image](https://user-images.githubusercontent.com/118239146/222344591-aea7408a-1943-4f0d-be93-f10ef1493bd2.png)

Finally, it is also possible to overlay a KDE (kernel density estimate) distribution too, using `kde = True`. We'll examine the KDE on its own now.

### Two more distributions

#### Kernal Density Estimate

KDE (kernel density estimate) plots are smooth distributions which fit statistical data. Their smoothness may reflect reality in a way histograms don't, although it's important to acknowledge that KDEs are estimations and will have some distortion of the data. Normally, they provide an accurate picture of the sample distribution.

KDE plots are produced by changing the attribute `kind` in our `sns.displot` function.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "kde")
```

![image](https://user-images.githubusercontent.com/118239146/222624804-6a14e7f0-19e2-4a07-bbfd-4b4f2316c18a.png)

Notice that the $y$-axis displays the *density* - the KDE, as its name suggests, estimates the probability density function, from which probabilities can be found. There are some attributes which allow the user to adjust specifics of the estimation to best account for the data, those can be found [here](https://seaborn.pydata.org/generated/seaborn.kdeplot.html).

#### Empirical Cumulative Distribution Function

The ECDF (empirical cumulative distribution function) plots provide a cumulative visualisation of the data. These are unique in that they require no aggregation or estimation - no bins or fitting function, the ECDF just plots observations as a running total.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "ecdf")
```

![image](https://user-images.githubusercontent.com/118239146/222625637-2630b793-8641-4252-8ff6-86343b0e4802.png)       

### Bivariate plots

The final feature of distributive plots we'll examine is bivariate plotting. For plots of `kind = "hist"` and `kind = "ecdf"`, it is possible to also pass a `y` attribute. Let's use **tip** with a histogram.

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            y = "tip",
            kind = "hist")
```

![image](https://user-images.githubusercontent.com/118239146/222626832-85b0c6c3-c49d-4d42-b4a0-0232ef5f048d.png)

These plots have all the options of their univariate counterparts, such as changing the bins, introducing another variable, etc.

We can also create a bivariate KDE plot changing `kind = "kde"`

```python
#%%
sns.displot(data = tips,
            x = "total_bill",
            y = "tip",
            kind = "kde")
```

![image](https://user-images.githubusercontent.com/118239146/222627073-e1d7c104-cddd-4be7-a047-629e56936880.png)

Visualised here are contour lines, corresponding to values of the estimated probability. Contours tend to circle around maxima.

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
              kind = "hist")
```

![image](https://user-images.githubusercontent.com/118239146/209045268-2d1887d6-067c-4153-af25-a1721cfbb981.png)

Joint plots provide a powerful tool for analysing data, particularly different grouped data, because the distribution plots on the margin indicate whether specific variables group in certain sections. In this case, it looks like the smoker and non-smoker data are both distributed around the same means, with similar tails, indicating that there may not be a relationship between smoker and total bill or smoker and tip. One of the most important tools for this form of analysis, however, is linear regression, which we will now explore.

## Regressions

There are two plotting functions which will allow us to produce a regression easily in seaborn: `sns.lmplot` and `sns.regplot`. As you might expect, one is figure-level and one is axes-level. For consistency (and functionality), this session uses `sns.lmplot`, but the other functions similarly.

Let's start by taking the same data and producing a linear regression.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/222052904-70438175-4038-4572-95eb-28815f81d87b.png)

Here, `sns.lmplot` has automatically produced a scatter plot with a linear regression, including a confidence interval. Clearly much of our data is falling outside the confidence interval, so its not necessarily the best model.

As with the facetting examples, we can use `hue`, `col` and `row` to include additional variables. For example,

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
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
| Lowess                | `lowess = True`       | **Lo**cally **we**ighted **s**catterplot **s**moothing. No confidence intervals (in seaborn). |
| Log-linear            | `logx = True`         | Linear regression of the form $y \sim \log(x)$, but still displays on the $x-y$ axes. Could highlight an exponential relationship. |

> For the logistic and lowess models, seaborn uses `statsmodels`, a python statistics module, behind the scenes.

Let's produce a polynomial regression of order 3.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           order = 3)
```

![image](https://user-images.githubusercontent.com/118239146/222330468-33829909-d58c-463c-83c6-6416a514ec52.png)

Alternatively, we could try the lowess model.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           lowess = True)
```
> Note that if you try to use `order = ` and another model in the same plot, e.g. `logistic = True`, it will return an error, as order is only for polynomial regressions.

![image](https://user-images.githubusercontent.com/118239146/222330559-686daf0b-afd0-44a7-a018-6a13515b2b47.png)

This summarises the function `sns.lmplot`, providing some of the most common regression models. If you wanted to use a different model, a statistics package would need to be imported and used for the model. You could still then plot those results with seaborn, if you wanted to maintain visual consistancy.

### Residual plot

In the same family as the above is the residual plot, which is a scatterplot of the *residuals* from a linear regression performed in the background. If you're unfamiliar with residuals, they are a way of determining how well a regression fits, and where that fit is best.

To produce a residual plot, we use the function `sns.residplot`. Let's use it on our previous data.

```python
#%%
sns.residplot(data = tips,
              x = "total_bill",
              y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/222331779-c451bda3-dd57-48bc-8131-75cb7bcea091.png)

## Categorical plots

There are four categorical plots that we'll look at now, box plots, violin plots, swarm plots and point plots. To produce these, we'll move to the function `sns.catplot`.

> Bar plots were covered in the [introductory session](https://github.com/uqlibrary/technology-training/blob/bc4007cd0d9d7cf3b13af635cb23f8deb4e7657c/Python/seaborn_intro/seaborn_intro.md).

### Box plots

Box plots are a classic categorical plot, showing key statistics about the dataset. To produce one, we can simply use

```python
#%%
sns.catplot(data = tips,
            kind = "box")
```

![image](https://user-images.githubusercontent.com/118239146/222629853-02cff570-4a17-44f4-b9b9-09b087aadaf5.png)

Boxplots are composed of a box (coloured), whiskers (extending from the box in each direction) and outliers (diamond points). The box represents the middle quartiles (between 25%-75%, half of the data), displaying the median with the interior line. The whiskers display the outer quartiles (between 0-25% and 75-100%), with outliers excluded from the statistical calculations and displayed as points.

Obviously, the observations don't scale too well between variables here, so let's isolate a specific variable, by assigning one to $x$. Let's use **size**.

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            kind = "box")
```

![image](https://user-images.githubusercontent.com/118239146/223629761-0b1b3730-4527-43fd-9aad-e8a61a7663a7.png)

Next, we can introduce another variable with `y = `. Let's use **day**.

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            kind = "box")
```

![image](https://user-images.githubusercontent.com/118239146/222630961-62fb0e7c-7ddd-4cdb-8566-4b5f1743078d.png)

Here four boxplots display the data for each day. We can introduce a third variable using `hue`, let's include **smoker**.

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "box")
```

![image](https://user-images.githubusercontent.com/118239146/222631311-7f089c14-d343-4e93-8a6d-13a35c2f7466.png)

Bear in mind, boxplots don't display the number of data points, and by separating by day and smoker status, we have probably reduced our groups to small sample sizes which may be stastically unreliable.


### Violin plots

Violin plots are similar to boxplots, but use a smooth design rather than a box, to emphasise the distribution.

To produce a violin plot like our previous boxplot, we simply need to change the attribute `kind = "violin"`.

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "violin")
```

![image](https://user-images.githubusercontent.com/118239146/223583729-1cbb017e-9982-4f0c-a716-8080d8ad9803.png)

Violin plots replace the boxes with Kernel Density Estatimates (remember them?) for the underlying distribution. Note that these may be misleading if there are only a small number of data points. We can check that by using the attribute `inner`

With the `inner` attribute, there are five options:

| Code | Description |
| --- | --- |
| `inner = "box"`       | Default, shows the box and whisker plot inside |
| `inner = "quartile"`  | Shows the quartiles, with markers at 25% Q1, 50% (median) and 75% Q3 |
| `inner = "point"`     | Shows individual data entries as points |
| `inner = "stick"`     | Shows individual data entries as lines |
| `inner = None`        | Shows nothing |

Let's use `inner = "stick"`.

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "violin",
            inner = "stick")
```

![image](https://user-images.githubusercontent.com/118239146/223584570-94668713-3c54-4f8b-b7a6-f01e7362959e.png)

As you can see, some plots have more data points than others. In particular, the *Friday, Yes* plot has only a handful of points - the plot may be unreasonably smooth.

### Swarm plots

Finally, let's examine swarm plot. These are a way of creating scatterplot-like visualisations for categorical data that adjusts the position of individual points to present all observations. We can create one with the variables we used previously (let's exclude `hue` for now)

```python
#%%
sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            kind = "swarm")
```

![image](https://user-images.githubusercontent.com/118239146/223587178-68e6bd43-4fd0-422a-9b55-9a9010b5d1c8.png)

Swarm plots give a clear qualitative indication of the spread of data.

## Conclusion

That was a lot of different plots. Here is a summary of what we just covered.

| Topic | Description |
| --- | --- |
| **Cells**             | By using `#%%`, we can create a cell which runs all the code within it using ctrl + return |
| **Distributive Plots**| Histograms, KDE plots and ECGF plots all allow analysis of data distributions, which can be modified by statistic, bin dimensions, etc. |
| **Faceting**          | With `col = ` and `row = ` we can facet by variables within our dataset. *Joint plots* and *Pair plots* offer special types of facet plots. |
| **Regressions**       | The function `sns.lmplot( ... )` offers a number of regression options |
| **Categorical Plots** | A number of categorical plots are available (e.g. box plots, swarm plots) which provide alternative visualisations for categorical data |

Below is a summary of *all* available* plots in seaborn. Most of these have been examined in either the introductory session or this one, however, there are some which we have not yet looked at. The [seaborn documentation](https://seaborn.pydata.org/api.html) and [tutorials](https://seaborn.pydata.org/tutorial.html) provide desciptions and advice for all available plots.

> *As of v0.12.2

### Relational Plots

| Plot Name | Code | Notes |
| --- | --- | --- |
| Scatter Plot          | `sns.relplot( ... , kind = "scatter", ... )` | Requires numerical data |
| Line Plot             | `sns.relplot( ... , kind = "line", ... )` | Requires numerical data | 

### Distributions

| Plot Name | Code | Notes |
| --- | --- | --- |
| Histogram             | `sns.displot( ... , kind = "hist", ... )` | Can be univariate (`x` only) or bivariate (`x` and `y`)|
| Kernal Density Estimate| `sns.displot( ... , kind = "kde" , ... )` | Can be univariate (`x` only) or bivariate (`x` and `y`)|
| ECDF* | `sns.displot( ... , kind = "ecdf", ... )` | |
| Rug Plot              | `sns.displot( ... , rug = True , ... ) `  | Combine with another `sns.displot`, plots marginal distributions | 

> *Empirical Cumulative Distribution Functions

### Categorical Plots

| Plot Name | Code | Notes |
| --- | --- | --- |
| Strip Plot            | `sns.catplot( ... , kind = "strip" , ... )`| Like a scatterplot for categorical data |
| Swarm Plot            | `sns.catplot( ... , kind = "swarm" , ... )`| |
| Box Plot              | `sns.catplot( ... , kind = "box" , ... )` | Choose `x` and `y` carefully |
| Violin Plot           | `sns.catplot( ... , kind = "violin" , ... )` | |
| Enhanced Box Plot     | `sns.catplot( ... , kind = "boxen", ... )`  | A box plot with additional quantiles |
| Point Plot            | `sns.catplot( ... , kind = "point" , ... ) ` | Like a line plot for categorical data | 
| Bar Plot              | `sns.catplot( ... , kind = "bar" , ... ) `    | Aggregates data | 
| Count Plot            | `sns.catplot( ... , kind = "count" , ... )` | A bar plot with the total number of observations |


### Other Plots
| Plot Name | Code | Notes |
| --- | --- | --- |
| Pair Plot             | `sns.pairplot( ... )` | A form of facetting |
| Joint Plot            | `sns.jointplot( ... )` | |
| Regressions           | `sns.lmplot( ... )` | |
| Residual Plot         | `sns.residplot( ... )` | The residuals of a linear regression |
| Heatmap               | `sns.heatmap( ... )`  | |
| Clustermap            | `sns.clustermap( ... )` |


If you have any further questions, would like to learn about more python content or would like support with your work, we would love to hear from you at training@library.uq.edu.au

## Resources

- [Official seaborn documentation](https://seaborn.pydata.org/index.html)
- [Official matplotlib documentation](https://matplotlib.org/stable/index.html)
- Our [compilation of useful Python links](https://github.com/uqlibrary/technology-training/blob/master/Python/useful_links.md)

