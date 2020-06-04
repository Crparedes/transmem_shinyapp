sepFactorModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 12, 
      conditionalPanel(condition = 'input.nSpecies == 1',
                       infoBox(width = 12, "More species required", color = Hcol('Main')[2], icon = icon("eye-slash"),
                               h4('Separation factor calculations require at least two species!'))),
      conditionalPanel(condition = 'input.nSpecies >= 2', 
                       box(title = "Separation factors against secondary species", solidHeader = TRUE, width = 4,
                           status = Hcol('Secondary')[1],
                           infoBox(width = 12, "Results", htmlOutput(ns('SepFac2dat')),
                                   color = Hcol('Secondary')[2], icon = icon("chart-line")),
                           plotOutput(ns("SepFac2")))),
      conditionalPanel(condition = 'input.nSpecies == 3', 
                       box(title = "Separation factors against Tertiary species", solidHeader = TRUE, width = 4,
                           status = Hcol('Tertiary')[1],
                           infoBox(width = 12, "Results", htmlOutput(ns('SepFac3dat')),
                                   color = Hcol('Tertiary')[2], icon = icon("chart-line")),
                           plotOutput(ns("SepFac3")))),
      conditionalPanel(condition = 'input.nSpecies == 3', 
                       box(title = "Combined plot", solidHeader = TRUE, width = 4,
                           status = Hcol('Main')[1],
                           plotOutput(ns("SepFacComb"))))
  )
}

sepFactorModule <- function(input, output, session, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, calcSepFc, SF.model) {
  
  mode <- c('batch', 'continuous')
  CoefMn <- reactive(permcoefCustom(trans = as.data.frame(MaiTrDt()), vol = P.data[2], area = P.data[1]))
  
  PermPlotLimsM <- eventReactive(calcSepFc(), {c(min(CoefMn()[[4]]), max(CoefMn()[[4]]), min(CoefMn()[[3]]), max(CoefMn()[[3]]))})
  
  prmCoefMn <- eventReactive(calcSepFc(), {paste0('P: ', CoefMn()[[1]], " \u00b1 ", CoefMn()[[2]], " m/s")})
  
  output$prmCoefMn <- renderText(prmCoefMn())
  
  SepFac2 <- eventReactive(calcSepFc(), {
    ggplot(data = data.frame(t = CoefMn()[[4]], y = CoefMn()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsM()[3:4] + diff(PermPlotLimsM()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsM()[1:2] + diff(PermPlotLimsM()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsM()[1:2], ylim = PermPlotLimsM()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  output$SepFac2 <- renderPlot(SepFac2())
  
  SepFac3 <- eventReactive(calcSepFc(), {
    ggplot(data = data.frame(t = CoefMn()[[4]], y = CoefMn()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsM()[3:4] + diff(PermPlotLimsM()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsM()[1:2] + diff(PermPlotLimsM()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsM()[1:2], ylim = PermPlotLimsM()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  output$SepFac3 <- renderPlot(SepFac3())
  
  SepFacComb <- eventReactive(calcSepFc(), {
    ggplot(data = data.frame(t = CoefMn()[[4]], y = CoefMn()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsM()[3:4] + diff(PermPlotLimsM()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsM()[1:2] + diff(PermPlotLimsM()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsM()[1:2], ylim = PermPlotLimsM()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  output$SepFacComb <- renderPlot(SepFacComb())
}