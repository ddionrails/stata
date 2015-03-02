program define dorappend, rclass
version 13
syntax using/[, GENerate(name) MVal(integer -5) MLab(string)]

local source0 = "`c(filename)'"
quietly: extractfilename "`source0'"
quietly: return list
local source0 = "`r(filename)'"
di "master: `source0'"

tempfile master     /* create a temporary file */
save "`master'"      /* save memory into the temporary file */

tempfile masterdescribe     /* create a temporary file */
describe, replace
keep name
save "`masterdescribe'"      /* save memory into the temporary file */

use `using', clear

local source1 = "`c(filename)'"
quietly: extractfilename "`source1'"
quietly: return list
local source1 = "`r(filename)'"
di "using: `source1'"

tempfile usingdescribe     /* create a temporary file */
describe, replace
keep name
save "`usingdescribe'"      /* save memory into the temporary file */

use "`masterdescribe'", clear
merge 1:1 name using "`usingdescribe'"

preserve
* Erstellen der Makros für die varnamen masteronly/new in using
keep if _merge==1
local numbervarsnewusing = _N
foreach x of numlist 1/`numbervarsnewusing' {
local var`x'_newusing = name[`x']
}
restore
* Erstellen der Makros für die varnamen usingonly/new in master
keep if _merge==2
local numbervarsnewmaster = _N
foreach x of numlist 1/`numbervarsnewmaster' {
local var`x'_newmaster = name[`x']
}

* appenden
use "`master'", clear
append using `using', generate(`generate')
label define dorsource 0 "`source0'" 1 "`source1'"
label values `generate' dorsource

* missing value bei neuen master-variablen setzen
foreach x of numlist 1/`numbervarsnewmaster' {
local vartype : type `var`x'_newmaster'
local vartype : piece 1 3 of "`vartype'"
if "`vartype'"=="str" {
replace `var`x'_newmaster' = "`mval'" if `generate'==0
}
else {
replace `var`x'_newmaster' = `mval' if `generate'==0
}
}

* missing value bei neuen using-variablen setzen
foreach x of numlist 1/`numbervarsnewusing' {
local vartype : type `var`x'_newusing'
local vartype : piece 1 3 of "`vartype'"
if "`vartype'"=="str" {
replace `var`x'_newusing' = "`mval'" if `generate'==1
}
else {
replace `var`x'_newusing' = `mval' if `generate'==1 
}
}

* TODO: labels ergänzen

end
