bibliographyModuleUI <- function(id) {
  box(width = 12,
    h5(HTML('
<table>
  <tr><td>&zwnj;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
          &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</td></tr>
  
  <tr valign="top">
    <td align="right">[NAME et al., ]&emsp;</td>
    <td> DETAILS <a href="https://doi.org/">https://doi.org/</a></td>
  </tr><tr><td>&zwnj;</td></tr>
  
  <tr valign="top">
    <td align="right">[Chang et al., 2020]&emsp;</td>
    <td>Chang, W, Cheng, J., Allaire, J., Xie, Y. and McPherson, J.,  (2020). shiny: Web Application Framework for R. R package 
        version 1.4.0.2. <a href="https://CRAN.R-project.org/package=shiny">https://CRAN.R-project.org/package=shiny</a></td>
  </tr>tr><td>&zwnj;</td></tr>
  
  <tr valign="top">
    <td align="right">[Koros et al., 1996]&emsp;</td>
    <td> Koros, W., Ma, Y. and Shimidzu, T., (1996). Terminology for membranes and membrane processes (IUPAC Recommendation 1996).  
         Journal of Membrane Science, 120(2), 149–159. DOI: 
         <a href="https://doi.org/10.1016/0376-7388(96)82861-4">https://doi.org/10.1016/0376-7388(96)82861-4</a></td>
  </tr><tr><td>&zwnj;</td></tr>
  
  <tr valign="top">
    <td align="right">[Luis, 2018]&emsp;</td>
    <td> Luis, P. (2018). Gas permeation and supported liquid membranes. Fundamental Modelling of Membrane Systems, 
         103–151. DOI: <a href="https://doi.org/10.1016/b978-0-12-813483-2.00004-6">
         https://doi.org/10.1016/b978-0-12-813483-2.00004-6</a></td>
  </tr><tr><td>&zwnj;</td></tr>

  <tr valign="top">
    <td align="right">[Ma et al., 2000]&emsp;</td>
    <td> Ma, P., Chen, X., and Hossain, M., (2000). Lithium Extraction from a Multicomponent Mixture Using Supported Liquid
         Membranes, Separation Science and Technology, 35:15, 2513-2533, DOI: <a href="https://doi.org/10.1081/
         SS-100102353">https://doi.org/10.1081/SS-100102353</a></td>
  </tr><tr><td>&zwnj;</td></tr>

  <tr valign="top">
    <td align="right">[Paredes and Rodriguez de San Miguel, 2020]&emsp;</td>
    <td>Paredes, C., and Rodríguez de San Miguel, E., (2020). Selective lithium extraction and concentration from diluted 
        alkaline aqueous media by a polymer inclusion membrane and application to seawater. Desalination, 487, 114500. DOI: 
        <a href="https://doi.org/10.1016/j.desal.2020.114500">https://doi.org/10.1016/j.desal.2020.114500</a></td>
  </tr><tr><td>&zwnj;</td></tr>

  <tr valign="top">
    <td align="right">[R Core Team, 2020]&emsp;</td>
    <td>R Core Team, (2020). R: A language and environment for statistical computing. R Foundation for Statistical Computing,
    Vienna, Austria. <a href="https://www.R-project.org/">https://www.R-project.org/</a></td>
  </tr>tr><td>&zwnj;</td></tr>
</table>')))
}

citationModuleUI <- function(id) {
  box(width = 12,
      tags$h5('If you have found this App useful for your research, please cite it as:', tags$br(), tags$br(),
              tags$b('Paredes, Cristhian and Rodriguez de San Miguel, Eduardo (2020).
                      transmem: Treatment of Membrane-Transport Data. R package
                      version 0.1.1.', tags$a("https://CRAN.R-project.org/package=transmem",
                                              href = "https://CRAN.R-project.org/package=transmem"))),
      tags$br(),
      tags$h5('A BibTeX entry for LaTeX users is:', tags$br()),
      tags$code('@Manual{,', tags$br(),
                HTML('&nbsp;'), 'title = {transmem: Treatment of Membrane-Transport Data},', tags$br(),
                HTML('&nbsp;'), 'author = {Paredes, Cristhian and {Rodr\'iguez de San Miguel}, Eduardo},', tags$br(),
                HTML('&nbsp;'), 'year = {2020},', tags$br(),
                HTML('&nbsp;'), 'note = {R package version 0.1.1},', tags$br(),
                HTML('&nbsp;'), 'url = {https://CRAN.R-project.org/package=transmem}', tags$br(),
                '}')
  )
}
