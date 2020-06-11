convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value']  = tabName
  mi
}

sidebarMenuUI <- sidebarMenu(id = "tabs",
  menuItem("Introduction", tabName = "introduction", icon = icon("question-circle")),
  convertMenuItem(menuItem("Main settings", tabName = "config", icon = icon("cog"),
                           sliderInput("nSpecies", label = "Species considered", min = 1, max = 3, value = 1),
                           sliderInput("nDataSts", label = "Transport datasets", min = 1, max = 12, value = 1),
                           tags$hr(),
                           radioButtons("Format", label = "Download files type",
                                        choices = list("PDF (vector graphics)" = ".pdf", "PNG (300 ppi bitmap)" = ".png")),
                           sliderInput("plotsW", label = "Figures width (mm)", min = 40, max = 300, value = 80),
                           sliderInput("plotsH", label = "Figures height (mm)", min = 40, max = 300, value = 60)),
                  tabName = "config"),
  menuItem("Calibration Models", tabName = "calib", icon = icon("signal")),
  menuItem("Data input and transformation", tabName = "datInput", icon = icon("exchange-alt")),
  menuItem("Transport experiments", icon = icon("hourglass-half"),
           menuSubItem("Single transport profiles", tabName = "sTrns"),
           menuSubItem("Permeability coefficients", tabName = "pCoef"),
           menuSubItem("Separation factors", tabName = "sepFctr"),
           menuSubItem("Reuse cycles", tabName = "rCycl"),
           menuSubItem("Species concentration", tabName = "spCnc")),
  menuItem("Example datasets", icon = icon("folder-open"), tabName = "exDat"),
  menuItem("Citation", tabName = "citation", icon = icon("creative-commons")),
  menuItem("transmem CRAN webpage", icon = icon("r-project"), href = "https://CRAN.R-project.org/package=transmem"),
  menuItem("Bug reports and suggestions", icon = icon("bug"), href = "https://github.com/Crparedes/transmem_shinyapp/issues"),
  menuItem("Github repository", icon = icon("github"), href = "https://github.com/Crparedes/transmem_shinyapp"),
  menuItem("Bibliography", tabName = "bibliography", icon = icon("book"))
)

tabItemsUI <- tabItems(
  tabItem(tabName = "introduction", h1('Introduction'), introductionModuleUI('introduction')),
  tabItem(tabName = "calib", h1("Calibration models"), LytCalibration),
  tabItem(tabName = "datInput", h1("Data input and transformation"), LytDatInput),
  tabItem(tabName = "sTrns", h1("Single transport profiles"), LytProfiles),
  tabItem(tabName = "pCoef", h1("Permeability coefficients"), LytPermCoef),
  tabItem(tabName = "sepFctr", h1("Separation factors"), tags$hr(), LytSepFactor),
  # Reuse Cycles
  tabItem(tabName = "rCycl", h1("Reuse cycles"), tags$hr(),
          conditionalPanel(condition = 'input.nDataSts == 1',
                           infoBox(width = 12, "More datasets required", color = Hcol('Tertiary')[2], icon = icon("eye-slash"),
                                   h4('Reuse cycles plots require at least two datasets!'))), 
          conditionalPanel(condition = 'input.nDataSts >= 2', 
                           #fluidRow(column(2, selectInput("MP.model", label = "Definition to use:", 
                          #                                choices = list("Batch systems" = 1, "Continous systems" = 2))),
                          #          column(2, h5('Be sure all data has been entered and transformated (if required).'),
                          #                 actionButton("plotReuseButton", label = "Plot reuse cycles", styleclass = 'primary'))),
                           tags$hr(),
                           reuseModuleUI('reusecyclesM'))),
  #Species concentration
  tabItem(tabName = "spCnc", h2("Species concentration")),

  tabItem(tabName = 'exDat', examplesModuleUI('examples')),
  tabItem(tabName = "citation", h1("Citation"), citationModuleUI()),
  tabItem(tabName = "bibliography", h1("Bibliography"), bibliographyModuleUI())
)
