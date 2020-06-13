bibliographyModuleUI <- function(id) {
  box(width = 12,
    h5(HTML('
<table>
  <tr><td><span style="opacity:0;">_</span>
          &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</td></tr>
  
  <tr valign="top">
    <td align="right">[NAME et al., ]&emsp;</td>
    <td> DETAILS <a href="URL">URL</a></td>
  </tr><tr><td><span style="opacity:0;">_</span></td></tr>
  
  <tr valign="top">
    <td align="right">[Chang et al., 2020]&emsp;</td>
    <td>Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R
    package version 1.4.0.2. <a href="https://CRAN.R-project.org/package=shiny">https://CRAN.R-project.org/package=shiny</a></td>
  </tr>tr><td>&zwnj;</td></tr>
  
  <tr valign="top">
    <td align="right">[R Core Team, 2020]&emsp;</td>
    <td>R Core Team (2020). R: A language and environment for statistical computing. R Foundation for Statistical Computing,
    Vienna, Austria. <a href="https://www.R-project.org/">https://www.R-project.org/</a></td>
  </tr>tr><td><span style="opacity:0;">_</span></td></tr>
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
