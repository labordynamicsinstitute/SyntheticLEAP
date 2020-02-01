# Read in and convert screwy Stata tabular output (eststo)

# libraries
library(tidyverse)
library(readr)
library(here)


# location
basedir <- here::here() # will find base of git repo
datadir <- file.path(basedir,"data")
tabledir <- file.path(basedir,"tables")

clean_table <- function(infile) {
mytable <- read_csv(file.path(tabledir,infile))
# clean names
names(mytable)[1] <- "_name"
names(mytable) <- str_replace_all(names(mytable),"[=\"]","")
mytable %>% 
  mutate(name = str_replace_all(`_name`,"[=\"]",""),type = if_else(name == "","estimate","stderr")) %>%
  mutate(name= if_else(name=="",lag(name,1),name)) %>% 
  select(-`_name`) %>% 
  pivot_longer(-c("name","type"),names_to = "sector",values_to = "_parameter") %>%
  mutate(parameter = str_replace_all(`_parameter`,"[=\"*()]","")) %>%
  select(-`_parameter`) %>%
  pivot_wider(names_from = type, values_from = parameter) 
}

# now process them. A few have additional features.
newtable <- clean_table("Regression_coefficients_Dynamic.csv")

