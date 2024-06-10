sysdir set PLUS "~/ado/plus/"
sysdir set PERSONAL "/bplimext/projects/p068_SilvaSantosGouveia/tools"


log using "/bplimext/projects/p068_SilvaSantosGouveia/work_area/Log_1_Curation", replace




set more off


*****************MERGING TABLES*****************************
*****************MERGING TABLES*****************************
*****************MERGING TABLES*****************************

use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/ROSTO_2006-2018.dta", clear

merge 1:1 tina ano using DR_2006-2018, generate(dr)

merge 1:1 tina ano using PESSOAL_2006-2018, generate(_pessoal)

merge 1:1 tina ano using EXPORT_2006-2018, generate (_export)

merge 1:m tina ano using "AMARC_edit", keep(master match) keepusing(tipoacont) generate (_amarc)


* Delete duplicate observations arising from merge with AMARC_edit
//duplicates report tina ano
duplicates drop tina ano, force

joinby tina ano using "CRC_2014_edit", update unmatched(master) _merge(garant2014)
joinby tina ano using "CRC_2015_edit", update unmatched(master) _merge(garant2015)
joinby tina ano using "CRC_2016_edit", update unmatched(master) _merge(garant2016)
joinby tina ano using "CRC_2017_edit", update unmatched(master) _merge(garant2017)

sort tina ano

drop _export _pessoal dr tipogarantia

save "/bplimext/projects/p068_SilvaSantosGouveia/work_area/merged.dta", replace

**********************CURATION FOR POLICY ELIGIBILITY*****************
**********************CURATION FOR POLICY ELIGIBILITY*****************
**********************CURATION FOR POLICY ELIGIBILITY*****************

use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/merged.dta", clear


***** INTEGRITY CHECK *****

bysort tina (ano): egen counter_beforedrop = count(tina)

***** INTEGRITY CHECK *****



* Dummies for firms if treated and treatment year
bysort tina (ano): egen byte treated14 = max(garant2014)
replace treated14 = 0 if treated14 == 1
replace treated14 = 1 if treated14 == 3

bysort tina (ano): egen byte treated15 = max(garant2015)
replace treated15 = 0 if treated15 == 1
replace treated15 = 1 if treated15 == 3

bysort tina (ano): egen byte treated16 = max(garant2016)
replace treated16 = 0 if treated16 == 1
replace treated16 = 1 if treated16 == 3

bysort tina (ano): egen byte treated17 = max(garant2017)
replace treated17 = 0 if treated17 == 1
replace treated17 = 1 if treated17 == 3

** Finding nr of firms treated in each year
*2014
egen counter14 = group(tina) if treated14==1
sum counter14
drop counter14
//485 firms observed

*2015
egen counter15 = group(tina) if treated15==1
sum counter15
drop counter15
//564 firms observed

*2016
egen counter16 = group(tina) if treated16==1
sum counter16
drop counter16
// 332 firms observed

*2017
egen counter17 = group(tina) if treated17==1
sum counter17
drop counter17
// 276 firms observed


** Tagging firms for treatment in 2014 or 2015 or 2016 or 2017

bysort tina: egen byte treat14to17 = max(treated14 | treated15 | treated16 | treated17)


** Finding nr of firms treated  14 to 17
egen counter14to17 = group(tina) if treat14to17==1
sum counter14to17
drop counter14to17
// 725 firms (because some firms are treated in more than one year)



********Policy eligibility *********
********Policy eligibility *********
********Policy eligibility *********


* Dropping if firms always large
bysort tina: egen avg_size = mean(dimcomissao)
drop if avg_size == 4

drop avg_size


* Dropping if untreated firms with negative liquid result in 2013 or 2014 or 2015 or 2016 [years prior to policy attribution]
bysort tina (ano): gen float result_liq = D087 if (ano == 2013 | ano == 2014 | ano == 2015 | ano == 2016)

