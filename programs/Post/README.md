---
title: "README"
author: "Lars Vilhuber"
date: "2/15/2020"
output: 
  html_document: 
    keep_md: yes
    number_sections: yes
    toc: yes
editor_options: 
  chunk_output_type: console
---



# Data Availability Statement

The key data sources used in the article are described and cited in the article. 

## LEAP

The Canadian LEAP is accessible at CRDE. Access requests can be made at (URL). Applicants need to be Canadian residents, and a security check is conducted. Access is only at Statistics Canada offices in Ottawa.

## BHP

The version of the BHP we used is an internal version, accessible only to IAB employees and their collaborators. A 50% sample is accessible to external researchers through the FDZ (Research Data Center) of the IAB. Applicants must fill out a form, subject to approval, and can access the data via the various access mechanisms of the FDZ, including physical locations in Germany, elsewhere in Europe, and North America.

## Synthetic data

Synthetic data from both confidential data were never released to the public, and are accessible only via the same access mechanisms as above. A related synthetic LEAP was made available through the Canadian Research Data Center system, as part of a pilot program, to prepare access to the confidential data. We are not aware of current access. The outcomes of the pilot program have not been made documented yet.

## Analytic outcomes

The analytic outcomes described in the article were released through the respective disclosure avoidance mechanisms, subject to disclosure avoidance procedures of each statistical institution. This outcomes, as figures, CSV files, and others, are available in this repository. Some were extracted from figures or released tables by the programs in this directory.

> NEED TO CLEAN THIS UP


|Name                                                              |
|:-----------------------------------------------------------------|
|33100164-eng.zip                                                  |
|all_reg_coeffs.csv                                                |
|all_reg_coeffs.Rds                                                |
|graph_regs_jkt.csv                                                |
|graph_regs_jkt.Rds                                                |
|graph_regs_jkt_summary.csv                                        |
|graph_regs_jkt_summary.Rds                                        |
|graph_regs_wide.csv                                               |
|graph_regs_wide.Rds                                               |
|Gross_employment_level_by_year_manufacturing.csv                  |
|Gross_employment_level_by_year_manufacturing.dta                  |
|Gross_employment_level_by_year_private.csv                        |
|Gross_employment_level_by_year_private.dta                        |
|Job_creation_rate_by_year_Manufacturing.csv                       |
|Job_creation_rate_by_year_Manufacturing.dta                       |
|Job_creation_rate_by_year_private.csv                             |
|Job_creation_rate_by_year_private.dta                             |
|NAICS-SCIAN-2012-Structure-eng.csv                                |
|Net_job_creation_rate__by_year_Manufacturing.csv                  |
|Net_job_creation_rate__by_year_Manufacturing.dta                  |
|Net_job_creation_rate__by_year_private.csv                        |
|Net_job_creation_rate__by_year_private.dta                        |
|pmse.table.csv                                                    |
|pmse.table.Rds                                                    |
|README.md                                                         |
|reg_can_dyn2_gmm.csv                                              |
|reg_can_dyn2_gmm.Rds                                              |
|reg_can_dyn2_System_gmm.csv                                       |
|reg_can_dyn2_System_gmm.Rds                                       |
|reg_can_dyn2_System_gmm_MA.csv                                    |
|reg_can_dyn2_System_gmm_MA.Rds                                    |
|reg_can_OLS2.csv                                                  |
|reg_can_OLS2.Rds                                                  |
|reg_ger_dyn2_gmm.csv                                              |
|reg_ger_dyn2_gmm.Rds                                              |
|reg_ger_dyn2_System_gmm.csv                                       |
|reg_ger_dyn2_System_gmm.Rds                                       |
|reg_ger_dyn2_System_gmm_MA.csv                                    |
|reg_ger_dyn2_System_gmm_MA.Rds                                    |
|reg_ger_OLS2.csv                                                  |
|reg_ger_OLS2.Rds                                                  |
|Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.csv |
|Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.dta |
|Share_of_employment_by_NAICS_two-digit_and_year_private.csv       |
|Share_of_employment_by_NAICS_two-digit_and_year_private.dta       |
|Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.csv      |
|Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.dta      |
|Share_of_firms_by_NAICS_two-digit_and_year_private.csv            |
|Share_of_firms_by_NAICS_two-digit_and_year_private.dta            |
|Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.csv    |
|Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.dta    |
|Share_of_payroll_by_NAICS_two-digit_and_year_private.csv          |
|Share_of_payroll_by_NAICS_two-digit_and_year_private.dta          |
|table-comparison-original.png                                     |
|table-comparison.csv                                              |
|table_tests.csv                                                   |
|table_tests.Rds                                                   |
|Total_payroll_by_year_manufacturing.csv                           |
|Total_payroll_by_year_manufacturing.dta                           |
|Total_payroll_by_year_private.csv                                 |
|Total_payroll_by_year_private.dta                                 |




## NAICS data

As a small part of the post-processing, we count the (theoretical) number of Canadian NAICS industry groups (Statistics Canada, 2012). The file can be downloaded from [https://www.statcan.gc.ca/eng/subjects/standard/naics/2012/index](https://www.statcan.gc.ca/eng/subjects/standard/naics/2012/index).


```
## Parsed with column specification:
## cols(
##   Level = col_double(),
##   `Hierarchical structure` = col_character(),
##   Code = col_character(),
##   `Class title` = col_character(),
##   Superscript = col_character(),
##   `Class definition` = col_character()
## )
```

         Level       Hierarchical structure       Code           Class title        Superscript        Class definition 
---  --------------  -----------------------  -----------------  -----------------  -----------------  -----------------
     Min.   :1.000   Length:2078              Length:2078        Length:2078        Length:2078        Length:2078      
     1st Qu.:4.000   Class :character         Class :character   Class :character   Class :character   Class :character 
     Median :4.000   Mode  :character         Mode  :character   Mode  :character   Mode  :character   Mode  :character 
     Mean   :4.161   NA                       NA                 NA                 NA                 NA               
     3rd Qu.:5.000   NA                       NA                 NA                 NA                 NA               
     Max.   :5.000   NA                       NA                 NA                 NA                 NA               

# Programs


## Requirements

- R
- Stata
- bash shell (optional, to execute all programs in order)

## Synthetic generation

The software used to generate the synthetic data is described in Kinney et al (2011b). A copy of the code as used for the Canadian data is provided in the `programs/Canada` directory.

## Post-processing

The following programs are used to post-process the analytic results:

### Stata programs


|Name                   |
|:----------------------|
|01_extract_from_gph.do |
|config.do              |
|program_my_extract.do  |

### R programs


|Name                |
|:-------------------|
|02_read_tables.R    |
|03_combine_tables.R |
|04_graph_coefs.R    |
|05_compute_jkt.R    |
|06_recompute_pmse.R |
|07_m2_table.R       |
|config.R            |

### Execution of programs

Numbered programs should be executed in the natural order. Other programs define locations and/or subroutines, and should not be executed. A convenience bash script `run_all.sh` is provided.



