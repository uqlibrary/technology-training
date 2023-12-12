# Python with Spyder: introduction to data science

This hands-on course – directed at beginners – will get you started on using **Python 3** and the program **Spyder** to import, explore, analyse and visualise data.

## Setup

The easiest way to use Python 3 and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

## Introducing Python and Spyder

Python is a **programming language** that can be used to build programs (i.e. a "general programming language"), but it can also be used to analyse data by importing a number of useful modules.

We are using **Spyder** to interact with Python more comfortably. If you have used RStudio to interact with R before, you should feel right at home: Spyder is a program designed for doing data science with Python.

We will start by using the **console** to work interactively. This is our direct line to the computer, and is the simplest way to run code. Don't worry about any unfamiliar language, fonts or colours - we can ignore most of it for now - all you need to know is that 
- `In [1]: ... ` is code that we've sent to the computer, and
- `Out[1]: ... ` is its response.

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

### Numbers

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

### Booleans

Even simpler than integers is the **boolean** type. These are either 1 or 0 (True or False), representing a single binary unit (bit). Don't be fooled by the words, these work like numbers: `True + True` gives `2`.

```python
myBool = True
```

> In Python, the boolean values `True` and `False` **must** begin with a capital letter.

### Sequences

Let's look at variable types which aren't (necessarily) numbers. **Sequences** are variables which store more than one data point. For example, **strings** store a sequence of characters and are created with quotation marks `'<insert string>' ` or `"<insert string>"`:

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
| Numeric | Boolean | `bool` | `True` | `bool()`|
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

### Important Built-in Functions

## Project 1: isprime()

In this project
