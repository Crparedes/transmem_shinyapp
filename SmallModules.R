instructionsModuleUI <- function(id) {
  ns <- NS(id)
  fluidRow(infoBox(width = 12, "transmem package", color = 'light-blue', icon = icon("align-justify"),
                   h4("This is the graphical user interface for the R-package transmem.",
                      tags$br(), tags$br(),
                      "The objective of the tools here available is to provide functionalities that automatizes the treatment of
                      membrane transport data in which some species concentrations envolve as a function of time
                      at both sides of the membrane as a consecuence of the transport process.
                      Membrane performance parameters and high quality plots for several experimental setups are
                      easily obtained using this app.",
                      tags$br(), tags$br(),
                      "The app is divided in a main panel to enter data and extract results and a side panel (left) that allows the
                      user to select the desired option. The tools here provided may be cited in publications as shown in ",
                      icon("creative-commons"), tags$b("Citation."),
                      tags$br(), tags$br(),
                      "The useful and powerful object-oriented R programming
                      capabilities [1] were implemented in this interactive web app using Shiny [2].")),

           box(solidHeader = TRUE, status = "primary", width = 2, title = "Main settings",
               h5("The main chararacteristics that must be defined are the number of species
                  considered and the number of datasets (experiments) to analize. Those options are selected in ",
                  icon("cog"), tags$b("Main Settings."), "The package allows the inclusion of up
                  to three species that must be regularly monitored during the transport experiment.",
                  tags$hr(),
                  "The data to be input to the app may be entered manually or may be copied from any spreadsheet.
                  The amount of rows needed must be indicated before entering any data.", tags$br(),
                  "Some example datasets have been included and can be visualized by clicking the",
                  icon("folder-open"), tags$b('Example datasets'), "option in the side panel.")),

           box(solidHeader = TRUE, status = "primary", width = 4, title = "Data input",
               h5("Depending on the data units and nature, it may be required some conversion from signal values to
                  concentration or fractions using calibration techniques.", tags$hr(),
                  "If your data is already in concentration or transported fraction values, proceed to ",
                  icon("exchange-alt"), tags$b("Data input and transformation"), "and enter the transport data
                  for all species in each transport dataset.", tags$hr(),
                  "If your data are signal values to be converted to concentration by using calibration curves, the
                  information regarding the standards concentration and their signals must be provided in ",
                  icon("signal"), tags$b("Calibration models"), ". Available models are univariated external standard calibration
                  (linear and polynomial) and bivariated external standard calibration. The calibration plot is displayed
                  and the residuals plot is also shwon to assess the model convenience. Regression  parameters and their statistical
                  significance are also given.", tags$b(), "Now it is possible to proceed to ",
                  icon("exchange-alt"), tags$b("Data input and transformation"), "to enter the signals for the analytes in both phases
                  for each transport data."), tags$hr(),
                  "By default the data is nomalized to the initial concentration in the feed solution. To change this unselect
                  the", tags$b(" Normalize data"), " option."),

           box(solidHeader = TRUE, status = "primary", width = 6, title = "Results obtention",
               tags$hr(), h4('askldñhf'), h4('askldñhf')))
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
