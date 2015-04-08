program define dorlabeldta, rclass
version 13
syntax using/, language(string)

local study : char _dta[study]
local dataset : char _dta[dataset]
local version : char _dta[version]

if "`language'"!="en" {
display "The language specifed in the options has to be 'en'. 'de' not yet implemented."
} 
else {

preserve

// VARIABLE LABELS

quietly: import delimited "`using'/variables.csv", ///
	delimiter(comma) varnames(1) stringcols(_all) clear
quietly: keep if study=="`study'"
quietly: keep if dataset=="`dataset'"
quietly: keep if version=="`version'"

// Number of variables in metadata
local N = _N
display `N'

// Macros for new variable labels
foreach x of numlist 1/`N' {
	local var`x'_de = label_de[`x']
	local var`x'_en = label[`x']
	local variable`x' = variable[`x']
	}
	
restore
preserve
// surplus variables in metadata (variables.csv)
foreach x of numlist 1/`N' {
		gen ok`x'=2
}

foreach y of varlist * {
	foreach x of numlist 1/`N' {
		if `"`variable`x''"'==`"`y'"' {
			label variable `y' `"`var`x'_`language''"' 
			drop ok`x'
			generate ok`x'=1
		}
	}
}
foreach x of numlist 1/`N' {
	if ok`x'==2 {
		display in red "Variable `variable`x'' only in using and ignored. Probably you want to delete them in `using'/variables.csv."
	}
}

restore
preserve
// surplus variables in dataset
foreach y of varlist * {
local n=1
	foreach x of numlist 1/`N' {
		if `"`y'"'!=`"`variable`x''"' {
		local n `n'+1
			}
		if `n'==`N'+1 {
			display in red "Variable `y' only in data and not re-labeled. Probably you want to add it in `using'/variables.csv."
		}
	}
}

restore

// New variable labels
foreach y of varlist * {
	foreach x of numlist 1/`N' {
		if `"`variable`x''"'==`"`y'"' {
			label variable `y' `"`var`x'_`language''"' 
		}
	}
}

preserve

// VALUE LABELS

quietly: import delimited "`using'/variable_categories.csv", ///
	delimiter(comma) varnames(1) stringcols(_all) clear
quietly: keep if study=="`study'"
quietly: keep if dataset=="`dataset'"
quietly: keep if version=="`version'"

// Die Anzahl der Values
local N = _N
display `N'

// Erstellen der Makros für die neuen Valuenamen
foreach x of numlist 1/`N' {
	local val`x'_de = label_de[`x']
	local val`x'_en = label[`x']
	local value`x' = value[`x']
	local variable`x' = variable[`x']
}

restore

// Uebersetzung der Label
foreach y of varlist * {
	label values `y' `y'
	foreach x of numlist 1/`N' {
		if `"`variable`x''"'==`"`y'"' {
			label define `y' `value`x'' `"`val`x'_`language''"', add modify
		}
	}
}
	
}
end

