/* Config.do */
/* Lars Vilhuber */
/* Originally created 2018-02-16 */
/* Extracts data from GPH files and saves them in the data directory */

include "config.do"
include "program_my_extract.do"

my_extract $gphdir/Gross_employment_level_by_year_manufacturing.gph
my_extract $gphdir/Gross_employment_level_by_year_private.gph
my_extract $gphdir/Job_creation_rate_by_year_Manufacturing.gph
my_extract $gphdir/Job_creation_rate_by_year_private.gph
my_extract $gphdir/Net_job_creation_rate__by_year_Manufacturing.gph
my_extract $gphdir/Net_job_creation_rate__by_year_private.gph
my_extract $gphdir/Share_of_employment_by_NAICS_two-digit_and_year_Manufacturing.gph
my_extract $gphdir/Share_of_employment_by_NAICS_two-digit_and_year_private.gph
my_extract $gphdir/Share_of_firms_by_NAICS_two-digit_and_year_Manufacturing.gph
my_extract $gphdir/Share_of_firms_by_NAICS_two-digit_and_year_private.gph
my_extract $gphdir/Share_of_payroll_by_NAICS_two-digit_and_year_Manufacturing.gph
my_extract $gphdir/Share_of_payroll_by_NAICS_two-digit_and_year_private.gph
my_extract $gphdir/Total_payroll_by_year_manufacturing.gph
my_extract $gphdir/Total_payroll_by_year_private.gph
