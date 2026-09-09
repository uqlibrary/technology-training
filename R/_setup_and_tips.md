## Setting up

Let's open Positron and get set up. (If you don't have it installed already, follow the [installation instructions](../installation.qmd).)

Everything we write today will be saved in your project. If you are using a Library computer, remember to save it on your H drive or USB stick.

### New project folder

A project folder helps us keep all files related to one project in a single location. It makes it easy to share it, and to switch from one project to another.

1. Select New (top left) and choose "New Folder from Template"
1. Select "R Project" from the available templates
1. Enter a name for your project, for example "dplyr_intro"
1. Choose the folder where you want to create the project, such as `Documents/RProjects`, which you can create if it doesn't exist yet
1. Leave the default options selected unless instructed otherwise
1. Click "Create"

### Create a script

We use a script to save our code and write more comfortably.

- Create a new file by selecting File > New Text File, or use the shortcut {{< kbd mac="Cmd + N" win="Ctrl + N" linux="Ctrl + N" >}}
- Save the file by selecting File > Save, or use the shortcut {{< kbd mac="Cmd + S" win="Ctrl + S" linux="Ctrl + S" >}}
- Navigate to your project folder and save the file as "process.R"

You can now write some comments (lines that start with `#`) to introduce the script.

Remember some of the most commonly used Positron shortcuts when writing an R script:

- execute the current command: {{< kbd "Ctrl + Enter" >}}
- assignment operator (`<-`): {{< kbd "Alt + -" >}}

::: {.callout-tip}
To avoid common issues, keep in mind:

- R is case sensitive: it will tell the difference between uppercase and lowercase.
- Objects and functions have naming rules, the main ones being: no spaces; don't start with a number.
:::

### Finding help

For any dataset or function doubts that you might have, open the documentation! In Positron, you can find it with:

1.  the shortcut command: `?functionname`
2.  the help function: `help(functionname)`
3.  the keyboard shortcut: press {{< kbd F1 >}} after placing your cursor on a function name
4.  the popup: hover over a function name
