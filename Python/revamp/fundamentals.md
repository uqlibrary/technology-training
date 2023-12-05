# Python with Spyder: introduction to data science

This hands-on course – directed at beginners – will get you started on using **Python 3** and the program **Spyder** to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

## Introducing Python and Spyder

Python is a **programming language** that can be used to build programs (i.e. a "general programming language"), but it can also be used to analyse data by importing a number of useful modules.

We are using **Spyder** to interact with Python more comfortably. If you have used RStudio to interact with R before, you should feel right at home: Spyder is a program designed for doing data science with Python.

We will start by using the **console** to work interactively. This is our direct line to the computer, and is the simplest way to run code. Don't worry about any unfamiliar language, fonts or colours - we can ignore most of it for now - all you need to know is that `In [1]: ... ` is code that we've sent to the computer, and `Out[1]: ... ` is its response.

### Maths

To start with, we can use Python like a calculator. Type the following **commands** in the console, and press <kbd>Enter</kbd> to **execute** them:

```python
1 + 1
2 * 3
4 / 10
5 ** 2
```

After running each command, you should see the result as an output.

## Variables

Most programming languages are like spoken language in that they have nouns and verbs - you have "things" and they "do things". In Python, we have **variables** and **functions**. We'll look first at variables, the nouns of Python, which store data.

To create a variable, we choose its name (e.g. `favNumber`) and assign (`=`) it a value (e.g. `42`):

```python
favNumber = 42
```

You can then retrieve the value by running the variable name on its own:

```python
favNumber
```

Let's create more variables. We can use the variable names in place of their values, so we can perform maths:

```python
otherNumber = 5.678
prod1 = favNumber * otherNumber
```

So far, we've only looked at numbers. If you click on the "variable explorer" tab, you should see two variables like these:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/f8e3a769-69b0-43df-a0f3-c8b00d307eaf)

Notice that the "Type" of `favNumber` is `int`, while the other is `float`. These are different **variable types** and can operate differently. `int` means integer, and corresponds to whole numbers, while `float` stands for floating point number, meaning decimals. You may occasionally encounter errors where you can only use one type.

Even simpler than numbers is the **boolean** type. These are either True or False (1 or 0), representing a single binary unit (bit).

```python
myBool = True
```

> In Python, the boolean values `True` and `False` **must** begin with a capital letter.

### Sequences

Let's look at variable types which aren't numbers. **Sequences** are variables which store more than one data point. For example, **strings** store a sequence of characters and are created with quotation marks `'<insert string>' ` or `"<insert string>"`:

```python
sentence = 'Hello world!'
```

We can also create **lists**, which will store several variables (not necessarily of the same type). We need to use square brackets for that:

```python
myList = [38, 3, 54, 17, 7]
diverse = [3, 'Hi!', 9.0]
```

Lists are very flexible as they can contain any number of items, and any type of data. You can even nest lists inside a list, which makes for a very flexible data type.

Operations on sequences are a bit different to numbers. We can still use `+` and `*`, but they will concatenate (append) and duplicate, rather than perform arithmetic.

```python
sentence + ' How are you?'
myList + diverse
3 * myList
```

However, depending on the variable, some operations won't work:

```python
sentence + favNumber
```

There are other data types like tuples, dictionaries and sets, but we won't look at those in this session. Here's a summary of the ones we've covered
| Category | Type | Short name | Example | Generator |
| --- | --- | --- | --- | --- |
| Numeric | Integer | `int` | `3` | `int()` |
| Numeric | Floating Point Number | `float` | `4.2` | `float()` |
| Sequence | String | `str` | `A sentence ` | `" "` or `' '` or `str()` |
| Sequence | List | `list` | `['apple', 'banana', 'cherry']` | `[ ]` or `list()` |

### Indexing

We can access part of a sequence by **indexing**. Sequences are ordered, **starting at 0**, so the first element has index 0, the second index 1, the third 2 and so on. For example, see what these commands return:

```python
sentence[0]
sentence[6]
myList[4]
```

