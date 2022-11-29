# Python data visualisation with matplotlib

***Introduction***

## Setup

The easiest way to use Python 3, matplotlib and Spyder is to [install the Anaconda Distribution](https://www.anaconda.com/products/distribution), a data science platform for Windows, Linux and macOS.

Open the Anaconda Navigator (you might have to run `anaconda-navigator` from a terminal on Linux), and launch Spyder. On some operating systems, you might be able to find Spyder directly in your applications.

### Create a project

In order to keep everything nicely contained in one directory, and to find files more easily, we need to create a project.

-   Projects -\> New project...
-   New directory
-   Project name: "python_matplotlib"
-   Choose a location that suits you on your computer
-   Click "Create"

This will move our working directory to the directory we just created, and Python will look for files (and save files) in this same directory by default.

### Create a script

Spyder opens a temporary script automatically. You can save that as a file into our project directory:

-   File -\> Save as...
-   Make sure you are located in the project directory
-   Name the script "process.py"

Working in a script allows us to write code more comfortably, and save a process as a clearly defined list of commands that others can review and reuse.

### Introducing and installing matplotlib

`matplotlib` is a large Python module useful for data visualisation. Created by John D. Hunter in 2003, it parallels many features availble in MATLAB and is an extensive library of visualisation functions and submodules. 

`pyplot` is a submodule with functions that allow the most intuitive creation of most plots, and also contains some essential functions for all visualisation. 

While we could import the whole `matplotlib` module, we only need to use the `pyplot` submodule, so it makes sense just to import it directly.

To be able to use the functions included in pyplot, we have to first import it:

``` python
import matplotlib.pyplot as plt
```

`plt` is the usual nickname for the pyplot submodule, and writing out `matplotlib.pyplot...` every time we need to use a function gets cumbersome pretty quickly.

## The basics
