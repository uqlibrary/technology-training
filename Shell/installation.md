# Installation of software for Unix Shell session

It is best to use your own laptop for this session. Here are the installation instructions to access Bash (the Unix Shell we use for this session) depending on your operating system.

## GNU/Linux

You should already have access to Bash, either installed by default or available to install from your distribution's official repositories.

Bash is often the default shell used in your terminal app. If you have a different default shell, you can run `bash` to momentarily swap it.

## macOS

On macOS, the default shell is Bash, which you can use by opening the Terminal utility.

## Windows

Here are the different options, **in order of preference**:

### Bash for Windows 10 on your laptop

Windows 10 introduces the Windows Subsystem for Linux, which allows using Bash inside Windows. If you have admin rights on your laptop, follow these steps:

1. Go to Control Panel > Programs > Turn Windows features on or off;
1. Tick the check box for  "Windows Subsystem for Linux";
1. Restart your computer;
1. Open the Microsoft Store, search for "Ubuntu" and install it;
1. Launch Ubuntu from the start menu;
1. Set your username and password to use this GNU/Linux Environment.

### Git for Windows on your laptop

If you don't have Windows 10, or if you can't install Ubuntu for Windows:

1. Go to the Git for Windows website and click on "Download": https://gitforwindows.org/
1. Download and execute the installer that starts with "Git" and finishes with ".exe";
1. Launch "Git Bash" from the start menu.

### Git for Windows on a library computer

If you can't install software on your own laptop, you can still use the library computers:

1. Go to ZENworks;
1. Search for "Git for Windows" and double-click on the icon to install it;
1. Once installed, launch "Git Bash" from the start menu;
1. Type the following command (with `<yourusername>` replaced by your username, e.g. `s1234567`) and press enter:
```shell
cd /C/home/<yourusername>
```
That command changes your working directory to your home directory. (More on that during the sessions!)