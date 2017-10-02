#!/usr/bin/env bash

brew install R --with-openblas
brew cask install rstudio
R CMD javareconf JAVA_CPPFLAGS=-I/System/Library/Frameworks/JavaVM.framework/Headers
Rscript -e "update.packages(ask=F, repos='http://r-forge.r-project.org')"
