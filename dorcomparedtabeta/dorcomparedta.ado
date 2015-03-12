program define dorcomparedta, rclass
version 13
syntax using/


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

* variable-type-information aus datensatz
preserve
keep `d' variable isnumeric position
generate position2 = 1
generate attribute = "type"
generate `d'info = "string"
quietly: replace `d'info = "numeric" if isnumeric==1
keep position position2 `d' variable attribute `d'info 
quietly: save "`compare`d''", replace
restore

* varlab-information aus datensatz
preserve
keep `d' variable varlab position
generate position2 = 2
generate attribute = "varlabel"
generate `d'info = varlab
keep position position2 `d' variable attribute `d'info 
quietly: append using "`compare`d''"
quietly: generate value = .
quietly: save "`compare`d''", replace
restore

* vallab aus datensatz
keep `d' variable vallab position
quietly: keep if vallab!=""
generate position2 = 3
joinby vallab using "`usevalue`d''"
gen attribute = string(value)
keep position position2 `d' variable attribute `d'info value
quietly: append using "`compare`d''"
sort position position2 value
drop position position2 value
order `d' variable attribute `d'info
quietly: save "`compare`d''", replace
}

quietly: merge 1:1 variable attribute using "`compareset2'", keep(match) nogenerate

order set1 set2 variable attribute set1info set2info 
quietly: tab set1 if set1info==set2info
local equallines = r(N)
if `equallines' > 0 {
quietly: drop if set1info==set2info
display "`equallines' lines dropped, " _N " lines left"
}

end

