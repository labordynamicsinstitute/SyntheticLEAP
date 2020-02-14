# Output table of m2 and Sargan
# Lars Vilhuber
# 2020-02-14


source(here::here("programs","Post","config.R"),echo=TRUE)

test <- FALSE

graph_regs_wide <- readRDS(file.path(datadir,paste0("graph_regs_wide",".Rds")))

graph_regs_wide %>% 
  filter(name %in% c("Sargan test","m2")) %>%
  filter(sector %in% c("Private","Universe")) %>%
  dplyr::select(-synthetic,-stderr,-conf_stderr,-sector) %>%
  pivot_wider(names_from=country,values_from=c("estimate","conf_estimate")) %>%
  select(model,name,
         `Confidential (CDN)`=conf_estimate_Canada,`Synthetic (CDN)`=estimate_Canada,
         `Confidential (GER)`=conf_estimate_Germany,`Synthetic (GER)`=estimate_Germany) -> table_tests

library(stargazer)

stargazer(table_tests,summary=FALSE,
          title = "m2 and Sargan tests by country",
          label = "tab:m2sargan",
          rownames=FALSE,out=file.path(tabledir,"table_m2_sargan.tex"))

mysave(table_tests)

