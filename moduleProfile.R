profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4, 
      actionButton('plotTrPr', label = 'Plot transport profile', styleclass = 'primary'),
      uiOutput(ns('Spc2Incld')), tags$hr(),
      #hotable(ns("TrnsDt")),
      #tableOutput(ns("TrnsfrmdDt")))
      column(12, plotOutput(ns("profile")),
             column(4, h5(tags$b('Settings')), checkboxInput(ns("nrmliz"), label = "Normalize data", value = TRUE))),
      column(5, hotable(ns("TrnsDt"))),
      column(7, textOutput(ns('ModelMsg')),
             #uiOutput(ns("chckbx")),
             uiOutput(ns("button")), tags$hr(),
             tableOutput(ns("TrnsfrmdDt"))))
  
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL) {
  output$profile <- renderPlot(transPlot(trans = MaiTrDt(), bw = TRUE))
  
}