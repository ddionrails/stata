{smcl}
{* *! version 1.0.1 27 February 2015}{...}
help for {cmd:dorrename}{right:version beta  (2 March 2015)}
{hline}


{title:Title}

{phang}
{bf:dorrename} {hline 2} renames variables in a datasets using metadata in DDIonRails format (generations.csv).


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:dorrename using} {help filename:{it:filename}}, {opt ostudy("study")} {opt odataset("dataset")} {opt oversion("version")}
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dorrename} renames variables in a datasets using metadata in DDIonRails format (generations.csv). The dataset needs to have the characteristcs study and version. Together with this characteristics and the information given in the options, the using file (generations.csv) is restricted for the relevant lines. If the dataset does not have the necessary characteristics, they have to be added in advance. Variables that are not present in the renaming table will be deleted.
{p_end}


{marker options}{...}
{title:Options}

{phang}
{opt ostudy("study")} the output_study for which generations.csv will be restricted
{p_end}
{phang}
{opt odataset("dataset")} the output_dataset for which generations.csv will be restricted
{p_end}
{phang}
{opt oversion("version")} the output_version for which generations.csv will be restricted
{p_end}


{marker remarks}{...}
{title:Remarks}

{pstd}
This command is part of the {browse "http://ddionrails.org/stata":dortools} bundle. Please inform the authors about issues using this {browse "https://github.com/ddionrails/stata/issues":tracker}.
{p_end}

{pstd}
The source code of the program is licensed under the GNU General Public License version 3 or later. The corresponding license text can be found on the internet at {browse "http://www.gnu.org/licenses/"} or in {help gnugpl}.
{p_end}


{marker author}{...}
{title:Author}

{pstd}
Knut Wenzig ({browse "mailto:kwenzig@diw.de":kwenzig@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}
{pstd}Marius Pahl ({browse "mailto:mpahl@diw.de":mpahl@diw.de}), DIW Berlin, German Socio-Economic Panel (SOEP), Germany.
{p_end}

