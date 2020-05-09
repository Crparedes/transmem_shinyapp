calibrationModuleUI <- function(id, inputCM, label.1 = "Main species") {
  ns <- NS(id)
  fluidRow(
    box(title = label.1, status = "primary", width = 3, br(), solidHeader = TRUE,
        selectInput(ns("calModel"), label = 'Model',
                    choices = list("Canonical (use when the transport data is already in the desired units)" = "calCnncl",
                                   "Univariate external standard" = "calUnES",
                                   "Bivariate external standard" = "calBiES",
                                   #"Standard addition with dilution" = "calSAWiD",
                                   "Single point standard addition without dilution" = "calSAWoD"),
                    selected = "calCnncl"),
        conditionalPanel(condition = "input.calModel == 'calUnES' || input.calModel == 'calBiES'", ns = ns,
                         sliderInput(ns("calStdN"), label = "Number of standards (set tables values to zero to modify)",
                                     min = 3, max = 12, value = 6)),

        conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                         fluidRow(column(5, hotable(ns("ExCalCurv"))),
                                  column(6, selectInput(ns("order"), label = 'Model order',
                                                        choices = list("Linear" = 1, "Quadratic" = 2), selected = 1),
                                         actionButton(ns("calculateRSC"), label = "Calculate model",
                                                      styleclass = 'primary')))
                         ),

        conditionalPanel(condition = "input.calModel == 'calBiES'", ns = ns,
                         hotable(ns("ExCalPlne"))),

        conditionalPanel(condition = "input.calModel == 'calSAWiD' || input.calModel == 'calSAWoD'", ns = ns,
                         h4('Enter data directly on '))
    ),
    conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                     tabBox(
                       title = "Plots", width = 5,
                       # The id lets us use input$tabset1 on the server to find the current tab
                       id = "tabset1",
                       tabPanel("Calibration", plotOutput(ns('ExCalCurvPlot')),
                                downloadButton(ns('DwnECCP'), label = 'Download plot')),
                       tabPanel("Residuals", plotOutput(ns('ExCalResiPlot')),
                                downloadButton(ns('DwnECRP'), label = 'Download plot'))
                     )),
    conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                     column(4, infoBox(width = 12, "Calibration function", htmlOutput(ns('niceCurvEq')),
                                                                color = 'light-blue', icon = icon("vials")),
                            infoBox(width = 12, "Statistical significance", htmlOutput(ns('niceStatSg')),
                                                               color = 'light-blue', icon = icon("chart-line"))))
  )
}

