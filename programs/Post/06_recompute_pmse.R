# Compute pMSE standardized
# Lars Vilhuber
# 2020-02-09


source(here::here("programs","Post","config.R"),echo=TRUE)


clean_pmse <- function(infile,countryval = "Canada",...) {
  # these work for a second batch
  # [1] "---- reading infile=Regression_coefficients_Dynamic2.csv --------"
  # [1] "X1"              "Private"         "X3"              "Manufacturing"  
  # [5] "X5"              "Private_1"       "X7"              "Manufacturing_1"
  # [9] "X9" 
  mytable <- read_csv(file.path(tabledir,infile),...)
  names(mytable)[1] <- "_name"
  names(mytable) <- str_replace_all(names(mytable),"[=\"]","")
  for (x in seq(3,length(names(mytable)),2)) {
    names(mytable)[x] <- paste0(names(mytable)[x-1],"-se")
  }
  mytable %>% 
    mutate(name = str_replace_all(`_name`,"[=\"]",""),type = if_else(name == "","stderr","estimate")) %>%
    mutate(name= if_else(name=="",lag(name,1),name)) %>% 
    filter(!is.na.data.frame(`_name`)) %>%
    dplyr::select(-`_name`) %>% 
    filter(! name %in% c("pseudo R-sq")) %>%
    pivot_longer(-c("name","type"),names_to = "sector",values_to = "_parameter") %>%
    mutate(value = str_replace_all(`_parameter`,"[=\"*()]",""),
           type=if_else(str_detect(sector,"-se"),"stderr","estimate"),
           sector=str_squish(str_replace(sector,"-se"," ")),
           model=if_else(str_detect(sector,"_1"),"probit","logit"),
           sector=str_squish(str_replace(sector,"_1"," ")),
           flag=if_else(name=="pMSE","yes","no"),
           country=countryval) %>%
    filter(type == "estimate") %>%
    dplyr::select(-`_parameter`,-type) 
}

pmse.1 <- clean_pmse("pMSE_estimates.csv")  

pmse.2 <- clean_pmse("pMSE_estimates_GsynLBD.csv",countryval = "Germany") %>% 
  mutate(sector="Universe")

pmse.both <- bind_rows(pmse.1,pmse.2)

# split this up, compute k and N
pmse <- pmse.both %>% 
  filter(flag=="yes") %>%
  mutate(pMSE = as.numeric(value)) %>%
  dplyr::select(-name,-flag,-value)

# the Canadian data did not output the indicator value
pmse.both %>% 
  group_by(model,country,sector) %>%
  filter(name != "indicator") %>%
  summarize(k = n()+1) -> k

pmse.both %>% 
  filter(name == "N") %>%
  mutate(N = as.numeric(value)) %>%
  dplyr::select(-flag,-name,-value) -> N

left_join(pmse,k) %>% left_join(N) %>%
  mutate(c = 0.5,
         pMSE.stdev = sqrt(2*(k-1))*(1-c)^2*c/N,
         pMSE.exp = (k-1)*(1-c)^2 * c/N,
         pMSE.corrected = (pMSE - pMSE.exp)/pMSE.stdev,
         pMSE.ratio = pMSE/pMSE.exp) -> pmse.table
mysave(pmse.table)

pmse.table %>%
  filter(model=="logit") %>%
  select(country,sector,pMSE,pMSE.ratio,pMSE.corrected) -> pmse.logit

library(stargazer)

stargazer(pmse.logit,summary=FALSE,
          title = "pMSE by sector and country",
          label = "tab:pmse",
          rownames=FALSE,out=file.path(tabledir,"table_pmse_corrected.tex"))



