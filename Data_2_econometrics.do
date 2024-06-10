sysdir set PLUS "~/ado/plus/"
sysdir set PERSONAL "/bplimext/projects/p068_SilvaSantosGouveia/tools"

log using "/bplimext/projects/p068_SilvaSantosGouveia/work_area/Log_2_econometrics", replace


use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/finaldb.dta", clear



set more off

xtset tina ano

set seed 636299


*************************** USING PSMATCH2**********************
*************************** USING PSMATCH2**********************
*************************** USING PSMATCH2**********************

// Nearest-neighbor matching with replacement and Abadie Imbens SE

  
*OUTCOME VARIABLE: Financing
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit neighbor(2) caliper(0.001) common ties ai(14)

pstest
** a lot of companies have no financing in 2007, hence why we have a small treated group here. We match on 2 nn to overcome the problem.


*OUTCOME VARIABLE: total_assets
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14)

pstest



*OUTCOME VARIABLE: fixed_assets
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14)

pstest 



*OUTCOME VARIABLE: laborprod
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit neighbor(1) caliper(0.001) common ties ai(14) ate

pstest



*OUTCOME VARIABLE: levpetTFP 
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit neighbor(1) caliper(0.001) common ties ai(14)

pstest



*OUTCOME VARIABLE: employment
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit neighbor(1) caliper(0.001) common ties ai(14)

pstest



*OUTCOME VARIABLE: avg_wages
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit neighbor(1) caliper(0.001) common ties ai(14)

pstest




*OUTCOME VARIABLE: ebitda
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit neighbor(1) caliper(0.001) common ties ai(14)


pstest 



********* continues on Robustness.do file ***********



log close