bysort tina (ano): drop if result_liq < 0

drop result_liq


* Deleting firms from Açores or Madeira since rules are different
//tab distrito
bysort tina (ano): drop if distrito == 19 | distrito == 20 | distrito == 21 | distrito == 22


* Deleting firms with no information available at all
bysort tina (ano): drop if sitempresa ==.


* Correcting missing values in database
* the following set of rules must be run in this exact order
replace E005 = 0 if E001==.
replace E007 = 0 if E001==.
replace E007 = 0 if (E006 == 0 & E007==.)
replace E007 = 0 if (E004 == E002 & E007==.)
replace E005 = 0 if (E002 == E006 & E005==.)
replace E007 = 0 if (E002+E003 == E001 & E007 ==.)
replace E005 = 0 if E001 == 0
replace E007 = 0 if (E004 == E001 & E007==.)
replace E005 = 0 if (E006 == E001 & E005==.)
//had to make a call here based on the lack of data
replace E007 = 0 if (E005 == E001 & E007==.)
replace E005 = 0 if (E004 == 0 & E005==.)
replace E007 = 0 if (E006 == E003 & E007==.)
replace E005 = 0 if (E001 == E003 & E005 ==.)
replace E005 = 0 if (E003 + E007 == E001 & E005 ==.)
replace E005 = 0 if (E002 == E007)
replace E007 = 0 if E007 ==.

** Dropping firms always with under 3 employees
by tina, sort : egen float max_employees = max(E005 + E007)
bysort tina: drop if max_employees < 3

drop max_employees


* Delete awkward firms that only show up one time and "dead"
bysort tina: egen counter_tina = count(tina)
drop if motivodec == 2 & counter_tina ==1

drop counter_tina


* Deleting firms with CAEs attributted to financial institutions or public administration
//tab cae3
bysort tina (ano): drop if cae3 == 64190 | cae3 == 64201 | cae3 == 64202 |cae3 == 64300 | cae3 == 64910 | cae3 == 64921 | cae3 == 64922 | cae3 == 64923 | cae3 == 64991 | cae3 == 64992 
bysort tina (ano): drop if cae3 == 66110 | cae3 == 66120 | cae3 == 66190 | cae3 == 66210 | cae3 == 66220 | cae3 == 66290 | cae3 == 66300 
bysort tina (ano): drop if cae3 ==  84113  | cae3 ==  84114 | cae3 == 84123 | cae3 == 84130 | cae3 == 84230 | cae3 == 84240 | cae3 == 84250 
bysort tina (ano): drop if caekotu ==1


* Private non-financial Holdings
bysort tina (ano): drop if sectorinstfinal == 348500308 

* Private non-financial Holdings under foregin control
bysort tina (ano): drop if sectorinstfinal == 348500314

* Public non-financial Holdings
bysort tina (ano): drop if sectorinstfinal == 348500302



******** Database checks *******
******** Database checks *******
******** Database checks *******



* Dropping companies tagged with relevant events in AMARC_edit but irrelevant for the analysis
bysort tina (ano): drop if (tipoacont == 67 | tipoacont == 70 | tipoacont == 71 | tipoacont == 72 | tipoacont == 78 | tipoacont == 79)

drop tipoacont

* Dropping firms with no assets or no liabilities
by tina: egen media_ativo = mean(B001)
by tina: egen media_passivo = mean(B080)
bysort tina: drop if media_ativo == 0
bysort tina: drop if media_passivo == 0

drop media_ativo
drop media_passivo



***** INTEGRITY CHECK *****

bysort tina (ano): egen counter_afterdrop = count(tina)

bysort tina (ano): drop if counter_beforedrop != counter_afterdrop



drop counter_beforedrop
drop counter_afterdrop

***** INTEGRITY CHECK *****


egen counter14to17 = group(tina) if treat14to17==1
sum counter14to17
drop counter14to17
//453 firms



** Number of micro or small firms

