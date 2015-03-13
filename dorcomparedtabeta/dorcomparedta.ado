program define dorcomparedta, rclass
version 13
syntax using/


* TODO: force option replace

tempfile set1
tempfile set2


local set1shortname : char _dta[dataset]
display "set1: `set1shortname'"
quietly: save "`set1'", replace



quietly: use "`using'", clear
local set2shortname : char _dta[dataset]
display "set2: `set2shortname'"
quietly: save "`set2'", replace

tempfile compareset1
tempfile usevalueset1
tempfile compareset2
tempfile usevalueset2
tempfile describeset1
tempfile describeset2

/* Erzeuge für beide Datensätze Tabellen:
set1/2 | variable |	attribute |	set1/2info

mit attribute = type (string/numeric)
              = varlabel (variable label)
			  = "value" (values as string)
*/

local mu set2 set1

foreach d of local mu {
quietly: use "``d''", clear
uselabel, clear var
rename lname vallab
rename label `d'info
quietly: keep vallab value `d'info
quietly: save "`usevalue`d''", replace

quietly: use "``d''", clear
describe, replace
generate `d' = "``d'shortname'"
rename name variable
keep `d' variable isnumeric vallab varlab position
quietly: save "`describe`d''", replace

* variable-type-information aus datensatz
preserve
keep `d' variable isnumeric
generate attribute = "type"
generate `d'info = "string"
quietly: replace `d'info = "numeric" if isnumeric==1
keep `d' variable attribute `d'info 
quietly: save "`compare`d''", replace
restore

* varlab-information aus datensatz
preserve
keep `d' variable varlab
generate attribute = "varlabel"
generate `d'info = varlab
keep `d' variable attribute `d'info 
quietly: append using "`compare`d''"
quietly: save "`compare`d''", replace
restore

* vallab aus datensatz
keep `d' variable vallab
quietly: keep if vallab!=""
joinby vallab using "`usevalue`d''"
gen attribute = string(value)
keep `d' variable attribute `d'info
quietly: append using "`compare`d''"
order `d' variable attribute `d'info
quietly: save "`compare`d''", replace
}


tempfile jointvariables
quietly: use "`describeset1'", clear
keep set1 variable
quietly: merge 1:1 variable using "`describeset2'", keepusing(set2) keep(match) nogen
order set1 set2 variable
display _N " joint variables, available in both datasets."
quietly: save "`jointvariables'", replace

* compareset2 einschränken auf jointvariables
drop set1
quietly: merge 1:m set2 variable using "`compareset2'", keep(match) nogen
quietly: save "`compareset2'", replace

* compareset1 einschränken auf jointvariables
quietly: use "`jointvariables'", clear
drop set2
quietly: merge 1:m set1 variable using "`compareset1'", keep(match) nogen

* bei exklusiv vorhandenen Attribute set1/set2 auffüllen
quietly: merge 1:1 variable attribute using "`compareset2'", nogenerate
quietly: count if set1==""
display r(N) " attributes not in `set1shortname'"
quietly: replace set1="`set1shortname'" if set1==""

quietly: count if set2==""
display r(N) " attributes not in `set2shortname'"
quietly: replace set2="`set2shortname'" if set2==""

order set1 set2 variable attribute set1info set2info 
quietly: tab set1 if set1info==set2info
local equallines = r(N)
if `equallines' > 0 {
quietly: drop if set1info==set2info
display "`equallines' lines dropped, " _N " lines left"
}

* Variablenposotion gemäß set1 hinzufügen
quietly: merge m:1 variable using "`describeset1'", keep(match) keepusing(position) nogen

end

