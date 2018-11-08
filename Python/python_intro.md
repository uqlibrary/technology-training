# Python with Spyder: introduction to data science

This hands-on course will get you started on using Python 3 and the Spyder IDE to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to install the Anaconda distribution. Make sure you download the Python 3 version: https://www.anaconda.com/download

## Introducing Python and Spyder

Python is a programming language that can be used to build programs but it can also be used to analyse data by importing a number of useful libraries.

We are using the Spyder IDE to interact with Python more comfortably.

Python can be used interactively, or we can build scripts and programs with it.

We will start by using the IPython console to work interactively.

## Maths

We can use Python like a calculator.

```python
1 + 1
2 * 3
4 / 10
6**3
9 % 2
```

## Variables

Variables will store data.

```python
favNumber = 42
otherNumber = 5.678
prod1 = favNumber * otherNumber
sentence = "Hello world!"
```

## Data types

Variables have different types. The most commons are `int` for integers, `float` for decimals and `string` for strings of characters.

> You can see the type of your existing variables in the "Variable explorer" pane.

We can also create lists, which will store several variables (not necessary of the same type). We need to use square brackets for that:

```python
myList = [1, 6, 4]
diverse = [3, "Hi!", 9.0]
```

Operators give different results depending on types. For example, we can use the `*` and `+` operators to repeat and append strings and lists:

```python
sentence + " How are you?"
myList + diverse
3 * myList
```

Another important data type is `bool`  for "boolean". Booleans are often are the result of checking for a condition. For example:

```python
1 == 1
1 == 2
1 != 2
5 > 7
bool1 = favNumber > otherNumber
```

There are other data types like tuples, dictionaries and sets, but we won't get into details today.

### Mutable vs immutable

Some data types are mutable (like lists and dictionaries), others are immutable (like integers, floats, strings and tuples).

### Indexing

Indexing in Python **starts at 0**, and does not include the upper bound. For example:

```python
myList[0]
myList[2]
myList[0:2]
```

## Functions

Some functions are built in and ready to use:

```python
len(myList)
min(myList)
max(myList)
sum(myList)
round(otherNumber)
```

> Notice how Spyder gives you hints about the available arguments after typing the function name?

```python
round(otherNumber, 2)
```

Functions always have parentheses behind their name, and they can take one or several **arguments**, or none at all.

## Finding help

To find help about a function, you can use the `help()` function, or a `?` after a function name:

```python
help(max)
print?
```

In Spyder, you can use the <kbd>Ctrl</kbd> + <kbd>I</kbd> keyboard shortcut to open the help in a separate pane.

For a comprehensive manual, go to the online documentation: https://docs.python.org/3/

For questions and answers, typing the right question in a search engine will usually lead you to something helpful. If you can't find an answer, StackOverflow is a great Q&A community: https://stackoverflow.com/questions/tagged/python

## Libraries

To do more with Python, it is easier to import extra libraries. Here are a few that are helpful:

```python
pi # throws an error
import math
math.pi
import math as m # give a shorter name
m.pi
from math import pi # only import what is necessary
pi
```

To install more: might need Pip, or to do it from the Anaconda Navigator.

```bash
python -m pip install SomePackage
```

### NumPy for arrays

Arrays are a data type introduced by NumPy. They can be very useful in many cases.

```python
import numpy as np
myArray = np.array([[1, 2], [3, 4]])
myArray * 2
```

### Pandas for data frames

Pandas introduces dataframes, which are often used to store two-dimensional data with different kinds of variables in each column.

```python
import pandas as pd
df = pd.DataFrame(columns = ("Name", "Age"))
df.loc[1] = "Josephine", 70
df.loc[2] = "Dilsah", 38
df
df.Age
```

### Matplotlib for visualisation

Matplotlib and Pyplot

Matplotlib is a large collection of data visualisation functions, and Pyplot is a subset of Matplotlib that contains essentials.

```python
import matplotlib.pyplot as plt
plt.plot([0,1,4,9,16])
```

This shows a plot in the IPython console.

> In a python shell, you might have to use the `plt.show()` command to show the plot.

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


## Loops

A "for loop" will execute something for each element of a list:

```python
friends = ["Mary", "Toya", "Fernand"]
for name in friends:
	print(name + "is a perfectly fine name")
```

### Comprehension

...

## Custom functions

We can create our own custom functions to reuse later on:

```python
def my_function(arg1, arg2):
	prod = arg1 * arg2
	sum = prod + 10
	return sum
my_function(3, 5)
```

We have to specify the function **name**, what **arguments** are available, what **operations** we do with them, and what the function **returns**.

## Example project

### Create a new project

Create a project with `Projects > New project...`

### Create a script

Click on  the "New file" icon, and save it as "process.py" in your project directory.

Remember to add comments (they start with the `#` symbol) to document your work.

To execute something from the script (the current line, or a selected block), use the <kbd>F9</kbd> keyboard shortcut.

### Import data

It is possible to read a CSV file with a Pandas function:

```python
import pandas as pd
data = pd.read_csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")
```

Some functions are useful to familiarise yourself with the data:

```python
data.shape
data.head()
data.tail()
```

### Analyse data

```python
data.describe()
data.groupby(by = "year").mean()
```

### Visualise data

```python
import matplotlib.pyplot as plt
plt.plot(data.gdpPercap, data.lifeExp, "go")
plt.plot(data.groupby(by = "year").mean().lifeExp)
```

You can save you plots as PNG by right-clicking on them. To save automatically with some code, you can use:

```python
plt.savefig("myPlot.pdf")
```

## Saving your work

You project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important. You can however save your variables as a `.spydata` file if you want to.

