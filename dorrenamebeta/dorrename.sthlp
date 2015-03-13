{smcl}
{* *! version 1.0.1 27 February 2015}{...}
help for {cmd:dororder}{right:version beta  (13 March 2015)}
{hline}


{title:Title}

{phang}
{bf:dororder} {hline 2} Reorder variables in dataset using metadata in DDIonRails format.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorrename using} {help filename:{it:filename}}
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dororder} relocates the variables to a position specified metadata in DDIonRails format ({browse "http://ddionrails.org/imports/variables_csv.html":variables.csv}). The dataset needs to have the characteristics study, dataset and version. With this characteristics the using file (variables.csv) is restricted for the relevant lines. If the dataset does not have the necessary characteristics, they have to be added in advance. Variables that are not present in variables.csv are moved to the end of the dataset. Variables that are present in variables.csv but not in the dataset are ignored.
{p_end}


{marker remarks}{...}
{title:Remarks}

{pstd}
This command is part of the {browse "http://ddionrails.org/stata":dortools} bundle. Please inform the author about issues using this {browse "https://github.com/ddionrails/stata/issues":tracker}.
{p_end}

{pstd}
The source code of the program is licensed under the GNU General Public License version 3 or later. The corresponding license text can be found on the internet at {browse "http://www.gnu.org/licenses/"} or in {help gnugpl}.
{p_end}


{marker author}{...}
{title:Authors}

{pstd}
Knut Wenzig ({browse "mailto:kwenzig@diw.de":kwenzig@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}

