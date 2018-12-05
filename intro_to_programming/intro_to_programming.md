Introduction to scientific programming
================
Stéphane Guillou
4 December 2018

Welcome!
--------

This workshop assumes no prior technical knowledge and focuses on:

-   using a language interactively in a Command Line Interface
-   introducing concepts and tools central to scientific programming
-   working with source code efficiently
-   automating tasks and enhancing reproducibility with small programs

This seminar will focus on the R language for a hands-on practice and extensive examples, but other languages will be presented, highlighting the differences between options.

The best way to learn is to practise, so we will quickly get into coding by all typing and executing the same commands. This is called "live-coding".

Installation
------------

Today, we will use R and RStudio. They are available on the library's training computers, but if you want to use your own laptop, please follow the instructions here: <https://gitlab.com/stragu/CDS/blob/master/R/Installation.md>

Introduction
------------

Let's start by adding our names and some info about us in our collaborative pad.

See how we can use some code to format our document? This is called **Markdown**, which is a concise language designed to easily create HTML documents. We are already coding!

### Why programming?

Programming allows you to use a programming language to build programs and **execute tasks**. There are many programs around, both Open Source and proprietary, that researchers can use to execute tasks by using a graphical user interface – or **GUI** – and clicking on buttons. You might however find that the programs you have been recommended do not help you with the specific task that you want to achieve, or at least do not do it efficiently.

Programming allows you to **automate** tasks by, for example, using loops to repeat a task many times, and creating functions to avoid writing the same code many times over.

Another added benefit to programming is that you can **share** your code with a team or with peers, and include it in a publication, in order to increase **reproducibility**.

Finally, because of the text-based nature of your program, you can use tools to keep track of **version history** and of **authorship** when collaborating with others.

### What language?

There are many languages you can use. They differ with their syntax, what they were designed for, and the size of the community that is actively using them.

In scientific computing, **R** and **Python** are two very popular languages. R was designed as a language for statistical analysis to be used interactively, whereas Python is more generalist.

### GUI vs CLI

A **GUI** gives the user visual elements to interact with the program, for example a button to click on in order to do a task.

A command-line interface, or **CLI**, takes an input (a command), executes it and sometimes prints some output.

Languages like R and Python can be used interactively in a command-line interface, which allows us to experiment and quickly get some results. However, if we need to create more complex series of steps for our data processing, it becomes more comfortable to work with **scripts**.

### IDE

An integrated development environment, or **IDE**, is a program that allows to write code more comfortably. Code is only text, and can therefore always be written in the most simple text editor, but an IDE makes it easier to work with code, test it, execute it, and sometimes find help and visualise output.

RStudio is an IDE primarily designed to work on R code.

Programming with R
------------------

### Getting to know R

Let's open RStudio and start using the R language interactively.

The most simple thing we can do with R is using it as a calculator, with the help of **binary operators**.

For example, try executing the following commands:

R can be used like a calculator. Try the following commands:

    3 * 4
    10 / 2
    11^6

### Objects

We can store data by creating objects, and assigning values to them with the **assignement operator** `<-`:

    num1 <- 42
    num2 <- x / 9
    str1 <- "Hello world!"

You can use the shortcut <kbd>Alt</kbd> + <kbd>-</kbd> to type the assignement operator quicker.

> Different objects have different classes and will be handled differently.

### Using functions

An R function looks like this:

    <functionname>(<argument(s)>)

In the console, we write a command and then evaluate it by pressing Enter.

For example, try running the following command:

    sqrt(x = num1)

#### Finding help

There are two main ways to find help about a function inside RStudio:

1.  the shortcut command: `?functionname`
2.  the keyboard shortcut: press <kbd>F1</kbd> with your cursor in a function name

**Exercise 1** - Use the help pages to find out what these functions do:

-   `c()`
-   `sum()`
-   `rm()`
-   `length()`
-   `list.files()`

`c()` concatenates the arguments into a vector.

`sum()` returns the sum of several numbers.

`seq()` creates a sequence of numbers from the parameters you give it.

`rm()` removes an object from your environment.

`length()` returns the length of a vector.

`list.files()` lists all the files in a directory.

Let's do some more complex operations by combining two functions:

`ls()` lists the objects in the current R environment. For example, try running the `ls()` function after executing the command `num3 <- 42`.

You can remove *all* the objects in the environment by using `ls()` as the value for the `list` argument:

    rm(list = ls())

> Arguments can be named, or can be automatically matched if used in order.

### Packages

Base R contains quite a few functions, and you can already build most things from scratch.

However, other people have already developped many functions for specific uses, and made them available to all via **packages**.

We can install packages with a command. For example, to install the package `praise`:

``` r
install.packages("praise")
```

We now need to **load** the package to access its functions:

``` r
library(praise) # load the package
praise() # use a function
```

    ## [1] "You are sensational!"

### Custom functions

We can create our own **custom function**, so we can reuse code easily:

``` r
greeting <- function(name) {
  paste0(name, " is my name. Hello World! :)")
}
```

> Use <kbd>Shift</kbd> + <kbd>Enter</kbd> to go to the line without executing the command.

If I try running my function without a value for the argument `name`, I will get an error.

I can include a default value if I want to:

``` r
greeting <- function(name = "Jane Doe") {
  paste0(name, " is my name. Hello World! :)")
}
```

### Loops

If you want to execute something many times, you can use a **loop**:

``` r
for (i in 1:100) {
  print(":D")
}
```

### Logical operators, booleans and if statements

A **logical operator** returns a **boolean**: TRUE or FALSE.

Common ones are `==` for equality, `!=` for inequality, `>` for greater than, `<` for smaller than, `>=` for greater or equal, and `<=` for smaller or equal.

Try those examples:

``` r
1 == 1
```

    ## [1] TRUE

``` r
1 != 1
```

    ## [1] FALSE

``` r
3 > 4
```

    ## [1] FALSE

``` r
7 <= c(7, 8, 6)
```

    ## [1]  TRUE  TRUE FALSE

With these tools, we can check for conditions, for example in an **`if` statement**:

``` r
number = rnorm(1)
if (number > 0) {
  print("Positive")
} else {
  print("Negative")
}
```

    ## [1] "Positive"

### Indexing

**Indexing** allows use to access a part of an object.

``` r
fact <- c("People", "are", "alright")
fact[1]
```

    ## [1] "People"

``` r
fact[3] <- "hopeless"
fact[4] <- "right"
fact[nchar(fact) < 7]
```

    ## [1] "People" "are"    "right"

> Indexing in R starts at 1. Most other languages start at 0.

An example project
------------------

Let's put what we just learned to use with a concrete example!

### Creating a project

File &gt; New Project &gt; New Directory &gt; New Project

### Our data

Download the dataset from and unzip it inside your project directory.

### Creating a script

### Our first function

### Looping

### Branching

### Visualising

### Experiment with it!

Other tools
-----------

### Python: another language

### Git: revision control and collaboration

### Bash: control a computer

What next?
----------
