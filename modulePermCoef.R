permCoefModuleUI <- function(id, IntID = 1) {
  ns <- NS(id)
  box(title = paste0("System ", IntID), width = 12, height = 610,
      column(4, infoBox(width = 12, "Main species", htmlOutput(ns('prmCoefMn')),
                        color = Hcol('Main')[2], icon = icon("chart-line")),
             downloadButton(ns('DwnPeCM'), label = 'Download plot'),
             plotOutput(ns("permPlotM"))),
      column(4, conditionalPanel(condition = 'input.nSpecies >= 2',
                                 infoBox(width = 12, "Secondary species", htmlOutput(ns('prmCoefSc')),
                                         color = Hcol('Secondary')[2], icon = icon("chart-line")),
                                 downloadButton(ns('DwnPeCS'), label = 'Download plot'),
                                 plotOutput(ns("permPlotS")))),
      column(4, conditionalPanel(condition = 'input.nSpecies == 3',
                                 infoBox(width = 12, "Tertiary species", htmlOutput(ns('prmCoefTr')),
                                         color = Hcol('Tertiary')[2], icon = icon("chart-line")),
                                 downloadButton(ns('DwnPeCT'), label = 'Download plot'),
                                 plotOutput(ns("permPlotT"))))
  )
}

permCoefModule <- function(input, output, session, P.data, MaiTrDt, SecTrDt = NULL, TerTrDt = NULL, calPermCoef,
                           formatP, dimensP) {
  CoefMn <- reactive(permcoefCustom(trans = as.data.frame(MaiTrDt()), vol = P.data[2], area = P.data[1]))
  CoefSc <- reactive(permcoefCustom(trans = as.data.frame(SecTrDt()), vol = P.data[2], area = P.data[1]))
  CoefTr <- reactive(permcoefCustom(trans = as.data.frame(TerTrDt()), vol = P.data[2], area = P.data[1]))
  
  PermPlotLimsM <- eventReactive(calPermCoef(), {c(min(CoefMn()[[4]]), max(CoefMn()[[4]]), min(CoefMn()[[3]]), max(CoefMn()[[3]]))})
  PermPlotLimsS <- eventReactive(calPermCoef(), {c(min(CoefSc()[[4]]), max(CoefSc()[[4]]), min(CoefSc()[[3]]), max(CoefSc()[[3]]))})
  PermPlotLimsT <- eventReactive(calPermCoef(), {c(min(CoefTr()[[4]]), max(CoefTr()[[4]]), min(CoefTr()[[3]]), max(CoefTr()[[3]]))})
  
  prmCoefMn <- eventReactive(calPermCoef(), {paste0('P: ', CoefMn()[[1]], " \u00b1 ", CoefMn()[[2]], " m/s", '<br /><small>', 
                                                    CoefMn()[[5]])})
  prmCoefSc <- eventReactive(calPermCoef(), {paste0('P: ', CoefSc()[[1]], " \u00b1 ", CoefSc()[[2]], " m/s", '<br /><small>', 
                                                    CoefSc()[[5]])})
  prmCoefTr <- eventReactive(calPermCoef(), {paste0('P: ', CoefTr()[[1]], " \u00b1 ", CoefTr()[[2]], " m/s", '<br /><small>', 
                                                    CoefTr()[[5]])})
  
  output$prmCoefMn <- renderText(prmCoefMn())
  output$prmCoefSc <- renderText(prmCoefSc())
  output$prmCoefTr <- renderText(prmCoefTr())
  
  permPlotM <- eventReactive(calPermCoef(), {
    ggplot(data = data.frame(t = CoefMn()[[4]], y = CoefMn()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsM()[3:4] + diff(PermPlotLimsM()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsM()[1:2] + diff(PermPlotLimsM()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsM()[1:2], ylim = PermPlotLimsM()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  permPlotS <- eventReactive(calPermCoef(), {
    ggplot(data = data.frame(t = CoefSc()[[4]], y = CoefSc()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsS()[3:4] + diff(PermPlotLimsS()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsS()[1:2] + diff(PermPlotLimsS()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsS()[1:2], ylim = PermPlotLimsS()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  permPlotT <- eventReactive(calPermCoef(), {
    ggplot(data = data.frame(t = CoefTr()[[4]], y = CoefTr()[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = PermPlotLimsT()[3:4] + diff(PermPlotLimsT()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = PermPlotLimsT()[1:2] + diff(PermPlotLimsT()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = PermPlotLimsT()[1:2], ylim = PermPlotLimsT()[3:4]) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  
  output$permPlotM <- renderPlot(permPlotM())
  output$permPlotS <- renderPlot(permPlotS())
  output$permPlotT <- renderPlot(permPlotT())
  
  output$DwnPeCM <- downloadHandler(filename = function(){paste0('permeabilityCoefficientMain', as.character(formatP))},
                                    content = function(file){
                                      if (as.character(formatP) == '.pdf') {
                                        pdf(file, width = dimensP[1], height = dimensP[2])
                                      } else {
                                        png(file, width = dimensP[1], height = dimensP[2], units = 'in', res = 300)
                                      }
                                      print(permPlotM())
                                      dev.off()
                                    }
  )
  output$DwnPeCS <- downloadHandler(filename = function(){paste0('permeabilityCoefficientSecondary', as.character(formatP))},
                                    content = function(file){
                                      if (as.character(formatP) == '.pdf') {
                                        pdf(file, width = dimensP[1], height = dimensP[2])
                                      } else {
                                        png(file, width = dimensP[1], height = dimensP[2], units = 'in', res = 300)
                                      }
                                      print(permPlotS())
                                      dev.off()
                                    }
  )
  output$DwnPeCT <- downloadHandler(filename = function(){paste0('permeabilityCoefficientTertiary', as.character(formatP))},
                                    content = function(file){
                                      if (as.character(formatP) == '.pdf') {
                                        pdf(file, width = dimensP[1], height = dimensP[2])
                                      } else {
                                        png(file, width = dimensP[1], height = dimensP[2], units = 'in', res = 300)
                                      }
                                      print(permPlotT())
                                      dev.off()
                                    }
  )
}