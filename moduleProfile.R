profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4,

      uiOutput(ns('Spc2Incld')),
      column(12, plotOutput(ns("profile1")),
             plotOutput(ns("profile"))))
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt, TerTrDt, plotTrPr,
                          trendM) {
  profile <- eventReactive(plotTrPr(), {
    if (nSpecies == 1) {
      TransProfile(trans = as.data.frame(MaiTrDt()))#, secondary = as.data.frame(SecTrDt()))#, tertiary = as.data.frame(TerTrDt()))#,
      #trendM = as.character(trendM))
    }
    if (nSpecies == 2) {
      TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()))#, tertiary = as.data.frame(TerTrDt()))#,
      #trendM = as.character(trendM))
    }
    if (nSpecies == 3) {
      TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()), tertiary = as.data.frame(TerTrDt()))#,
      #trendM = as.character(trendM))
    }
    
  })
  profile1 <- eventReactive(plotTrPr(), {
    TransProfile(Ex = TRUE)
    #  TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()), tertiary = as.data.frame(TerTrDt()))#,
                 #trendM = as.character(trendM))
  })
  output$profile <- renderPlot(profile())
  output$profile1 <- renderPlot(profile1())
}

