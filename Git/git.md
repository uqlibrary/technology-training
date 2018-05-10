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


