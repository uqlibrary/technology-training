# Python with Spyder: introduction to data science

This hands-on course will get you started on using Python 3 and the Spyder IDE to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to install the Anaconda distribution. Make sure you download the Python 3 version.

## Introducing Python and Spyder

Python is a programming language that can be used to build programs but it can also be used to analyse data by importing a number of useful libraries.

We are using the Spyder IDE to interact with Python more comfortably.

Python can be used interactively, or we can build scripts and programs with it.

We will start by using the IPython console to work interactively.

## Maths

We can use Python like a calculator.

## Variables

Variables will store data.

## Data types

Int, float, Strings

Booleans

Lists

Dict ??? Set ???

### Mutable vs immutable

### Indexing

Starts at 0, does not include upper bound.

## Functions

min

max

sum

round

len

## Finding help

help(max)

print?

Ctrl + I in Spyder

Online docs: https://docs.python.org/3/

Q&As: Stack Exchange and Stack Overflow

## Libraries

import math
math.pi

import math as m
m.pi

from math import pi
pi

To install more: might need Pip, or from the Anaconda Navigator.

```bash
python -m pip install SomePackage
```

### NumPy for arrays

import numpy as np

### Pandas for data frames

import pandas as pd

### Updates?

## Loops

For

While

### Comprehension



## Custom functions

def my_function(arg1, arg2):
	prod = arg1 * arg2
	return prod

## Example project

### Create a new project

Create a project with `Projects > New project...`

### Import data

with pandas

### Analyse data

...

### Visualise data

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
x = np.linspace(0, 10, 20)
y = x**2
# blue, circles, line
plt.plot(x, y, "bo-")
# green, squares, dashes:
plt.plot(x, y, "gs--")
```

Extra arguments can be used to style further:

```python
# red, diamonds, line; change width of line and size of diamonds:
plt.plot(x, y, "rd-", linewidth = 3, markersize = 6)
```

Executing several lines together will render everything on the same visualisation. See for example this code that plots two lines together, modifies axis ranges, adds a legend and styles axis labels with LaTex, and saves to pdf:

```python
plt.plot(x, y, "bo-", label = "High")
plt.plot(x, x**1.5, "gs--", label = "Low")
# we can use LaTex
plt.xlabel("$X$")
plt.ylabel("$Y$")
# change axis limits: [xmin, xmax, ymin, ymax]
plt.axis([-0.5, 10.5, -10, 120])
plt.legend(loc = "upper left")
# save plot
plt.savefig("hi-lo.pdf")
```

```python
x = np.random.normal(size = 1000)
plt.hist(x, density = True)
```

Modify the bins setting to have 25 bins between -5 and 5:

```python
plt.hist(x, density = True, bins = np.linspace(-5, 5, 26))
```

> Note that to define `n` bins, we need `n+1` numbers.


We can join several plots on the same image with the `subplot()` function, which takes three numbers: the number of rows, number of columns, and position of the subplot.

```python
x = np.random.gamma(2, 3, 100000) # create data
plt.figure() # initialise
plt.subplot(221)
plt.hist(x, bins = 30)
plt.subplot(222)
plt.hist(x, bins = 30, cumulative = True)
plt.subplot(223)
plt.plot(x)
plt.subplot(224)
plt.boxplot(x)
```

> You can also use `subplot()` with three separate arguments, e.g. `subplot(3, 3, 7)`


