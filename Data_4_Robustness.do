sysdir set PLUS "/bplimext/projects/p068_SilvaSantosGouveia/tools/k/"
sysdir set PERSONAL "/bplimext/projects/p068_SilvaSantosGouveia/tools/k/"


log using "/bplimext/projects/p068_SilvaSantosGouveia/work_area/Log_4_Robustness", replace


use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/finaldb.dta", clear

xtset tina ano


*************** DIFFERENT MATCHING METHODS***********
*************** DIFFERENT MATCHING METHODS***********
*************** DIFFERENT MATCHING METHODS***********
set seed 636299

***********RESULTS WITHOUT ABADIE IMBENS SE BOOTSTRAPPED 200 TIMES********
*OUTCOME VARIABLE: Financing
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit neighbor(2) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07 

*OUTCOME VARIABLE: total_assets
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit neighbor(1) caliper(0.001) common ties

pstest collateral07 longcreditpc07 cae3 age07

*OUTCOME VARIABLE: fixed_assets
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07


*OUTCOME VARIABLE: laborprod
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07


*OUTCOME VARIABLE: levpetTFP 
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*OUTCOME VARIABLE: employment
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*OUTCOME VARIABLE: avg_wages
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*OUTCOME VARIABLE: ebitda
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit neighbor(1) caliper(0.001) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

********* 5 NEAREST-NEIGHBORS**********
********* 5 NEAREST-NEIGHBORS**********
********* 5 NEAREST-NEIGHBORS**********
* Financing
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest


* Total assets
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest


*FIXED ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest

*LABOR PROD
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest

*TFP LEVPET
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest

*EMPLOYMENT
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest

*WAGES
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest


*EBITDA
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit neighbor(5) caliper(0.001) common ties ai(14)

pstest

********* NO REPLACEMENT **********
********* NO REPLACEMENT **********
********* NO REPLACEMENT **********
* Financing
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

*TOTAL ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest
 
*FIXED ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest
 
*LABOR PROD
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

*TFP LEVPET
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

*EMPLOYMENT
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

*WAGES
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

*EBITDA
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit neighbor(1) caliper(0.001) common ties ai(14) noreplacement

pstest

************** RADIUS MATCHING 0.001**************
************** RADIUS MATCHING 0.001**************
************** RADIUS MATCHING 0.001**************
*Financing
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit radius caliper(0.001) common ties ai(14)

pstest

*TOTAL ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit radius caliper(0.001) common ties ai(14)

pstest

 *FIXED ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit radius caliper(0.001) common ties ai(14)

pstest

*LABOR PROD
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit radius caliper(0.001) common ties ai(14)

pstest

*TFP LEVPET
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit radius caliper(0.001) common ties ai(14)

pstest

*EMPLOYMENT
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit radius caliper(0.001) common ties ai(14)

pstest

*WAGES
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit radius caliper(0.001) common ties ai(14)

pstest

*EBITDA
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit radius caliper(0.001) common ties ai(14)

pstest

************** RADIUS MATCHING 0.00001**************
************** RADIUS MATCHING 0.00001**************
************** RADIUS MATCHING 0.00001**************
*Financing
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit radius caliper(0.00001) common ties ai(14)

pstest

*TOTAL ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit radius caliper(0.00001) common ties ai(14)

pstest

 *FIXED ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit radius caliper(0.00001) common ties ai(14)

pstest

*LABOR PROD
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit radius caliper(0.00001) common ties ai(14)

pstest

*TFP LEVPET
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit radius caliper(0.00001) common ties ai(14)

pstest

*EMPLOYMENT
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit radius caliper(0.00001) common ties ai(14)

pstest

*WAGES
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit radius caliper(0.00001) common ties ai(14)

pstest

*EBITDA
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit radius caliper(0.00001) common ties ai(14)


*********** KERNEL MATCHING *****************
*********** KERNEL MATCHING *****************
*********** KERNEL MATCHING *****************

* FINANCING
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest 

*TOTAL ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest 
 
*FIXED ASSETS
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit kernel kerneltype(normal) bwidth(0.06)  common ties 

pstest 

*LABOR PROD
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest

*TFP LEVPET
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest 

*EMPLOYMENT
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest 

*WAGES
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest 

*EBITDA
psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest 


*********** KERNEL MATCHING with bootstrapping*****************
*********** KERNEL MATCHING with bootstrapping*****************
*********** KERNEL MATCHING with bootstrapping*****************

* Financing
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(financing) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*TOTAL ASSETS
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 if ano==2018, outcome(t_assets1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest collateral07 longcreditpc07 cae3 age07
 
*FIXED ASSETS
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(f_assets1318) logit kernel kerneltype(normal) bwidth(0.06)  common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*LABOR PROD
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(laborprod1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*TFP LEVPET
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(levpetTFP1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*EMPLOYMENT
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(employment1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*WAGES
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(avgwages1318) logit kernel kerneltype(normal) bwidth(0.06) common ties

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07

*EBITDA
bootstrap r(att), reps(200) level(95): psmatch2 treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07 if ano==2018, outcome(ebitda1318) logit kernel kerneltype(normal) bwidth(0.06) common ties 

pstest collateral07 longcreditpc07 cae3 age07 debtassetr07



*************** USING TEFFECTS ai2**************
*************** USING TEFFECTS ai2**************
*************** USING TEFFECTS ai2**************


* FINANCING
teffects psmatch (financing) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(2)

tebalance summarize

* TOTAL ASSETS
teffects psmatch (t_assets1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* FIXED ASSETS
teffects psmatch (f_assets1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* LABOR PRODUCTIVITY
teffects psmatch (laborprod1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* TOTAL FACTOR PRODUCTIVITY
teffects psmatch (levpetTFP1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* EMPLOYMENT
teffects psmatch (employment1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* WAGES
teffects psmatch (avgwages1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

* EBITDA
teffects psmatch (ebitda1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1)

tebalance summarize

*************** USING TEFFECTS ai14**************
*************** USING TEFFECTS ai14**************
*************** USING TEFFECTS ai14**************


* FINANCING
teffects psmatch (financing) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(2) vce(robust, nn(14))

tebalance summarize

* TOTAL ASSETS
teffects psmatch (t_assets1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* FIXED ASSETS
teffects psmatch (f_assets1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* LABOR PRODUCTIVITY
teffects psmatch (laborprod1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* TOTAL FACTOR PRODUCTIVITY
teffects psmatch (levpetTFP1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* EMPLOYMENT
teffects psmatch (employment1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* WAGES
teffects psmatch (avgwages1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

* EBITDA
teffects psmatch (ebitda1318) (treat14to17 collateral07 longcreditpc07 cae3 age07 debtassetr07) if ano==2018, atet nneighbor(1) vce(robust, nn(14))

tebalance summarize

log close
