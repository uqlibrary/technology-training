# Python with Spyder: introduction to data science

This hands-on course – directed at beginners – will get you started on using **Python 3** and the program **Spyder** to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to install the Anaconda Distribution, a data science platform for Windows, Linux and macOS. Make sure you download the Individual Edition with Python 3: https://www.anaconda.com/products/individual

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder.

## Introducing Python and Spyder

Python is a **programming language** that can be used to build programs (i.e. a "general programming language"), but it can also be used to analyse data by importing a number of useful modules.

We are using **Spyder** to interact with Python more comfortably. If you have used RStudio to interact with R before, you should feel right at home: Spyder is a program designed for doing data science with Python.

Python can be used **interactively** in a console, or we can build **scripts and programs** with it, making the most out of Spyder's code editor.

We will start by using the "Console" to work interactively.

## Maths

To start with, we can use Python like a calculator. Type the following **commands** in the console, and press <kbd>Enter</kbd> to **execute** them:

```python
1 + 1
2 * 3
4 / 10
```

After running each command, you should see the result as an output.

## Variables

**Variables** will store data. We need to give them a name, and assign a value to them with the `=` operator. For example:

```python
favNumber = 42
```

You can then retrieve the value by running the variable name on its own:

```python
favNumber
```

Let's create more variable, and reuse them:

```python
otherNumber = 5.678
prod1 = favNumber * otherNumber
sentence = 'Hello world!'
```

> Spyder helps us with extra panels and features apart from the Console. To see what variables you have created, look at the "Variable explorer" tab in the top right.

## Data types

Variables have different types. The most common are `int` for integers, `float` for decimals and `string` for strings of characters.

> You can see the type of your existing variables in the Variable explorer.

We can also create **lists**, which will store several variables (not necessarily of the same type). We need to use square brackets for that:

```python
myList = [1, 6, 4, 3, 9]
diverse = [3, 'Hi!', 9.0]
```

Lists are very flexible as they can contain any number of items, and any type of data. You can even nest lists inside a list, which makes for a very flexible data type.

Operators give different results depending on types. For example, we can use the `*` and `+` operators to repeat and append strings and lists:

```python
sentence + " How are you?"
myList + diverse
3 * myList
```

However, depending on the variable, some operations won't work:

```python
sentence + favNumber
```

There are other data types like booleans, tuples, dictionaries and sets, but we won't get into details today.

### Indexing

**Indexing** is useful to get only a part of a variable. In Python, indexing **starts at 0**. For example, see what these commands return:

```python
sentence[0]
sentence[6]
mylist[4]
```

You can use a range to index, but note that it will not include the upper bound in the returned values. For example:

```python
myList[0:4]
```

That command returns "elements from position 0 up to - but not including! - position 4."

## Functions

**Functions** are little programs that do specific jobs. Here are a few examples of built-in functions:

```python
len(myList)
min(myList)
max(myList)
sum(myList)
round(otherNumber)
```

Functions always have parentheses behind their name, and they can take one or several **arguments**, or none at all, depending on what they can do, and how the user wants to use them.

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

