# Read in and convert screwy Stata tabular output (eststo)

# libraries
library(tidyverse)
library(readr)
library(here)


# location
basedir <- here::here() # will find base of git repo
datadir <- file.path(basedir,"data")
tabledir <- file.path(basedir,"tables")

clean_table <- function(infile,...) {
  
mytable <- read_csv(file.path(tabledir,infile),...)
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
  pivot_wider(names_from = type, values_from = parameter) %>%
  filter(name!="* p<0.1") %>% filter(name!="Standard errors in parentheses")
}

# aux function - consistent saving
mysave <- function(object) {
  name=deparse(substitute(object))
  saveRDS(object,file.path(datadir,paste0(name,".Rds")))
  write_csv(object,file.path(datadir,paste0(name,".csv")))
}
# now process them. A few have additional features.
reg_dyn_gmm_can <- clean_table("Regression_coefficients_Dynamic_GMM.csv")
mysave(reg_dyn_gmm_can)

reg_dyn_gmm_ger <- clean_table("Regression_coefficients_Dynamic_GMM_GsynLBD.csv",col_names=c("_name","Model","Model_1"))
mysave(reg_dyn_gmm_ger)