calibrationModule <- function(input, output, session, species = 'Main', formatP, dimensP) {
  # External calibration univariate
  ExCalCurvPrevious <- reactive({data.frame(Conc = rep(0, as.numeric(input$calStdN)),
                                                 Signal = rep(0, as.numeric(input$calStdN)))})
  orderRSC <- eventReactive(input$calculateRSC, return(as.numeric(input$order)))
  ExCalCurvMyChanges <- reactive({
    input$calculateRSC
    ifelse(all(as.data.frame(hot.to.df(input$ExCalCurv)) == 0),
           return(ExCalCurvPrevious()),
           return(data.frame(apply(as.data.frame(hot.to.df(input$ExCalCurv)), 2, function(x) as.numeric(as.character(x)))))
           ) #hot.to.df function will convert your updated table into the dataframe
  })
  ExCalCurvXlimYlim <- reactive({
    ifelse(all(as.data.frame(hot.to.df(input$ExCalCurv)) == 0),
           return(c(0, 1, 0, 1)),
           return(c(min(ExCalCurvMyChanges()[, 1]), max(ExCalCurvMyChanges()[, 1]),
                    min(ExCalCurvMyChanges()[, 2]), max(ExCalCurvMyChanges()[, 2])))
    )
  })
  output$ExCalCurv <- renderHotable({ExCalCurvMyChanges()}, readOnly = F)

  cCurveESU <- reactive({input$calculateRSC
    calibCurve(curve = ExCalCurvMyChanges(), order = as.numeric(input$order), plot = FALSE)})
  reactive_RSC <- eventReactive(input$calculateRSC, {
    list(Eq = ifelse(as.numeric(input$order) == 1,
                      paste0("Signal = (",
                             signif(summary(cCurveESU())$coefficients[1, 1], 4), "\u00b1",
                             signif(summary(cCurveESU())$coefficients[1, 2], 2), ") +<br />
                                            &emsp;&emsp;&emsp;&ensp;&ensp;&ensp;(",
                             signif(summary(cCurveESU())$coefficients[2, 1], 4), "\u00b1",
                             signif(summary(cCurveESU())$coefficients[2, 2], 2), ") * Conc"),
                      paste0("Signal = (",
                             signif(summary(cCurveESU())$coefficients[1, 1], 4), "\u00b1",
                             signif(summary(cCurveESU())$coefficients[1, 2], 2), ") +<br />
                                                 &emsp;&emsp;&emsp;&ensp;&ensp;&ensp;(",
                             signif(summary(cCurveESU())$coefficients[2, 1], 4), "\u00b1",
                             signif(summary(cCurveESU())$coefficients[2, 2], 2), ") * Conc +<br />
                                                 &emsp;&emsp;&emsp;&ensp;&ensp;&ensp;(",
                             signif(summary(cCurveESU())$coefficients[3, 1], 4), "\u00b1",
                             signif(summary(cCurveESU())$coefficients[3, 2], 2), ") * Conc<sup>2</sup>")),
         St = ifelse(as.numeric(input$order) == 1,
                     paste0("<small>p-values for regression coefficients:</small> <br />&emsp;(Intercept): ",
                            round(summary(cCurveESU())$coefficients[1, 4], 5),
                            "<br />&emsp;Conc:&emsp;&emsp;&ensp;&nbsp;&nbsp;",
                            round(summary(cCurveESU())$coefficients[2, 4], 5),
                            "<hr><small>Residual standard error: ", signif(summary(cCurveESU())$sigma, 4),
                            " on ", summary(cCurveESU())$df[2], " DF",
                            "<br />F-statistic: ", signif(summary(cCurveESU())$fstatistic[1], 4),
                            " on ", summary(cCurveESU())$fstatistic[2], " and ",
                            summary(cCurveESU())$fstatistic[3], " DF,  p-value: ",
                            round(1 - pf(summary(cCurveESU())$fstatistic[1],
                                         summary(cCurveESU())$fstatistic[2],
                                         summary(cCurveESU())$fstatistic[3]), 5), "</small>"),
                     paste0("<small>p-values for regression coefficients:</small> <br />&emsp;(Intercept): ",
                            round(summary(cCurveESU())$coefficients[1, 4], 5),
                            "<br />&emsp;Conc:&emsp;&emsp;&ensp;&nbsp;&nbsp;",
                            round(summary(cCurveESU())$coefficients[2, 4], 5),
                            "<br />&emsp;Conc<sup>2</sup>:&emsp;&emsp;&nbsp;&nbsp;",
                            round(summary(cCurveESU())$coefficients[3, 4], 5),
                            "<hr><small>Residual standard error: ", signif(summary(cCurveESU())$sigma, 4),
                            " on ", summary(cCurveESU())$df[2], " DF",
                            "<br />F-statistic: ", signif(summary(cCurveESU())$fstatistic[1], 4),
                            " on ", summary(cCurveESU())$fstatistic[2], " and ",
                            summary(cCurveESU())$fstatistic[3], " DF,  p-value: ",
                            round(1 - pf(summary(cCurveESU())$fstatistic[1],
                                         summary(cCurveESU())$fstatistic[2],
                                         summary(cCurveESU())$fstatistic[3]), 5), "</small>")),
         plt = ggplot(data = ExCalCurvMyChanges(), aes(x = Conc, y = Signal)) +
           theme_bw() + geom_point(size = 3, shape = 16)  +
           labs(y = 'Signal', x = expression(paste('Concentration'))) +# (mg k', g^{-1}, ')'))) +
           theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 axis.text.x = element_text(color = "black"),
                 axis.text.y = element_text(color = "black")) +
           scale_y_continuous(limits = ExCalCurvXlimYlim()[3:4] + diff(ExCalCurvXlimYlim()[3:4]) * c(-2, 2)) +
           scale_x_continuous(limits = ExCalCurvXlimYlim()[1:2] + diff(ExCalCurvXlimYlim()[1:2]) * c(-2, 2)) +
           coord_cartesian(xlim = ExCalCurvXlimYlim()[1:2], ylim = ExCalCurvXlimYlim()[3:4]) +
           geom_smooth(method = 'lm', formula = y ~ poly(x, orderRSC()),
                       fullrange = TRUE, color = 'black', size = 0.4, level = 0.99),
         rsd = ggplot(data = data.frame(Residuals = cCurveESU()$residuals, Concentration = ExCalCurvMyChanges()$Conc),
                      aes(x = Concentration, y = Residuals)) + theme_bw() + geom_point() +
           theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 axis.text.x = element_text(color = "black"),
                 axis.text.y = element_text(color = "black")) +
           scale_x_continuous(limits = ExCalCurvXlimYlim()[1:2] + diff(ExCalCurvXlimYlim()[1:2]) * c(-2, 2)) +
           coord_cartesian(xlim = ExCalCurvXlimYlim()[1:2]) +
           geom_smooth(method = 'lm', color = 'black', fullrange = TRUE))
  })
  output$niceCurvEq <- renderText(reactive_RSC()$Eq)
  output$niceStatSg <- renderText(reactive_RSC()$St)

  output$ExCalCurvPlot <- renderPlot(reactive_RSC()$plt)
  output$DwnECCP <- downloadHandler(filename = function(){paste0(species, '_cal_curve', as.character(formatP))},
                                    content = function(file){
                                      if (as.character(formatP) == '.pdf') {
                                        pdf(file, width = dimensP[1], height = dimensP[2])
                                      } else {
                                        png(file, width = dimensP[1], height = dimensP[2])
                                      }
                                      print(reactive_RSC()$plt)
                                      dev.off()
                                    }
  )
  output$ExCalResiPlot <- renderPlot(reactive_RSC()$rsd)
  output$DwnECRP <- downloadHandler(filename = function(){paste0(species, '_residuals', as.character(formatP))},
                                    content = function(file){
                                      if (as.character(formatP) == '.pdf') {
                                        pdf(file, width = dimensP[1], height = dimensP[2])
                                      } else {
                                        png(file, width = dimensP[1], height = dimensP[2])
                                      }
                                      print(reactive_RSC()$plt)
                                      dev.off()
                                    }
  )

  # External calibration bivariate
  ExCalPlnePrevious <- reactive({data.frame(Conc = rep(0, as.numeric(input$calStdN)),
                                            Conc.S = rep(0, as.numeric(input$calStdN)),
                                            Signal = rep(0, as.numeric(input$calStdN)))})
  ExCalPlneMyChanges <- reactive({
    if(all(as.data.frame(hot.to.df(input$ExCalPlne)) == 0)){return(ExCalPlnePrevious())}
    else if(!identical(ExCalPlnePrevious(), input$ExCalPlne)){
      as.data.frame(hot.to.df(input$ExCalPlne)) # hot.to.df function will convert your updated table into the dataframe
    }
  })
  output$ExCalPlne <- renderHotable({ExCalPlneMyChanges()}, readOnly = F)

  return(list(natModel = reactive(input$calModel),
              calModel = cCurveESU))
}

