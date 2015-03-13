{smcl}
{* *! version 1.0.1 27 February 2015}{...}
help for {cmd:dorcomparexls}{right:version beta  (13 March 2015)}
{hline}


{title:Title}

{phang}
{bf:dorcomparexls} {hline 2} consildates the result of a dataset comparison with a comparison memory.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorcomparexls using} {help filename:{it:filename}}}
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorcomparexls} uses the result of {cmd:dorcomparedta} and consolidates it with a comparison memory stored in the first sheet of an Excel file. The underlying idea is the following: If all differences between two files are accepted (by stateing "1" in the column accept in the sheet "result" of the Excel file), then the two files can be appended without mixing incompatible information. If the difference is not acceptable, the files should be modified in advance.
{p_end}
{pstd}
The Excel sheet specified with the using statement serves as a comparision memory for this specific job. Each row contains a difference in the two datasets (processed with {cmd:dorcomparedta}). The acceptance is stored in the column accept and kept as long as the the difference is detected by {cmd:dorcomparedta}.
{p_end}

{pstd}
The Excel file is overwritten by a Excel file with three sheets:
{p_end}
{pstd}
Sheet "unchanged": contains a copy of the first sheet of the specified Excel file.
{p_end}
{pstd}
Sheet "used_memory": Rows from sheet "unchanged", which show an accepted difference detected by {cmd:dorcomparedta}. (Rows which are not accepted or show a difference which is not (again) detected by {cmd:dorcomparedta} are deleted.)
{p_end}
{pstd}
Sheet "result": Every row shows a detected difference. The differences which have not yet been evaluated appear at the top, the accepted differences (from sheet "used_memory") appear at the bottom. If one states a "1" in the column "accepted", this means: the the difference shown in this row does not have severe consequences, if one would append the two datasets. If one can not accept this difference, one has to modify the files before appending them. If one has finished to evaluate the differences, the other sheets of the Excel file should be deleted and the sequence {cmd:dorcomparedta}/{cmd:dorcomparexls} can be started again. If the are no more unaccepted rows, it is save to append the two files using {cmd:append} or {cmd:dorappend}.
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