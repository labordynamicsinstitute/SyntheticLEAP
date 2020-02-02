# Read in and convert screwy Stata tabular output (eststo)
# Lars Vilhuber
# 2020-02-01

source(here::here("programs","Post","config.R"),echo=TRUE)

#!-------------- FIRST BATCH ------------------

clean_table <- function(infile,tag = "Model",countryval = "Canada",...) {
  # these work for a first batch
  # [1] "---- reading infile=Regression_coefficients_Dynamic.csv --------"
  # [1] "=\"\""                "=\"Private\""         "=\"Manufacturing\""  
  # [4] "=\"Private\"_1"       "=\"Manufacturing\"_1"
  mytable <- read_csv(file.path(tabledir,infile),...)
  # clean names
  print(paste0("---- reading infile=",infile," --------"))
  print(names(mytable))
  names(mytable)[1] <- "_name"
  names(mytable) <- str_replace_all(names(mytable),"[=\"]","")
  mytable %>% 
    mutate(name = str_replace_all(`_name`,"[=\"]",""),type = if_else(name == "","stderr","estimate")) %>%
    mutate(name= if_else(name=="",lag(name,1),name)) %>% 
    filter(!is.na.data.frame(`_name`)) %>%
    select(-`_name`) %>% 
    pivot_longer(-c("name","type"),names_to = "sector",values_to = "_parameter") %>%
    mutate(value = str_replace_all(`_parameter`,"[=\"*()]",""),
           synthetic=if_else(str_detect(sector,"_1"),TRUE,FALSE),
           sector=str_squish(str_replace(sector,"_1"," ")),
           model=tag,country=countryval) %>%
    select(-`_parameter`) %>%
    filter(name!="* p<0.1") %>% filter(name!="Standard errors in parentheses")
}


#!-------------------- Second batch --------------------

clean_table2 <- function(infile,tag = "Model", countryval = "Canada",...) {
  # these work for a second batch
  # [1] "---- reading infile=Regression_coefficients_Dynamic2.csv --------"
  # [1] "X1"              "Private"         "X3"              "Manufacturing"  
  # [5] "X5"              "Private_1"       "X7"              "Manufacturing_1"
  # [9] "X9" 
  mytable <- read_csv(file.path(tabledir,infile),...)
  # clean names
  print(paste0("---- reading infile=",infile," --------"))
  print(names(mytable))
  names(mytable)[1] <- "_name"
  names(mytable) <- str_replace_all(names(mytable),"[=\"]","")
  for (x in seq(3,length(names(mytable)),2)) {
    names(mytable)[x] <- paste0(names(mytable)[x-1],"-se")
  }
  mytable %>% 
    mutate(name = str_replace_all(`_name`,"[=\"]",""),type = if_else(name == "","stderr","estimate")) %>%
    mutate(name= if_else(name=="",lag(name,1),name)) %>% 
    filter(!is.na.data.frame(`_name`)) %>%
    select(-`_name`) %>% 
    pivot_longer(-c("name","type"),names_to = "sector",values_to = "_parameter") %>%
    mutate(value = str_replace_all(`_parameter`,"[=\"*()]",""),
           type=if_else(str_detect(sector,"-se"),"stderr","estimate"),
           sector=str_squish(str_replace(sector,"-se"," ")),
           synthetic=if_else(str_detect(sector,"_1"),TRUE,FALSE),
           sector=str_squish(str_replace(sector,"_1"," ")),
           model=tag,country=countryval) %>%
    select(-`_parameter`) %>%
    filter(name!="* p<0.1") %>% filter(name!="Standard errors in parentheses")
}



#! ---------- now process them. A few have additional features. ---------

