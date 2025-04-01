# How to use the python language to build programs

In the introductory session, we cover some fundamentals in python which provide us with the tools to manipulate and visualise data. Our initial overview neglected some substantial and fundamental features of python which are important to understand when using python *in general*. 

## Basic programming

A simple way to think of programming is in terms of *nouns* and *verbs*. Nouns - things - simply *exist* and we in coding we call them **variables**. For the most part, variables need to be defined by the programmer. Verbs, on the other hand, perform actions on nouns (variables), and we call these **functions**. The job of the programmer is to create 'sentences' of variables and functions which, when 'spoken' (run) by the computer create some meaningful output. Different languages use variables and functions in different ways, much like linguistics. Here we explore python.

### Variables

In its base language, python has 15 different data types, most* of which we explore below:

| Data type | Full name | Python name | 
| --- | --- | --- |
| Boolean | Boolean | `bool` |
| Numeric | Integer, Floating Point Number, Complex | `int`, `float`, `complex` |
| Text | String | `str` |
| Array-like | List, Tuple, Range, Set, Frozen Set | `list`, `tuple`, `range`, `set`, `frozenset` |
| Mapping | Dictionary | `dict` |
| Binary* | Bytes, Byte Array, Memory View | `bytes`, `bytearray`, `memoryview` |
| None | None | `NoneType` |

> *We don't explore the binary type, as this is too advanced for this course.

#### Variable Syntax

Variables are defined as follows:

```python
<variable name> = <variable value>
```

We use the `=` operator exclusively to mean *assign* - more on that later. The name cannot have spaces and must have some letters or an underscore, and can otherwise be an arrangement of numbers, letters and underscores. Python automatically assigns a variable type based on the value you give it.

#### Boolean

The first variable we examine is the **boolean** type. This is the simplest, and can either `True` or `False` - the most basic logical unit.

> The computer stores `True` as 1 and `False` as 0 in the background, so it only takes up one bit (1/8 bytes) of storage, making it the smallest data type

Let's create a boolean called `myBoolean`, use the `print` command to print it and `print(type(myBool))` to print its type

```python
#%%
myBoolean = True
print(myBool)
print(type(myBool))
```

> In python, `True` and `False` **always** need a capital first letter.

![image](https://user-images.githubusercontent.com/118239146/225510651-f9fe2007-5664-47c1-b659-7a28e14c3cb5.png)

While it's not the most common datatype to create, it often *gets* created by python as a result of other functions.

#### Numeric

Next, let's examine the three numeric types, **integers**, **floats** and **complex numbers**

##### Integers

The next most basic variable is the `int`. This is a whole number, either negative, zero or positive. Crucially, it has no decimal component and can't be treated as such.

```python
#%%
myInt = -93
print(myInt)
print(type(myInt))
```

![image](https://user-images.githubusercontent.com/118239146/225511136-03e2f712-5bde-4a9f-bc81-7d2e58248641.png)

##### Floating Point Numbers (floats)

Integers become limited very quickly when decimals need to be evaluated. For complex reasons related to binary numbers (base 2), expressing decimals is a complicated process. Luckily, it's all done behind the scenes, and despite some errors at extremely large and small numbers, they're *extremely* accurate for ordinary use. In essence, if you see `float`, it means decimal (or scientific notation).

```python
#%%
myFloat = 2.4
print(myFloat)
print(type(myFloat))
```

![image](https://user-images.githubusercontent.com/118239146/225511645-856c1b45-7a3d-4c89-b318-d3fac113fb73.png)

#####

Finally, python offers a `complex` type which allows complex numbers (of the form $z = a + bi$ where $i^2 \equiv -1$). If you don't deal with complex numbers, don't worry about it. Note that here, python uses `j` to mean $i$.

```python
#%%
myComplex = 3 - 2j
print(myComplex)
print(type(myComplex))
```

![image](https://user-images.githubusercontent.com/118239146/225511968-ac862f66-8522-4d4e-ac9e-eadffe49422f.png)


#### Text

Moving on from numbers, we often want to use text. For this we have the **string** variable, which is a collection of characters and interpreted as such, even if some of those are numbers. To create strings, we use quotation marks `" <my string> "` or `' <my string> '`. Both work the same, but you can't start with one and end with the other.

```python
#%%
myString = "This is a string with a number, 583. See!"
print(myString)
print(type(myString))
```

![image](https://user-images.githubusercontent.com/118239146/225512274-dc636b9d-de6a-4fe2-af42-29d58e6d4acb.png)


#### Array-like

#### Mapping

### Built-in Functions

#### Operators

#### Conditionals

#### Loops

### Creating Functions

### Classes

## Using modules and IDEs

### How to import

### How to interpret an API

### Different IDEs and Jupyter notebook

##
