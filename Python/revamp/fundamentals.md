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
| Sequence | String | `str` | `'A sentence '` | `" "` or `' '` or `str()` |
| Sequence | List | `list` | `['apple', 'banana', 'cherry']` | `[ ]` or `list()` |

The **generator** commands are new. We use these to manually change the variable type. For example, 
```python
int(True)
```
yields `1`, converting a **boolean** into an **integer**. These commands are **functions**, as opposed to variables - we'll look at functions a bit later.


#### Indexing

We can access part of a sequence by **indexing**. Sequences are ordered, **starting at 0**, so the first element has index 0, the second index 1, the third 2 and so on. For example, see what these commands return:

```python
sentence[0]
sentence[6]
myList[4]
```

If you want more than one element in a sequence, you can **slice**. Simple slices specify a range to slice, from the first index to the last, **but not including the last**. For example:

```python
myList[0:4]
```

That command returns elements from position 0 up to - but not including! - position 4.

## Scripts

So far, we've been working in the console, our direct line to the computer. However, it is often more convenient to use a **script**. These are simple text files which store code and run when we choose. They are useful to
- write code more comfortably,
- store clearly defined steps in chronological order,
- share a process with peers easily, and
- make your work reproducible

Let's create a folder system to store our script in by creating a **project**. 
- Press `Projects > New project... ` and name your project, perhaps "python_fundamentals".
- Create a new script with <kbd>ctrl</kbd>+<kbd>N</kbd>, `File > New file...` or the new file button ![image](https://github.com/uqlibrary/technology-training/assets/118239146/584d4955-2085-4b95-b03c-f4af9f2c3070) .

You should now see a script on the left panel in Spyder, looking something like this:

![image](https://github.com/uqlibrary/technology-training/assets/118239146/679517d6-3cf7-4b2b-a4a7-9172596dec61)

Try typing a line of code in your new script, such as
```python
a = "hello!"
a
```
Press <kbd>F9</kbd> to run each line, or <kbd>ctrl</kbd>+<kbd>enter</kbd> for the whole script. You should see something like the following appear in the **console** (depending on how you ran it):

![image](https://github.com/uqlibrary/technology-training/assets/118239146/c2f0bc66-e84c-4e7d-ae66-5d7fd34b4684)

We'll work out of a script for the rest of the session. Don't forget to save your script by pressing <kbd>ctrl</kbd>+<kbd>S</kbd> or the save button ![image](https://github.com/uqlibrary/technology-training/assets/118239146/10fbbc68-8f27-4c2d-aa6e-b064bf29b357) .

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

### Operators

Operators are a special type of function in Python with which you're already familiar. The most important is ` = `, which assigns values to variables. Here is a summary of some important operators, although there are many others:

#### General
| Operator | Function | Description | Example command |
| --- | --- | --- | --- |
| = | Assignment | Assigns values to variables | `a = 7` | 
| # | Comment | Excludes any following text from being run | `# This text will be ignored by Python`

#### Mathematical
| Operator | Function | Description | Example command | Example output |
| --- | --- | --- | --- | --- |
| + | Addition | Adds or concatenates values, depending on variable types | `7 + 3` or `"a" + "b"` | `10` or `'ab'` |
| - | Subtraction | Subtracts numerical values | `8 - 3` | `5` |
| * | Multiplication | Multiplies values, depending on variable types | `7 * 2` or `"a" * 3` | `14` or `'aaa'`|
| / | Division | Divides numerical vlues | `3 / 4` | `0.75` |
| ** | Exponentiation | Raises a numerical value to a power | `7 ** 2` | `49` |
| % | Remainder | Takes the remainder of numerical values | `13 % 7` | `6` |

#### Comparison
| Operator | Function | Description | Example command | Example output |
| --- | --- | --- | --- | --- |
| == | Equal to | Checks whether two variables are the same and outputs a boolean | `1 == 1` | `True` |
| != | Not equal to | Checks whether two variables are different | `'1' != 1` | `True` |
| > | Greater than | Checks whether one variable is greater than the other | `1 > 1` | `False` |
| >= | Greater than or equal to | Checks whether greater than (>) or equal to (==) are true | `1 >= 1` | `True` |
| < | Less than | Checks whether one variable is less than the other | `0 < 1` | `True` |
| <= | Less than or equal to | Checks whether less than (<) or equal to (==) are true | `0 <= 1` | `True` |

## Finding help

To find help about a function, you can use the `help()` function, or a `?` after a function name:

```python
help(max)
print?
```

In Spyder, you can use the <kbd>Ctrl</kbd> + <kbd>I</kbd> keyboard shortcut to open the help in a separate pane.

> The help information can often be dense and difficult to read at first, taking some practice. In the [next session](https://github.com/uqlibrary/technology-training/blob/4ea3e86ab8f6f43a73c3b3a44d63a00ac8d366f8/Python/revamp/data_transformation.md) we look closer at interpreting this **documentation**, one of the most important Python skills.

For a comprehensive manual, go to the [official online documentation](https://docs.python.org/). For questions and answers, typing the right question in a search engine will usually lead you to something helpful. If you can't find an answer, [StackOverflow is a great Q&A community](https://stackoverflow.com/questions/tagged/python).

## Activity 1

## Conditionals
Funnelling code through different blocks based on conditions is a fundamental element of all programming, and achieved in Python with conditionals. The most important is the `if` statement, which checks a condition and runs the **indendented** code block if it returns `True`:

```python
if 1 + 1 == 2:
    print("We are inside the if statement!")
```

Here's how it works
1. `if` starts the conditional.
2. `1 + 1 == 2` is the condition - this comes after `if`, and must return `True` (1) or `False` (0).
3. The colon, `:`, indicates that the condition is finished and the code block is next
4. `    print(" ...` the **indented** code is only run if the condition is `True` (1).

Try altering the condition, and see if the code runs.

Obviously, $1 + 1 = 2$, so this will always run and we don't need to use an `if` statement. Let's replace the condition with variables:

```python
name = "your_name"

if len(name) > 5:
  print(name + " is longer than 5 letters!")
```

Here, we're checking if the length of `name` is greater than `5`. Note that `name + " is longer than 5!"` concatenates (combines) the strings together.

> ### Advanced
>
> Using `name + " is longer than 5!"` is a bit clunky, there is a better way to include variables in strings, called **f-strings**.
>
> ```python
> name = "your_name"
> 
> if len(name) > 5:
>     print(f"{name} is longer than 5 letters!")
> ```
>
> By putting `f` before `'` or `"`, Python will insert any code run between curly brackets `{ }` into the string. Here, running `word` just returns "apple".

### `elif` and `else`

There are two other commands for conditionals: `elif` and `else`.

`elif` is short for *else if*, and can be used after an if statement to apply another condition, **if** the first one fails.

```python
name = "your_name"

if len(name) > 5:
  print(name + " is longer than 5 letters!")
elif len(name) > 3:
  print(name + " is longer than 3 letters, but not more than 5")
```

Here, if the `name` is longer than `5`, it will run in the `if` block and skip `elif`. Otherwise, it will check the `elif` condition and run if it's `True`.

Finally, `else` comes at the end of a conditional and will run if all other conditions failed

```python
name = "your_name"

if len(name) > 5:
    print(name + " is longer than 5 letters!")
elif len(name) > 3:
    print(name + " is longer than 3 letters, but not more than 5")
else:
    print(name + " is 3 letters long or shorter.")
```

You can only have one `if` and `else` statement, but as many `elif`s as you'd like.

## Loops

## Activity 2

## Modules

## Defining functions

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

## Activity 3
