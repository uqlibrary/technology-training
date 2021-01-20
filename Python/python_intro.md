# Python with Spyder: introduction to data science

This hands-on course – directed at beginners – will get you started on using **Python 3** and the program **Spyder** to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to install the Anaconda Distribution, a data science platform for Windows, Linux and Mac OS X. Make sure you download the Individual Edition with Python 3: https://www.anaconda.com/products/individual

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder.

## Introducing Python and Spyder

Python is a **programming language** that can be used to build programs (i.e. a "general programming language"), but it can also be used to analyse data by importing a number of useful modules.

We are using **Spyder** to interact with Python more comfortably. If you have used the RStudio IDE to interact with R before, you should feel right at home: Spyder is a program designed for doing data science with Python.

Python can be used **interactively** in a console, or we can build **scripts and programs** with it, making the most out of Spyder's code editor.

We will start by using the IPython console to work interactively.

## Maths

We can use Python like a calculator.

```python
1 + 1
2 * 3
4 / 10
```

Some binary operators might differ from other languages, like exponent and modulus:

```python
6**3
9 % 2
```

## Variables

**Variables** will store data. We need to give them a name, and assign a value to them with the `=` operator.

```python
favNumber = 42
otherNumber = 5.678
prod1 = favNumber * otherNumber
sentence = "Hello world!"
```

## Data types

Variables have different types. The most commons are `int` for integers, `float` for decimals and `string` for strings of characters.

> You can see the type of your existing variables in the "Variable explorer" pane.

We can also create **lists**, which will store several variables (not necessarily of the same type). We need to use square brackets for that:

```python
myList = [1, 6, 4, 3, 9]
diverse = [3, "Hi!", 9.0]
```

Operators give different results depending on types. For example, we can use the `*` and `+` operators to repeat and append strings and lists:

```python
sentence + " How are you?"
myList + diverse
3 * myList
```

Another important data type is `bool`, for "boolean". Booleans often are the result of checking for a condition, and can only be one of two values: `True` or `False`. For example:

```python
1 == 1
1 == 2
1 != 2
5 > 7
bool1 = favNumber > otherNumber
```

There are other data types like tuples, dictionaries and sets, but we won't get into details today.

### Indexing

**Indexing** in Python **starts at 0**, and does not include the upper bound. For example:

```python
sentence[0]
sentence[6]
myList[0:4]
```

## Functions

Some **functions** are built in and ready to use:

```python
len(myList)
min(myList)
max(myList)
sum(myList)
round(otherNumber)
```

Functions always have parentheses behind their name, and they can take one or several **arguments**, or none at all.

Here, we use two arguments to modify the default behaviour of the `round()` function:

```python
round(otherNumber, 2)
```

> Notice how Spyder gives you hints about the available arguments after typing the function name?

## Finding help

To find help about a function, you can use the `help()` function, or a `?` after a function name:

```python
help(max)
print?
```

In Spyder, you can use the <kbd>Ctrl</kbd> + <kbd>I</kbd> keyboard shortcut to open the help in a separate pane.

For a comprehensive manual, go to the official online documentation: https://docs.python.org/3/

For questions and answers, typing the right question in a search engine will usually lead you to something helpful. If you can't find an answer, StackOverflow is a great Q&A community: https://stackoverflow.com/questions/tagged/python

## Modules

To do more with Python, it is easier to import extra **modules**. For example, to access the `pi` constant:

```python
pi # throws an error
import math # this module contains the pi constant
math.pi # we have to specify where it comes from
import math as m # give a shorter name
m.pi
from math import pi # only import what is necessary
pi
```

`math` is part of the "Python standard library". You can see all the functions and constants available in the `math` module here: https://docs.python.org/3/library/math.html

Python distributions like Anaconda already come with a number of useful extra modules for science.

### Installing extra modules

To install more modules, you might need to use `pip` (on most systems) or `conda` (if you use Anaconda or Miniconda) from the command line.