For a comprehensive manual, go to the [official online documentation](https://docs.python.org/).

For questions and answers, typing the right question in a search engine will usually lead you to something helpful. If you can't find an answer, [StackOverflow is a great Q&A community](https://stackoverflow.com/questions/tagged/python).

## Modules

To do more with Python, you could write new functions from scratch, but it is easier to import extra **modules** to extend its capabilities. For example, to access the `pi` constant:

```python
pi # throws an error: it does not exist!
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

Here, we present a few modules that are very important for data science with Python, and which are already available in the Anaconda distribution.

### NumPy for arrays

Arrays are a data type introduced by `numpy`, a module with many functions useful for numerical computing.

For example, you can convert the list we created before to then do mathematical operations on each one of its elements:

```python
import numpy as np
myArray = np.array(myList)
myArray * 2
```

### Pandas for dataframes

`pandas` introduces dataframes, which are often used to store two-dimensional datasets with different kinds of variables in each column. If your data is stored as a spreadsheet, you probably want to import it with a pandas function.

Here is an example of creating a pandas dataframe from scratch, populating it by hand:

```python
import pandas as pd
df = pd.DataFrame(columns=['Name', 'Age'])
# populate the dataframe:
df.loc[1] = 'Josephine', 70
df.loc[2] = 'Dilsah', 38
df
df.Age # access a specific variable
```

> You can double-click on a dataframe in the Variable explorer to explore it in a separate window.

### Matplotlib for visualisation

`matplotlib` is a large collection of data visualisation functions, and `pyplot` is a submodule of `matplotlib` that contains essentials.

```python
import matplotlib.pyplot as plt
plt.plot(myList)
```

This shows a plot in the Plots tab of Spyder.

> In a Python shell, you might have to use the `plt.show()` command to show the plot.

The default look is a line plot that joins all the points, but we can style a plot with only a few characters:

```python
# blue circles
plt.plot(myList, 'bo')
# green squares, dashed line:
plt.plot(myList, 'gs--')
```

Extra arguments can be used to style further:

```python
# red, diamonds, solid line; change width of line and size of diamonds:
plt.plot(myList, 'rd-', linewidth=3, markersize=10)
```

To find out about the styling shorthand and all other arguments, look at the documentation:

```python
plt.plot?
```

## Example project

A project is useful to keep everything related to one job all contained in one directory.

### Create a new project

Create a project with `Projects > New project...`. You can name this one "python_intro" for example.

### Create a script

A script is a simple text file that contains code. It is useful to:

* write code more comfortably
* store clearly defined steps in a chronological order
* share a process with peers easily
* make your work reproducible

Click on  the "New file" icon, and save it as "process.py" in your project directory.

Remember to add comments (they start with the `#` symbol) to document your work: this will be useful if you share your work with others, or even for your future self!

To execute something from the script (the current line, or a selected block), use the <kbd>F9</kbd> keyboard shortcut (or the white "Run" button).

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
data = pd.read_csv('https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv')
```

> `pandas` contains many functions for interpreting a variety of file formats. Start typing `pd.read_` to see what is available.

Now that we have stored our dataset as a variable, we can print the dataset to the console:

```python
data
```

The console conveniently shows us only the beginning and end of the dataframe.

We can also use the "dot notation" to create commands that are useful to explore the data:

```python
data.shape # size of the dataframe (an attribute)
data.head() # first few rows (a method)
data.head(10) # change the behaviour of the method
data.tail() # last few rows
data.country # single variable
```

Variables have **attributes** and **methods** attached to them, depending on the data type. Here, `shape` is an attribute, i.e. a static characteristic of the variable, whereas `head()` is a method, i.e. a function that can often take arguments.

### Analyse data

Let's now learn a bit more about our data. The `describe()` method gives us summary statistics for our numerical data:

```python
data.describe()
```

To create a customised summary, we can string different methods one after the other. Here, we first group by year to then get the yearly mean of the numerical columns:

```python
data.groupby('year').mean()
```

### Visualise data

We can visualise our data with `matplotlib`. First, let's visualise the relationship between gross domestic product per capita (`gdpPercap`) and life expectancy (`lifeExp`) with a scatterplot:

```python
import matplotlib.pyplot as plt
plt.plot(data.gdpPercap, data.lifeExp, 'g.')
```

We add the data as two arguments, which are understood as what we put on the x and y axes respectively.

We can now add labels with extra functions:

```python
plt.plot(data.gdpPercap, data.lifeExp, 'g.')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Live expectancy (years)')
```

> Make sure that you execute all the lines of code that relate to one plot *together*. When you need to execute many lines together, you might want to start using **cells** in your script: you can start a new cell with a `#%%` line, and execute the current cell with the keyboard shortcut <kbd>Ctrl</kbd> + <kbd>Enter</kbd>.

#### Saving plots

You can save you plots as PNG by right-clicking on them. To save automatically with some code, you can add the following line to the visualisation block:

```python
plt.savefig('gdp_vs_life_exp.pdf')
```

A PDF is a great option for a visualisation in vector format.

You can change the extension in the filename to save in a different format. For example, for a PNG file with a higher definition than the default:

```python
plt.savefig('gdp_vs_life_exp.png', dpi=600)
```

#### Challenge 2: Visualise mean life expectancy over the years

1. How can we reuse previous code to visualise how mean life expectancy evolved over the years?
1. Try changing the look of the plot to a magenta dotted line.

#### Solution

We can reuse the same summary as before, but adding the attribute of the right column we are interested in:

```python
plt.plot(data.groupby('year').mean().lifeExp, 'm:')
```

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a `.spydata` file if you want to (for example, if it takes a lot of time to process your data).
