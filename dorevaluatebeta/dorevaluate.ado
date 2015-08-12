/***** ADO: DOREVALUATE. Version 1.1 | 25. Juni 2015 ***/
/**Maximilian Priem
Deutsches Institut für Wirtschaftsforschung
Mohrenstraße 58D
10117 Berlin
Tel: +49 30 89789 235 
E-Mail: mpriem@diw.de
http://www.diw.de/
**/

program dorevaluate
	version 13
	syntax [varlist] [, PAth(string) SRCvariable(varname numeric max=1) GPPage(integer 6)]
		if missing("`srcvariable'") {
			di "{error: No source variable was defined. Program stops.}"
			break
		}
		if missing("`path'") {
			local path `c(pwd)'
			di "{text:path was not specified. Path is now: `path'}"
		}
		local dataset : char _dta[dataset]
		local X = 0
		local Y = 1
		qui tab `srcvariable', gen(src)
		local srcmax = r(r)
		tempvar help
		gen `help' = 0
		di "{input:`dataset' is being evaluated by variable {bf:`srcvariable'}, which indicates {bf:`srcmax'} sources.}"
		foreach var in `varlist' {
			local vartype: type `var'
			if substr("`var'",1,.) == "`srcvariable'" | substr("`vartype'",1,3)=="str"{
				if substr("`vartype'",1,3)=="str"{
					di "{text:{bf:`var'} is string}"
				}
			}
			else {
				foreach M of numlist 1/`srcmax' {
					qui sum `var' if src`M'==1
						if r(min) == r(max) {
							local noplot`M' `noplot`M'' `var'
							local noplotall `noplotall' `var'
						}
				}
				local wcount: word count `noplotall'
				if `wcount'!=0{
					local lastvar: word `wcount' of `noplotall' 
					if `var' == `lastvar' {
					}
					else{
						foreach M of numlist 1/`srcmax' {
							if `M' == 1{
								local h : variable label src`M'
								local plots "kdensity `var' if src`M' == 1, lw(thick) lc(green)"
								local _M = `M'+1
								local lab  `_M' "`h'"
							}
							else{
								if `M' == 2{
									local h : variable label src`M'
									local plots "`plots' || kdensity `var' if src`M' == 1, lw(medthick) lc(magenta)"
								local _M = `M'+1
								local lab `lab' `_M' "`h'"
								}
								else {
									local h : variable label src`M'
									local _M = `M'+1
									local lab `lab' `_M' "`h'"
									local plots "`plots' || kdensity `var' if src`M' == 1, lw(medthick)" 
								}
							}
						}
						local xname `var'
						local xlab: variable label `var'
						if `X' == `gppage'{
							local X = 0
							local ++Y
							qui kdensity `help' , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend(off) addplot(`plots') note("") name(`var'_graph, replace) nodraw
							local graphnames`Y' `graphnames`Y'' `var'_graph
							local ++X
						}
						else{
							if `X' == `gppage'-1{
								qui kdensity `help' , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend( rows(1) order(`lab') region(m(zero))) addplot(`plots') note("") name(`var'_graph, replace) nodraw
								local graphnames`Y' `graphnames`Y'' `var'_graph
								local ++X
							}
							else {
								qui kdensity `help'  , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend(off)addplot(`plots') note("") name(`var'_graph, replace) nodraw
								local graphnames`Y' `graphnames`Y'' `var'_graph
								local ++X
							}
						}
					}
				}
				else{
					foreach M of numlist 1/`srcmax' {
						if `M' == 1{
							local h : variable label src`M'
							local plots "kdensity `var' if src`M' == 1, lw(thick) lc(green)"
							local _M = `M'+1
							local lab `_M' "`h'"
							local ord `_M'
						}
						else{
							if `M' == 2{
								local h : variable label src`M'
								local plots "`plots' || kdensity `var' if src`M' == 1, lw(medthick) lc(magenta)"
								local _M = `M'+1
								local lab `lab' `_M' "`h'"
								local ord `ord' `_M'
							}
							else {
								local h : variable label src`M'
								local _M = `M'+1
								local lab `lab' `_M' "`h'"
								local ord `ord' `_M'
								local plots "`plots' || kdensity `var' if src`M' == 1, lw(medthick)" 
							}
						}
					}
					local xname `var'
					local xlab: variable label `var'
					if `X' == `gppage'{
						local X = 0
						local ++Y
						qui kdensity `help' , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend(off)addplot(`plots') note("") name(`var'_graph, replace) nodraw
						local graphnames`Y' `graphnames`Y'' `var'_graph
						local ++X
					}
					else{
						if `X' == `gppage'-1{
							qui kdensity `help' , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend( rows(1)  order(`lab') region(m(zero))) addplot(`plots') note("") name(`var'_graph, replace) nodraw
							local graphnames`Y' `graphnames`Y'' `var'_graph
							local ++X
						}
						else {
							qui kdensity `help'  , scale(.4) title("") xtitle("`xname' : `xlab'") ytitle("kernel density") aspectratio(.5) plotr(margin(zero)) graphr(margin(medsmall)) legend(off) addplot(`plots') note("") name(`var'_graph, replace) nodraw
							local graphnames`Y' `graphnames`Y'' `var'_graph
							local ++X
						}
					}
				}
			}
		}
		foreach M of numlist 1/`srcmax' {
			if "`noplot`M''" != "" {
				local srclab: variable label src`M'
				display "{text: Because there is only one value assigned to all `srclab', no graphs are plotted for the follwing variables: {bf:`noplot`M''} }"
			}
		}
		drop src*
		if `gppage' == 1{
			local col 1
		}
		else {
			local col 2
		}
		foreach Z of numlist 1/`Y' {
			graph combine `graphnames`Z'', cols(`col') iscale(1) plotr(margin(zero)) graphr(margin(tiny)) name(evaluation`Z'_`dataset',replace)
			qui graph export "`path'evaluation`Z'_`dataset'.pdf", as(pdf) replace
			graph drop `graphnames`Z'' evaluation`Z'_`dataset' 
		}
		di "{result:{bf:`Y' PDF} pages à {bf:`gppage'} graphs were compiled and saved in {bf:`path'}.}"
end
