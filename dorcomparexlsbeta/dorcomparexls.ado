program define dorcomparexls, rclass
version 13
syntax using/

tempfile dta
quietly: save "`dta'", replace

tempfile xls
import excel "`using'", firstrow allstring clear
capture tostring _all, replace
quietly: export excel "`using'", sheet("unchanged") firstrow(variables) nolabel replace 
quietly: keep if accept == "1"
display _N " line/s in comparison memory."

* empty sheets can't be exported
local newexcel 0
if _N == 0 {
set obs 1
local newexcel 1
}
quietly: export excel "`using'", sheet("used_memory") firstrow(variables) nolabel
quietly: save "`xls'", replace

quietly: use "`dta'", clear
if `newexcel'==1 {
gen accept = ""
}
else {
quietly: merge 1:1 set1 set2 variable attribute set1info set2info using "`xls'"
quietly: tab _merge if _merge==2
if r(N)>0 {
display r(N) " line/s in comparison memory deleted, because they don't fit to job."
quietly: drop if _merge==2
}
quietly: tab _merge if _merge==3
if r(N)>0 {
display r(N) " line/s in comparison memory found again, don't need to evaluate again."
}
quietly: tab _merge if _merge==1
if r(N)>0 {
display r(N) " line/s to evaluate."
}
drop _merge
}

quietly: tab set1 if set1info==set2info
local equallines = r(N)
if `equallines' > 0 {
quietly: drop if set1info==set2info
display "`equallines' lines dropped, " _N " lines left"
}

* Sortierung
generate position2 = 3
quietly: replace position2=1 if attribute=="type"
quietly: replace position2=2 if attribute=="varlabel"
quietly: destring attribute, generate(value) force
sort accept position position2 value
drop position position2 value

export excel "`using'",  sheet("results")  firstrow(variables) nolabel
display "Evaluate sheet 'results', delete other sheets when you are done."
end

* dorcomparexls using "I:\MA\fams\Fams@Wenzig\Testdaten_FiD_Integration\comparememory.xls"

/* so könnte man nicht existentes excel-sheet abfangen - und anlegen:
cap import excel "I:\MA\fams\Fams@Wenzig\Testdaten_FiD_Integration\comparememory2.xlsx", firstrow allstring clear
if _rc!=0 {
display "fehler"
}
*/
