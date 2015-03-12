program define dorrename, rclass
version 13
syntax using/, ostudy(string) odataset(string) oversion(string)

/*dataset ermitteln:
local idataset = "`c(filename)'"
quietly: extractfilename "`idataset'"
quietly: return list
local idataset = "`r(filename)'"
*/

local idataset : char _dta[dataset]
local istudy : char _dta[study]
local iversion : char _dta[version]

* di "outputstudy: `ostudy'"
* di "outputdataset: `odataset'"
* di "outputversion: `oversion'"

preserve

tempfile inputdescribe     /* create a temporary file */
describe, replace
rename name input_variable
keep input_variable

quietly: save "`inputdescribe'"      /* save memory into the temporary file */

quietly: import delimited "`using'", delimiter(comma) varnames(1) clear 
* Beschränken auf den input-Datensatz und output-Datensatz
quietly: keep if input_study == "`istudy'"
quietly: keep if input_dataset == "`idataset'"
quietly: keep if input_version == "`iversion'"
quietly: keep if output_study == "`ostudy'"
quietly: keep if output_dataset == "`odataset'"
quietly: keep if output_version == "`oversion'"
di "Dataset '`idataset'' from study '`istudy'' in version '`iversion'' renamed by '`using'' which has " _N " lines with rename information."

* Integrität sichern
isid output_variable
isid input_variable
* TODO: abfangen, Warnung ausgeben

quietly: merge 1:1 input_variable using "`inputdescribe'"
* überflüssige Zeilen in generations.csv
quietly: tab _merge if _merge==1
if r(N)>0 {
display r(N) " line/s in generations.csv is superfluous, probably you want to delete them/it:"
list output_study-input_variable if _merge==1
}

* zu löschende Variablen in dataset
quietly: tab _merge if _merge==2
local deletevarnumber = r(N)
if `deletevarnumber'>0 {
tempfile deletevars
quietly: save "`deletevars'", replace
* TODO: Variablen in local(s) reinschreiben, damit gelöscht werden kann, nach restore
}

* Aufräumen
quietly: drop if _merge ==1
quietly: drop if _merge ==2
drop _merge

// Die Anzahl der Variablen im Zieldatensatz
local N = _N
display `N' " variables after renaming"

// Erstellen der Makros für die neuen Labelnamen
foreach x of numlist 1/`N' {
local var`x'_output = output_variable[`x']
local var`x'_input = input_variable[`x']
}

if `deletevarnumber'>0 {
use "`deletevars'", clear
quietly: keep if _merge==2
local deletelist ""
display "`deletevarnumber' variables will be deleted in dataset, due to missing rename information:"
foreach x of numlist 1/`deletevarnumber' {
local addvariable = input_variable[`x']
local deletelist `deletelist' `addvariable'
}
}

restore
if `deletevarnumber'>0 {
display "`deletelist'"
drop `deletelist'
}

* Umbebennung
* - erst generisch in var1_XxX
* - dann real
* ermöglicht Überkreuzumbenennungen
foreach x of numlist 1/`N' {
rename `var`x'_input' var`x'_XxX
}
foreach x of numlist 1/`N' {
rename var`x'_XxX `var`x'_output' 
}

end
