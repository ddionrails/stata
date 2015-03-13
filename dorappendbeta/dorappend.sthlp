{smcl}
{* *! version 1.0.1 27 February 2015}{...}
help for {cmd:dorappend}{right:version beta  (13 March 2015)}
{hline}


{title:Title}

{phang}
{bf:dorappend} {hline 2} append datasets and fill resulting spare cells


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorappend using} {help filename:{it:filename}}[, {opt generate(newvar)} {opt  mval(value)} {opt mlab("label")}]
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorappend} appends two datasets and fills resulting spare cells with a given value while {help append} fills this cells only with NA. The datasets need to have the characteristic dataset containing the name of the dataset.
{p_end}


{marker options}{...}
{title:Options}

{phang}
{opt generate(newvar)} specifies the name of a variable to be created that will mark the source of observations. (string variable with dataset names)
{p_end}
{phang}
{opt mval(value)} specifies the value to be assigned, if a variable is not present in the origin dataset. In case of string variables the value is stored as string.
{p_end}
{phang}
{opt mlab(value)} (not yet implemented!) the label added to value labels of variables which are only present in one of the two files. (not yet implemented)
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
Knut Wenzig ({browse "mailto:kwenzig@diw.de":mailto:kwenzig@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}
{pstd}Marius Pahl ({browse "mailto:mpahl@diw.de":mailto:mpahl@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}

