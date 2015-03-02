program define dorrename, rclass
version 13
syntax using/, ostudy(string) odataset(string) oversion(string)

local idataset = "`c(filename)'"
quietly: extractfilename "`idataset'"
quietly: return list
local idataset = "`r(filename)'"
local istudy : char _dta[study]
local iversion : char _dta[version]

di "generations: `using'"

di "inputstudy: `istudy'"
di "inputdataset: `idataset'"
di "inputversion: `iversion'"

di "outputstudy: `ostudy'"
di "outputdataset: `odataset'"
di "outputversion: `oversion'"

preserve

tempfile inputdescribe     /* create a temporary file */
describe, replace
rename name input_variable
keep input_variable

save "`inputdescribe'"      /* save memory into the temporary file */

import delimited "`using'", delimiter(comma) varnames(1) clear 

* Beschränken auf den input-Datensatz und output-Datensatz
keep if input_study == "`istudy'"
keep if input_dataset == "`idataset'"
keep if input_version == "`iversion'"
keep if output_study == "`ostudy'"
keep if output_dataset == "`odataset'"
keep if output_version == "`oversion'"

* Integrität sichern
isid output_variable
isid input_variable
* TODO: abfangen, Warnung ausgeben

merge 1:1 input_variable using "`inputdescribe'"
* überflüssige Zeilen in generations.csv
list if _merge==1
* TODO: Ausgabe generieren

* zu löschende Variablen in dataset
list input_variable if _merge==2
* TODO: Variablen in local(s) reinschreiben, damit gelöscht werden kann, nach restore

* Aufräumen
drop if _merge ==1
drop if _merge ==2
drop _merge

// Die Anzahl der Variablen im Zieldatensatz
local N = _N
display `N'

// Erstellen der Makros für die neuen Labelnamen
foreach x of numlist 1/`N' {
local var`x'_output = output_variable[`x']
local var`x'_input = input_variable[`x']
}

restore

*TODO: droppen


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
