convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value']  = tabName
  mi
}

sidebarMenuUI <- sidebarMenu(id = "tabs",
  menuItem("Help", tabName = "help", icon = icon("question-circle")),
  convertMenuItem(menuItem("Main settings", tabName = "config", icon = icon("cog"),
                           sliderInput("nSpecies", label = "Species considered", min = 1, max = 3, value = 2),
                           sliderInput("nDataSts", label = "Transport datasets", min = 1, max = 12, value = 1)), 
                  tabName = "config"),
  #convertMenuItem(menuItem("Calibration", tabName = "calib", icon = icon("signal"),
  #                         selectCalModelUI('MainSpeciesCalMod'),
  #                         conditionalPanel(condition = "input.nSpecies >= 2", selectCalModelUI('SeconSpeciesCalMod')),
  #                         conditionalPanel(condition = "input.nSpecies == 3", selectCalModelUI('TertiSpeciesCalMod'))), 
  #                tabName = "calib"),
  menuItem("Calibration Models", tabName = "calib", icon = icon("signal")),
  menuItem("Data transformation", tabName = "datTrans", icon = icon("exchange-alt")),
  menuItem("Transport experiments", icon = icon("hourglass-half"),
           menuSubItem("Single transport", tabName = "sTrns"),
           menuSubItem("Separation factors", tabName = "sepFctr"),
           menuSubItem("Reuse cycles", tabName = "rCycl"),
           menuSubItem("Species concentration", tabName = "spCnc")),
  menuItem("Citation", tabName = "citation", icon = icon("creative-commons")),
  menuItem("Github repository", icon = icon("github"), href = "https://github.com/Crparedes/transmem_shinyapp"),
  menuItem("R Project", icon = icon("r-project"), href = "https://www.r-project.org"),
  menuItem("Bibliography", tabName = "bibliography", icon = icon("book"))
)




tabItemsUI <- tabItems(
  tabItem(tabName = "help", h2("Help content")),
  # Calibration methods
      tabItem(tabName = "calib", h1("Calibration models"),
              calibrationModuleUI('MainSpeciesCal'),
              conditionalPanel(condition = "input.nSpecies >= 2", 
                               calibrationModuleUI('SeconSpeciesCal', label.1 = "Secondary species")),
              conditionalPanel(condition = "input.nSpecies == 3", 
                               calibrationModuleUI('TertiSpeciesCal', label.1 = "Tertiary species"))),
  tabItem(tabName = "datTrans", h2("Data transformation")),
  # Transport experiments,
      tabItem(tabName = "sTrns", h2("Single transport")),
      tabItem(tabName = "sepFctr", h2("Separation factors")),
      tabItem(tabName = "rCycl", h2("Reuse cycles")),
      tabItem(tabName = "spCnc", h2("Species concentration")),
  tabItem(tabName = "citation", h2("Citation"))
)