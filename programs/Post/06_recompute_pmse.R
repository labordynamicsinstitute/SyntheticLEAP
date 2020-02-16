# Compute pMSE standardized
# Lars Vilhuber
# 2020-02-09

#adjustments 2020-02-13 by Joerg Drechsler:
#corrected k, the number of parameters in the propensity model, for Germany
#corrected c, the fraction of synthetic records, for Germany

#2020-02-15: correct k for Canada


source(here::here("programs","Post","config.R"),echo=TRUE)
library("stringi")

test <- FALSE

# Correction factors
# c is the fraction of synthetic observations
# this is not 0.5 because we run pMSE on long data, not wide data
c.ger <- 0.5234779
# For Canada, we are not quite certain
c.can <- 0.5

# Each regression includes industry dummies
# 
k.ger <- 1

# For Canada, we estimate the k, since we don't actually know the exact number.
# Somewhat frustrating

first.year.can = 1991
last.year.can = 2015

first.year.ger = 1976
last.year.ger  = 2008

# Industries: we count the 4-digit industries minus the exclusions from the NAICS spec
naics.exclusions.can <- c("61", "62", "91")
# We know that "less than 10" failed, 
naics.synthesis.failure.can <- 9

infile <- "NAICS-SCIAN-2012-Structure-eng.csv"
naics.can <- read_csv(file.path(datadir,infile))

naics.can %>% 
  filter(Level == 3) %>%
  filter(! stri_sub(Code,from=1,length=2) %in% naics.exclusions.can) %>%
  summarise(k.can = n()) %>% 
  as.numeric()  - naics.synthesis.failure.can %>%
  round(digits = 0) -1 -> k.can

# do the same for manufacturing (31-33)
naics.can %>% 
  filter(Level == 3) %>%
  filter(stri_sub(Code,from=1,length=2) %in% c("31","32","33") ) %>%
  summarise(k.can = n()) %>% 
  as.numeric()  - naics.synthesis.failure.can/3 %>%
  round(digits = 0) -1 -> k.can.manuf


# Correct for time periods, -1 for constant
k.can <- k.can + last.year.can - first.year.can 
k.can.manuf <- k.can.manuf + last.year.can - first.year.can 
k.ger <- k.ger + last.year.ger - first.year.ger

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

# Compute k
# the Canadian data did not output the indicator value
pmse.both %>% 
  group_by(model,country,sector) %>%
  filter(! name %in% c("indicator","N","pMSE")) %>%
  summarize(k = n()+1) -> k

pmse.both %>% 
  filter(name == "N") %>%
  mutate(N = as.numeric(value)) %>%
  dplyr::select(-flag,-name,-value) -> N

# Adjust k for unreported coefficients 
print("================= Prior to adjustments ====================")
k

left_join(pmse,k) %>% left_join(N) %>%
  mutate(c = if_else(country=="Germany",c.ger,0.5),
       pMSE.stdev = sqrt(2*(k-1))*(1-c)^2*c/N,
       pMSE.exp = (k-1)*(1-c)^2 * c/N,
       pMSE.standardized = (pMSE - pMSE.exp)/pMSE.stdev,
       pMSE.ratio = pMSE/pMSE.exp) 



print("================= After adjustments ====================")

## Adjust k
k %>%
  mutate(k=if_else(country=="Germany",k.ger,k)) %>%
  mutate(k=if_else(country=="Canada" & sector=="Private",k+k.can,k)) %>%
  mutate(k=if_else(country=="Canada" & sector=="Manufacturing",k+k.can.manuf,k))-> k


left_join(pmse,k) %>% left_join(N) %>%
  mutate(c = if_else(country=="Germany",c.ger,0.5),
         pMSE.stdev = sqrt(2*(k-1))*(1-c)^2*c/N,
         pMSE.exp = (k-1)*(1-c)^2 * c/N,
         pMSE.standardized = (pMSE - pMSE.exp)/pMSE.stdev,
         pMSE.ratio = pMSE/pMSE.exp) -> pmse.table
pmse.table
mysave(pmse.table)



pmse.table %>%
  filter(model=="logit") %>%
  select(country,sector,pMSE,pMSE.ratio,pMSE.standardized)%>%
  mutate(pMSE.ratio=round(pMSE.ratio,2),
	pMSE.standardized=round(pMSE.standardized,2)) -> pmse.logit

library(stargazer)

stargazer(pmse.logit,summary=FALSE,
          title = "pMSE by sector and country",
          label = "tab:pmse",
          rownames=FALSE,out=file.path(tabledir,"table_pmse_corrected.tex"))



