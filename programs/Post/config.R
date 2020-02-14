# Config file
# Does not install libraries!
# libraries
mran.date <- "2019-12-01"
options(repos=paste0("https://cran.microsoft.com/snapshot/",mran.date,"/"))

# install.packages(c("tidyverse","readr","here"))

library(tidyverse)
library(readr)
library(here)


# location
basedir <- here::here() # will find base of git repo
datadir <- file.path(basedir,"data")
tabledir <- file.path(basedir,"tables")
figuredir <- file.path(basedir,"r-graphs")

#!------------ aux function - consistent saving -----------
mysave <- function(object) {
  name=deparse(substitute(object))
  print("---------- Saving -------------")
  print(names(object))
  if ( test ) {
    print(" !! Only testing - no files saved !!")
  } else {
    print(paste0("  ---> saving as ",name))
    saveRDS(object,file.path(datadir,paste0(name,".Rds")))
    write_csv(object,file.path(datadir,paste0(name,".csv")))
  }
  
}