### Slicing

If you want more than one element in a sequence, you can **slice**. Simple slices specify a range to slice, from the first index to the last, **but not including the last**. For example:

```python
myList[0:4]
```

That command returns "elements from position 0 up to - but not including! - position 4." By specifying a third number, we can skip indexing. For example, to choose every second number,

```python
myList[0:4:2]
```

We can get creative by skipping numbers too. Try these:

```python
myList[3:]
myList[1::2]
myList[::3]
myList[:2]
```

## Functions

**Functions** are little programs that do specific jobs. These are the verbs of Python, because they do things to and with our variables. Here are a few examples of built-in functions:

```python
len(myList)
min(myList)
max(myList)
sum(myList)
round(otherNumber)
```

Functions always have parentheses after their name, and they can take one or several **arguments**, or none at all, depending on what they can do, and how the user wants to use them.

Here, we use two arguments to modify the default behaviour of the `round()` function:

```python
round(otherNumber, 2)
```

> Notice how Spyder gives you hints about the available arguments after typing the function name?

We can create our own custom functions too, using the `def` command. The syntax is quite particular: 
1. We start with the line `def <function_name>(<input 1>,<input 2>,...):`
1. Then put what our function does on the next few lines, **indented**.
1. Finally, we use `return <output>` to specify what our function outputs.

For example, the following function called `addOne` takes one variable, `x` and outputs the result of `x + 1` (stored temporarily in `y`):

```python
def addOne(x):
  y = x + 1
  return y
```

Notice that nothing happens when you run this code. That's because while we've *defined* the function, we haven't actually used it! Currently, it just exists like those other functions above (e.g. `min()`, `round()`, etc.). To use it, we need to input a variable

```python
addOne(7)
```

This calls the function, assigning `x = 7` temporarily while the function's internal code executes. It then spits out the result - `8` in this case - before deleting `x` and `y` from memory, because they only exist inside the function.




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
gap = pd.read_csv('https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv')
```

> `pandas` contains many functions for interpreting a variety of file formats. Start typing `pd.read_` to see what is available.

Now that we have stored our dataset as a variable, we can print the dataset to the console:

```python
gap
```

The console conveniently shows us only the beginning and end of the dataframe.

We can also use the "dot notation" to create commands that are useful to explore the data:

```python
gap.shape # size of the dataframe (an attribute)
gap.head() # first few rows (a method)
gap.head(10) # change the behaviour of the method
gap.tail() # last few rows
gap.country # single variable
```

Variables have **attributes** and **methods** attached to them, depending on the data type. Here, `shape` is an attribute, i.e. a static characteristic of the variable, whereas `head()` is a method, i.e. a function that can often take arguments.

### Analyse data

Let's now learn a bit more about our data. The `describe()` method gives us summary statistics for our numerical data:

```python
gap.describe()
```

To create a customised summary, we can string different methods one after the other. Here, we first group by year to then get the yearly mean of the numerical columns:

```python
gap.groupby('year').mean()
```

### Visualise data

We can visualise our data with `matplotlib`. First, let's visualise the relationship between gross domestic product per capita (`gdpPercap`) and life expectancy (`lifeExp`) with a scatterplot:

```python
import matplotlib.pyplot as plt
plt.plot(gap.gdpPercap, gap.lifeExp, 'g.')
```

We add the data as two arguments, which are understood as what we put on the x and y axes respectively.

We can now add labels with extra functions:

```python
plt.plot(gap.gdpPercap, gap.lifeExp, 'g.')
plt.xlabel('GDP per capita (USD)')
plt.ylabel('Life expectancy (years)')
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
plt.plot(gap.groupby('year').mean().lifeExp, 'm:')
```

## Saving your work

Your project can be reopened from the "Projects" menu in Spyder.

By default, your variables are *not* saved, which is another reason why working with a script is important: you can execute the whole script in one go to get everything back. You can however save your variables as a `.spydata` file if you want to (for example, if it takes a lot of time to process your data).
