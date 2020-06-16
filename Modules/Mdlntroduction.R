introductionModuleUI <- function(id) {
  ns <- NS(id)
  fluidRow(column(10, introductionDs), column(2, genCharDs), 
           column(12, tabBox(width = 12, height = 900, title = "FEATURES", side = 'left',
                  tabPanel("Transport profiles", intrTransProfDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExProfile')), type = 6), intrTransProfCpt),
                                    column(6, intrTransProfDs2))),
                  tabPanel("Permeability coefficients", intrPermCoefDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExPermCoef')), type = 6)),
                                    column(6, intrPermCoefDs2))),
                  tabPanel("Separation factors/coefficients", intrSepFactorDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExSepFactor')), type = 6)),
                                    column(6, intrSepFactorDs2))),
                  tabPanel("Reuse cycles", intrReuseDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExReuseCycl')), type = 6)),
                                    column(6, intrReuseDs2))),
                  tabPanel("Species concentration", intrSpConcDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExSpcsConc')), type = 6)),
                                    column(6, intrSpConcDs2))),
                  tabPanel(''),tabPanel(''),
                  tabPanel("-Details of empiric models", intrEmprcMdlsDs1))))
}

introductionOutputs <- function(input, output, session) {
  # Profile
  output$ExProfile <- renderPlot(custom_transPlot(Ex = TRUE))
  # PermCoef
  ExPerm <- custom_permcoef(trans = reusecycles[[1]], vol = 85, area = 2.5**2*pi)
  output$ExPermCoef <- renderPlot({
    ggplot(data = data.frame(t = ExPerm[[4]], y = ExPerm[[3]]), aes(x = t, y = y)) +
      theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
      scale_y_continuous(limits = c(min(ExPerm[[3]]), max(ExPerm[[3]])) + diff(c(min(ExPerm[[3]]), max(ExPerm[[3]]))) * c(-2, 2)) +
      scale_x_continuous(limits = c(min(ExPerm[[4]]), max(ExPerm[[4]])) + diff(c(min(ExPerm[[4]]), max(ExPerm[[4]]))) * c(-2, 2)) +
      coord_cartesian(xlim = c(min(ExPerm[[4]]), max(ExPerm[[4]])), ylim = c(min(ExPerm[[3]]), max(ExPerm[[3]]))) +
      geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
  # Sep Factor
  df1 <- cbind(SF2 <- sepfactor(main = seawaterLiNaK$Lithium.1, secon = seawaterLiNaK$Sodium.1, order = 2, plot = FALSE), 
               rep('Sec', 7))
  df2 <- cbind(SF3 <- sepfactor(main = seawaterLiNaK$Lithium.1, secon = seawaterLiNaK$Potassium.1, order = 2, plot = FALSE),
               rep('Ter', 7))
  colnames(df1)[3] <- colnames(df2)[3] <- 'spc'
  output$ExSepFactor <- renderPlot({
    ggplot(data = rbind(df1, df2), aes(x = time, y = SF, group = spc)) + 
      geom_smooth(method = 'loess', formula = 'y ~ x', se = FALSE, color = 'black') +
      geom_point(size = 3, color = 'black', fill = 'white', aes(shape = spc)) +
      theme_bw() +  labs(y = 'Separation factor', x = 'Time') +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"), 
            legend.position = 'none') + scale_shape_manual(values = c(17, 24))})
  # Reuse
  
  # Species concentration
}




