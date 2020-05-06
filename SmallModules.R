instructionsModuleUI <- function(id) {
  ns <- NS(id)
  fluidRow(infoBox(width = 11, "transmem package", color = 'light-blue', icon = icon("align-justify"),
                   h5("This is the graphical user interface for the R-package transmem.",
                      tags$br(), tags$br(),
                      "The objective of the tools here is to provide functionalities that automatizes the treatment of
                      membrane transport data in which some species concentrations envolve in function of time
                      at both sides of the membrane as a consecuence of the transport process.
                      Membrane performance parameters and high quality plots for several experimental setups are
                      easily obtained using this app.",
                      tags$br(), tags$br(),
                      "R is a powerfull free software
                      environment for statistical computing and graphics [1]. This interactive web app was made using Shiny [2].")),
           box(solidHeader = TRUE, status = "primary", width = 2, title = "Main settings",
               tags$hr(), h5("The main chararacteristics that must be defined is the number of species
                             considered and the number of datasets to analize. The package allows up to measured during the transport experiment")),
           box(solidHeader = TRUE, status = "primary", width = 6, title = "Data input",
               tags$hr(), h5("There are two alternatives to enter data depending on the disponible information")),
           box(solidHeader = TRUE, status = "primary", width = 4, title = "Results obtention",
               tags$hr(), h6('askldñhf'), h4('askldñhf')))
}


citationModuleUI <- function(id) {
  box(width = 12,
      tags$h5('If you have found this app useful for your research please cite it as:', tags$br(), tags$br(),
              tags$b('Cristhian Paredes and Eduardo Rodriguez-de-San-Miguel (2020).
                      transmem: Treatment of Membrane-Transport Data. R package
                      version 0.1.0.', tags$a("https://CRAN.R-project.org/package=transmem",
                                              href = "https://CRAN.R-project.org/package=transmem"))),
      tags$br(),
      tags$h5('A BibTeX entry for LaTeX users is:', tags$br()),
      tags$code('@Manual{,', tags$br(),
                HTML('&nbsp;'), 'title = {transmem: Treatment of Membrane-Transport Data},', tags$br(),
                HTML('&nbsp;'), 'author = {Cristhian Paredes and Eduardo Rodriguez-de-San-Miguel},', tags$br(),
                HTML('&nbsp;'), 'year = {2020},', tags$br(),
                HTML('&nbsp;'), 'note = {R package version 0.1.0},', tags$br(),
                HTML('&nbsp;'), 'url = {https://CRAN.R-project.org/package=transmem}', tags$br(),
                '}')
  )
}

bibliographyModuleUI <- function(id) {
  box(width = 12,
    h5('[1]. R Core Team (2020). R: A language and environment for statistical computing. R Foundation for Statistical Computing,
    Vienna, Austria. URL ', a("https://www.R-project.org/", href = "https://www.R-project.org/")),
    h5('[s]. Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R
    package version 1.4.0.2. ', a("https://CRAN.R-project.org/package=shiny", href = "https://CRAN.R-project.org/package=shiny"))
  )
}
