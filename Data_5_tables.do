sysdir set PLUS "~/ado/plus/"
sysdir set PERSONAL "/bplimext/projects/p068_SilvaSantosGouveia/tools"

log using "/bplimext/projects/p068_SilvaSantosGouveia/work_area/Log_2_econometrics_1417", replace


use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/finaldb.dta", clear



set more off

xtset tina ano

set seed 636299


*************************** USING PSMATCH2**********************
*************************** USING PSMATCH2**********************
*************************** USING PSMATCH2**********************

// Nearest-neighbor matching with replacement and Abadie Imbens SE

  
*OUTCOME VARIABLE: Financing
eststo financing: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit neighbor(2) caliper(0.001) common ties ai(14)

eststo b_financing: pstest
** a lot of companies have no financing in 2007, hence why we have a small treated group here. We match on 2 nn to overcome the problem.


*OUTCOME VARIABLE: total_assets
eststo totalassets: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_totalassets: pstest



*OUTCOME VARIABLE: fixed_assets
eststo fixedassets: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_fixedassets: pstest 





*OUTCOME VARIABLE: laborprod
eststo laborprod: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_laborprod: pstest




*OUTCOME VARIABLE: levpetTFP 
eststo TFP: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_TFP: pstest



*OUTCOME VARIABLE: employment
eststo employment: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_employment: pstest




*OUTCOME VARIABLE: avg_wages
eststo wages: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit neighbor(1) caliper(0.001) common ties ai(14)

eststo b_wages: pstest





*OUTCOME VARIABLE: ebitda
eststo ebitda: psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit neighbor(1) caliper(0.001) common ties ai(14)


eststo b_ebitda: pstest 



********* continues on Robustness.do file ***********



////// NON - BOOTSTRAPPED /////

esttab financing using results.tex, replace title (Results) label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab  totalassets using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab fixedassets using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab laborprod using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab TFP using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab employment using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab wages using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)

esttab ebitda using results.tex, append label lines noobs tex nonumber cells("b(fmt(4) star) se(fmt(4)) t(fmt(2)) ci(fmt(4))") star(+ 0.10 * 0.05 ** 0.01 *** 0.001) addnotes(+ p \textless 0.10, * p \textless 0.05, ** p \textless 0.01, *** p \textless 0.001)


log close

