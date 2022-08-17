# Legal

This course borrows information from the Git Bash course _[Git version control for collaboration](https://github.com/uqlibrary/technology-training/blob/master/Git/git.md)_ which is based on the longer course _[Version Control with Git](http://swcarpentry.github.io/git-novice/)_ developped by the non-profit organisation [The Carpentries](http://carpentries.org/). The original material [is licensed](https://software-carpentry.org/license/) under a Creative Commons Attribution license ([CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode)), and this modified version uses the same license. You are therefore free to:

* **Share** — copy and redistribute the material in any medium or format
* **Adapt** — remix, transform, and build upon the material

... as long as you give attribution, i.e. you give appropriate credit to the original author, and link to the license.

# Setup

## Software

We will use Git through GitHub Desktop, you will need to create a Github Account and install GitHub Desktop.

Account creation instructions are available on [this page](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account).

Installation instructions are available on [this page](https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop).

# Material

## What is Git?

If you need to collaborate on a project, a script, some code or a document, there are a few ways to operate. Sending a file back and forth and taking turns is not efficient; a cloud-based office suite requires a connection to the Internet and doesn't usually keep a clean record of contributions.

**Version control** allows users to:

* record a clean history of changes;
* keep track of who did what;
* go back to previous versions;
* work offline; and
* resolve potential conflicts.

Programmers use version control systems to collaborativelly write code all the time, but it isn’t just for software: books, papers, small data sets, and anything that changes over time or needs to be shared can be stored in a version control system.

A version control system is a tool that keeps track of changes for us, effectively creating different versions of our files. It allows us to decide which changes will be made to the next version (each record of these changes is called a **commit**), and keeps useful metadata about them. The complete history of commits for a particular project and their metadata make up a **repository**. Repositories can be kept in sync across different computers, facilitating collaboration among different people.


## What is GitHub?

GitHub is a Git host server which stores your Git repository online. This means that you can easily use this platform to share your work, find the work of others, and collaborate. There are many other Git host servers such as GitLab and BitBucket.

## Navigating GitHub Online

### How to explore GitHub
You can search for repositories in a search engine, or on https://github.com/

For example, if you search for **spotify artists analysis** on GitHub you can see many projects relating to spotify.

The highest and most popular link listed is generally the one that you're after.

You should find your way to this repository: https://github.com/khanhnamle1994/spotify-artists-analysis

**Click** the link to have a look.

### Read the Readme
A first look at a Github repository can be intimidating, but you should initially ignore the folder structure you see, and scroll down to the **Readme** section where you can usually find details surrounding what the project is, how to install/use it, and get more help.

### Popularity
On the **right menu** you can see how popular this repository is, the number of forks (or spin-off repositories) that have been created from this, and more.

### History
Near the top of the repository you will see a clock icon followed by some numbers. This is the Hisotry of edits to this repository. You can click on this an see the entire history of changes made to this code.
![image](https://user-images.githubusercontent.com/67612228/182783554-5abc6679-8e1e-4fcd-bae3-9347bb46e72a.png)

### Where the code is 
Once you go back to the folder structure you can dig in to find the code that makes up the ggplot2 package. If you navigate to `R > geom-bar.r` you can see the code that underpins the Bar charts that you can create with ggplot2.

### Cloning code
To **clone**, or make a copy, of the code, you can simply click the `**Code**` button on the main repository screen, and import it into GitHub Desktop, allowing you to edit and make your own alterations to, and versions of the code before you.

### Creating a Portfolio
You can also use GitHub to create and display your own work. This good example has their details, their achievements, and links to all their major projects: 
https://github.com/archd3sai/Portfolio

## Creating a Repository

Once you have created a GitHub account, and have GitHub Desktop installed, open GitHub Desktop.

We have a few options here:
- You can **clone** (make a copy of) a repository that you (or someone else) has previously created on the internet
- You can create a repository within an already existing folder for a project you're already working on
- You can create a new folder and repository when you begin your project

Let's create a new folder for our project today by doing the following:

1. Click `+ Create a New Repository on your hard drive...` or go to `File > New Repository...` or press `Ctrl + N`
1. In the **Create a new repository** window fill in the details for your repository:
* **Name**: `Portfolio`
* **Description**: `A portfolio of my coding projects`
* **Local path**: In this case we're going to create a new folder in our Documents click `Choose...` and select Documents - GitHub will create a new folder here for our project to be stored in.
* Tick the **Initialize this repository with a README** box
* Leave **Git ignore** and **License** as `None` for now.

Now that we've created our repository, let's populate it with some files.

Open **RStudio** create a new R script file `File > New File > R Script`

Add a line of code to get started: 
  ```# a basic R comment 
  print("Hello World")
  ```

Save your script `File > Save As...` navigate to your portfolio folder and save your file as `process`

If you navigate back to GitHub, you will see that it has already identified that there is a new change in our repository. 
> They appear green to demonstate that these changes have added something new, as opposed to deleting something. 
We can now begin the process of commiting and backing up these changes.


## Tracking Changes

Instead of viewing your version history as a series of documents with different changes (e.g. thesis_final.pdf, thesis_final_1.pdf, etc.), Git views your **document as a compilation, or a stack, of different changes through time**. 
This means that you can go back in time to view each change as it was commited to the main document. 

When we commit a change, it writes that change to the branch of our repository that we choose to, in this case, that is called `main`. This means that if you want to do some experimenting with your code, you can instead commit it to an `experimental` branch so that you don't break your main code while you play. 

> Before commiting your changes, it's best practice to briefly describe your changes. 

### Describe your changes

Type a brief description into the box in the bottom right which currently reads `Update process.R` 
* Type something along the lines of "Added a comment and line of code". You can provide more detail in the `Description` box below if necessary. 
> Comments describing our commits are a very important part of Git, as they allow us to quickly visual changes at a glance.

### Committing and pushing Changes

Now we can commit our changes click `Commit to main`

This has committed the version history to our local device, but if we want to share this with others, or store it online, we will need to Publish/Push the file to GitHub. 

To do this we will first need to sign in to our GitHub.com account:
1. Navigate to `File > Options... . Accounts > Sign in > Continue with browser` 
2. Sign in to GitHub in your browser
3. It will then take you back to GitHub Desktop with you signed in (you may need to click to allow this in your browser)

You can publish your repository in any one of three different ways:
* clicking the blue `Publish Repository` button
* going to `Repository > Push`
* or pressing `Ctrl + p`
You can choose to keep your code private for now, and simply make it public later on. Click `Publish Repository`.

Let's have a look at what it looks like when we edit a file.

Go to R and insert edit our previous line to: `print("Hello GitHub")`

If you return to GitHub, you will see the former text in red, and our new addition highlighted in green.

Before we can push this to GitHub, we need to:
1. Describe our edits "changed the print code"
2. Then click `Commit to **main**`
3. Then press `Ctrl + P` to push it to GitHub.

## Accessing and intereacting with your Git Repository Online

### View and edit online
If you click your profile picture in the top right of Github online, you can view all **Your repositories**.

From here you can access your **portfolio** repository, and then the **process.R** file we pushed earlier.

Once you've navigated to the file, you can click the pencil button to edit the code online.

1. Make some edits to the code
1. Provide a description of your changes in the **Commit changes** section
1. Then click the `Commit changes` button.
> On the desktop you would need to push to the repository, as we are already in the external repository, you don't need to do that, however next time you access the file in another location, you should **Pull** the data.

### Fetch/Pull
Before doing any edits on a file in a repository that is worked on by many individuals or on different devices, it's best to **Fetch/Pull** your repository. 
You can do this in Github Desktop by clicking **Pull origin** up the top. 
This will pull the changes from the online repository, and let you know if there are any new additons, deletions, or, if you have simultaneously changed the same section of code, any conflicts (which need to be fixed and resolved before continuing).
 
We can see the creation, updates, and commits on the left side of Github Desktop.

### Conflicts
If we simultaneously make edits online, and then make edits on desktop without Fetching/Pulling first, we will have conflicts. Let's create a conflict.
1. Edit the document online, add `# Edited online`, then **Commit**
2. Edit the document on desktop, add `# Edited on Desktop`, **save** the file, then **Commit**
3. Click **Push**
> You will receive an error that there are newer commits on the remote. Before we **Push**, we will need to **Fetch**
4. Click **Fetch**
5. Click **Pull Origin**
> A popup will appear asking you to resolve the conflicts in the document before you merge. We need to open the file to view and remove those conflicts.
6. Open the file with the conflict. You will see code similar to that below:
```R
<<<<<<< HEAD
# Edited on Desktop
=======
# Edited Online
>>>>>>> 7e2e0c3b4a819b3cf3c285a47a862f975629bf8a
```
7. Here we decide what we want to keep, and what we want to delete. Once we have decided what to keep, we need to remove the unwanted code, as well as the tags that Git has inserted. Let's keep both edits, and simply remove the tags that Git added. Your code should look like this:
```R
print("Hello Github")
# I added this code on GitHub Online 
# Edited on Desktop
# Edited Online
```
8. Save your file.
9. Return to GitHub Desktop, and it should now update to show that there are no conflicts remaining. Click **Continue merge**
10. The conflicts are now resolved, and you can once again **Push** our edits to our GitHub repository.

### Delete
Let's navigate to the file location, and then **delete the file** so that we can see the process behind this.
Once you delete the file, Github Desktop will show this as a **Change** where all lines of code were removed.
We can now add comments, commit this change, and then push it to the repository.

### Revert
Even though we have deleted the file locally, and pushed that deletion to the web based repository, we can revert that change within Github Desktop (you can also do this through the Git command line, but note that **you cannot** do this on Github online.

Within Github Desktop click the **History** tab, right click on the commit where the file was deleted, and select **Revert changes in commit**. This will bring our file back.

### Gitignore
Before you push to a git repository, it's worth making sure that you want to commit everything in that repository.
For example, there may be private documents, or large datafiles you do not want to commit and upload. You can set these to be ignored with Gitignore.

Let's create some documents we want Github to ignore.
1. Navigate to your Portfolio folder
2. Right-click inside the folder and select **New** > **Text Document**, and call it **example.txt**

Now let's have GitHub ignore this file.
You can do this in Github Desktop by going to `Repository > Repository Settings... > Ignored files` and then entering the locations, names, or types of files you want to ignore. Let's enter **example.txt**. 
> You can also cover all instances of a particular document type by entering something similar to ***.dat**

## Creating a good Readme for your Portfolio
The Readme is often the first place people go when looking at a Git Repository, so it's important to have useful information here, and displayed in a meaningful way. This is especially the case for your Portfolio.

### Markdown
When editing a Readme file you can format it using a simple coding language called Markdown, as well as HTML coding.

Today we're going to finish by creating a simple **Readme** template.

1. Navigate to your GitHub repository online.
2. Click the **pencil** icon to edit your README.md
3. Create a heading by entering 
``` 
# Analytics Portfolio - <your name>
```
> You can create headings using \# symbols, \# will create the largest heading, and \###### will create the smallest
4. On the next line, enter some normal text describing your portfolio 
``` 
This **Portfolio** contains all of my Analytics projects
```
> You can **Bold** text by putting it between a set of double asterisks, eg. \**example text\** becomes **example text**.
5. Create a dot point with a link to your contact details by entering 
``` 
- **Email**: [yourname@email.com](yourname@email.com)
```
> A - symbol will give you a bullet point.
> You can add links, including emails, by wrapping the link text in `[ ]`, and then putting the link address in parentheses `()`. 
6. Add a second level heading by entering 
``` 
## Projects
```
7. Insert an image by entering the following HTML code: 
``` 
<img align="left" width="250" height="150" src="https://user-images.githubusercontent.com/67612228/184837530-9a4537b3-22f0-495c-90d1-6ccdcb4bc4bd.png">
```
8. Scroll to the bottom and descibe your commit, and click `**Commit** changes`

There is a lot more customisation you can do, and you can find a complete breakdown of [Git Markdown here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).


# Things not covered today
* Branching (creating experimental branches of your code)
* Fulling cloning others' code (this can vary from straightforward to complex)
* Collaboration

# More Guides
* [Terminal/GitBash](https://github.com/uqlibrary/technology-training/blob/master/Git/git.md)
* [Git in R](https://r-bio.github.io/intro-git-rstudio/)
* [Creating a website with Git and R](https://geospatial-community.netlify.app/post/create-a-geospatial-blog/)

# UQ User Groups, Support, and Training
* [UQ R User Group (UQ RUG)](https://frama.link/uqrug)
* [R Ladies](https://www.meetup.com/en-AU/rladies-brisbane/)
* [UQ Library Training](https://web.library.uq.edu.au/library-services/training#keyword=;campus=;weekstart=)
* [RCC's Hacky Hour](https://rcc.uq.edu.au/meetups)