### CANADA 
# reg_can_OLS <- clean_table("Regression_coefficients_OLS.csv","OLS")
# mysave(reg_can_OLS)
# 
# reg_can_dyn <- clean_table("Regression_coefficients_Dynamic.csv","Dynamic")
# mysave(reg_can_dyn)
# 
# reg_can_dyn_gmm <- clean_table("Regression_coefficients_Dynamic_GMM.csv","GMM")
# mysave(reg_can_dyn_gmm)
# 
# reg_can_dyn_System_gmm <- clean_table("Regression_coefficients_Dynamic_System_GMM.csv","System GMM")
# mysave(reg_can_dyn_System_gmm)
# 
# reg_can_dyn_System_gmm_MA <- clean_table("Regression_coefficients_Dynamic_System_GMM_MA.csv","System GMM MA")
# mysave(reg_can_dyn_System_gmm_MA)


## Second batch
reg_can_OLS2 <- clean_table2("Regression_coefficients_OLS2.csv","OLS")
mysave(reg_can_OLS2)

reg_can_dyn2 <- clean_table2("Regression_coefficients_Dynamic2.csv","Dynamic)
mysave(reg_can_dyn2") 

reg_can_dyn2_gmm <- clean_table2("Regression_coefficients_Dynamic2_GMM.csv","GMM")
mysave(reg_can_dyn2_gmm)

reg_can_dyn2_System_gmm <- clean_table2("Regression_coefficients_Dynamic2_System_GMM.csv","System GMM")
mysave(reg_can_dyn2_System_gmm)

reg_can_dyn2_System_gmm_MA <- clean_table2("Regression_coefficients_Dynamic2_System_GMM_MA.csv","System GMM MA)
mysave(reg_can_dyn2_System_gmm_MA")


#! ----- Germany - GsynLBD ----

#! ------ ### Alter Stil -----
# 
# reg_ger_OLS <- clean_table("Regression_coefficients_OLS_GsynLBD.csv","OLS",country="Germany",col_names=c("_name","Universe","Universe_1"))
# mysave(reg_ger_OLS)
# 
# # es fehlt reg_ger_dyn!!
# 
# reg_ger_dyn_gmm <- clean_table("Regression_coefficients_Dynamic_GMM_GsynLBD.csv","GMM",country="Germany",col_names=c("_name","Universe","Universe_1"))
# mysave(reg_ger_dyn_gmm)
# 
# reg_ger_dyn_System_gmm <- clean_table("Regression_coefficients_Dynamic_System_GMM_GsynLBD.csv","System GMM",country="Germany",col_names=c("_name","Universe","Universe_1"))
# mysave(reg_ger_dyn_System_gmm)
# 
# reg_ger_dyn_System_gmm_MA <- clean_table("Regression_coefficients_Dynamic_System_GMM_MA_GsynLBD.csv","System GMM MA",country="Germany",col_names=c("_name","Universe","Universe_1"))
# mysave(reg_ger_dyn_System_gmm_MA)


#! ------ ### Neuer Stil -----

reg_ger_OLS2 <- clean_table2("Regression_coefficients_OLS2_GsynLBD.csv","OLS",country="Germany",col_names=c("_name","Universe","Universe-se","Universe_1","Universe_1-se"))
mysave(reg_ger_OLS2)

# es fehlt reg_ger_dyn2 !

reg_ger_dyn2_gmm <- clean_table2("Regression_coefficients_Dynamic2_GMM_GsynLBD.csv","GMM",country="Germany",col_names=c("_name","Universe","Universe-se","Universe_1","Universe_1-se"))
mysave(reg_ger_dyn2_gmm)

reg_ger_dyn2_System_gmm <- clean_table2("Regression_coefficients_Dynamic2_System_GMM_GsynLBD.csv","System GMM",country="Germany",col_names=c("_name","Universe","Universe-se","Universe_1","Universe_1-se"))
mysave(reg_ger_dyn2_System_gmm)

reg_ger_dyn2_System_gmm_MA <- clean_table2("Regression_coefficients_Dynamic2_System_GMM_MA_GsynLBD.csv","System GMM MA",country="Germany",col_names=c("_name","Universe","Universe-se","Universe_1","Universe_1-se"))
mysave(reg_ger_dyn2_System_gmm_MA)

#! ---- List them all ----

list.files(path = datadir,
           pattern = glob2rx("^reg*.Rds"),
           full.names = FALSE,
           recursive = FALSE)
