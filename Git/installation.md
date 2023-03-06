# Installation of software for Git session

It is best to use your own laptop for this session. Here are the installation instructions to use Git (through a shell) depending on your operating system.

- [Linux instructions](https://github.com/uqlibrary/technology-training/blob/master/Git/installation.md#gnulinux)
- [Mac instructions](https://github.com/uqlibrary/technology-training/blob/master/Git/installation.md#macos)
- [Windows instructions](https://github.com/uqlibrary/technology-training/blob/master/Git/installation.md#windows)

## GNU/Linux

If you don't already have Git installed, it should be available in your distribution's official repositories.

For example, on a Debian-based distribution (e.g. Debian, Ubuntu, Linux Mint...), you can run `sudo apt-get install git` in your terminal app.

## macOS

[Git for Mac](http://sourceforge.net/projects/git-osx-installer/files/) makes it possible to use git on macOS.

For macOS 10.9 and higher, download and run the most recent "mavericks" installer.

For older versions of macOS (10.5-10.8), download and run the most recent "snow-leopard" installer.

## Windows

Here are the different options available to you:

### Git for Windows on your laptop (easiest install)

> This option is the fastest way to get Git going.

If you don't have Windows 10, or if you can't install Ubuntu for Windows:

1. Go to the [Git for Windows website](https://gitforwindows.org/) and click on "Download";
1. Download and run the installer that starts with "Git" and finishes with ".exe";
1. Once installed, launch "Git Bash" from the start menu.

### Bash for Windows 10 + Git on your laptop (more comprehensive install)

> This takes more time, but will give you a more complete Linux environment inside Windows.

Windows 10 introduces the Windows Subsystem for Linux, which allows using Bash inside Windows. If you have admin rights on your laptop, follow these steps:

1. Go to Control Panel > Programs > Turn Windows features on or off;
1. Tick the check box for  "Windows Subsystem for Linux";
1. Restart your computer;
1. Open the Microsoft Store, search for "Ubuntu" and install it;
1. Launch Ubuntu from the start menu;
1. Set your username and password to use this GNU/Linux Environment;
1. Install Git with the following command: `sudo apt-get install git`


### Git for Windows on a Library computer

If you can't install software on your own laptop, you can still use the Library computers:

1. Go to ZENworks;
1. Search for "Git for Windows" and double-click on the icon to install it;
1. Once installed, launch "Git Bash" from the start menu.
