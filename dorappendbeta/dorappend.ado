program define dorappend, rclass
version 13
syntax using/[, GENerate(name) MVal(integer -5) MLab(string)]

local source0 : char _dta[dataset]

tempfile master     /* create a temporary file */
quietly: save "`master'"      /* save memory into the temporary file */

tempfile masterdescribe     /* create a temporary file */
describe, replace
keep name
quietly: save "`masterdescribe'"      /* save memory into the temporary file */

quietly: use `using', clear
local source1 : char _dta[dataset]

tempfile usingdescribe     /* create a temporary file */
describe, replace
keep name
quietly: save "`usingdescribe'"      /* save memory into the temporary file */

quietly: use "`masterdescribe'", clear
quietly: merge 1:1 name using "`usingdescribe'"

preserve
* Erstellen der Makros für die varnamen masteronly/new in using
quietly: keep if _merge==1
local numbervarsnewusing = _N
forvalues x = 1/`numbervarsnewusing' {
local var`x'_newusing = name[`x']
}
restore
preserve
* Erstellen der Makros für die varnamen usingonly/new in master
quietly: keep if _merge==2
local numbervarsnewmaster = _N
forvalues x = 1/`numbervarsnewmaster' {
local var`x'_newmaster = name[`x']
}
restore
* zählen gemeinsame variablen
quietly: keep if _merge==3
local numbervarscommon = _N

* appenden
quietly: use "`master'", clear
quietly: append using "`using'", generate(`generate')
label define dorsource 0 "`source0'" 1 "`source1'"
label values `generate' dorsource

* missing value bei neuen master-variablen setzen
forvalues x = 1/`numbervarsnewmaster' {
local vartype : type `var`x'_newmaster'
local vartype : piece 1 3 of "`vartype'"
if "`vartype'"=="str" {
quietly: replace `var`x'_newmaster' = "`mval'" if `generate'==0
}
else {
quietly: replace `var`x'_newmaster' = `mval' if `generate'==0
}
}
display "There are `numbervarsnewmaster' variables originating exclusively from '`source1''."

* missing value bei neuen using-variablen setzen
forvalues x = 1/`numbervarsnewusing' {
local vartype : type `var`x'_newusing'
local vartype : piece 1 3 of "`vartype'"
if "`vartype'"=="str" {
quietly: replace `var`x'_newusing' = "`mval'" if `generate'==1
}
else {
quietly: replace `var`x'_newusing' = `mval' if `generate'==1 
}
}
display "There are `numbervarsnewusing' variables originating exclusively from `source0'."
display "There are `numbervarscommon' variables originating from both datasets and "`numbervarscommon'+`numbervarsnewusing'+`numbervarsnewmaster'+1 " variables in resulting dataset, including new variable '`generate''."

* TODO: labels ergänzen

end
