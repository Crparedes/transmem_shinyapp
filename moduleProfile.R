profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4,
      uiOutput(ns('Spc2Incld')),
      column(12, #plotOutput(ns("profileEx")),
             conditionalPanel(condition = 'input.nSpecies == 1',
                              plotOutput(ns("profile1"))),
             conditionalPanel(condition = 'input.nSpecies == 2',
                              plotOutput(ns("profile2"))),
             conditionalPanel(condition = 'input.nSpecies == 3',
                              plotOutput(ns("profile3")))
             )
  )
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, plotTrPr,
                          trends) {
  trendOptions <- c('paredes', 'rodriguez')
  profile1 <- eventReactive(plotTrPr(), {
    TransProfile(trans = as.data.frame(MaiTrDt()), trendM = trendOptions[trends[1]])
  })
  profile2 <- eventReactive(plotTrPr(), {
    TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
                 trendM = trendOptions[trends[1]], trendS = trendOptions[trends[2]])
  })
  profile3 <- eventReactive(plotTrPr(), {
    TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()), tertiary = as.data.frame(TerTrDt()),
                 trendM = trendOptions[trends[1]], trendS = trendOptions[trends[2]], trendT = trendOptions[trends[3]])
  })
      
  profileEx <- eventReactive(plotTrPr(), {TransProfile(Ex = TRUE)})
  output$profile1 <- renderPlot(profile1())
  output$profile2 <- renderPlot(profile2())
  output$profile3 <- renderPlot(profile3())
  output$profileEx <- renderPlot(profileEx())
}

