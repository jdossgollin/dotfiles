#!/usr/bin/env bash

# see https://rud.is/b/2015/10/22/installing-r-on-os-x-100-homebrew-edition/

brew cask install java

brew install R --with-openblas

brew cask install rstudio

R CMD javareconf JAVA_CPPFLAGS=-I/System/Library/Frameworks/JavaVM.framework/Headers
