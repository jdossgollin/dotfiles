# dotfiles
[![Build Status](https://travis-ci.com/jdossgollin/dotfiles.svg?branch=master)](https://travis-ci.com/jdossgollin/dotfiles)

These are my dotfiles.
Take anything you want, but at your own risk.
Most of what I have comes from other, better sources, particularly:

* http://github.com/webpro/dotfiles/
* http://efavdb.com/dotfiles/
* http://jilles.me/badassify-your-terminal-and-shell/

## Overview

These dotfiles are targeted at a data science / scientific computing workflow on macOS.
The key technologies that I use are:

* `homebrew`, to install packages (and applications, via `brew cask`)
* `zsh` shell with [`oh-my-zsh`](http://jilles.me/badassify-your-terminal-and-shell/)
* OSX defaults that make life easier
* VS Code as an editor, with lots of defaults including a docker-based LaTeX workflow

So far, so good.
If you want to use these dotfiles as a starting point, you'll probably want to change some things.

## Install

First, update the OS and install the xcode developer tools you will need.

```bash
sudo softwareupdate -i -a
xcode-select --install
```

Next, install this repository

```bash
git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
```

**CAUTION:** although in principle one can run this software with a "just press run and go" approach, that never quite works for me. 
Versions change and stuff happens.
**DO NOT** do the following:

```bash
source ~/.dotfiles/install.sh
```

Instead, open ~/.dotfiles/install.sh in a text editor (or here on GitHub!) and run it line by line.
**You want to keep track of any error messages or warnings in the terminal!**

## The `dotfiles` command

```
    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in VS code
       help             This help message
       macos            Apply macOS system defaults
       update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [homebrew-cask](https://caskroom.github.io) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)
