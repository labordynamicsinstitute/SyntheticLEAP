# Config file
# Does not install libraries!
# libraries
library(tidyverse)
library(readr)
library(here)


# location
basedir <- here::here() # will find base of git repo
datadir <- file.path(basedir,"data")
tabledir <- file.path(basedir,"tables")

#!------------ aux function - consistent saving -----------
mysave <- function(object) {
  name=deparse(substitute(object))
  print(paste0("  ---> saving as ",name))
  print(names(object))
  saveRDS(object,file.path(datadir,paste0(name,".Rds")))
  write_csv(object,file.path(datadir,paste0(name,".csv")))
  
}
