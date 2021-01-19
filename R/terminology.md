# Main terms and concepts in R

This is a list of main terms and concepts used when introducing the R programming language. It is not meant to be a comprehensive and precise language definition, far from it. The idea is to provide a quick reference card of short definitions useful when being introduced to the world of R, without the unnecessary details that might scare people off.

This resource was created because an equivalent could not be found online (to the surprise of the author).

* **Argument**: sometimes called "options", arguments are used to tell a function what to do. They are separated by commas, inside the function's parentheses.
* **Assignment**: assigning a value to an object means defining what value is stored inside it. We use the assignment operator for that: `<-` (shortcut in RStudio: <kbd>Alt</kbd> + <kbd>-</kbd>)
* **Base R**: the most basic installation of R, which provides hundreds of functions. Can be extended with packages.
* **Class**: what kind of object you are dealing with, for example "numeric" or "character", which you can find out with `class()`. Important, as functions will demand particular classes of data.
* **Command**: a snippet of code that can be executed on its own. An instruction for R.
* **Comment**: a line that starts with `#`, which allows to write free text to document the code (R will ignore it).
* **Console**: where R is used interactively, i.e. where commands are executed (and outputs might be shown).
* **CRAN**: the Comprehensive R Archive Network, where documentation about and packages for R can be found online.
* **Data frame**: a kind of object suited to store tabular data, for example when importing a spreadsheet. Ideal to store different kinds of data in different columns. Technically, it is a special case of a list: a list that contains vectors of the same lengths (i.e. the columns).
* **Environment**: where your objects and custom functions are. The Environment tab of RStudio shows you what you have created so far.
* **Error**: something went terribly wrong, and R can't finish running the code. The code most likely needs fixing.
* **Executing**: executing (or "evaluating" or "running") a command means asking R to follow the instructions (i.e. the code) we wrote (and potentially give us an output if one is expected). In RStudio, you can execute commands from the script with <kbd>Ctrl</kbd> + <kbd>Enter</kbd>, but <kbd>Enter</kbd> is enough in the console.
* **Function**: a small program that has a name directly followed by parentheses, e.g. `mean()` or `read.csv()`. Between the parentheses, we can specify arguments to tell the function what to do.
* **Indexing**: a way to pick parts of an object that has several elements. Usually done between square brackets, and with numbers that specify the position of the elements, e.g. `my_object[5]`.
* **Library**: _see "Package"_
* **List**: a kind of object that is very flexible. It can contain different kinds of data, of different sizes, as nested as you wish.
* **Matrix**: a kind of object that contains values organised in a 2D grid. Values can only be of one kind, which is different to data frames.
* **Object**: also called a "variable" in other languages, this is what you create to store information (and what you see in your Environment tab).
* **Operator**: a special (sequence of) characters that means something special to R (e.g `+` for adding up, or `<-` for assigning).
* **Package**: an extension that you can install to give your R installation extra functionalities; a way to share functions (and datasets) with others. You need to load them with `library()` in order to use their functions. Packages usually introduce new functions to do specific jobs, like deal with particular datasets, provide extra statistical methods, make a task easier, or introduce a new kind of visualisation... Some people call them "libraries".
* **Project** (or "R Project"): when using RStudio, a way to specify a default location where your work will happen. Ideal to keep a data analysis project nicely contained, without having to deal with telling R where things are. Makes your life easier, and your computer tidy!
* **RData**: a file format to save your functions and objects in between sessions.
* **Running**: _see "Executing"_
* **Script**: a text file that contains R code. Useful to store a series of command, document the code with comments, and share it with others. An essential part of making you work reproducible.
* **Session**: every time you open R or RStudio, you start a fresh R session, i.e. there is no inputs and outputs in your console (and your environment is empty, unless you make use of an RData file).
* **Source** panel: in RStudio, the panel where we edit scripts, but also where the viewer lets us explore data frames. "Sourcing" a script means importing all the objects and functions defined inside it.
* **Tidyverse**: if R is a _language_, the [Tidyverse](https://www.tidyverse.org/) is the most popular of its _dialects_. It is a cohesive group of data science packages that share a data structure, a design philosophy and a grammar. Many people will directly load the Tidyverse as soon as they start writing an R script (but you can pick and choose which packages you need too).
* **Vector**: most often used to refer to an object that contains several values (i.e an object of one dimension, as it has a length greater than 1).
* **Variable**: in R, "variable" most often means "a column in a data frame" (but some people might use it to mean "object").
* **Warning**: not as bad as an error. Usually something important to take note of, but that doesn't mean running the code failed.
