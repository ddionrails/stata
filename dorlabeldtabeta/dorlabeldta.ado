program define dorlabeldta, rclass
version 13
syntax using/, language(string) enc(string)

set more off

local study : char _dta[study]
local dataset : char _dta[dataset]
local version : char _dta[version]

preserve

// VARIABLE LABELS

quietly: import delimited "`using'/variables.`enc'", ///
	delimiter(comma) varnames(1) stringcols(_all) clear
quietly: keep if study=="`study'"
quietly: keep if dataset=="`dataset'"
quietly: keep if version=="`version'"

// Number of variables in metadata
local N = _N
display `N'

// Macros for new variable labels
forvalues x = 1/`N' {
	local varname = variable[`x']
	local varlab_`varname'_de = label_de[`x']
	local varlab_`varname'_en = label[`x']
	}
	
restore

foreach y of varlist * {
	label variable `y' `"`varlab_`y'_`language''"' 			
}

preserve

// VALUE LABELS

quietly: import delimited "`using'/variable_categories.`enc'", ///
	delimiter(comma) varnames(1) stringcols(_all) clear
quietly: keep if study=="`study'"
quietly: keep if dataset=="`dataset'"
quietly: keep if version=="`version'"

bysort variable: gen values=_N
bysort variable: gen valuesortorder = _n

// Die Anzahl der Values
local N = _N
display `N'

// Erstellen der Makros für die neuen Valuelabels
forvalues x = 1/`N' {
	local varname = variable[`x']
	local valuesortorder = valuesortorder[`x']
	local values = values[`x']
	local vallab_`varname'_`valuesortorder'_de = label_de[`x']
	local vallab_`varname'_`valuesortorder'_en = label[`x']
	local value_`varname'_`valuesortorder' = value[`x']	
	local values_`varname' = values[`x']	
}

restore

// Uebersetzung der Label
label drop _all
foreach y of varlist * {
	local values = `"`values_`y''"'
	if "`values'"!="" {
		label values `y' `y'	
		forvalues x = 1/`values' {
			label define `y' `value_`y'_`x'' `"`vallab_`y'_`x'_`language''"', add modify
		}
	}
}

end

