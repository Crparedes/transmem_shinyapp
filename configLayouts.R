convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value']  = tabName
  mi
}

sidebarMenuUI <- sidebarMenu(id = "tabs",
  menuItem("Instructions", tabName = "instructions", icon = icon("question-circle")),
  convertMenuItem(menuItem("Main settings", tabName = "config", icon = icon("cog"),
                           sliderInput("nSpecies", label = "Species considered", min = 1, max = 3, value = 2),
                           sliderInput("nDataSts", label = "Transport datasets", min = 1, max = 12, value = 1),
                           tags$hr(),
                           radioButtons("Format", label = "Download files type",
                                        choices = list("PDF (vector image)" = ".pdf", "PNG" = ".png"), selected = ".pdf"),
                           sliderInput("plotsW", label = "Figures width (mm)", min = 40, max = 300, value = 80),
                           sliderInput("plotsH", label = "Figures height (mm)", min = 40, max = 300, value = 60)),
                  tabName = "config"),
  #convertMenuItem(menuItem("Calibration", tabName = "calib", icon = icon("signal"),
  #                         selectCalModelUI('MainSpeciesCalMod'),
  #                         conditionalPanel(condition = "input.nSpecies >= 2", selectCalModelUI('SeconSpeciesCalMod')),
  #                         conditionalPanel(condition = "input.nSpecies == 3", selectCalModelUI('TertiSpeciesCalMod'))),
  #                tabName = "calib"),
  menuItem("Calibration Models", tabName = "calib", icon = icon("signal")),
  menuItem("Data input and transformation", tabName = "datInput", icon = icon("exchange-alt")),
  menuItem("Transport experiments", icon = icon("hourglass-half"),
           menuSubItem("Single transport profiles", tabName = "sTrns"),
           menuSubItem("Permeability coefficients", tabName = "pCoef"),
           menuSubItem("Separation factors", tabName = "sepFctr"),
           menuSubItem("Reuse cycles", tabName = "rCycl"),
           menuSubItem("Species concentration", tabName = "spCnc")),
  menuItem("Example datasets", icon = icon("folder-open"), tabName = "expDat"),
  menuItem("Citation", tabName = "citation", icon = icon("creative-commons")),
  menuItem("transmem CRAN webpage", icon = icon("r-project"), href = "https://CRAN.R-project.org/package=transmem"),
  menuItem("Bug reports and suggestions", icon = icon("bug"), href = "https://github.com/Crparedes/transmem_shinyapp/issues"),
  menuItem("Github repository", icon = icon("github"), href = "https://github.com/Crparedes/transmem_shinyapp"),
  menuItem("Bibliography", tabName = "bibliography", icon = icon("book"))
)

tabItemsUI <- tabItems(
  tabItem(tabName = "instructions", h1('Instructions'), instructionsModuleUI('instructions')),
  # Calibration methods
  tabItem(tabName = "calib", h1("Calibration models"),
          calibrationModuleUI('MainSpeciesCal'),
          conditionalPanel(condition = "input.nSpecies >= 2",
                           calibrationModuleUI('SeconSpeciesCal', label.1 = "Secondary species")),
          conditionalPanel(condition = "input.nSpecies == 3",
                           calibrationModuleUI('TertiSpeciesCal', label.1 = "Tertiary species"))),
  # Input and transform data
  tabItem(tabName = "datInput", h1("Data input and transformation"),
          fluidRow(inputDataModuleUI('MainDset1'),
                   conditionalPanel(condition = "input.nSpecies >= 2",
                                    inputDataModuleUI('SecDset1', Spc = "Secondary species")),
                   conditionalPanel(condition = "input.nSpecies == 3",
                                    inputDataModuleUI('TerDset1', Spc = "Tertiary species")))),
  # Transport experiments,
  tabItem(tabName = "sTrns", h1("Single transport profiles"),
          profileModuleUI('transProf1')),

  tabItem(tabName = "sepFctr", h2("Separation factors")),
  tabItem(tabName = "rCycl", h2("Reuse cycles")),
  tabItem(tabName = "spCnc", h2("Species concentration")),
  tabItem(tabName = "citation", h1("Citation"), citationModuleUI()),
  tabItem(tabName = "bibliography", h1("Bibliography"), bibliographyModuleUI())
)
