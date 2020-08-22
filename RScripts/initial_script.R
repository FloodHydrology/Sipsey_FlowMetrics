#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Title: Magnficient 7 Flow Metrics
#Coder: Nate Jones (cnjones7@ua.edu)
#Date: 8/22/2020
#Purpose: Initial exploration of magnificient 7 flow metrics
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Resources that may be helpful:
#   David Bloggett's git repo: https://github.com/USGS-R/EflowStats
#   Vignette: https://cdn.rawgit.com/USGS-R/EflowStats/707bec71/inst/doc/packageDiscrepencies.html

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Step 1: Setup workspace--------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Clear workspace
remove(list=ls())

#Install relevant packages (only do this once!)
remotes::install_github("USGS-R/EflowStats")


#Load relevant libraries
library(tidyverse)
