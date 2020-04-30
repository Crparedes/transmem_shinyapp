convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value']  = tabName
  mi
}

sidebarMenuUI <- sidebarMenu(id = "tabs",
  menuItem("Help", tabName = "help", icon = icon("question-circle")),
  convertMenuItem(menuItem("Calibration", tabName = "calib", icon = icon("signal"),
                           selectInput("mn_sp_calMod", label = "Main species", 
                                       choices = list("Canonical (data already in desired units)" = "calCnncl", 
                                                      "Univariate external standard" = "calUnES",
                                                      "Bivariate external standard" = "calBiES",
                                                      "Standard addition with dilution" = "calSAWiD",
                                                      "Standard addition without dilution (single point)" = "calSAWoD"), 
                                       selected = "calCnncl"),
                           selectInput("sec_sp_calMod", label = "Secondary species", 
                                       choices = list("(Not considered)" = "notCons",
                                                      "Canonical (data already in desired units)" = "calCnncl", 
                                                      "Univariate external standard" = "calUnES",
                                                      "Bivariate external standard" = "calBiES",
                                                      "Standard addition with dilution" = "calSAWiD",
                                                      "Standard addition without dilution (single point)" = "calSAWoD"), 
                                       selected = "notCons"),
                           selectInput("ter_sp_calMod", label = "Tertiary species", 
                                       choices = list("(Not considered)" = "notCons",
                                                      "Canonical (data already in desired units)" = "calCnncl", 
                                                      "Univariate external standard" = "calUnES",
                                                      "Bivariate external standard" = "calBiES",
                                                      "Standard addition with dilution" = "calSAWiD",
                                                      "Standard addition without dilution (single point)" = "calSAWoD"), 
                                       selected = "notCons")), tabName = "calib"),
  menuItem("Data transformation", tabName = "datTrans", icon = icon("exchange-alt")),
  menuItem("Transport experiments", icon = icon("hourglass-half"),
           menuSubItem("Single transport", tabName = "sTrns"),
           menuSubItem("Separation factors", tabName = "sepFctr"),
           menuSubItem("Reuse cycles", tabName = "rCycl"),
           menuSubItem("Species concentration", tabName = "spCnc")),
  menuItem("Citation", tabName = "citation", icon = icon("creative-commons")),
  menuItem("R Project", icon = icon("r-project"), href = "https://www.r-project.org")
)




tabItemsUI <- tabItems(
  tabItem(tabName = "help", h2("Help content")),
  # Calibration methods
      tabItem(tabName = "calib", h2("Calibration")),

  tabItem(tabName = "datTrans", h2("Data transformation")),
  # Transport experiments,
      tabItem(tabName = "sTrns", h2("Single transport")),
      tabItem(tabName = "sepFctr", h2("Separation factors")),
      tabItem(tabName = "rCycl", h2("Reuse cycles")),
      tabItem(tabName = "spCnc", h2("Species concentration")),
  tabItem(tabName = "citation", h2("Citation"))
)