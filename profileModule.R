profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4, 
      actionButton('plotTrPr', label = 'Plot transport profile'),
      uiOutput(ns('hwmnysp')), tags$hr(),
      #hotable(ns("TrnsDt")),
      #tableOutput(ns("TrnsfrmdDt")))
      column(12, column(8, uiOutput(ns("chckbx"))),
             column(4, h5(tags$b('Settings')), checkboxInput(ns("nrmliz"), label = "Normalize data", value = TRUE))),
      column(5, hotable(ns("TrnsDt"))),
      column(7, textOutput(ns('ModelMsg')),
             #uiOutput(ns("chckbx")),
             uiOutput(ns("button")), tags$hr(),
             tableOutput(ns("TrnsfrmdDt"))))
  
}

profileModule <- function(input, output, session, nSpecies) {
  output$hwmnysp <- renderUI(ifelse(nSpecies == 2, 
                                    checkboxGroupInput(session$ns("Spc2Incld"), 
                                                       label = "Species to include in the profile",
                                                       choices = "")))
  
}