egen countersmall = group(tina) if (treat14to17==1 & E001 < 50)
sum countersmall
drop countersmall
// 432 firms



** Firms with 5 or less employees

egen counter5 = group(tina) if treat14to17==1 & E001 < 6
sum counter5
drop counter5
//242 firms


save "/bplimext/projects/p068_SilvaSantosGouveia/work_area/curated.dta", replace


************** GENERATING NEEDED VARIABLES *****************
************** GENERATING NEEDED VARIABLES *****************
************** GENERATING NEEDED VARIABLES *****************

use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/curated.dta", clear

xtset tina ano
set seed 636299

gen lag_aftai = L.B005
gen investment = (B005-lag_aftai)/lag_aftai
gen ln_aft = ln(B012)
gen prod = (MG010 + MG011) + D006 + D007 + DL043
gen custint = D025 + D026
gen eftw = E005 + 0.5* E007
gen vab = prod - custint + D005 - DL047
gen shortcredit = B089 - B093 - B161
gen debtassetr = (B085 + shortcredit) / B001 
gen fixed_assetsr= B005 / B001
label variable fixed_assetsr "Fixed assets / Total Assets"
gen currentr = B029 / B089  
label variable currentr "Current Assets / Current Liabilities"
by tina, sort : egen float lastyear = max(ano)
by tina, sort : egen float firstyear = min(ano)
gen age = lastyear - ancon
replace age = lastyear - firstyear if age==.
gen total_credit = B085 + shortcredit
gen longcreditpc = B085 / (B085 + (shortcredit)) //missing values
replace longcreditpc = 0 if longcreditpc ==.
gen shortcreditpc = (shortcredit) / (B085 + shortcredit)
replace shortcreditpc = 0 if shortcreditpc ==. //missing values
gen hascredit = 1 if shortcredit + B085 > 0
replace hascredit = 0 if hascredit==.
gen collateral = B012 / B001
gen ln_collateral = ln(B012/B001)
gen profitability = D084/D053
gen ln_fse = ln(D026)
gen labor_costs = D029
gen ln_laborcost = ln(D029)
gen turnover = MG010 + MG011
gen ln_turnover = ln(MG010 + MG011)
gen ln_fixed_assets = ln(B005)
gen ln_total_assets = ln(B001)
gen ln_wages = ln(DL012 / eftw)
gen ln_ebitda = ln(D084)
gen ln_finance = ln(B085)

**** GENERATING OUTCOME VARIABLES*****


*FINANCING
bysort tina: gen fin_2018 = B085 if ano == 2018
bysort tina: gen fin_2013 = B085 if ano == 2013
bysort tina: egen fin2018 = max(fin_2018)
bysort tina: egen fin2013 = max(fin_2013)
bysort tina: gen financing = ln(fin2018) - ln(fin2013)



*FIXED ASSETS
bysort tina: gen fassets_2018 = B005 if ano == 2018
bysort tina: gen fassets_2013 = B005 if ano == 2013
bysort tina: egen fassets2018 = max(fassets_2018)
bysort tina: egen fassets2013 = max(fassets_2013)
drop fassets_2018 fassets_2013
bysort tina: gen f_assets1318 = ln(fassets2018) - ln(fassets2013)



* TOTAL ASSETS
bysort tina: gen totalassets_2018 = B001 if ano == 2018
bysort tina: gen totalassets_2013 = B001 if ano == 2013
bysort tina: egen totalassets2018 = max(totalassets_2018)
bysort tina: egen totalassets2013 = max(totalassets_2013)
drop totalassets_2018 totalassets_2013
bysort tina: gen t_assets1318 = ln(totalassets2018) - ln(totalassets2013)


