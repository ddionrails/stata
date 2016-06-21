program define dororder, rclass
version 13
syntax using/

* 2016-06-21 v2beta - dororder: fix for lager datasets (foreach -> forvalues)

local study : char _dta[study]
local dataset : char _dta[dataset]
local version : char _dta[version]

preserve

tempfile describe
describe, replace clear
keep name
rename name variable
quietly: save "`describe'", replace

quietly: import delimited "`using'", delimiter(comma) varnames(1) stringcols(_all) clear
quietly: keep if study=="`study'"
quietly: keep if dataset=="`dataset'"
quietly: keep if version=="`version'"
keep variable
gen position2=_n

quietly: merge 1:1 variable using "`describe'"
* variables only in variables/master (will be reported and ignored)
quietly: tab _merge if _merge==1
if r(N)>0 {
display "Variables only in using and ignored, probably you want to delete them in `using'."
list variable if _merge==1
quietly: drop if _merge==1
}

* variables only in dataset/using (will be reported and sorted to end)
quietly: tab _merge if _merge==2
if r(N)>0 {
display "Variables only in dataset sorted to end of dataset, probably you want to add them in `using'."
list variable if _merge==2
}

gen position=1
quietly: replace position=2 if _merge==2
sort position position2
drop _merge position position2

local variablenumber = _N
local orderlist ""
forvalues x = 1/`variablenumber' {
local addvariable = variable[`x']
local orderlist `orderlist' `addvariable'
}

restore

order `orderlist'

end

