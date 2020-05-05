---
title: "APPLYING DATA SYNTHESIS FOR LONGITUDINALBUSINESS DATA ACROSS THREE COUNTRIES"
authors: "M. Jahangir Alam, Benoit Dostie, Jörg Drechsler, Lars Vilhuber"
date: "2020-05-04"
output:
  html_document: 
    includes:
      before_body: _includes/header.html
    keep_md: yes
    self_contained: no
    toc: yes
    toc_depth: 4
    toc_float: yes
    df_print: paged
editor_options: 
  chunk_output_type: console
---



## Data Availability Statement

The key data sources used in the article are described and cited in the article. All source data is confidential, available on restricted-access servers.


### LEAP

- Confidential LEAP: Access to the [LEAP](https://www.statcan.gc.ca/eng/cder/data#a6) can be requested at Statistics Canada/ CDER ([https://www.statcan.gc.ca/eng/cder/index](https://www.statcan.gc.ca/eng/cder/index)). 
 - Synthetic LEAP: Release of the data was not requested; data are thus still considered to be confidential. The data were generated on internal servers, and accessed by one of the authors during his stay at Statistics Canada. None of the authors currently have access to the data. Data may be accessible through the CDER access process outlined above. The Canadian LEAP is accessible at CRDE. 
 - Applicants need to be Canadian residents, and a security check is conducted. Access is only at Statistics Canada offices in Ottawa, ON, Canada.

### BHP

- Access to the BHP (in English: Establishment History Panel) is possible through the Research Data Center of the IAB ([https://fdz.iab.de/en.aspx](https://fdz.iab.de/en.aspx)). One of the authors, as an IAB employee, had access to the internal version of the data not available to researchers. Release of the data was not requested; data are thus still considered to be confidential.

A 50% sample of the BHP is accessible to external researchers through the FDZ (Research Data Center) of the IAB. Applicants must fill out a form, subject to approval, and can access the data via the various access mechanisms of the FDZ, including physical locations in Germany, elsewhere in Europe, and North America.

### Synthetic data

Synthetic data from both confidential data were never released to the public, and are accessible only via the same access mechanisms as above. A related synthetic LEAP was made available through the Canadian Research Data Center system, as part of a pilot program, to prepare access to the confidential data. We are not aware of current access. The outcomes of the pilot program have not been made public yet.


### NAICS data

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

## Analytic outcomes

The analytic outcomes described in the article were released through the respective disclosure avoidance mechanisms, subject to disclosure avoidance procedures of each statistical institution. These outcomes, as figures, CSV files, and others, are available in this repository. Some were extracted from figures or released tables by the programs in this directory.

## Files 

### Data directory

The [data](data/README.md) directory contains materials released from Statistics Canada and the IAB. It is mostly highly aggregated synthetic data, as well as regression coefficients. All data releases were authorized by the respective statistical agencies.

<!--html_preserve--><div id="htmlwidget-2f67a4628c952fffc09f" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2f67a4628c952fffc09f">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60],["all_reg_coeffs.csv","all_reg_coeffs.Rds","graph_regs_jkt_summary.csv","graph_regs_jkt_summary.Rds","graph_regs_jkt.csv","graph_regs_jkt.Rds","graph_regs_wide.csv","graph_regs_wide.Rds","Gross_employment_level_by_year_manufacturing.csv","Gross_employment_level_by_year_manufacturing.dta","Gross_employment_level_by_year_private.csv","Gross_employment_level_by_year_private.dta","Job_creation_rate_by_year_Manufacturing.csv","Job_creation_rate_by_year_Manufacturing.dta","Job_creation_rate_by_year_private.csv","Job_creation_rate_by_year_private.dta","NAICS-SCIAN-2012-Structure-eng.csv","Net_job_creation_rate__by_year_Manufacturing.csv","Net_job_creation_rate__by_year_Manufacturing.dta","Net_job_creation_rate__by_year_private.csv","Net_job_creation_rate__by_year_private.dta","pmse.table.csv","pmse.table.Rds","README.md","reg_can_dyn2_gmm.csv","reg_can_dyn2_gmm.Rds","reg_can_dyn2_System_gmm_MA.csv","reg_can_dyn2_System_gmm_MA.Rds","reg_can_dyn2_System_gmm.csv","reg_can_dyn2_System_gmm.Rds","reg_can_OLS2.csv","reg_can_OLS2.Rds","reg_ger_dyn2_gmm.csv","reg_ger_dyn2_gmm.Rds","reg_ger_dyn2_System_gmm_MA.csv","reg_ger_dyn2_System_gmm_MA.Rds","reg_ger_dyn2_System_gmm.csv","reg_ger_dyn2_System_gmm.Rds","reg_ger_OLS2.csv","reg_ger_OLS2.Rds","Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.csv","Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.dta","Share_of_employment_by_NAICS_two-digit_and_year_private.csv","Share_of_employment_by_NAICS_two-digit_and_year_private.dta","Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.csv","Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.dta","Share_of_firms_by_NAICS_two-digit_and_year_private.csv","Share_of_firms_by_NAICS_two-digit_and_year_private.dta","Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.csv","Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.dta","Share_of_payroll_by_NAICS_two-digit_and_year_private.csv","Share_of_payroll_by_NAICS_two-digit_and_year_private.dta","table_tests.csv","table_tests.Rds","table-comparison-original.png","table-comparison.csv","Total_payroll_by_year_manufacturing.csv","Total_payroll_by_year_manufacturing.dta","Total_payroll_by_year_private.csv","Total_payroll_by_year_private.dta"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### graphs directory

The [graphs](graphs/) contains mostly pre-rendered figures released as part of the agency data releases.  The programs to generate these figures can be found in [programs/Canada](programs/Canada), and were run on the confidential data.

<!--html_preserve--><div id="htmlwidget-78df6ee9ab0f94d75aef" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-78df6ee9ab0f94d75aef">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],["Divergence_of_exit_and_entry_rate_between_BHP_and_CanSynLBD_bw.pdf","Divergence_of_exit_and_entry_rate_between_BHP_and_GSynLBD_bw.pdf","Divergence_of_exit_and_entry_rate_between_BHP_and_GSynLBD.pdf","Divergence_of_exit_and_entry_rate_between_LEAP_and_CanSynLBD_bw.pdf","Divergence_of_exit_and_entry_rate_between_LEAP_and_CanSynLBD.pdf","Entry_rate_bw_GsynLBD.pdf","Entry_rate_bw_private.pdf","Entry_rate_GSynLBD.pdf","Entry_rate_private.pdf","Exit_rate_bw_GsynLBD.pdf","Exit_rate_bw_private.pdf","Exit_rate_GSynLBD.pdf","Exit_rate_private.pdf","figure-strategy-2.tex","figure-strategy.log","figure-strategy.tex","Gross_employment_level_by_year_bw_GsynLBD.pdf","Gross_employment_level_by_year_manufacturing_bw.pdf","Gross_employment_level_by_year_manufacturing.pdf","Gross_employment_level_by_year_private_bw.pdf","Gross_employment_level_by_year_private.pdf","Job_creation_rate_by_year_bw_GsynLBD.pdf","Job_creation_rate_by_year_Manufacturing_bw.pdf","Job_creation_rate_by_year_Manufacturing.pdf","Job_creation_rate_by_year_private_bw.pdf","Job_creation_rate_by_year_private.pdf","Job_destruction_by_year_bw_GsynLBD.pdf","Job_destruction_rate_by_year_GsynLBD.pdf","Job_destruction_rate_by_year_Manufacturing_bw.pdf","Job_destruction_rate_by_year_Manufacturing.pdf","Job_destruction_rate_by_year_private_bw.pdf","Net_job_creation_rate_by_year_bw_GsynLBD.pdf","Net_job_creation_rate_by_year_Manufacturing_bw.pdf","Net_job_creation_rate_by_year_Manufacturing.pdf","Net_job_creation_rate_by_year_private_bw.pdf","Net_job_creation_rate_by_year_private.pdf","Share_of_employment_by_NAICS_and_year_bw_GsynLBD.pdf","Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf","Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.pdf","Share_of_employment_by_NAICS_two-digit_and_year_private_bw.pdf","Share_of_employment_by_NAICS_two-digit_and_year_private.pdf","Share_of_firms_by_NAICS_and_year_bw_GsynLBD.pdf","Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf","Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.pdf","Share_of_firms_by_NAICS_two-digit_and_year_private_bw.pdf","Share_of_firms_by_NAICS_two-digit_and_year_private.pdf","Share_of_payroll_by_NAICS_and_year_bw_GsynLBD.pdf","Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf","Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.pdf","Share_of_payroll_by_NAICS_two-digit_and_year_private_bw.pdf","Share_of_payroll_by_NAICS_two-digit_and_year_private.pdf","The_difference_between_first_and_last_year_given_synthetic_first_year_bw_GsynLBD.pdf","The_difference_between_first_and_last_year_given_synthetic_first_year_bw.pdf","The_difference_between_first_and_last_year_given_synthetic_first_year.pdf","Total_payroll_by_year_bw_GsynLBD.pdf","Total_payroll_by_year_manufacturing_bw.pdf","Total_payroll_by_year_manufacturing.pdf","Total_payroll_by_year_private_bw.pdf","Total_payroll_by_year_private.pdf"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### stata-graphs directory

The [graphs](graphs/) contains   GPH (Stata) format files, the source for the PDFs in the [graphs](graphs/) directory. The programs to generate these figures can be found in [programs/Canada](programs/Canada), and were run on the confidential data.

<!--html_preserve--><div id="htmlwidget-f49b638fe3740e5574ff" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f49b638fe3740e5574ff">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29],["Divergence_of_exit_and_entry_rate_between_BHP_and_GSynLBD.gph","Divergence_of_exit_and_entry_rate_between_LEAP_and_CanSynLBD.gph","Entry_rate_GSynLBD.gph","Entry_rate_private.gph","Exit_rate_GSynLBD.gph","Exit_rate_private.gph","Gross_employment_level_by_year_Appendix_bw_GsynLBD.gph","Gross_employment_level_by_year_manufacturing.gph","Gross_employment_level_by_year_private.gph","Job_creation_rate_by_year_GsynLBD.gph","Job_creation_rate_by_year_Manufacturing.gph","Job_creation_rate_by_year_private.gph","Job_destruction_rate_by_year_Manufacturing.gph","Net_job_creation_rate _by_year_GsynLBD.gph","Net_job_creation_rate__by_year_Manufacturing.gph","Net_job_creation_rate__by_year_private.gph","Share_of_employment_by_NAICS_and_year_GsynLBD.gph","Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.gph","Share_of_employment_by_NAICS_two-digit_and_year_private.gph","Share_of_firms_by_NAICS_and_year_GsynLBD.gph","Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.gph","Share_of_firms_by_NAICS_two-digit_and_year_private.gph","Share_of_payroll_by_NAICS_and_year_GsynLBD.gph","Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.gph","Share_of_payroll_by_NAICS_two-digit_and_year_private.gph","The_difference_between_first_and_last_year_given_synthetic_first_year_GsynLBD.gph","Total_payroll_by_year_GsynLBD.gph","Total_payroll_by_year_manufacturing.gph","Total_payroll_by_year_private.gph"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Programs

Programs for analysis ([programs/Canada](programs/Canada), used for both Canada and Germany), and post-processing ([programs/Post](programs/Post)) are provided.

<!--html_preserve--><div id="htmlwidget-448c1ed4a19cee8c641f" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-448c1ed4a19cee8c641f">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4"],[1,2,3,4],["Canada","Germany","Post","README.md"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Derived graphs

Graphs generated through post-processing ([programs/Post](programs/Post)) are available in [r-graphs](r-graphs/). 


<!--html_preserve--><div id="htmlwidget-7af98affe4ef200aa436" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7af98affe4ef200aa436">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4","5","6"],[1,2,3,4,5,6],["fig_conf_both.png","fig_estimates1.png","fig_estimates2.png","fig_estimates3.png","fig_estimates4.png","fig_estimates5.png"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Tables

Tables generated both by tabulation of confidential data ([programs/Canada](programs/Canada), used for both Canada and Germany), and post-processing ([programs/Post](programs/Post))  can be found in the [tables](tables/) directory.


## Computation

### Computational Requirements

- R (for post-processing)
- Stata (for analysis of synthetic and confidential data)
- bash shell (optional, to execute all programs in order)
- SAS (for the synthetic data generation)

### Synthetic generation

The software used to generate the synthetic data is described in Kinney et al (2011b). A copy of the code can be obtained by request.

### Intra-mural Analysis

The raw synthetic and confidential data served as input to the various analyses described in the paper. These analyses occurred within the secure environments of the respective agencies. The code for the analysis is common to both countries (with minor adjustments to account for different variable names). The code used in the Canadian context is provided as a single Stata file in the `[programs/Canada](programs/Canada)` directory.

### Extra-mural post-processing

The following programs are used to post-process the analytic results:

#### Stata programs

<!--html_preserve--><div id="htmlwidget-3482dcfd42750e4f087d" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3482dcfd42750e4f087d">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3"],[1,2,3],["01_extract_from_gph.do","config.do","program_my_extract.do"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

#### R programs

<!--html_preserve--><div id="htmlwidget-cd4dd2ad5f3e6d6dcf96" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cd4dd2ad5f3e6d6dcf96">{"x":{"filter":"none","autoHideNavigation":true,"data":[["1","2","3","4","5","6","7","8","9","10"],[1,2,3,4,5,6,7,8,9,10],["00_create_readme.R","02_read_tables.R","03_combine_tables.R","04_graph_coefs.R","05_compute_jkt.R","06_recompute_pmse.R","07_m2_table.R","08_graph_confmeasures.R","config.R","get_os.R"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Execution of programs

Numbered programs should be executed in the natural order. Other programs define locations and/or subroutines, and should not be executed. A convenience bash script `run_all.sh` is provided.

## Funding

Vilhuber acknowledges funding through NSF Grants SES-1131848 and SES-1042181, and a grant from Alfred P. Sloan Grant (G-2015-13903). Alam and Dostie acknowledge funding through SSHRC Partnership Grant "Productivity, Firms and Incomes". The creation of the Synthetic LBD  was funded by NSF Grant SES-0427889.


## License

These data are licensed under a [Creative Commons Attribution-NonCommercial 4.0 International](https://creativecommons.org/licenses/by-nc/4.0/) license. See [citation] for attribution.