*** Gouveia, Ana Methodology for apparent labor productivity**
gen laborprod = vab/eftw
gen ln_laborprod = ln(laborprod)
gen laborprod_2018 = vab/eftw if ano == 2018
gen laborprod_2013 = vab/eftw if ano == 2013
bysort tina: egen laborprod2018 = max(laborprod_2018)
bysort tina: egen laborprod2013 = max(laborprod_2013)
drop laborprod_2018 laborprod_2013
bysort tina: gen laborprod1318 = ln(laborprod2018) - ln(laborprod2013)



**TFP Levinsohn and Petri Methodology (used by SPGM)**
eststo levpet_TFP: prodest ln_turnover, method(lp) free(ln_laborcost) proxy(ln_fse) state(ln_fixed_assets) fsresidual(levpet_residuals) reps(5)

predict levpetTFP, omega
gen ln_levpetTFP = ln(levpetTFP)

bysort tina: gen levpetTFP_2018 = levpetTFP if ano == 2018
bysort tina: gen levpetTFP_2013 = levpetTFP if ano == 2013
bysort tina: egen levpetTFP2018 = max(levpetTFP_2018)
bysort tina: egen levpetTFP2013 = max(levpetTFP_2013)
drop levpetTFP_2018 levpetTFP_2013
bysort tina: gen levpetTFP1318 = ln(levpetTFP2018) - ln(levpetTFP2013)



*EMPLOYMENT
gen employment_2018 = E005 + 0.5* E007 if ano== 2018
gen employment_2013 = E005 + 0.5* E007 if ano == 2013
bysort tina: egen employment2018 = max(employment_2018)
bysort tina: egen employment2013 = max(employment_2013)
drop employment_2018 employment_2013
bysort tina: gen employment1318 = ln(employment2018) - ln(employment2013)


* AVERAGE WAGES

gen avg_wages_2018 = DL012 / eftw if ano == 2018
gen avg_wages_2013 = DL012 / eftw if ano == 2013
bysort tina: egen avg_wages2018 = max(avg_wages_2018)
bysort tina: egen avg_wages2013 = max(avg_wages_2013)
drop avg_wages_2018 avg_wages_2013
bysort tina: gen avgwages1318 = ln(avg_wages2018) - ln(avg_wages2013)


* EBITDA

gen ebitda_2018 = D084 if ano == 2018
gen ebitda_2013 = D084 if ano == 2013
bysort tina: egen ebitda2018 = max(ebitda_2018)
bysort tina: egen ebitda2013 = max(ebitda_2013)
drop ebitda_2018 ebitda_2013
bysort tina: gen ebitda1318 = ln(ebitda2018) - ln(ebitda2013)



drop prod custint vab

**************** VARIABLE LABELS*************************
**************** VARIABLE LABELS*************************
**************** VARIABLE LABELS*************************

label var ln_finance "Debt"
label var ln_total_assets "ln Total Assets"
label var ln_fixed_assets "ln Fixed Assets"
label var ln_laborprod "ln Labor Productivity"
label var ln_levpetTFP " ln Total Factor Productivity"
label var ln_wages "ln Wages"
label var ln_ebitda "ln EBITDA"
label var age "Firm Age"
label var hascredit "In bank debt"
label var longcreditpc "Share long-term bank debt"
label var shortcredit "Share short-term bank debt"
label var eftw "Equivalent Full-Time Workers"
label var investment "Investment"
label var turnover "Turnover"
label var collateral "Collateral (Tangible Assets/Total Assets)"
label var debtassetr "Leverage (Total Debt/Total Assets)"



***************** GENERATING LAGGED VARIABLES FOR 2007***********
***************** GENERATING LAGGED VARIABLES FOR 2007***********
***************** GENERATING LAGGED VARIABLES FOR 2007***********
sort tina ano

