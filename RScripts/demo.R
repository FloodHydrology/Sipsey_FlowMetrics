#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Title: Magnficient 7 Flow Metrics
#Coder: Nate Jones (cnjones7@ua.edu)
#Date: 8/22/2020
#Purpose: Initial exploration of magnificient 7 flow metrics
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Resources that may be helpful:
#   David Bloggett's git repo: https://github.com/USGS-R/EflowStats
#   Vignette: https://cdn.rawgit.com/USGS-R/EflowStats/707bec71/inst/doc/packageDiscrepencies.html

#Paper: 
#   Archfield, S.A., J.G. Kennen, D.M. Carlisle, and D.M. Wolock. 2013. An 
#   Objective and Parsimonious Approach for Classifying Natural Flow Regimes at 
#   a Continental Scale. River Res. Applic. doi: 10.1002/rra.2710

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Step 1: Setup workspace--------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Clear workspace
remove(list=ls())

#Install relevant packages (only do this once!)
remotes::install_github("USGS-R/EflowStats")

#Load relevant libraries
library(dataRetrieval)
library(EflowStats)
library(tidyverse)
library(lubridate)

#define gage number
gage<-'02446500'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Step 2: Calculate MAG7 Metrics-------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#2.1 Retreive flow data---------------------------------------------------------
#Download flow data
df<-readNWISdv(
  siteNumbers = gage,
  parameterCd = '00060') #Daily flow

#2.2 Filter to years with full dataset -----------------------------------------
#Determine if gap filling is needed
validate_data(df[c("Date","X_00060_00003")],yearType="calendar")
  #Suprise, its not perfect!

#Determine where full water years are recorded
df_year<-df %>% 
  #Define month & year
  mutate(year = year(Date), 
         month = month(Date)) %>% 
  #Define water year
  mutate(water_year = if_else(month>=10, year + 1, year)) %>% 
  #Count number of observations per year
  group_by(water_year) %>% 
  summarise(count = n()) %>% 
  #filter for events with less than 30 days missing
  filter(count>365)

#Remove years with missing data
df<-df %>% 
  #Define month & year
  mutate(year = year(Date), 
         month = month(Date)) %>% 
  #Define water year
  mutate(water_year = if_else(month>=10, year + 1, year)) %>% 
  #left join df_year
  left_join(.,df_year) %>% 
  #Remove years with too many NA's
  drop_na(count)

#Check to see if that fixed everythign?
validate_data(df[c("Date","X_00060_00003")],yearType="water")

#2.3 Estimate Mag7 stats--------------------------------------------------------
#Clean up df
df<-df %>% select(Date, X_00060_00003)

#Estimate stats
output<-calc_magnifSeven(df, yearType = "water")

