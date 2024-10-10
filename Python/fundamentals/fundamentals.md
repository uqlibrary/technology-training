# Python training (1 of 4): The fundamentals


This hands-on course – directed at beginners – will get you started on
using **Python 3** and the program **Spyder** to import, explore,
analyse and visualise data.

## Table of Contents

- [Setup](#setup)
- [Introduction](#introducing-python-and-spyder)
- [Variables](#variables)
- [Scripts](#scripts)
- [Functions](#functions)
- [Finding help](#finding-help)
- [Activity 1](#activity-1)
- [Conditionals (`if`, `elif` and `else`)](#conditionals)
- [Loops (`while` and `for`)](#loops)
- [Activity 2](#activity-2)
- [Packages/Modules](#packages)
- [Activity 3](#activity-3)
- [Conclusion](#conclusion-and-saving-your-work)

## Setup

The easiest way to use Python 3 and Spyder is to [install the Anaconda
Distribution](https://www.anaconda.com/products/distribution), a data
science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator`
from a terminal on Linux), and launch Spyder. On some operating systems,
you might be able to find Spyder directly in your applications.

## Introducing Python and Spyder

Python is a **programming language** that can be used to build programs
(i.e. a “general programming language”), but it can also be used to
analyse data by importing a number of useful modules.

We are using **Spyder** to interact with Python more comfortably. If you
have used RStudio to interact with R before, you should feel right at
home: Spyder is a program designed for doing data science with Python.

We will start by using the **console** to work interactively. This is
our direct line to the computer, and is the simplest way to run code.
Don’t worry about any unfamiliar language, fonts or colours - we can
ignore most of it for now - all you need to know is that

- `In [1]: ...` is code that we’ve sent to the computer, and
- `Out[1]: ...` is its response.

### Maths

To start with, we can use Python like a calculator. Type the following
**commands** in the console, and press <kbd>Enter</kbd> to **execute**
them:

``` python
1 + 1
2 * 3
4 / 10
5 ** 2
```

    25

After running each command, you should see the result as an output.

## Variables

### Numbers

Most programming languages are like spoken language in that they have
nouns and verbs - you have “things” and they “do things”. In Python, we
have **variables** and **functions**. We’ll look first at variables, the
nouns of Python, which store data.

To create a variable, we choose its name (e.g. `favNumber`) and assign
(`=`) it a value (e.g. `42`):

``` python
favNumber = 42
```

You can then retrieve the value by running the variable name on its own:

``` python
favNumber
```

    42

Let’s create more variables. We can use the variable names in place of
their values, so we can perform maths:

``` python
otherNumber = 5.678
prod1 = favNumber * otherNumber
```

So far, we’ve only looked at numbers. If you click on the “variable
explorer” tab, you should see two variables like these:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/f8e3a769-69b0-43df-a0f3-c8b00d307eaf.png)

Notice that the “Type” of `favNumber` is `int`, while the other is
`float`. These are different **variable types** and can operate
differently. `int` means integer, and corresponds to whole numbers,
while `float` stands for floating point number, meaning decimals. You
may occasionally encounter errors where you can only use one type.

### Booleans

Even simpler than integers is the **boolean** type. These are either 1
or 0 (True or False), representing a single binary unit (bit). Don’t be
fooled by the words, these work like numbers: `True + True` gives `2`.

``` python
myBool = True
```

> In Python, the boolean values `True` and `False` **must** begin with a
> capital letter.

### Sequences

Let’s look at variable types which aren’t (necessarily) numbers.
**Sequences** are variables which store more than one data point. For
example, **strings** store a sequence of characters and are created with
quotation marks `'<insert string>'` or `"<insert string>"`:

``` python
sentence = 'Hello world!'
```

We can also create **lists**, which will store several variables (not
necessarily of the same type). We need to use square brackets for that:

``` python
myList = [38, 3, 54, 17, 7]
diverse = [3, 'Hi!', 9.0]
```

Lists are very flexible as they can contain any number of items, and any
type of data. You can even nest lists inside a list, which makes for a
very flexible data type.

Operations on sequences are a bit different to numbers. We can still use
`+` and `*`, but they will concatenate (append) and duplicate, rather
than perform arithmetic.

``` python
sentence + ' How are you?'
myList + diverse
3 * myList
```

    [38, 3, 54, 17, 7, 38, 3, 54, 17, 7, 38, 3, 54, 17, 7]

However, depending on the variable, some operations won’t work:

``` python
sentence + favNumber
```

    TypeError: can only concatenate str (not "int") to str
    [1;31m---------------------------------------------------------------------------[0m
    [1;31mTypeError[0m                                 Traceback (most recent call last)
    Cell [1;32mIn[9], line 1[0m
    [1;32m----> 1[0m [43msentence[49m[43m [49m[38;5;241;43m+[39;49m[43m [49m[43mfavNumber[49m

    [1;31mTypeError[0m: can only concatenate str (not "int") to str

There are other data types like tuples, dictionaries and sets, but we
won’t look at those in this session. Here’s a summary of the ones we’ve
covered:

| Category | Type | Short name | Example | Generator |
|----|----|----|----|----|
| Numeric | Integer | `int` | `3` | `int()` |
| Numeric | Floating Point Number | `float` | `4.2` | `float()` |
| Numeric | Boolean | `bool` | `True` | `bool()` |
| Sequence | String | `str` | `'A sentence '` | `" "` or `' '` or `str()` |
| Sequence | List | `list` | `['apple', 'banana', 'cherry']` | `[ ]` or `list()` |

The **generator** commands are new. We use these to manually change the
variable type. For example,

``` python
int(True)
```

    1

yields `1`, converting a **boolean** into an **integer**. These commands
are **functions**, as opposed to variables - we’ll look at functions a
bit later.

#### Indexing

We can access part of a sequence by **indexing**. Sequences are ordered,
**starting at 0**, so the first element has index 0, the second index 1,
the third 2 and so on. For example, see what these commands return:

``` python
sentence[0]
sentence[6]
myList[4]
```

    7

If you want more than one element in a sequence, you can **slice**.
Simple slices specify a range to slice, from the first index to the
last, **but not including the last**. For example:

``` python
myList[0:4]
```

    [38, 3, 54, 17]

That command returns elements from position 0 up to - but not
including! - position 4.

## Scripts

So far, we’ve been working in the console, our direct line to the
computer. However, it is often more convenient to use a **script**.
These are simple text files which store code and run when we choose.
They are useful to - write code more comfortably, - store clearly
defined steps in chronological order, - share a process with peers
easily, and - make your work reproducible

Let’s create a folder system to store our script in by creating a
**project**. - Press `Projects > New project...` and name your project,
perhaps “python_fundamentals”. - Create a new script with
<kbd>ctrl</kbd>+<kbd>N</kbd>, `File > New file...` or the new file
button
![image](https://github.com/uqlibrary/technology-training/assets/118239146/584d4955-2085-4b95-b03c-f4af9f2c3070.png)
.

You should now see a script on the left panel in Spyder, looking
something like this:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/679517d6-3cf7-4b2b-a4a7-9172596dec61.png)

Try typing a line of code in your new script, such as

``` python
a = "hello!"
a
```

    'hello!'

Press <kbd>F9</kbd> to run each line, or
<kbd>ctrl</kbd>+<kbd>enter</kbd> for the whole script. You should see
something like the following appear in the **console** (depending on how
you ran it):

![image](https://github.com/uqlibrary/technology-training/assets/118239146/c2f0bc66-e84c-4e7d-ae66-5d7fd34b4684.png)

We’ll work out of a script for the rest of the session. Don’t forget to
save your script by pressing <kbd>ctrl</kbd>+<kbd>S</kbd> or the save
button
![image](https://github.com/uqlibrary/technology-training/assets/118239146/10fbbc68-8f27-4c2d-aa6e-b064bf29b357.png)
.

## Functions

**Functions** are little programs that do specific jobs. These are the
verbs of Python, because they do things to and with our variables. Here
are a few examples of built-in functions:

``` python
len(myList)
min(myList)
max(myList)
sum(myList)
round(otherNumber)
```

    6

Functions always have parentheses after their name, and they can take
one or several **arguments**, or none at all, depending on what they can
do, and how the user wants to use them.

Here, we use two arguments to modify the default behaviour of the
`round()` function:

``` python
round(otherNumber, 2)
```

    5.68

> Notice how Spyder gives you hints about the available arguments after
> typing the function name?

### Operators

Operators are a special type of function in Python with which you’re
already familiar. The most important is `=`, which assigns values to
variables. Here is a summary of some important operators, although there
are many others:

#### General

| Operator | Function | Description | Example command |
|----|----|----|----|
| = | Assignment | Assigns values to variables | `a = 7` |
| \# | Comment | Excludes any following text from being run | `# This text will be ignored by Python` |

#### Mathematical

| Operator | Function | Description | Example command | Example output |
|----|----|----|----|----|
| \+ | Addition | Adds or concatenates values, depending on variable types | `7 + 3` or `"a" + "b"` | `10` or `'ab'` |
| \- | Subtraction | Subtracts numerical values | `8 - 3` | `5` |
| \* | Multiplication | Multiplies values, depending on variable types | `7 * 2` or `"a" * 3` | `14` or `'aaa'` |
| / | Division | Divides numerical vlues | `3 / 4` | `0.75` |
| \*\* | Exponentiation | Raises a numerical value to a power | `7 ** 2` | `49` |
| % | Remainder | Takes the remainder of numerical values | `13 % 7` | `6` |

#### Comparison

| Operator | Function | Description | Example command | Example output |
|----|----|----|----|----|
| == | Equal to | Checks whether two variables are the same and outputs a boolean | `1 == 1` | `True` |
| != | Not equal to | Checks whether two variables are different | `'1' != 1` | `True` |
| \> | Greater than | Checks whether one variable is greater than the other | `1 > 1` | `False` |
| \>= | Greater than or equal to | Checks whether greater than (\>) or equal to (==) are true | `1 >= 1` | `True` |
| \< | Less than | Checks whether one variable is less than the other | `0 < 1` | `True` |
| \<= | Less than or equal to | Checks whether less than (\<) or equal to (==) are true | `0 <= 1` | `True` |

## Finding help

To find help about a function, you can use the `help()` function, or a
`?` after a function name:

``` python
help(max)
print?
```

    Help on built-in function max in module builtins:

    max(...)
        max(iterable, *[, default=obj, key=func]) -> value
        max(arg1, arg2, *args, *[, key=func]) -> value

        With a single iterable argument, return its biggest item. The
        default keyword-only argument specifies an object to return if
        the provided iterable is empty.
        With two or more arguments, return the largest argument.

In Spyder, you can use the <kbd>Ctrl</kbd> + <kbd>I</kbd> keyboard
shortcut to open the help in a separate pane.

> The help information can often be dense and difficult to read at
> first, taking some practice. In the [next
> session](https://github.com/uqlibrary/technology-training/blob/4ea3e86ab8f6f43a73c3b3a44d63a00ac8d366f8/Python/revamp/data_transformation.md)
> we look closer at interpreting this **documentation**, one of the most
> important Python skills.

For a comprehensive manual, go to the [official online
documentation](https://docs.python.org/). For questions and answers,
typing the right question in a search engine will usually lead you to
something helpful. If you can’t find an answer, [StackOverflow is a
great Q&A community](https://stackoverflow.com/questions/tagged/python).

## Activity 1

### Stage 1

In this first activity, write a program which takes an age in years and
outputs how many minutes they’ve lived for. Note that

$$\text{Age (minutes)} = \text{Age (years)} \times 365 \times 24 \times 60$$

Steps

- Store the age in years in a variable
- Calculate the age in minutes
- Print a message with the output

### Stage 2

Next, we’ll get the user to provide the age themselves. To prompt the
user for to submit a value, we need to use a new command: `input`.

``` python
number = int(input("Pick a number: "))
```

Here, `input` asks the user to pick a number. After the user (you) types
something into the console and presses <kbd>enter</kbd>, it is saved by
Python in the variable `number`. Note that we need to put the input
inside an `int( ... )` function to turn it into a number.

<details>
<summary>
Solution
</summary>

We have three lines of code corresponding to the steps above:

``` python
### Age in minutes calculator
  
# Prompt user for age
age_years = int(input("What is your age: "))

# Calculate age in mins
age_mins = age_years * 365 * 24 * 60

# Print result
print("You have lived for" + age_mins + "minutes!")
```

:::

</details>

## Conditionals

Funnelling code through different blocks based on conditions is a
fundamental element of all programming, and achieved in Python with
conditionals. The most important is the `if` statement, which checks a
condition and runs the **indented** code block if it returns `True`:

``` python
if 1 + 1 == 2:
    print("We are inside the if statement!")
```

    We are inside the if statement!

Here’s how it works 1. `if` starts the conditional. 2. `1 + 1 == 2` is
the condition - this comes after `if`, and must return `True` (1) or
`False` (0). 3. The colon, `:`, indicates that the condition is finished
and the code block is next 4. `print(" ...` the **indented** code is
only run if the condition is `True` (1).

Try altering the condition, and see if the code runs.

Obviously, $1 + 1 = 2$, so this will always run and we don’t need to use
an `if` statement. Let’s replace the condition with variables:

``` python
name = "your_name"

if len(name) > 5:
  print(name + " is longer than 5 letters!")
```

    your_name is longer than 5 letters!

Here, we’re checking if the length of `name` is greater than `5`. Note
that `name + " is longer than 5!"` concatenates (combines) the strings
together.

> ### Advanced
>
> Using `name + " is longer than 5!"` is a bit clunky, there is a better
> way to include variables in strings, called **f-strings**.
>
> \`\`\`{python} name = “your_name”
>
> if len(name) \> 5: print(f”{name} is longer than 5 letters!“) \`\`\`
>
> By putting `f` before `'` or `"`, Python will insert any code run
> between curly brackets `{ }` into the string. Here, running `name`
> just returns “apple”.

### `elif` and `else`

There are two other commands for conditionals: `elif` and `else`.

`elif` is short for *else if*, and can be used after an if statement to
apply another condition, **if** the first one fails.

``` python
name = "your_name"

if len(name) > 5:
  print(name + " is longer than 5 letters!")

elif len(name) > 3:
  print(name + " is longer than 3 letters, but not more than 5")
```

    your_name is longer than 5 letters!

Here, if the `name` is longer than `5`, it will run in the `if` block
and skip `elif`. Otherwise, it will check the `elif` condition and run
if it’s `True`.

Finally, `else` comes at the end of a conditional and will run if all
other conditions failed

``` python
name = "your_name"

if len(name) > 5:
    print(name + " is longer than 5 letters!")

elif len(name) > 3:
    print(name + " is longer than 3 letters, but not more than 5")

else:
    print(name + " is 3 letters long or shorter.")
```

    your_name is longer than 5 letters!

You can only have one `if` and `else` statement, but as many `elif`s as
you’d like.

## Loops

For programming to speed up repetitive tasks we need to use loops. These
run a code block multiple times, and there are two types: `while` and
`for` loops.

### `while` loops

`while` loops run the code block until the condition is `False`, with
similar syntax to `if` statements:

``` python
a = 0

while a < 10:
    print(a)
    a = a + 1
```

    0
    1
    2
    3
    4
    5
    6
    7
    8
    9

> **WARNING**
>
> `while` loops can cause an infinite loop to occur if the condition is
> never `False`. If this happens, press <kbd>ctrl</kbd>+<kbd>C</kbd> or
> the red square in the console to stop the code.
>
> ![image](https://github.com/uqlibrary/technology-training/assets/118239146/a8ba8293-c64b-4994-9869-074a6d12e0a0.png)

### `for` loops

`for` loops iterate through a variable, like a list:

``` python
myList = [1,2,3]

for element in myList:
    print(element)
```

    1
    2
    3

These work a bit differently. Each time the loop runs, a variable (here
called `element`) stores one of the values in the container (here called
`myList`). The loop runs once for each element in the container, working
from the start to the finish.

## Activity 2

The second activity is a name comparer. Here, we will write code which
identifies the letters in common between two names.

We’ll need to use the command `in` for this activity. It checks whether
a variable on the left exists inside a variable on the write, for
example

``` python
"app" in "apple"
```

    True

will return `True`. We can use this for conditionals, like

``` python
word = "apple"
smaller = "app"

if smaller in word:
    print(smaller + "can be found inside" + word)
else:
    print(smaller + "is not inside" + word)
```

    appcan be found insideapple

We will also need to use a *method*. These are functions that only apply
to certain variables, and we access them using dot `.` notation. Here,
we will use the list method `.append`:

``` python
a = [1, 2, 3]
a.append(4)
print(a)
```

    [1, 2, 3, 4]

The list `a` is originally just `[1, 2, 3]`, but after running
`a.append(4)`, it appends the element 4 to the end, making it
`[1, 2, 3, 4]`.

All together, for this activity we will need to

- Ask the user for their first name using `input( ... )`
- Ask the user for their last/second name using `input( ... )`
- Initialise a list of common letters using `common = []` (this will let
  us append to it later)
- Use a `for` loop to iterate through the each letter in the first name
- Use an `if` statement to check if each letter is inside the
  last/second name
- Print a message stating the common letters

<details>
<summary>
Solution
</summary>

One solution could be the following:

``` python
# Name comparer

# Ask user for names
firstname = input("What is your first name? ")
surname = input("What is your surname? ")

# Initialise list of common letters
common = [] 

# Loop through each letter in first name
for letter in firstname:
  
    # Check if the letter is in the second word
    if letter in surname:
      
        # Add it to the list of common letters
        common.append(letter)
        
# Print final list of letters
print("The letter(s) in common between your names are: ")
print(common)
```

:::

</details>

## Packages

Python is set apart from other languages by the scale of its community
packages and the ease with which you import them. While you *could* code
everything you need from scratch, it’s often more effective to import
someone else’s predefined functions.

### Built-in packages

Python comes with a number of pre-installed packages, so they’re already
on your computer. However, your specific Python application doesn’t have
access to them until they’re imported:

``` python
import math
```

The module `math` brings in some mathematics constants and functions.
For example, you will get an **error** if you run `pi` on its own, but
we can access the constant using the module:

``` python
math.pi
2*math.pi
math.cos(math.pi)
```

    -1.0

Note that we use a period `.` in order to access objects inside the
module. In general, we use periods in Python to access objects stored
inside other objects.

### Naming

Some modules have long names and use abbreviated nicknames when
imported.

``` python
import math as m
m.pi
```

    3.141592653589793

Here the module `math` is stored as `m` in Python.

Where this naming is used, it is usually the standard, and sharing code
with different (including original/full) module names will not be
compatible with other programmers.

### External packages

There are hundreds of thousands of external packages available, and you
need to install them before importing them as above. There are many ways
to install packages, and two most common:

#### Using `pip`

If you are **not** using Anaconda, then the most common way to install a
package is using the command `pip`, which installs packages from the
Python Package Index (PyPI)

``` python
pip install numpy
```

> If this doesn’t work for you, try using `!pip install numpy` - using
> an exclamation mark `!` sends your command straight to your operating
> system shell

#### Using `conda`

If you are using **Anaconda**, then the recommended installation method
is using the `conda` command, which installs from Anaconda’s package
database:

``` python
conda install numpy
```

> As above, if this doesn’t work for you, try using
> `!pip install numpy` - using an exclamation mark `!` sends your
> command straight to your operating system shell

#### Common packages

Once installed, you can import these modules as before. Here, we’ve
installed `numpy`, which is a popular numerical package.

``` python
import numpy as np
```

Some popular packages include

| Package | Install command | Import command | Description |
|----|----|----|----|
| NumPy | `pip/conda install numpy` | `import numpy as np` | A **num**erical **Py**thon package, providing mathematical functions and constants, vector analysis, linear algebra etc. |
| Pandas | `pip/conda install pandas` | `import pandas as pd` | **Pan**el **Da**ta - data transformation, manipulation and analysis |
| Matplotlib | `pip/conda install matplotlib` | `import matplotlib.pyplot as plt` | **Mat**hematical **plot**ing **lib**rary, a popular visualisation tool. Note that there are other ways to import it, but the `.pyplot` submodule as `plt` is most common. |
| Seaborn | `pip/conda install seaborn` | `import seaborn as sns` | Another visualisation tool, closer to ggplot2 in R, built upon a matplotlib framework. |
| SciPy | `pip/conda install scipy` | `import scipy` or `import scipy as sp` | A **sci**entific **Py**thon package with algorithms and models for analysis and statistics. |
| Statsmodels | `pip/conda install statsmodels` | `import statsmodels.api as sm` and/or `import statsmodels.tsa.api as tsa` | **Stat**istical **model**ling. The first import `sm` is for cross-sectional models, while `tsa` is for time-series models. |
| Requests | `pip/conda install requests` | `import requests` | Make HTTP (internet) **requests**. |
| Beautiful Soup | `pip/conda install beautifulsoup4` | `from bs4 import BeautifulSoup` | Collect HTML data from websites. |

## Activity 3

In this final activity, we’re going to create some sample data and
visualise it.

**Our goal is to import and visualise random BMI data**

We’ll complete this in two parts. Before we begin, we need to set things
up by importing the modules we need

``` python
import pandas as pd
import seaborn as sns
```

> If importing any of these causes an error, it could be because you
> haven’t installed it yet. See [above](#External-packages) for
> information on how to do so.

### Part 1: Importing and modifying the data

The first challenge in this activity is bringing in the data. To do
this, we use the `pd.read_csv()` function, specifying the file path as
the first argument (this can be a URL), and store it in a variable
(typically `df`).

Today’s data is five (random) people’s height and weight. You can
download it
[here](https://github.com/uqlibrary/technology-training/blob/ef2d1e8eb721606a928ce140cdbebb12645f812e/Python/fundamentals/fundamentals.md).

Next, you’ll need to compute the each person’s BMI. The code below
demonstrates how to create a new column (converting weight into pounds).
You should do the same, but use the formula

$$ BMI = \frac{Weight}{(Height)^2} $$

> Remember, `5**2` is $5^2$

``` python
# Create a new column called Weight (lb) and store the weight in pounds
df["Weight (lb)"] = df["Weight"]*2.205
```

Once you’ve done these steps, you should see the following:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/ea32aa49-a679-4bd2-b525-d9044b6d1279.png)

<details>
<summary>
Solution
</summary>

One solution could be the following:

``` python
# Import packages
import pandas as pd
import seaborn as sns

# Import data - don't forget to change the file path as you need
df = pd.read_csv("BMI_data.csv")

# Create BMI column
df["BMI"] = df["Weight"] / (df["Height"]**2)

# Look at the data
df
```

:::

</details>

### Part 2: Visualisation

To visualise the data, we can use the **seaborn** module, with the
function `sns.catplot( ... )`. Inside the function, we’ll need to
specify the `x` and `y` values, and if we specifically want a bar plot,
`kind` as well. Use the `help()` documentation to see if you can
visualise the data we just created. See if you can produce something
like the following plot:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/e85ece7e-0186-4599-9d2b-cbb137bcd981.png)

<details>
<summary>
Solution
</summary>

The plot above is produced with the code

``` python
# Visualise
sns.catplot(data = df, x = names, y = "BMI", kind = "bar")
```

:::

</details>

## Conclusion and saving your work

Your project can be reopened from the “Projects” menu in Spyder.

By default, your variables are *not* saved, which is another reason why
working with a script is important: you can execute the whole script in
one go to get everything back. You can however save your variables as a
`.spydata` file if you want to (for example, if it takes a lot of time
to process your data).

### Summary

Today we looked at a lot of Python features, so don’t worry if they
haven’t all sunk in. Programming is best learned through practice, so
keep at it! Here’s a rundown of the concepts we covered

| Concept | Desctiption |
|----|----|
| **The console vs scripts** | The **console** is our window into the computer, this is where we send code directly to the computer. **Scripts** are files which we can write, edit, store and run code, that’s where you’ll write most of your Python. |
| **Variables** | **Variables** are the nouns of programming, this is where we store information, the objects and things of our coding. They come in different types like integers, strings and lists. |
| **Indexing** | In order to access elements of a sequence variable, like a list, we need to **index**, e.g. `myList[2]`. Python counts from 0. |
| **Functions** | **Functions** are the verbs of programming, they perform actions on our variables. Call the function by name and put inputs inside parentheses, e.g. `round(2.5)` |
| **Help** | Running `help( ... )` will reveal the **help** documentation about a function or type. |
| **Conditionals** | `if`, `elif` and `else` statements allow us to run code if certain **conditions** are true, and skip it otherwise. |
| **Loops** | `while` **loops** will repeatedly run code until a condition is no longer true, and `for` **loops** will iterate through a variable |
| **Packages** | We can bring external code into our environment with `import ...`. This is how we use **packages**, an essential for Python. Don’t forget to install the package first! |

### Next session

Thanks for completing this introductory session to Python! You’re now
ready for our next session, [Data
Transformation](https://github.com/uqlibrary/technology-training/blob/55946e771a59b0d82e02e69b25917ad5a0ca5588/Python/revamp/data_transformation.md),
which looks at using the **pandas** package in greater depth.

Before you go, don’t forget to check out the [Python User
Group](bit.ly/uqpug), a gathering of Python users at UQ.

Finally, if you need any support or have any other questions, shoot us
an email at [training@library.uq.edu.au](training@library.uq.edu.au).
