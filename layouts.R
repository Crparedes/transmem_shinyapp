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
                           radioButtons("Format", label = "Downloadable files format",
                                        choices = list("PDF (vector graphics)" = ".pdf", "PNG (300 ppi bitmap)" = ".png")),
                           sliderInput("plotsW", label = "Downloadable figures width (mm)", min = 40, max = 300, value = 80),
                           sliderInput("plotsH", label = "Downloadable figures height (mm)", min = 40, max = 300, value = 60)),
                  tabName = "config"),
  menuItem("Calibration Models", tabName = "calib", icon = icon("signal")),
  menuItem("Data input and transformation", tabName = "datInput", icon = icon("exchange-alt")),
  menuItem("Transport experiments", icon = icon("hourglass-half"),
           menuSubItem("Single transport profiles", tabName = "sTrns"),
           menuSubItem("P ermeability coefficients", tabName = "pCoef"),
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
  tabItem(tabName = "config", h1("Main settings"), settingsDs),
  tabItem(tabName = "calib", h1("Calibration models"), LytCalibration),
  tabItem(tabName = "datInput", h1("Data input and transformation"), LytDatInput),
  tabItem(tabName = "sTrns", h1("Single transport profiles"), LytProfiles),
  tabItem(tabName = "pCoef", h1("Permeability coefficients"), LytPermCoef),
  tabItem(tabName = "sepFctr", h1("Separation factors"), LytSepFactor),
  tabItem(tabName = "rCycl", h1("Reuse cycles"), LytReuCycl),
  tabItem(tabName = "spCnc", h1("Species concentration"), LytSpConc),
  tabItem(tabName = 'exDat', examplesModuleUI('examples')),
  tabItem(tabName = "citation", h1("Citation"), citationModuleUI()),
  tabItem(tabName = "bibliography", h1("Bibliography"), bibliographyModuleUI())
)