gen age07 =.
replace age07 = L11.age if lastyear==2018 & ano==2018
replace age07 = L10.age if lastyear==2017 & ano==2017
replace age07 = L9.age if lastyear==2016 & ano== 2016
replace age07 = L8.age if lastyear==2015 & ano== 2015
replace age07 = L7.age if lastyear==2014 & ano== 2014
replace age07 = L6.age if lastyear==2013 & ano== 2013
replace age07 = L5.age if lastyear==2012 & ano== 2012
replace age07 = L4.age if lastyear==2011 & ano== 2011
replace age07 = L3.age if lastyear==2010 & ano== 2010
replace age07 = L2.age if lastyear==2009 & ano== 2009
replace age07 = L1.age if lastyear==2008 & ano== 2008
replace age07 = age if lastyear==2007 & ano== 2007

by tina: egen valor_r07 = max(valor_r)
replace valor_r07 = . if (valor_r07!=. & ano!= 2018)


gen longcreditpc07 =.
replace longcreditpc07 = L11.longcreditpc if lastyear==2018 & ano==2018
replace longcreditpc07 = L10.longcreditpc if lastyear==2017 & ano==2017
replace longcreditpc07 = L9.longcreditpc if lastyear==2016 & ano== 2016
replace longcreditpc07 = L8.longcreditpc if lastyear==2015 & ano== 2015
replace longcreditpc07 = L7.longcreditpc if lastyear==2014 & ano== 2014
replace longcreditpc07 = L6.longcreditpc if lastyear==2013 & ano== 2013
replace longcreditpc07 = L5.longcreditpc if lastyear==2012 & ano== 2012
replace longcreditpc07 = L4.longcreditpc if lastyear==2011 & ano== 2011
replace longcreditpc07 = L3.longcreditpc if lastyear==2010 & ano== 2010
replace longcreditpc07 = L2.longcreditpc if lastyear==2009 & ano== 2009
replace longcreditpc07 = L1.longcreditpc if lastyear==2008 & ano== 2008
replace longcreditpc07 = longcreditpc if lastyear==2007 & ano== 2007


gen debtassetr07 =.
replace debtassetr07 = L11.debtassetr if lastyear==2018 & ano==2018
replace debtassetr07 = L10.debtassetr if lastyear==2017 & ano==2017
replace debtassetr07 = L9.debtassetr if lastyear==2016 & ano== 2016
replace debtassetr07 = L8.debtassetr if lastyear==2015 & ano== 2015
replace debtassetr07 = L7.debtassetr if lastyear==2014 & ano== 2014
replace debtassetr07 = L6.debtassetr if lastyear==2013 & ano== 2013
replace debtassetr07 = L5.debtassetr if lastyear==2012 & ano== 2012
replace debtassetr07 = L4.debtassetr if lastyear==2011 & ano== 2011
replace debtassetr07 = L3.debtassetr if lastyear==2010 & ano== 2010
replace debtassetr07 = L2.debtassetr if lastyear==2009 & ano== 2009
replace debtassetr07 = L1.debtassetr if lastyear==2008 & ano== 2008
replace debtassetr07 = debtassetr if lastyear==2007 & ano== 2007


gen collateral07 =.
replace collateral07 = L11.collateral if lastyear==2018 & ano==2018
replace collateral07 = L10.collateral if lastyear==2017 & ano==2017
replace collateral07 = L9.collateral if lastyear==2016 & ano== 2016
replace collateral07 = L8.collateral if lastyear==2015 & ano== 2015
replace collateral07 = L7.collateral if lastyear==2014 & ano== 2014
replace collateral07 = L6.collateral if lastyear==2013 & ano== 2013
replace collateral07 = L5.collateral if lastyear==2012 & ano== 2012
replace collateral07 = L4.collateral if lastyear==2011 & ano== 2011
replace collateral07 = L3.collateral if lastyear==2010 & ano== 2010
replace collateral07 = L2.collateral if lastyear==2009 & ano== 2009
replace collateral07 = L1.collateral if lastyear==2008 & ano== 2008
replace collateral07 = collateral if lastyear==2007 & ano== 2007


save "/bplimext/projects/p068_SilvaSantosGouveia/work_area/finaldb.dta", replace

log close
