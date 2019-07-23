
set  more off
cd "\\f4cder02\2017_SynLBD_LEAP\CanSynLBD\Stata\"


*** Synthesized data
use "Ori_Syn_LEAP_long.dta", clear
keep if private_sector==1
gen Synthesized=syn_alu !=. | syn_pay !=.
keep if ori_alu>0 | ori_pay>0
egen id=group(synid)
collapse (count) id, by(Synthesized)
preserve
collapse (sum) id
tempfile means
save "means", replace
restore
append using "means"
gen total=id if Synthesized==.
recode total (.=0)
egen max_total=max(total)
gen Percentage=(id/max_total)*100
gen observation=id/1000000
format Percentage observation %9.2fc
tostring Synthesized, replace
replace Synthesized="Not synthesized" if _n==1
replace Synthesized="Synthesized" if _n==2
replace Synthesized="Total" if _n==3
drop total max_total id
order Synthesized observation Percentage
listtex Synthesized observation Percentage using  "Report\Synthesized_observations.tex" , replace rstyle(tabular)


** Dropping inudstries which have less than 10 observations
use "Ori_Syn_LEAP_long.dta", clear
keep if private_sector==1
drop if syn_alu==. | syn_pay==.
replace ori_alu=0 if year==ori_lastyear
replace ori_pay=0 if year==ori_lastyear
replace syn_alu=0 if year==syn_lastyear
replace syn_pay=0 if year==syn_lastyear
drop if year==2015
egen id=group(synid)
egen obs=count(id) if syn_alu>0 | syn_pay>0, by(naics year)
egen min_obs=min(obs), by(naics)
drop if min_obs<10
drop private_sector obs min_obs
save "TemporaryFile\MainData.dta", replace


