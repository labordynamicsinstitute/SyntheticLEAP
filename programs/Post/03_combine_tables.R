# Stack all coefficients 
# Lars Vilhuber
# 2020-02-01

source(here::here("programs","Post","config.R"),echo=TRUE)

# function comes from purrr

allfiles <- list.files(path = datadir,
                       pattern = glob2rx("^reg*.Rds"),
                       full.names = TRUE,
                       recursive = FALSE)
all_reg_coeffs <- map_dfr(allfiles,readRDS)

mysave(all_reg_coeffs)

