sepFactorModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 12, 
      box(title = "Separation factors against secondary species", solidHeader = TRUE, width = 4,
          status = Hcol('Secondary')[1], height = 610,
          infoBox(width = 12, "Results", htmlOutput(ns('SepFac2dat')), color = Hcol('Secondary')[2], icon = icon("chart-line")),
          downloadButton(ns('DwnSel2'), label = 'Download plot'), 
          plotOutput(ns("SepFac2"))),
      conditionalPanel(condition = 'input.nSpecies == 3', 
                       box(title = "Separation factors against Tertiary species", solidHeader = TRUE, width = 4,
                           status = Hcol('Tertiary')[1], height = 610,
                           infoBox(width = 12, "Results", htmlOutput(ns('SepFac3dat')),
                                   color = Hcol('Tertiary')[2], icon = icon("chart-line")),
                           downloadButton(ns('DwnSel3'), label = 'Download plot'),
                           plotOutput(ns("SepFac3")))),
      conditionalPanel(condition = 'input.nSpecies == 3', 
                       box(title = "Combined plot", solidHeader = TRUE, width = 4,
                           status = Hcol('Main')[1], height = 610,
                           downloadButton(ns('DwnSelM'), label = 'Download plot'),
                           plotOutput(ns("SepFacComb"))))
  )
}

sepFactorModule <- function(input, output, session, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, calcSepFc, SF.model,
                            formatP, dimensP) {
  
  mode <- reactive(c('batch', 'continuous')[SF.model()])
  SF2 <- reactive(sepfactor(main = as.data.frame(MaiTrDt()), secon = as.data.frame(SecTrDt()), order = 2,
                            mode = mode(), plot = FALSE))
  SF3 <- reactive(sepfactor(main = as.data.frame(MaiTrDt()), secon = as.data.frame(TerTrDt()), order = 2,
                            mode = mode(), plot = FALSE))
  
  lSF2 <- reactive(length(SF2()$SF))
  lSF3 <- reactive(length(SF3()$SF))
  
  SepFac2dat <- eventReactive(calcSepFc(), {paste0('Final sep. factor: &emsp;&emsp;&emsp;&ensp;&ensp;&thinsp;', 
                                                   signif(SF2()$SF[lSF2()], 4), 
                                                   '<br />', 'Maximum sep. factor: &emsp;&ensp;&ensp;', signif(max(SF2()$SF), 4), 
                                                   '<br />', 'Average sep. factor (t > 0): ', signif(mean(SF2()$SF[-1]), 4))})
  SepFac3dat <- eventReactive(calcSepFc(), {paste0('Final sep. factor: &emsp;&emsp;&emsp;&ensp;&ensp;&thinsp;', 
                                                   signif(SF3()$SF[lSF3()], 4), 
                                                   '<br />', 'Maximum sep. factor: &emsp;&ensp;&ensp;', signif(max(SF3()$SF), 4), 
                                                   '<br />', 'Average sep. factor (t > 0): ', signif(mean(SF3()$SF[-1]), 4))})
  output$SepFac2dat <- renderText(SepFac2dat())
  output$SepFac3dat <- renderText(SepFac3dat())
  
  SepFac2 <- eventReactive(calcSepFc(), {
    ggplot(data = SF2(), aes(x = time, y = SF)) + 
      geom_smooth(method = 'loess', formula = 'y ~ x', se = FALSE, color = 'black') +
      theme_bw() +  labs(y = 'Separation factor', x = 'Time') + geom_point(size = 3, shape = 17) + 
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"))})
  SepFac3 <- eventReactive(calcSepFc(), {
    ggplot(data = SF3(), aes(x = time, y = SF)) +
      geom_smooth(method = 'loess', formula = 'y ~ x', se = FALSE, color = 'black') +
      theme_bw() +  labs(y = 'Separation factor', x = 'Time') + geom_point(size = 3, shape = 24, fill = 'white') + 
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"))})
  
  SepFacComb <- eventReactive(calcSepFc(), {
    df1 <- cbind(as.data.frame(SF2()), rep('Sec', lSF2()))
    df2 <- cbind(as.data.frame(SF3()), rep('Ter', lSF3()))
    colnames(df1)[3] <- colnames(df2)[3] <- 'spc'
    ggplot(data = rbind(df1, df2), aes(x = time, y = SF, group = spc)) + 
      geom_smooth(method = 'loess', formula = 'y ~ x', se = FALSE, color = 'black') +
      geom_point(size = 3, color = 'black', fill = 'white', aes(shape = spc)) +
      theme_bw() +  labs(y = 'Separation factor', x = 'Time') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"), 
            legend.position = 'none') + scale_shape_manual(values = c(17, 24))})
  
  output$SepFac2 <- renderPlot(SepFac2())
  output$SepFac3 <- renderPlot(SepFac3())
  output$SepFacComb <- renderPlot(SepFacComb())
  
  output$DwnSel2 <- dwldhndlr(name = 'sepFactVsSec', formatP = formatP, dimensP = dimensP, plt = SepFac2())
  output$DwnSel3 <- dwldhndlr(name = 'sepFactVsTer', formatP = formatP, dimensP = dimensP, plt = SepFac3())
  output$DwnSelM <- dwldhndlr(name = 'sepFactVsBoth', formatP = formatP, dimensP = dimensP, plt = SepFacComb())

}