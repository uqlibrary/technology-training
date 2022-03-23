# Git version control for collaboration
 
## Legal

This short course is based on the longer course _[Version Control with Git](http://swcarpentry.github.io/git-novice/)_ developped by the non-profit organisation [The Carpentries](http://carpentries.org/). The original material [is licensed](https://software-carpentry.org/license/) under a Creative Commons Attribution license ([CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode)), and this modified version uses the same license. You are therefore free to:

* **Share** — copy and redistribute the material in any medium or format
* **Adapt** — remix, transform, and build upon the material

... as long as you give attribution, i.e. you give appropriate credit to the original author, and link to the license.

## Setup

### Software

We will use Git inside a command-line shell called Bash.

Installation instructions are available on [this page](https://github.com/uqlibrary/technology-training/blob/master/Git/installation.md).

## Material

### Git??

If you need to collaborate on a project, a script, some code or a document, there are a few ways to operate. Sending a file back and forth and taking turns is not efficient; a cloud-based office suite requires a connection to the Internet and doesn't usually keep a clean record of contributions.

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

Before we use Git, we need to **configure** it with some defaults, like our credentials and our favourite text editor. For example:

```shell
git config --global user.name "Vlad Dracula"
git config --global user.email "vlad@tran.sylvan.ia"
```
This user name and email will be associated with your subsequent Git activity, which means that any changes pushed to GitLab, GitHub, BitBucket or another Git host server in the future will include this information. This has to match your GitLab credentials.

```shell
git config --global core.editor "nano -w"
git config --list
```

You can always find help about git with the `--help` flag:

```shell
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
Cold and dry, but everything is my favorite colour
```

Write out with <kbd>Ctrl</kbd>+<kbd>O</kbd> and exit nano with <kbd>Ctrl</kbd>+<kbd>X</kbd>. You can check the contents of your new file with the `cat` command:

```
cat mars.txt
```

Now, check the status of our project:

```
git status
```

Git noticed there is a new file. The "Untracked files” message means that there’s a file in the directory that Git isn’t keeping track of. We can tell Git to **track a file** using `git add`:

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

... we can see that the working tree is clean.

To see the recent **history**, we can use `git log`:

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

We have changed this file, but we haven’t told Git we will want to save those changes (which we do with `git add`) nor have we saved them (which we do with `git commit`). So let’s do that now. It is good practice to always **review our changes** before saving them. We do this using `git diff`. This shows us the differences between the current state of the file and the most recently saved version:

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
git add mars.txt
git commit -m "<your comment>"
```

Using `git add` allows us to select which changes are going to make it into a commit, and which ones won't. It sends them to what is called the **staging area**. In a way, `git add` specifies _what_ will go in a snapshot (putting things in the staging area), and git commit then actually _takes_ the snapshot.

**Challenge 1**

The staging area can hold changes from any number of files that you want to commit as a single snapshot.

1. Add some text to mars.txt noting your decision to consider Venus as a base
1. Create a new file venus.txt with your initial thoughts about Venus as a base for you and your friends
1. Add changes from both files to the staging area, and commit those changes as one single commit.

### Exploring history

> How can we identify old versions of files, review changes and recover old versions?

As we saw in the previous lesson, we can refer to commits by their identifiers. You can refer to the _most recent commit_ of the working directory by using the identifier `HEAD`.

Let's add a line to our file:

```shell
nano mars.txt
```

We can now check the difference with the head:

```shell
git diff HEAD mars.txt
```

Which is the same as using `git diff mars.txt`. What is useful is that we can **refer to previous commits**, for example for the commit before `HEAD`:

```shell
git diff HEAD~1 mars.txt
```

Similarly, `git show` can help us find out what was changed in a specific commit:

```shell
git show HEAD~2 mars.txt
```

We can also use the unique 7-character identifiers that were attributed to each commit:

```shell
git diff XXXXXXX mars.txt
```

> How do we **restore older versions** of our file?

Overwrite your whole text with one single new line:

```shell
nano mars.txt
git diff
```

We can put things back the way they were by using `git checkout`:

```shell
git checkout HEAD mars.txt
cat mars.txt
```

`git checkout` checks out (i.e., restores) an old version of a file. In this case, we’re telling Git that we want to recover the version of the file recorded in `HEAD`, which is the last saved commit. If we want to go back even further, we can use a commit identifier instead:

```shell
git log -3
git checkout XXXXXXX mars.txt
cat mars.txt
git status
```

Notice that **the changes are on the staged area**. Again, we can put things back the way they were by using git checkout:

```shell
git checkout HEAD mars.txt
cat mars.txt
```

**Challenge 2**

Jennifer has made changes to the Python script that she has been working on for weeks, and the modifications she made this morning “broke” the script and it no longer runs. She has spent more than an hour trying to fix it, with no luck…
  
Luckily, she has been keeping track of her project’s versions using Git! Which commands below will let her recover the last committed version of her Python script called data_cruncher.py?
 
1. `git checkout HEAD`
1. `git checkout HEAD data_cruncher.py`
1. `git checkout HEAD~1 data_cruncher.py`
1. `git checkout <unique ID of last commit> data_cruncher.py`
1. Both 2 and 4

### Ignoring things

> How can I tell git to ignore things?

Sometimes, we don't want git to track files like automatic backup files or intermediate files created during an analysis.

Say you create a bunch of `.dat` files like so:

```shell
touch a.dat b.dat c.dat
git status
```

If you don't want to track them, create a `.gitignore` file:

```shell
nano .gitignore
```

... and add the following line to it:

```shell
*.dat
```

That will make sure no file finishing with `.dat` will be tracked by git.

```shell
git status
git add .gitignore
git commit -m "Ignore data files"
git status
```

### Remotes in GitLab

> How do I share my changes with others on the web?

Version control really becomes extra useful when we begin to **collaborate with other people**. We already have most of the machinery we need to do this; the only thing missing is to **copy changes from one repository to another**.

It is easiest to use one copy as a central hub, stored online.

Let's **share our repository with the world**. Log into GitLab and create a new repository called `planets` ("+ > New project" in the top toolbar). Make sure you select "Public" for the visibility level.

Our local repository (on our computer) contains our recent work, but the **remote repository** on GitLab's servers doesn't.

We now need to connect the two: we do this by making the GitLab repository a **remote** for the local repository. The home page of the repository on GitLab includes the URL we need to identify it, under "HTTPS". Copy it to your clipboard, and in your local repository, run the following command:

```shell
git remote add origin https://gitlab.com/<your_username>/planets.git
```

The name `origin` is a local nickname for your remote repository. We could use something else if we wanted to, but `origin` is by far the most common choice.

Now, we can **push** our changes from our local repository to the remote on GitLab. Try this:

```shell
git push
```

Git does not know where it should push by default. See the suggested command in the error message? We can set the default remote with a shorter version of that:

```shell
git push -u origin master
```

We only need to do that once: from now one, Git will know that the default is the `origin` remote and the `master` branch.

You can now see on GitLab that your changes were pushed to the remote repository.

You can edit files directly on GitLab if you want. Try adding a line on mars.txt by clicking on "Edit".

If you do that, you will then need to **pull** changes from the remote repository to your local one before further editing:

```shell
git pull
cat mars.txt
```

In summary: `git push` sends commited changes to a remote repository, whereas `git pull` gets commited changes from the remote to your local repository.

### Collaborating

> How do we use version control to collaborate?

Now, let's get into pairs: one person is the "Owner", the other is the "Collaborator".

First, the Owner needs to give the collaborator editing access to the repository. On GitLab's left panel, go to "Settings > Members", search for your partner's username, select "Maintainer" and click "Add to project".

The Collaborator can then accept the invitation.

Next, the Collaborator needs to download a copy of the Owner's repository to their machine, which is called "**cloning a repository**". To do that, first make sure you move out of your personal repository:

```shell
cd ..
```

Now, you can clone the Owner's repository, giving it a recognisable name:

```shell
git clone https://gitlab.com/<owner_username>/planets.git partner-planets
```

The Collaborator can now make changes in their clone of the Owner's repository:

```shell
cd partner-planets
nano pluto.txt
git commit -m "add notes about Pluto"
```

Then push the change to the Owner's repository on GitLab:

```shell
git push
```

We didn't have to create a remote called `origin`, or set the default upstream: that was done by default by Git when cloning the repository.

You can see that the changes are now live on GitLab.

The Owner can now download the Collaborator's changes from GitLab:

```shell
git pull origin master
```

If you collaborate on a remote repository, **remember to `pull` before working**!

**Challenge 3**

Switch roles and repeat the process!

**Challenge 4**

Use the GitLab interface to add a comment to your partner's commit and suggest something. See your notifications in "Activity" afterwards.

### Conflicts

> What do I do when changes conflict with someone else's?

As soon as people can work in parallel, they’ll likely step on each other’s toes. This will even happen with a single person: if we are working on a piece of software on both our laptop and a server in the lab, we could make different changes to each copy. Version control helps us manage these conflicts by giving us tools to resolve overlapping changes.

To see how we can **resolve conflicts**, we must first create one. The file mars.txt is currently in the same state in both copies of the `planets` repository.

The Collaborator can add a line to their partner's copy, and push to GitLab:

```shell
nano mars.txt
git add mars.txt
git commit -m "Add a line in my friend's file"
git push
```

Now let’s have the Owner make a different change to their own copy _without pulling from GitLab beforehand_:

```shell
nano mars.txt
```

The Owner can commit the change locally:

```shell
git add mars.txt
git commit -m "Add a line in my own copy"
```

But Git won't let us push to GitLab:

```shell
git push
```

Git rejects the push because it detects that the remote repository has new updates that have not been incorporated into the local branch. What we have to do is (1) **pull** the changes from GitLab, (2) **merge** them into the copy we’re currently working in, and then (3) **push** that. Let’s start by pulling:

```shell
git pull
```

Git detects that changes made to the local copy overlap with those made to the remote repository, and therefore refuses to merge the two versions to stop us from trampling on our previous work. The conflict is marked in the affected file:

```shell
cat mars.txt
```

Our change is preceded by `<<<<<<< HEAD`. Git has then inserted `=======` as a separator between the conflicting changes and marked the end of the content downloaded from GitLab with `>>>>>>>`. (The string of letters and digits after that marker identifies the commit we’ve just downloaded.)

It is now up to the Owner to fix this conflict:

```shell
nano mars.txt
```

They can now add and commit to their local repo, and then push the changes to GitLab:

```shell
git add mars.txt
git commit -m "Merge changes from GitLab"
git push
```

Git keeps track of merged files. The Collaborator can now pull the changes from GitLab:

```shell
git pull
git log -3
```

### Hosting

GitHub? GitLab? BitBucket?

External company, purchased domain and host, or local server at the lab?
