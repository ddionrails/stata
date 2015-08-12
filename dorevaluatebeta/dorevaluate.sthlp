{smcl}
{* *! version 1.0.1 8 June 2015}{...}
help for {cmd:dorevaluate}{right:version beta  (8 June 2015)}
{hline}


{title:Title}

{phang}
{bf:dorevaluate} {hline 2} Visual comparison of a merged dataset from different sources.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorevaluate} [, {opt path("pathname")} {opt srcvariable(variable)} {opt  gppage(integer)}]
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorevaluate} compares the kernel density functions of all variables in the opened dataset between its sources. In order to visualize this evaluation, the corresponding graphs are displayed and saved by dorevaluate in the specified path.
{p_end}


{marker options}{...}
{title:Options}

{phang}
{opt path("pathname")} specifies the folder path, in which the compiled PDFs are saved. It must be written in double quotes.
{p_end}
{phang}
{opt srcvariable(variable)} specifies the name of the variable, that indicates the different sources of the dataset. It must be numeric.
{p_end}
{phang}
{opt  gppage(integer)} specifies the number of graphs per (PDF)page. The default value is 6.
{p_end}


{marker remarks}{...}
{title:Remarks}

{pstd}
This command is part of the {browse "http://ddionrails.org/stata":dortools} bundle. Please inform the author about issues using this {browse "https://github.com/ddionrails/stata/issues":tracker}.
{p_end}

{pstd}
The source code of the program is licensed under the GNU General Public License version 3 or later. The corresponding license text can be found on the internet at {browse "http://www.gnu.org/licenses/"} or in {help gnugpl}.
{p_end}


{marker authors}{...}
{title:Authors}

{pstd}
Maximilian Priem ({browse "mailto:mpriem@diw.de":mailto:mpriem@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}

