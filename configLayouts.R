convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value']  = tabName
  mi
}

sidebarMenuUI <- sidebarMenu(id = "tabs",
  menuItem("Instructions", tabName = "instructions", icon = icon("question-circle")),
  convertMenuItem(menuItem("Main settings", tabName = "config", icon = icon("cog"),
                           sliderInput("nSpecies", label = "Species considered", min = 1, max = 3, value = 1),
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
  menuItem("Example datasets", icon = icon("folder-open"), tabName = "exDat"),
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
                           calibrationModuleUI('SeconSpeciesCal', label.1 = "Secondary")),
          conditionalPanel(condition = "input.nSpecies == 3",
                           calibrationModuleUI('TertiSpeciesCal', label.1 = "Tertiary"))),
  # Input and transform data
  tabItem(tabName = "datInput", h1("Data input and transformation"),
          fluidRow(inputDataModuleUI('MainDset1'),
                   conditionalPanel(condition = "input.nSpecies >= 2",
                                    inputDataModuleUI('SecDset1', Spc = "Secondary")),
                   conditionalPanel(condition = "input.nSpecies == 3",
                                    inputDataModuleUI('TerDset1', Spc = "Tertiary"))),
          conditionalPanel(condition = 'input.nDataSts >= 2', {
            fluidRow(inputDataModuleUI('MainDset2', IntID = 2),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset2', Spc = "Secondary", IntID = 2)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset2', Spc = "Tertiary", IntID = 2)))}),
          conditionalPanel(condition = 'input.nDataSts >= 3', {
            fluidRow(inputDataModuleUI('MainDset3', IntID = 3),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset3', Spc = "Secondary", IntID = 3)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset3', Spc = "Tertiary", IntID = 3)))}),
          conditionalPanel(condition = 'input.nDataSts >= 4', {
            fluidRow(inputDataModuleUI('MainDset4', IntID = 4),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset4', Spc = "Secondary", IntID = 4)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset4', Spc = "Tertiary", IntID = 4)))}),
          conditionalPanel(condition = 'input.nDataSts >= 5', {
            fluidRow(inputDataModuleUI('MainDset5', IntID = 5),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset5', Spc = "Secondary", IntID = 5)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset5', Spc = "Tertiary", IntID = 5)))}),
          conditionalPanel(condition = 'input.nDataSts >= 6', {
            fluidRow(inputDataModuleUI('MainDset6', IntID = 6),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset6', Spc = "Secondary", IntID = 6)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset6', Spc = "Tertiary", IntID = 6)))}),
          conditionalPanel(condition = 'input.nDataSts >= 7', {
            fluidRow(inputDataModuleUI('MainDset7', IntID = 7),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset7', Spc = "Secondary", IntID = 7)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset7', Spc = "Tertiary", IntID = 7)))}),
          conditionalPanel(condition = 'input.nDataSts >= 8', {
            fluidRow(inputDataModuleUI('MainDset8', IntID = 8),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset8', Spc = "Secondary", IntID = 8)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset8', Spc = "Tertiary", IntID = 8)))}),
          conditionalPanel(condition = 'input.nDataSts >= 9', {
            fluidRow(inputDataModuleUI('MainDset9', IntID = 9),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset9', Spc = "Secondary", IntID = 9)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset9', Spc = "Tertiary", IntID = 9)))}),
          conditionalPanel(condition = 'input.nDataSts >= 10', {
            fluidRow(inputDataModuleUI('MainDset10', IntID = 10),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset10', Spc = "Secondary", IntID = 10)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset10', Spc = "Tertiary", IntID = 10)))}),
          conditionalPanel(condition = 'input.nDataSts >= 10', {
            fluidRow(inputDataModuleUI('MainDset11', IntID = 11),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset11', Spc = "Secondary", IntID = 11)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset11', Spc = "Tertiary", IntID = 11)))}),
          conditionalPanel(condition = 'input.nDataSts >= 12', {
            fluidRow(inputDataModuleUI('MainDset12', IntID = 12),
                     conditionalPanel(condition = "input.nSpecies >= 2",
                                      inputDataModuleUI('SecDset12', Spc = "Secondary", IntID = 12)),
                     conditionalPanel(condition = "input.nSpecies == 3",
                                      inputDataModuleUI('TerDset12', Spc = "Tertiary", IntID = 12)))})
          ),
  # Transport experiments,
  tabItem(tabName = "sTrns", h1("Single transport profiles"),
          fluidRow(column(2, selectInput("trendM", label = "Model for the main species",
                                         choices = list("Paredes et al." = 'paredes', "Rodriguez de San Miguel et al." = 2))),
                   column(2, selectInput("trendS", label = "Model for the secondary species",
                                         choices = list("Paredes et al." = 'paredes', "Rodriguez de San Miguel et al." = 2))),
                   column(2, selectInput("trendT", label = "Model for the tertiary species",
                                         choices = list("Paredes et al." = 'paredes', "Rodriguez de San Miguel et al." = 2))),
                   column(2, h5('Be sure all data has been entered and transformated (if required).'),
                          actionButton("plotTrPr", label = "Draw profiles", styleclass = 'primary'))),
          tags$hr(),
          profileModuleUI('transProf1')),

  tabItem(tabName = "sepFctr", h2("Separation factors")),
  tabItem(tabName = "rCycl", h2("Reuse cycles")),
  tabItem(tabName = "spCnc", h2("Species concentration")),

  #tabItem(tabName = 'exDat', examplesModuleUI('examples')),
  tabItem(tabName = "citation", h1("Citation"), citationModuleUI()),
  tabItem(tabName = "bibliography", h1("Bibliography"), bibliographyModuleUI())
)
