# dotfiles

These are my dotfiles. 
Take anything you want, but at your own risk.
Most of what I have comes from other, better sources, particularly:

* http://github.com/webpro/dotfiles/
* http://efavdb.com/dotfiles/

## Overview

These dotfiles are targeted at a data science / scientific computing workflow on macOS.
The key technologies that I use are:

* `homebrew`, to install packages (and applications, via `brew cask`)
* `conda` + `autoenv`, to create a specific environment for each project I use and to activate that environment by default whenever I change into its host directory. Please see http://efavdb.com/dotfiles/ for why and how I set this up.
* `bash` shell
* OSX defaults that make life easier

So far, so good.
If you want to use these dotfiles as a starting point, you'll probably want to change some things.
In particular, look at everything in the `install` directory:

* `install/install-brew.sh` defines a bunch of brew programs to install -- many are not necessary and some of them override programs installed by default by `xcode`, so make sure you want them.
* `install/install-bash.sh` provides a newer version of the bash shell
* `install/install-brew-cask.sh` lists a bunch of applications to download; you will likely want different ones
* `install/install-atom.sh` installs the Atom text editor and uses the `apm` package manager to install some packages. If you don't like Atom or want different packages, change this
* `install/install-conda.sh` installs `miniconda3`, then installs some useful **R** and python packages to the base state

Because I'm an indecisive person, I also use emacs, which is installed in `brew-cask` and has configurations in `emacs/init.d`.

## Install

On a sparkling fresh installation of macOS:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

    git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
    source ~/.dotfiles/install.sh

## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>
    
    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (ws) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [homebrew-cask](https://caskroom.github.io) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)
