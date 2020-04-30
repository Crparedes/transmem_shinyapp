#selectCalModelUI <- function(id, label = "Main species") {
#  ns <- NS(id)
#  selectInput(ns("calModel"), label = label, 
#              choices = list("Canonical (data already in desired units)" = "calCnncl", 
#                             "Univariate external standard" = "calUnES",
#                             "Bivariate external standard" = "calBiES",
#                             "Standard addition with dilution" = "calSAWiD",
#                             "Standard addition without dilution (single point)" = "calSAWoD"), 
#              selected = "calCnncl")
#}

calibrationModuleUI <- function(id, inputCM, label.1 = "Main species") {
  ns <- NS(id)
  box(title = label.1, status = "primary", 
      selectInput(ns("calModel"), label = 'Model', 
                  choices = list("Canonical (data already in desired units)" = "calCnncl", 
                                 "Univariate external standard" = "calUnES",
                                 "Bivariate external standard" = "calBiES",
                                 "Standard addition with dilution" = "calSAWiD",
                                 "Standard addition without dilution (single point)" = "calSAWoD"), 
                  selected = "calCnncl"),
      conditionalPanel(condition = "input.calModel != 'calCnncl'", ns = ns,
                       numericInput(ns("calStdN"), label = "Number of standards", value = 6)))
}

calibrationModule <- function(input, output, session) {
  
}