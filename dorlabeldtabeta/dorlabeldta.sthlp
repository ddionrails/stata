{smcl}
{* *! version beta 8 April 2015}{...}
help for {cmd:dorlabeldta}{right:version beta (8 April 2015)}
{hline}


{title:Title}

{phang}
{bf:dorlabeldta} {hline 2} label dataset using DDIonRails metadata


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorlabeldta using} {{it:path_name}}, {opt language(string)}
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorlabeldta} applies variable and value labels using metadata in DDIonRails format. Therefore the files variables.csv and variable_categories.csv have to be available in the using path. The dataset also needs to have the characteristics study, dataset and version.
{p_end}


{marker options}{...}
{title:Options}

{phang}
{opt language(string)} specifies the language of the labels deployed. (Implemented only: en.)
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

{pstd}Marius Pahl ({browse "mailto:mpahl@diw.de":mailto:mpahl@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}
{pstd}
Knut Wenzig ({browse "mailto:kwenzig@diw.de":mailto:kwenzig@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}

