sysdir set PLUS "~/ado/plus/"
sysdir set PERSONAL "/bplimext/projects/p068_SilvaSantosGouveia/tools"

log using "/bplimext/projects/p068_SilvaSantosGouveia/work_area/Log_3_Stats", replace

/////////////////// DESCRIPTIVE STATISTICS //////////////////


use "/bplimext/projects/p068_SilvaSantosGouveia/work_area/finaldb.dta", clear

label variable ln_turnover "ln Turnover"


eststo treat0_desc: quietly estpost summarize ln_finance ln_total_assets ln_fixed_assets ln_laborprod ln_levpetTFP ln_wages ln_ebitda investment ln_turnover age hascredit longcreditpc eftw collateral debtassetr if ano == 2007 & treat14to17 == 0, detail

eststo treat1_desc: quietly estpost summarize ln_finance ln_total_assets ln_fixed_assets ln_laborprod ln_levpetTFP ln_wages ln_ebitda investment ln_turnover age hascredit longcreditpc eftw collateral debtassetr if ano == 2007 & treat14to17 == 1, detail


esttab treat0_desc treat1_desc using sumstats.tex, replace cells("count(fmt(0)) mean(fmt(1)) sd(fmt(1)) p25(fmt(1)) p50(fmt(1)) p75(fmt(1)) p95(fmt(1))") title("Descriptive Statistics - 2007") label lines gaps noobs tex nonumbers mtitles("Untreated" "Treated")




log close

