profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4,
      column(12, #plotOutput(ns("profileEx")),
             #conditionalPanel(condition = 'input.nSpecies == 1',
                              withSpinner(plotOutput(ns("profile1"))),#),
             conditionalPanel(condition = 'input.nSpecies == 2',
                              withSpinner(plotOutput(ns("profile2")))),
             conditionalPanel(condition = 'input.nSpecies == 3',
                              withSpinner(plotOutput(ns("profile3")))),
             downloadButton(ns('DwnProf'), label = 'Download plot')
             )
  )
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, mdlStt, plotTrPr,
                          trends, formatP, dimensP) {
  trendOptions <- c('paredes', 'rodriguez')
  profile1 <- eventReactive(plotTrPr(), {
    if (nSpecies() == 1) {custom_transPlot(trans = as.data.frame(MaiTrDt()), trendM = trendOptions[trends()[1]])} else {
      if (nSpecies() == 2) {custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
                                             trendM = trendOptions[trends()[1]], trendS = trendOptions[trends()[2]])} else {
        if (nSpecies() == 3) {custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
                                               tertiary = as.data.frame(TerTrDt()), trendM = trendOptions[trends()[1]], 
                                               trendS = trendOptions[trends()[2]], trendT = trendOptions[trends()[3]])}}}})
#  profile2 <- eventReactive(plotTrPr(), {
#    if (nSpecies() == 2) custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
#                                                    trendM = trendOptions[trends()[1]], trendS = trendOptions[trends()[2]])
#  })
#  profile3 <- eventReactive(plotTrPr(), {
#    if (nSpecies() == 3) {custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
#                                                    tertiary = as.data.frame(TerTrDt()), trendM = trendOptions[trends()[1]], 
#                                                    trendS = trendOptions[trends()[2]], trendT = trendOptions[trends()[3]])}
#  })
      
  output$profile1 <- renderPlot(profile1())
#  output$profile2 <- renderPlot(profile2())
#  output$profile3 <- renderPlot(profile3())
  output$DwnProf <- downloadHandler(filename = function(){paste0('transportProfile', formatP())},
                                    content = function(file){
                                      if (formatP() == '.pdf') {
                                        pdf(file, width = dimensP()[1], height = dimensP()[2])
                                      } else {
                                        png(file, width = dimensP()[1], height = dimensP()[2], units = 'in', res = 300)
                                      }
                                      #if(as.numeric(nSpecies) == 1) 
                                      print(profile1())
                                      #if(as.numeric(nSpecies) == 2) print(profile2())
                                      #if(as.numeric(nSpecies) == 3) print(profile3())
                                      dev.off()
                                    }
  )
}

