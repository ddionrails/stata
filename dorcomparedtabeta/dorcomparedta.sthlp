{smcl}
{* *! version 1.0.1 27 February 2015}{...}
help for {cmd:dorcomparedta}{right:version beta  (13 March 2015)}
{hline}


{title:Title}

{phang}
{bf:dorcomparedta} {hline 2} compares type, label and value labels of joint variables in two datasets.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorcomparedta using} {help filename:{it:filename}}}
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorcomparedta} compares the joint variables of two datasets in respect of their type (string vs. numeric), their variable labels and their value labels. The dataset needs to have the characteristic dataset. The result is a new dataset with the outcome of the comparison.
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