With `pip`, which will fetch the module from the [Python Package Index](https://pypi.org/) (PyPI):

```bash
pip install some-module
```

With `conda`, which will fetch the module from the Anaconda repository:

```bash
conda install some-module
```

Refer to the module's website to find what is recommended.

Here, we present a few libraries that are very central to data manipulation and analysis with Python.

### NumPy for arrays

Arrays are a data type introduced by `numpy`. They can be very useful in many cases.

```python
import numpy as np
myArray = np.array([[1, 2], [3, 4]])
myArray * 2
```

### Pandas for dataframes

`pandas` introduces dataframes, which are often used to store two-dimensional data with different kinds of variables in each column.

```python
import pandas as pd
df = pd.DataFrame(columns = ["Name", "Age"])
# populate the dataframe:
df.loc[1] = "Josephine", 70
df.loc[2] = "Dilsah", 38
df
df.Age # access a specific variable
```

### Matplotlib for visualisation

`matplotlib` is a large collection of data visualisation functions, and `pyplot` is a submodule of `matplotlib` that contains essentials.

```python
import matplotlib.pyplot as plt
plt.plot([0,1,4,9,16])
```

This shows a plot in the IPython console.

> In a Python shell, you might have to use the `plt.show()` command to show the plot.

We can style a plot with only a few characters:

```python
x = np.linspace(0, 15, 8)
y = x**2
# only blue circles
plt.plot(x, y, "bo")
# green, squares, dashes:
plt.plot(x, y, "gs--")
```

Extra arguments can be used to style further:

```python
# red, diamonds, line; change width of line and size of diamonds:
plt.plot(x, y, "rd-", linewidth = 3, markersize = 10)
```

## Example project

A project is useful to keep everything related to one job all contained in one directory.

### Create a new project

Create a project with `Projects > New project...`. You can name this one "python_intro" for examples.

### Create a script

A script is a simple text file that contains code. It is useful to:

* write code more comfortably
* store clearly defined steps in a chronological order
* share a process with peers easily
* make your work reproducible

Click on  the "New file" icon, and save it as "process.py" in your project directory.

Remember to add comments (they start with the `#` symbol) to document your work: this will be useful if you share your work with others, or even for your future self!

To execute something from the script (the current line, or a selected block), use the <kbd>F9</kbd> keyboard shortcut.

### Import data

It is possible to **read a CSV file with a `pandas` function**.

#### Challenge 1: Import data

Have a look at the documentation for the `read_csv()` function:

```python
import pandas as pd
pd.read_csv?
```

How could you use it to store the following dataset into a variable?

https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv

#### Solution

We have to create a variable, and store the output of the function inside it. No need to download the file first: `read_csv()` can read from a URL!

```python
data = pd.read_csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")
```

> `pandas` contains many functions for interpreting a variety of file formats. Start typing `pd.read_` to see what is available.

Now that we have stored our dataset as a variable, we can print the dataset to the console:

```python
data
```

The console conveniently shows us only the beginning and end of the dataframe.

We can also use the "dot notation" to create commands that are useful to explore the data:

```python
data.shape
data.head()
data.tail()
data.country
```

Variables have **attributes** and **methods** attached to them, depending on the data type. Here, `shape` is a method, i.e. a static characteristic of the variable, whereas `head()` is a method, i.e. a function that can often take arguments.

### Analyse data

Let's now learn a bit more about our data:

```python
data.describe()
data.groupby(by = "year").mean()
```

### Visualise data

We can visualise our data with `pyplot`. First, let's visualise the relationship between GDP per capita and life expectancy with a scatterplot:

```python
import matplotlib.pyplot as plt
plt.plot(data.gdpPercap, data.lifeExp, "go")
```

The default circles are quite big, so let's reduce their size:

```python
plt.plot(data.gdpPercap, data.lifeExp, "go", markersize = 1)
```

#### Challenge 2: Visualise mean life expectancy over the years

1. How can we reuse previous code to visualise how mean life expectancy evolved over the years?
1. Try changing the look of the plot to a magenta dotted line.

#### Solution

We can reuse the same summary as before, but adding the attribute of the right column we are interested in:

```python
plt.plot(data.groupby(by = "year").mean().lifeExp, "m:")
```

#### Saving plots

You can save you plots as PNG by right-clicking on them. To save automatically with some code, you can add the following line:

```python
plt.savefig("myPlot.pdf")
```

> Make sure that you execute the code that generates the plot *together* with the code that saves the file. When you need to execute many lines together, you might want to start using **cells** in your script: you can start a new cell with a `#%%` line, and execute the current cell with the keyboard shortcut <kbd>Ctrl</kbd> + <kbd>Enter</kbd>.

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a `.spydata` file if you want to (for example, if it takes a lot of time to process your data).

## Extras

Here are some extras that usually don't fit in this session, but that you might be interested in to go further with Python.

### Loops

A "for loop" will execute something for each element of a list:

```python
friends = ["Mary", "Toya", "Fernand"]
for name in friends:
	print(name + "is a perfectly fine name")
```

This will allow you to automate the boring repetitive tasks!

### Custom functions

We can create our own custom functions to reuse later on:

```python
def my_function(arg1, arg2):
	prod = arg1 * arg2
	sum = prod + 10
	return sum
my_function(3, 5)
```

We have to specify the function **name**, what **arguments** are available, what **operations** we do with them, and what the function **returns**.

### More visualisations

Executing several lines together will render everything on the same visualisation. See for example this code that plots two lines together, modifies axis ranges, adds a legend and styles axis labels with LaTex, and saves to pdf:

```python
plt.plot(x, y, "bo-", label = "High")
plt.plot(x, x**1.5, "gs--", label = "Low")
# we can use LaTex
plt.xlabel("$X$")
plt.ylabel("$Y$")
plt.legend(loc = "upper left")
# save plot
plt.savefig("hi-lo.pdf")
```

To create a histogram:

```python
x = np.random.normal(size = 1000)
plt.hist(x)
plt.hist(x, bins = 20)
```

We can join several plots on the same image with the `subplot()` function, which takes three numbers: the number of rows, number of columns, and position of the subplot.

```python
x = np.random.gamma(2, 3, 100000) # create data
plt.figure() # initialise
plt.subplot(221)
plt.hist(x, bins = 30)
plt.subplot(222)
plt.hist(x, bins = 30, cumulative = True)
plt.subplot(223)
plt.hist(x, bins = 30, density = True)
plt.subplot(224)
plt.boxplot(x)
```

> You can also use `subplot()` with three separate arguments, e.g. `subplot(3, 3, 7)`