** Gross employment and payroll
** Private
use "TemporaryFile\MainData.dta", clear
collapse (sum) ori_alu ori_pay syn_alu syn_pay, by(year)
replace ori_alu= ori_alu/1000000
replace ori_pay=ori_pay/1000000000
replace syn_alu=syn_alu/1000000
replace syn_pay=syn_pay/1000000000
format ori_alu ori_pay syn_alu syn_pay %9.2fc
**ALU
twoway (connected ori_alu  year) || (connected syn_alu  year),  xlabel(1990(5)2015, labsize(small)) ylabel(0(5)15, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) 
graph save "Report\Gross_employment_level_by_year_private.gph", replace
graph export "Report\Gross_employment_level_by_year_private.pdf", as(pdf) replace
twoway (connected ori_alu  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected syn_alu  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(0(5)15, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Gross_employment_level_by_year_private_bw.pdf", as(pdf) replace
**Payroll
twoway (connected ori_pay  year) || (connected syn_pay  year),  xlabel(1990(5)2015, labsize(small)) ylabel(0(500)1000, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) 
graph save "Report\Total_payroll_by_year_private.gph", replace
graph export "Report\Total_payroll_by_year_private.pdf", as(pdf) replace
twoway (connected ori_pay  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected syn_pay  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(0(500)1000, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Total_payroll_by_year_private_bw.pdf", as(pdf) replace

** Manufacturing 
use "TemporaryFile\MainData.dta", clear
keep if industry=="31-33"
collapse (sum) ori_alu ori_pay syn_alu syn_pay, by(year)
replace ori_alu= ori_alu/1000000
replace ori_pay=ori_pay/1000000000
replace syn_alu=syn_alu/1000000
replace syn_pay=syn_pay/1000000000
**ALU
twoway (connected ori_alu  year) || (connected syn_alu  year),  xlabel(1990(5)2015, labsize(small)) ylabel(.5(.25)2, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) 
graph save "Report\Gross_employment_level_by_year_manufacturing.gph", replace
graph export "Report\Gross_employment_level_by_year_manufacturing.pdf", as(pdf) replace
twoway (connected ori_alu  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected syn_alu  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(.5(.25)2, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Gross_employment_level_by_year_manufacturing_bw.pdf", as(pdf) replace
**Payroll
twoway (connected ori_pay  year) || (connected syn_pay  year),  xlabel(1990(5)2015, labsize(small)) ylabel(25(25)100, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) 
graph save "Report\Total_payroll_by_year_manufacturing.gph", replace
graph export "Report\Total_payroll_by_year_manufacturing.pdf", as(pdf) replace
twoway (connected ori_pay  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected syn_pay  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(25(25)100, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Total_payroll_by_year_manufacturing_bw.pdf", as(pdf) replace



** Share
** Private 
use "TemporaryFile\MainData.dta", clear
gen ori_firm=ori_alu>0 | ori_pay>0
gen syn_firm=syn_alu>0 | syn_pay>0
collapse (sum) ori_firm syn_firm ori_alu ori_pay syn_alu syn_pay, by(naics_2digits year)
local all ori_firm syn_firm ori_alu ori_pay syn_alu syn_pay
foreach x in `all'{
egen sum_`x'=total(`x')
replace `x'=(`x'/sum_`x')*100
format `x' %9.2fc
}
** Share of firms
twoway (scatter syn_firm ori_firm ) || (function y=x, range(0 1)),  xlabel(0(.25)1, labsize(small)) ylabel(0(.5)1, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) 
graph save "Report\Share_of_firms_by_NAICS_two-digit_and_year_private.gph", replace
graph export "Report\Share_of_firms_by_NAICS_two-digit_and_year_private.pdf", as(pdf) replace
twoway (scatter syn_firm ori_firm, mcolor(black) ) || (function y=x, range(0 1)lcolor(black)),  xlabel(0(.25)1, labsize(small)) ylabel(0(.5)1, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_firms_by_NAICS_two-digit_and_year_private_bw.pdf", as(pdf) replace
** Share of employment
twoway (scatter syn_alu ori_alu ) || (function y=x, range(0 1)),  xlabel(0(.5)1, labsize(small)) ylabel(0(.5)1, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) 
graph save "Report\Share_of_employment_by_NAICS_two-digit_and_year_private.gph", replace
graph export "Report\Share_of_employment_by_NAICS_two-digit_and_year_private.pdf", as(pdf) replace
twoway (scatter syn_alu ori_alu, mcolor(black) ) || (function y=x, range(0 1)lcolor(black)),  xlabel(0(.5)1, labsize(small)) ylabel(0(.5)1, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_employment_by_NAICS_two-digit_and_year_private_bw.pdf", as(pdf) replace
** Share of payroll
twoway (scatter syn_pay ori_pay ) || (function y=x, range(0 2)),  xlabel(0(.5)2, labsize(small)) ylabel(0(.5)2, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) 
graph save "Report\Share_of_payroll_by_NAICS_two-digit_and_year_private.gph", replace
graph export "Report\Share_of_payroll_by_NAICS_two-digit_and_year_private.pdf", as(pdf) replace
twoway (scatter syn_pay ori_pay, mcolor(black) ) || (function y=x, range(0 2)lcolor(black)),  xlabel(0(.5)2, labsize(small)) ylabel(0(.5)2, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_payroll_by_NAICS_two-digit_and_year_private_bw.pdf", as(pdf) replace

** Manufacturing 
use "TemporaryFile\MainData.dta", clear
keep if industry=="31-33"
gen ori_firm=ori_alu>0 | ori_pay>0
gen syn_firm=syn_alu>0 | syn_pay>0
collapse (sum) ori_firm syn_firm ori_alu ori_pay syn_alu syn_pay, by(naics_2digits year)
local all ori_firm syn_firm ori_alu ori_pay syn_alu syn_pay
foreach x in `all'{
egen sum_`x'=total(`x')
replace `x'=(`x'/sum_`x')*100
format `x' %9.2fc
}
** Share of firms
twoway (scatter syn_firm ori_firm ) || (function y=x, range(0 3)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) 
graph save "Report\Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.gph", replace
graph export "Report\Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.pdf", as(pdf) replace
twoway (scatter syn_firm ori_firm, mcolor(black) ) || (function y=x, range(0 3)lcolor(black)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf", as(pdf) replace
** Share of employment
twoway (scatter syn_alu ori_alu ) || (function y=x, range(0 3)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) 
graph save "Report\Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.gph", replace
graph export "Report\Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.pdf", as(pdf) replace
twoway (scatter syn_alu ori_alu, mcolor(black) ) || (function y=x, range(0 3)lcolor(black)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf", as(pdf) replace
** Share of payroll
twoway (scatter syn_pay ori_pay ) || (function y=x, range(0 3)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) 
graph save "Report\Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.gph", replace
graph export "Report\Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.pdf", as(pdf) replace
twoway (scatter syn_pay ori_pay, mcolor(black) ) || (function y=x, range(0 3)lcolor(black)),  xlabel(0(.5)3, labsize(small)) ylabel(0(.5)3, labsize(small)) xtitle("LEAP", size(small)) ytitle("CanSynLBD", size(small)) legend(off) plotregion(color(white)) graphregion(color(white))
graph export "Report\Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing_bw.pdf", as(pdf) replace


*** Firm dynamics
** private
*** Firm dynamics
use "TemporaryFile\MainData.dta", clear
sort synid year
by synid: gen previous_alu=ori_alu[_n-1]
gen alugrowth= ori_alu - previous_alu
gen z_et=0.5*(ori_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation_ori=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction_ori=abs(alugrowth)/z_t if alugrowth<0
collapse (sum) job_creation_ori job_destruction_ori, by(year)
gen net_job_creation_ori=job_creation_ori - job_destruction_ori
drop if year==1991
sort year
save "TemporaryFile\Dynamics_Ori.dta", replace

use "TemporaryFile\MainData.dta", clear
sort synid year
by synid: gen previous_alu=syn_alu[_n-1]
gen alugrowth= syn_alu - previous_alu
gen z_et=0.5*(syn_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation_syn=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction_syn=abs(alugrowth)/z_t if alugrowth<0
collapse (sum) job_creation_syn job_destruction_syn, by(year)
gen net_job_creation_syn=job_creation_syn - job_destruction_syn
drop if year==1991
sort year
save "TemporaryFile\Dynamics_Syn.dta", replace

use "TemporaryFile\Dynamics_Ori.dta", clear
sort year
merge m:1 year using "TemporaryFile\Dynamics_Syn.dta"
drop _merge
local all job_creation_ori job_destruction_ori net_job_creation_ori job_creation_syn job_destruction_syn net_job_creation_syn
foreach x in `all'{
replace `x'=`x'*100
format `x' %9.2fc
}
** Job creation
twoway (connected job_creation_ori  year) || (connected job_creation_syn  year),  xlabel(1990(5)2015, labsize(small)) ylabel(0(10)30, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) 
graph save "Report\Job_creation_rate_by_year_private.gph", replace
graph export "Report\Job_creation_rate_by_year_private.pdf", as(pdf) replace
twoway (connected job_creation_ori  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected job_creation_syn  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(0(10)30, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Job_creation_rate_by_year_private_bw.pdf", as(pdf) replace
**Net job creation
twoway (connected net_job_creation_ori  year) || (connected net_job_creation_syn  year),  xlabel(1990(5)2015, labsize(small)) ylabel(-25(10)15, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) 
graph save "Report\Net_job_creation_rate _by_year_private.gph", replace
graph export "Report\Net_job_creation_rate_by_year_private.pdf", as(pdf) replace
twoway (connected net_job_creation_ori  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected net_job_creation_syn  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(-25(10)15, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Net_job_creation_rate_by_year_private_bw.pdf", as(pdf) replace


** Manufacturing
*** Firm dynamics
use "TemporaryFile\MainData.dta", clear
keep if industry =="31-33"
sort synid year
by synid: gen previous_alu=ori_alu[_n-1]
gen alugrowth= ori_alu - previous_alu
gen z_et=0.5*(ori_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation_ori=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction_ori=abs(alugrowth)/z_t if alugrowth<0
collapse (sum) job_creation_ori job_destruction_ori , by(year)
gen net_job_creation_ori=job_creation_ori - job_destruction_ori
drop if year==1991
sort year
save "TemporaryFile\Dynamics_Ori.dta", replace

use "TemporaryFile\MainData.dta", clear
keep if industry =="31-33"
sort synid year
by synid: gen previous_alu=syn_alu[_n-1]
gen alugrowth= syn_alu - previous_alu
gen z_et=0.5*(syn_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation_syn=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction_syn=abs(alugrowth)/z_t if alugrowth<0
collapse (sum) job_creation_syn job_destruction_syn , by(year)
gen net_job_creation_syn=job_creation_syn - job_destruction_syn
drop if year==1991
sort year
save "TemporaryFile\Dynamics_Syn.dta", replace

use "TemporaryFile\Dynamics_Ori.dta", clear
sort year
merge m:1 year using "TemporaryFile\Dynamics_Syn.dta"
drop _merge
local all job_creation_ori job_destruction_ori net_job_creation_ori job_creation_syn job_destruction_syn net_job_creation_syn
foreach x in `all'{
replace `x'=`x'*100
format `x' %9.2fc
}
** Job creation
twoway (connected job_creation_ori  year) || (connected job_creation_syn  year),  xlabel(1990(5)2015, labsize(small)) ylabel(0(5)20, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) 
graph save "Report\Job_creation_rate_by_year_Manufacturing.gph", replace
graph export "Report\Job_creation_rate_by_year_Manufacturing.pdf", as(pdf) replace
twoway (connected job_creation_ori  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected job_creation_syn  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(0(5)20, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Job_creation_rate_by_year_Manufacturing_bw.pdf", as(pdf) replace
**Net job creation
twoway (connected net_job_creation_ori  year) || (connected net_job_creation_syn  year),  xlabel(1990(5)2015, labsize(small)) ylabel(-15(5)15, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) 
graph save "Report\Net_job_creation_rate _by_year_Manufacturing.gph", replace
graph export "Report\Net_job_creation_rate_by_year_Manufacturing.pdf", as(pdf) replace
twoway (connected net_job_creation_ori  year, lpattern(dash) lcolor(black) msymbol(circle) mcolor(black)) || (connected net_job_creation_syn  year, lpattern(solid) lcolor(black) msymbol(diamond) mcolor(black)),  xlabel(1990(5)2015, labsize(small)) ylabel(-15(5)15, labsize(small)) xtitle("Year", size(small)) ytitle("Job creation rate (%)", size(small)) legend(label(1 "LEAP") label(2 "CanSynLBD")  size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Net_job_creation_rate_by_year_Manufacturing_bw.pdf", as(pdf) replace


*** Exit and entry
use "TemporaryFile\MainData.dta", clear
sort synid year
by synid: gen previous_alu=ori_alu[_n-1]
gen dynamics="incumbent" if ori_alu>0 & previous_alu>0
replace dynamics="entry" if ori_alu>0 & previous_alu==0
replace dynamics="exit" if ori_alu==0 & previous_alu>0
drop if year==1991
drop if dynamics ==""
collapse (count) id, by(year dynamics)
reshape wide id, i(year) j(dynamics) string
gen entry_ori=(identry/( identry+ idexit+ idincumbent))*100
gen exit_ori=(idexit/( identry+ idexit+ idincumbent))*100
format entry_ori exit_ori %9.2fc
keep year entry_ori exit_ori
save "TemporaryFile\Entry_Exit_Ori.dta", replace

use "TemporaryFile\MainData.dta", clear
sort synid year
by synid: gen previous_alu=syn_alu[_n-1]
gen dynamics="incumbent" if syn_alu>0 & previous_alu>0
replace dynamics="entry" if syn_alu>0 & previous_alu==0
replace dynamics="exit" if syn_alu==0 & previous_alu>0
drop if year==1991
drop if dynamics ==""
collapse (count) id, by(year dynamics)
reshape wide id, i(year) j(dynamics) string
gen entry_syn=(identry/( identry+ idexit+ idincumbent))*100
gen exit_syn=(idexit/( identry+ idexit+ idincumbent))*100
format entry_syn exit_syn %9.2fc
keep year entry_syn exit_syn
save "TemporaryFile\Entry_Exit_Syn.dta", replace

use "TemporaryFile\Entry_Exit_Ori.dta", clear
sort year
merge m:1 year using "TemporaryFile\Entry_Exit_Syn.dta"
drop _merge
listtex year entry_ori exit_ori entry_syn exit_syn using  "Report\Entry_and_exit_rate_by_year.tex" , replace rstyle(tabular)
export excel using  "Report\Entry_and_exit_rate_by_year.xls" , replace firstrow(variables)






** Regression 
use "TemporaryFile\MainData.dta", clear
keep if ori_alu>0 | ori_pay>0
gen log_alu=ln(ori_alu)
gen log_pay=ln(ori_pay)
sort id year
egen min_year=min(year), by(id)
gen age=year-min_year+1
recode age (1/2=1) (3/4=2) (5/7=3) (8/12=4) (13/30=5), gen (age_group)
gen size_group=1 if ori_alu<20
replace size_group=2 if ori_alu>=20 & ori_alu<100
replace size_group=3 if ori_alu>=100
save "TemporaryFile\Regression_Ori.dta", replace

use "TemporaryFile\MainData.dta", clear
keep if syn_alu>0 | syn_pay>0
gen log_alu=ln(syn_alu)
gen log_pay=ln(syn_pay)
sort id year
egen min_year=min(year), by(id)
gen age=year-min_year+1
recode age (1/2=1) (3/4=2) (5/7=3) (8/12=4) (13/30=5), gen (age_group)
gen size_group=1 if syn_alu<20
replace size_group=2 if syn_alu>=20 & syn_alu<100
replace size_group=3 if syn_alu>=100
save "TemporaryFile\Regression_Syn.dta", replace


** Economic Growth - OLS
eststo clear
use "TemporaryFile\Regression_Ori.dta", clear
xtset id year 
tab age_group, gen (age)
eststo : xi: quiet areg log_alu l.log_alu log_pay age2 - age5  i.year, absorb( naics )
eststo : xi: quiet areg log_alu l.log_alu log_pay age2 - age5 i.year if industry =="31-33", absorb( naics )
use "TemporaryFile\Regression_Syn.dta", clear
xtset id year 
tab age_group, gen (age)
eststo : xi: quiet areg log_alu l.log_alu log_pay age2 - age5  i.year, absorb( naics )
eststo : xi: quiet areg log_alu l.log_alu log_pay age2 - age5  i.year if industry =="31-33", absorb( naics )
esttab using "Report\Regression_coefficients_OLS.tex", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) r2(%8.4f) se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01) r2    mtitles(Private Manufacturing Private Manufacturing)  replace nonumbers fragment 
esttab using "Report\Regression_coefficients_OLS.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) r2(%8.4f) se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01) r2    mtitles(Private Manufacturing Private Manufacturing)  replace nonumbers  
esttab using "Report\Regression_coefficients_OLS2.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) r2(%8.4f) se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   r2    mtitles(Private Manufacturing Private Manufacturing)  replace nonumbers  plain noparentheses  nostar wide   
eststo clear


** Economic Growth -Dynamic GMM
global exogenous log_pay age2 - age5  i.year

eststo clear
use "TemporaryFile\Regression_Ori.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu)   hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu)   hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu)   hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu)   hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
use "TemporaryFile\Regression_Syn.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu)   hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu)   hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu)   hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu)   hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
esttab using "Report\Regression_coefficients_Dynamic_GMM.tex", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)    mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers fragment 
esttab using "Report\Regression_coefficients_Dynamic_GMM.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)   mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  
esttab using "Report\Regression_coefficients_Dynamic2_GMM.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) se(%8.4f) order(L.log_alu log_pay age2 age3 age4  age5) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress    mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  plain noparentheses  nostar wide  
eststo clear



** Economic Growth -Dynamic System GMM
global exogenous log_pay age2 - age5  i.year

eststo clear
use "TemporaryFile\Regression_Ori.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu)  lgmmiv(log_alu) hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
use "TemporaryFile\Regression_Syn.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu) lgmmiv(log_alu)  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
esttab using "Report\Regression_coefficients_Dynamic_System_GMM.tex", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)    mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers fragment 
esttab using "Report\Regression_coefficients_Dynamic_System_GMM.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)   mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  
esttab using "Report\Regression_coefficients_Dynamic2_System_GMM.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) order(L.log_alu log_pay age2 age3 age4  age5) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress      mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  plain noparentheses  nostar wide  
eststo clear



** Economic Growth -Dynamic System GMM with MA(1)
global exogenous log_pay age2 - age5  i.year
eststo clear
use "TemporaryFile\Regression_Ori.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu, lag(3 .))  lgmmiv(log_alu, lag(2)) hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
use "TemporaryFile\Regression_Syn.dta", clear
xtset id year 
tab age_group, gen (age)
xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous, iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons vce(robust) 
estat abond
mat m2=r(arm)
local m2=round(m2[2,2], 0.01)
eststo : xi: quiet xtdpd L(0/1).log_alu $exogenous if industry =="31-33", iv($exogenous) dgmmiv(log_alu, lag(3 .)) lgmmiv(log_alu, lag(2))  hascons 
estat sargan 
estadd scalar Sargan=round(e(sargan), 0.01)
estadd scalar p_value= round(chi2tail(e(zrank)-e(rank), e(sargan)), 0.01)
estadd scalar DF=int(e(zrank)-e(rank))
estadd scalar m2=`m2'
esttab using "Report\Regression_coefficients_Dynamic_System_GMM_MA.tex", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)   mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers fragment 
esttab using "Report\Regression_coefficients_Dynamic_System_GMM_MA.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f)  se(%8.4f) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress   star(* 0.1  ** 0.05 *** 0.01)    mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  
esttab using "Report\Regression_coefficients_Dynamic2_System_GMM_MA.csv", keep (L.log_alu log_pay age2 age3 age4  age5) b(%8.4f) se(%8.4f) order(L.log_alu log_pay age2 age3 age4  age5) coeflabels (L.log_alu "AR(1) Coefficient" log_pay "Ln Pay" age2 "Age 3-4" age3 "Age 5-7" age4 "Age 8-12"  age5 "Age 13 or more")  compress      mtitles(Private Manufacturing Private Manufacturing) scalars("m2 m2" "Sargan Sargan test" "DF df of Sargan Test" "p_value P value of Sargan test") replace nonumbers  plain noparentheses  nostar wide  
eststo clear




*** Confidentiality 
** Code in SAS
** Firstyear and lastyear
use "Ori_Syn_LEAP_long.dta", clear
egen id=group(synid)
keep if private_sector==1
drop if syn_alu==. | syn_pay==.
gen ori_syn_firstyear=1 if ori_firstyear==syn_firstyear & syn_firstyear==year
collapse syn_firstyear ori_syn_firstyear, by(id naics)
collapse (sum) ori_syn_firstyear (count) id, by(naics syn_firstyear)
drop if syn_firstyear==.
gen probability=(ori_syn_firstyear /id)*100
format probability %9.2fc
collapse (min) min=probability (mean) mean=probability (max) max=probability, by(syn_firstyear)
*drop if syn_firstyear==2015
gen actualyear=syn_firstyear
order syn_firstyear actualyear min mean max
listtex syn_firstyear actualyear min mean max using  "Report\Observed_firm_births_given_synthetic_births_private.tex" , replace rstyle(tabular)
export excel using  "Report\Observed_firm_births_given_synthetic_births_private.csv" , replace firstrow(variables)


use "Ori_Syn_LEAP_long.dta", clear
egen id=group(synid)
keep if private_sector==1
drop if syn_alu==. | syn_pay==.
keep if industry =="31-33"
gen ori_syn_firstyear=1 if ori_firstyear==syn_firstyear & syn_firstyear==year
collapse syn_firstyear ori_syn_firstyear, by(id naics)
collapse (sum) ori_syn_firstyear (count) id, by(naics syn_firstyear)
drop if syn_firstyear==.
gen probability=(ori_syn_firstyear /id)*100
format probability %9.2fc
collapse (min) min=probability (mean) mean=probability (max) max=probability, by(syn_firstyear)
*drop if syn_firstyear==2015
gen actualyear=syn_firstyear
order syn_firstyear actualyear min mean max
listtex syn_firstyear actualyear min mean max using  "Report\Observed_firm_births_given_synthetic_births_manufacturing.tex" , replace rstyle(tabular)
export excel using  "Report\Observed_firm_births_given_synthetic_births_manufacturing.csv" , replace firstrow(variables)



*** Distribution of the difference between last year and first year given synthetic first year
use "Ori_Syn_LEAP_long.dta", clear
egen id=group(synid)
keep if private_sector==1
drop if syn_alu==. | syn_pay==.
drop if ori_alu==0 | ori_pay==0
gen year_difference=ori_lastyear - ori_firstyear
collapse year_difference, by(synid syn_firstyear industry)
twoway kdensity year_difference, lpattern(dash) || kdensity year_difference if industry =="31-33", lpattern(solid) legend(label(1 "Private sector")  label(2 "Manufacturing secttor") size(small)) ytitle("Density", size(small)) xtitle("Difference between first year and last year given synthetic first year", size(small)) xlabel(0(5)25, labsize(small)) ylabel(0(.05)0.25, labsize(small))
graph save "Report\The_difference_between_first_and_last_year_given_synthetic_first_year.gph", replace
graph export "Report\The_difference_between_first_and_last_year_given_synthetic_first_year.pdf", as(pdf) replace
twoway kdensity year_difference, lpattern(dash) lcolor(black) || kdensity year_difference if industry =="31-33", lpattern(solid) lcolor(black) legend(label(1 "Private sector")  label(2 "Manufacturing secttor") size(small)) ytitle("Density", size(small)) xtitle("Difference between first year and last year given synthetic first year", size(small)) xlabel(0(5)25, labsize(small)) ylabel(0(.05)0.25, labsize(small))
graph export "Report\The_difference_between_first_and_last_year_given_synthetic_first_year_bw.pdf", as(pdf) replace



*** Appendix

** Gross employment and payroll - confidence interval
** Private
use "TemporaryFile\MainData.dta", clear
keep if ori_alu>0 | ori_pay>0
collapse (mean) ori_alu ori_pay (semean) se_ori_alu=ori_alu se_ori_pay=ori_pay (count)ori_id=id, by(year)
sort year
save "TemporaryFile\Ori_Confidence_Interval.dta", replace

use "TemporaryFile\MainData.dta", clear
keep if syn_alu>0 | syn_pay>0
collapse (mean) syn_alu syn_pay (semean) se_syn_alu=syn_alu se_syn_pay=syn_pay (count)syn_id=id, by(year)
sort year
save "TemporaryFile\Syn_Confidence_Interval.dta", replace

use "TemporaryFile\Ori_Confidence_Interval.dta", clear
sort  year
merge 1:1 year using "TemporaryFile\Syn_Confidence_Interval.dta"
drop _merge
gen low_ori_alu=ori_id*(ori_alu-1.96*se_ori_alu)/1000000
gen hig_ori_alu=ori_id*(ori_alu+1.96*se_ori_alu)/1000000
gen low_ori_pay=ori_id*(ori_pay-1.96*se_ori_pay)/1000000000
gen hig_ori_pay=ori_id*(ori_pay+1.96*se_ori_pay)/1000000000
gen low_syn_alu=syn_id*(syn_alu-1.96*se_syn_alu)/1000000
gen hig_syn_alu=syn_id*(syn_alu+1.96*se_syn_alu)/1000000
gen low_syn_pay=syn_id*(syn_pay-1.96*se_syn_pay)/1000000000
gen hig_syn_pay=syn_id*(syn_pay+1.96*se_syn_pay)/1000000000
replace ori_alu= ori_id*ori_alu/1000000
replace ori_pay=ori_id*ori_pay/1000000000
replace syn_alu=syn_id*syn_alu/1000000
replace syn_pay=syn_id*syn_pay/1000000000
format ori_alu ori_pay syn_alu syn_pay %9.2fc
**ALU
twoway (rarea low_ori_alu hig_ori_alu year, astyle(ci)) || (connected ori_alu  year, mstyle(p1) mcolor(black) lcolor(black) lpattern(dash)) || (rarea low_syn_alu hig_syn_alu year, astyle(ci)) || (connected syn_alu  year, mstyle(p1) mcolor(black) lcolor(black)msymbol(diamond)), xlabel(1990(5)2015, labsize(small)) ylabel(0(5)15, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "95% confidence interval") label(2 "LEAP") label(3 "95% confidence interval") label(4 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Gross_employment_level_by_year_private_Appendix_bw.pdf", as(pdf) replace
graph save "Report\Gross_employment_level_by_year_private_Appendix_bw.gph", replace
**Payroll
twoway (rarea low_ori_pay hig_ori_pay year, astyle(ci)) || (connected ori_pay  year, mstyle(p1) mcolor(black) lcolor(black) lpattern(dash)) || (rarea low_syn_pay hig_syn_pay year, astyle(ci)) || (connected syn_pay  year, mstyle(p1) mcolor(black) lcolor(black)msymbol(diamond)), xlabel(1990(5)2015, labsize(small)) ylabel(0(500)1000, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "95% confidence interval") label(2 "LEAP") label(3 "95% confidence interval") label(4 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Total_payroll_by_year_private_Appendix_bw.pdf", as(pdf) replace
graph save "Report\Total_payroll_by_year_private_Appendix_bw.gph", replace

** Manufacturing 
use "TemporaryFile\MainData.dta", clear
keep if industry=="31-33"
keep if ori_alu>0 | ori_pay>0
collapse (mean) ori_alu ori_pay (semean) se_ori_alu=ori_alu se_ori_pay=ori_pay (count)ori_id=id, by(year)
sort year
save "TemporaryFile\Ori_Confidence_Interval.dta", replace

use "TemporaryFile\MainData.dta", clear
keep if industry=="31-33"
keep if syn_alu>0 | syn_pay>0
collapse (mean) syn_alu syn_pay (semean) se_syn_alu=syn_alu se_syn_pay=syn_pay (count)syn_id=id, by(year)
sort year
save "TemporaryFile\Syn_Confidence_Interval.dta", replace

use "TemporaryFile\Ori_Confidence_Interval.dta", clear
sort  year
merge 1:1 year using "TemporaryFile\Syn_Confidence_Interval.dta"
drop _merge
gen low_ori_alu=ori_id*(ori_alu-1.96*se_ori_alu)/1000000
gen hig_ori_alu=ori_id*(ori_alu+1.96*se_ori_alu)/1000000
gen low_ori_pay=ori_id*(ori_pay-1.96*se_ori_pay)/1000000000
gen hig_ori_pay=ori_id*(ori_pay+1.96*se_ori_pay)/1000000000
gen low_syn_alu=syn_id*(syn_alu-1.96*se_syn_alu)/1000000
gen hig_syn_alu=syn_id*(syn_alu+1.96*se_syn_alu)/1000000
gen low_syn_pay=syn_id*(syn_pay-1.96*se_syn_pay)/1000000000
gen hig_syn_pay=syn_id*(syn_pay+1.96*se_syn_pay)/1000000000
replace ori_alu= ori_id*ori_alu/1000000
replace ori_pay=ori_id*ori_pay/1000000000
replace syn_alu=syn_id*syn_alu/1000000
replace syn_pay=syn_id*syn_pay/1000000000
format ori_alu ori_pay syn_alu syn_pay %9.2fc
**ALU
twoway (rarea low_ori_alu hig_ori_alu year, astyle(ci)) || (connected ori_alu  year, mstyle(p1) mcolor(black) lcolor(black) lpattern(dash)) || (rarea low_syn_alu hig_syn_alu year, astyle(ci)) || (connected syn_alu  year, mstyle(p1) mcolor(black) lcolor(black)msymbol(diamond)), xlabel(1990(5)2015, labsize(small)) ylabel(.5(.25)2, labsize(small)) xtitle("Year", size(small)) ytitle("Gross employment (millions)", size(small)) legend(label(1 "95% confidence interval") label(2 "LEAP") label(3 "95% confidence interval") label(4 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Gross_employment_level_by_year_manufacturing_Appendix_bw.pdf", as(pdf) replace
graph save "Report\Gross_employment_level_by_year_manufacturing_Appendix_bw.gph", replace
**Payroll
twoway (rarea low_ori_pay hig_ori_pay year, astyle(ci)) || (connected ori_pay  year, mstyle(p1) mcolor(black) lcolor(black) lpattern(dash)) || (rarea low_syn_pay hig_syn_pay year, astyle(ci)) || (connected syn_pay  year, mstyle(p1) mcolor(black) lcolor(black)msymbol(diamond)), xlabel(1990(5)2015, labsize(small)) ylabel(25(25)100, labsize(small)) xtitle("Year", size(small)) ytitle("Total payroll (billions)", size(small)) legend(label(1 "95% confidence interval") label(2 "LEAP") label(3 "95% confidence interval") label(4 "CanSynLBD") size(small)) plotregion(color(white)) graphregion(color(white))
graph export "Report\Total_payroll_by_year_manufacturing_Appendix_bw.pdf", as(pdf) replace
graph save "Report\Total_payroll_by_year_manufacturing_Appendix_bw.gph", replace





** Creating sas data for vetting
use "TemporaryFile\Regression_Ori.dta", clear
*keep if year>=2001
xtset id year 
tab age_group, gen (age)
gen group=1
gen AR_1=l.log_alu
*drop if AR_1==.
sort synid year
by synid: gen previous_alu=ori_alu[_n-1]
gen alugrowth= ori_alu - previous_alu
gen z_et=0.5*(ori_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction=abs(alugrowth)/z_t if alugrowth<0
drop previous_alu alugrowth z_et z_t
gen net_job=job_creation - job_destruction
saveold "\\f4cder02\2017_SynLBD_LEAP\CanSynLBD\UserGuide\Vetting\PrivateSectorRegression.dta", replace 

use "TemporaryFile\Regression_Ori.dta", clear
*keep if year>=2001
xtset id year 
tab age_group, gen (age)
keep if industry =="31-33"
gen group=1
gen AR_1=l.log_alu
*drop if AR_1==.
sort synid year
by synid: gen previous_alu=ori_alu[_n-1]
gen alugrowth= ori_alu - previous_alu
gen z_et=0.5*(ori_alu + previous_alu)
egen z_t=total(z_et), by(year)
gen job_creation=abs(alugrowth)/z_t if alugrowth>0
gen job_destruction=abs(alugrowth)/z_t if alugrowth<0
drop previous_alu alugrowth z_et z_t
gen net_job=job_creation - job_destruction
saveold "\\f4cder02\2017_SynLBD_LEAP\CanSynLBD\UserGuide\Vetting\ManufacturingSectorRegression.dta", replace 



exit


