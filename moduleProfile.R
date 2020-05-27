profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4,

      uiOutput(ns('Spc2Incld')),
      #hotable(ns("TrnsDt")),
      #tableOutput(ns("TrnsfrmdDt")))
      column(12, plotOutput(ns("profile1")),
             plotOutput(ns("profile"))))
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, plotTrPr) {
  profile <- eventReactive(plotTrPr(), {ExProfile()})
  output$profile1 <- renderPlot(profile())
  output$profile <- renderPlot(TransProfile(trans = 'example'))

}
