# Git version control for collaboration
 
## Legal

This short course is based on the longer course _[Version Control with Git](http://swcarpentry.github.io/git-novice/)_ developped by the non-profit organisation [The Carpentries](http://carpentries.org/). The original material [is licensed](https://software-carpentry.org/license/) under a Creative Commons Attribution license ([CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode)), and this modified version uses the same license. You are therefore free to:

* **Share** — copy and redistribute the material in any medium or format
* **Adapt** — remix, transform, and build upon the material

... as long as you give attribution, i.e. you give appropriate credit to the original author, and link to the license.

## Setup

### Software

We will use Git inside a command-line shell called Bash.

Installation instructions are available on [this page](https://github.com/stragu/CDS/blob/master/Git/installation.md).

## Material

### Git??

If you need to collaborate on a project, a script, some code or a document, there are a few ways to operate. Sending a file back and forth and taking turns is not efficient; a cloud-based office suite requires a connection to the Internet and does not keep a clean record of contributions.

**Version control** allows users to:

* record a clean history of changes;
* keep track of who did what;
* go back to previous versions;
* work offline; and
* resolve potential conflicts.

Programmers use version control systems to collaborativelly write code all the time, but it isn’t just for software: books, papers, small data sets, and anything that changes over time or needs to be shared can be stored in a version control system.

A version control system is a tool that keeps track of changes for us, effectively creating different versions of our files. It allows us to decide which changes will be made to the next version (each record of these changes is called a **commit**), and keeps useful metadata about them. The complete history of commits for a particular project and their metadata make up a **repository**. Repositories can be kept in sync across different computers, facilitating collaboration among different people.

### Configuring Git

On a command line, Git commands are written as `git verb`, where `verb` is what we actually want to do.

Before we use Git, we need to configure it with some defaults, like our credentials and our favourite text editor. For example:

```bash
git config --global user.name "Vlad Dracula"
git config --global user.email "vlad@tran.sylvan.ia"
```
This user name and email will be associated with your subsequent Git activity, which means that any changes pushed to GitHub, BitBucket, GitLab or another Git host server in the future will include this information. This has to match your GitHub credentials.

```bash
git config --global core.editor "nano -w"
git config --list
```

You can always find help about git with the `--help` flag:

```bash
git --help
git config --help
```

### Creating a repository

First, let's create a directory for our project and move into it:

```
mkdir planets
cd planets
```

Then we tell Git to make `planets` a repository — a place where Git can store versions of our files:

```
git init
```

Using the `ls` command won't show anything new, but adding the `-a` flag will show the hidden files and directories too:

```
ls -a
```

Git created a hidden `.git` directory to store information about the project (i.e. everything inside the directory where the repository was initiated).

We can now check the status of our project with:

```
git status
```

### Tracking changes

> How do we record changes and make notes about them?

You should still be in the `planets` directory, which you can check with the `pwd` command.

Let's create a new text file that contains some notes about the Red Planet’s suitability as a base. We'll use the `nano` text editor:

```
nano mars.txt
```

Type the following text into it:

```
Cold and dry, but everything is my favorite color
```

Write out with <kbd>Ctrl</kbd>+<kbd>O</kbd> and exit nano with <kbd>Ctrl</kbd>+<kbd>X</kbd>. You can check the contents of your new file with the `cat` command:

```
cat mars.txt
```

Now, check the status of our project:

```
git status
```

Git noticed there is a new file. The "untracked files” message means that there’s a file in the directory that Git isn’t keeping track of. We can tell Git to track a file using git add:

```
git add mars.txt
```

... and use `git status` again to see what happenned:

```
git status
```

Git now knows that it's supposed to keep track of `mars.txt`, but it hasn’t recorded these changes as a commit yet. To get it to do that, we need to run one more command:

```
git commit -m "Start notes on Mars as a base"
```

When we run `git commit`, Git takes everything we have told it to save by using `git add` and stores a copy permanently inside the special .git directory. This permanent copy is called a **commit** (or **revision**) and it is given a short identifier.

We use the `-m` flag (for "message") to record a short descriptive comment that will help us remember what was done and why.

If we run `git status` now:

```
git status
```

To see the recent history, we can use `git log`:

```
git log
```

`git log` lists all commits made to a repository in reverse chronological order. The listing for each commit includes the commit’s full identifier (which starts with the same characters as the short identifier printed by the `git commit` command earlier), the commit’s author, when it was created, and the log message Git was given when the commit was created.

Now, let's add a line to our text file:

```
nano mars.txt
```

After writing out and saving, let's check the status:

```
git status
```

We have changed this file, but we haven’t told Git we will want to save those changes (which we do with `git add`) nor have we saved them (which we do with `git commit`). So let’s do that now. It is good practice to always review our changes before saving them. We do this using `git diff`. This shows us the differences between the current state of the file and the most recently saved version:

```
git diff
```

There is a quite a bit of cryptic-looking information in there: it contains the command used to compare the files, the names and identifiers of the files, and finally the actual differences. The `+` sign indicates which line was added.

It is now time to commit it:

```
git commit -m "<your comment>"
```

That didn't work, because we forgot to use `git add` first. Let's fix that:

```
git add
git commit -m "<your comment>"
```

Using `git add` allows us to select which changes are going to make it into a commit, and which ones won't. It sends them to what is called the **staging area**. In a way, `git add` specifies _what_ will go in a snapshot (putting things in the staging area), and git commit then actually _takes_ the snapshot.

We can watch a new edit move from our text editor to the staging area and into long-term storage as a commit:

```
nano mars.txt
git diff
```

This shows the difference between the working directory and the staging area.

Now, let's add our edited file to the staging area and check again the difference:

```
git add mars.txt
git diff
```

There is no output: as far as Git can tell, there’s no difference between what it’s been asked to save permanently and what’s currently in the directory. However, we can do this:

```
git diff --staged
```

... it show the difference between the last commited change and the staging area.

Let's save our changes and check our status and history:

```
git commit -m "<your comment>"
git status
git log
```

**Challenge 1**

The staging area can hold changes from any number of files that you want to commit as a single snapshot.

1. Add some text to mars.txt noting your decision to consider Venus as a base
1. Create a new file venus.txt with your initial thoughts about Venus as a base for you and your friends
1. And changes from both files to the staging area, and commit those changes.

### Exploring history

> How can we identify old versions of files, review changes and recover old versions?

As we saw in the previous lesson, we can refer to commits by their identifiers. You can refer to the _most recent commit_ of the working directory by using the identifier `HEAD`.

Let's add a line to our file:

```
nano mars.txt
```

We can now check the difference with the head:

```
git diff HEAD mars.txt
```

Which is the same as using `git diff mars.txt`. What is useful is that we can refer to previous commits, for example for the commit before HEAD:

```
git diff HEAD~1 mars.txt
```

Similarly, `git show` can help us find out what was changed in a specific commit:

```
git show HEAD~2 mars.txt
```

We can also use the unique 7-character identifiers that were attributed to each commit:

```
git diff XXXXXXX mars.txt
```

How do we restore older versions of our file?

Overwrite your whole text with one single new line:

```
nano mars.txt
git diff
git status
```

We can put things back the way they were by using `git checkout`:

```bash
git checkout HEAD mars.txt
cat mars.txt
```

`git checkout` checks out (i.e., restores) an old version of a file. In this case, we’re telling Git that we want to recover the version of the file recorded in `HEAD`, which is the last saved commit. If we want to go back even further, we can use a commit identifier instead:

```bash
git log -3
git checkout XXXXXXX mars.txt
cat mars.txt
git status
```

Notice that the changes are on the staged area. Again, we can put things back the way they were by using git checkout:

```bash
git checkout HEAD mars.txt
cat mars.txt
```

**Challenge 2**

Jennifer has made changes to the Python script that she has been working on for weeks, and the modifications she made this morning “broke” the script and it no longer runs. She has spent ~ 1hr trying to fix it, with no luck…
  
Luckily, she has been keeping track of her project’s versions using Git! Which commands below will let her recover the last committed version of her Python script called data_cruncher.py?
 
1. `git checkout HEAD`
1. `git checkout HEAD data_cruncher.py`
1. `git checkout HEAD~1 data_cruncher.py`
1. `git checkout <unique ID of last commit> data_cruncher.py`
1. Both 2 and 4

`git revert` is used if the bad change has _already_ been commited (whereas `git checkout` is used if the changes have not yet been commited). If you want to revert the last commited change, you can use the following command:

```bash
git revert HEAD
```
