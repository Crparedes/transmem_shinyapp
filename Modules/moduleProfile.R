profileModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 4,
      column(12, verbatimTextOutput(ns("value")), plotOutput(ns("profilePlt")), downloadButton(ns('DwnProf'), label = 'Download plot')))
}

profileModule <- function(input, output, session, nSpecies, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, mdlStt, plotTrPr,
                          trends, formatP, dimensP) {
  trndOpt <- reactive(c('paredes', 'rodriguez', 'loess', 'linear', 'nTL')[trends()])
  mdlSttRc <- eventReactive(plotTrPr(), {x <- rep(1, 3)
    for (i in 1:nSpecies()) {if (trndOpt()[i] %in%  c('paredes', 'loess')) x[i] <- mdlStt()[i]}
    return(x)})

  profilePlt <- eventReactive(plotTrPr(), {
    if (nSpecies() == 1) {custom_transPlot(trans = as.data.frame(MaiTrDt()), trendM = trndOpt()[1], mdlStt = mdlSttRc())} else {
      if (nSpecies() == 2) {custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
                                             trendM = trndOpt()[1], trendS = trndOpt()[2], mdlStt = mdlSttRc())} else {
        if (nSpecies() == 3) {custom_transPlot(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
                                               tertiary = as.data.frame(TerTrDt()), trendM = trndOpt()[1], 
                                               trendS = trndOpt()[2], trendT = trndOpt()[3], mdlStt = mdlSttRc())}}}})

  output$profilePlt <- renderPlot(profilePlt())
  
  output$DwnProf <- dwldhndlr(name = 'transportProfile', formatP = formatP, dimensP = dimensP, plt = profilePlt())
  
  downloadHandler(filename = function(){paste0('transportProfile', formatP())},
                                    content = function(file){
                                      if (formatP() == '.pdf') {
                                        pdf(file, width = dimensP()[1], height = dimensP()[2])
                                      } else {
                                        png(file, width = dimensP()[1], height = dimensP()[2], units = 'in', res = 300)
                                      }
                                      #if(as.numeric(nSpecies) == 1) 
                                      print(profilePlt())
                                      #if(as.numeric(nSpecies) == 2) print(profile2())
                                      #if(as.numeric(nSpecies) == 3) print(profile3())
                                      dev.off()
                                    }
  )
}

