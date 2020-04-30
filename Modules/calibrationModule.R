#selectCalModelUI <- function(id, label = "Main species") {
#  ns <- NS(id)
#  selectInput(ns("calModel"), label = label, 
#              choices = list("Canonical (data already in desired units)" = "calCnncl", 
#                             "Univariate external standard" = "calUnES",
#                             "Bivariate external standard" = "calBiES",
#                             "Standard addition with dilution" = "calSAWiD",
#                             "Standard addition without dilution (single point)" = "calSAWoD"), 
#              selected = "calCnncl")
#}

calibrationModuleUI <- function(id, inputCM, label.1 = "Main species") {
  ns <- NS(id)
  fluidRow(
    box(title = label.1, status = "primary", width = 3, br(), solidHeader = TRUE,
        selectInput(ns("calModel"), label = 'Model', 
                    choices = list("Canonical (use when the transport data is already in the desired units)" = "calCnncl", 
                                   "Univariate external standard" = "calUnES",
                                   "Bivariate external standard" = "calBiES",
                                   "Standard addition with dilution" = "calSAWiD",
                                   "Standard addition without dilution (single point)" = "calSAWoD"), 
                    selected = "calCnncl"),
        conditionalPanel(condition = "input.calModel == 'calUnES' || input.calModel == 'calBiES'", ns = ns,
                         sliderInput(ns("calStdN"), label = "Number of standards (modify before entering data)", 
                                     min = 3, max = 12, value = 6)),
        
        conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                         hotable(ns("ExCalCurv")), 
                         selectInput(ns("order"), label = 'Model order', 
                                     choices = list("Linear" = 1, "Quadratic" = 2), selected = 1)),
        
        conditionalPanel(condition = "input.calModel == 'calBiES'", ns = ns,
                         hotable(ns("ExCalPlne"))),
        
        conditionalPanel(condition = "input.calModel == 'calSAWiD' || input.calModel == 'calSAWoD'", ns = ns,
                         h4('Enter data directly on '))
    ),
    conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                     box(status = "primary", width = 5,
                         plotOutput(ns('ExCalCurvPlot'))),
                     infoBox("Calibration function", 10 * 2, icon = icon("kiwi-bird")))
  )
}

calibrationModule <- function(input, output, session) {
  # External calibration univariate
  ExCalCurvPrevious <- reactive({data.frame(Conc = rep(0, as.numeric(input$calStdN)), 
                                            Signal = rep(0, as.numeric(input$calStdN)))})
  ExCalCurvMyChanges <- reactive({
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
    ) #hot.to.df function will convert your updated table into the dataframe
  })
  output$ExCalCurv <- renderHotable({ExCalCurvMyChanges()}, readOnly = F)
  cCurveESU <- reactive({calibCurve(curve = ExCalCurvMyChanges(), order = as.numeric(input$order))})
  output$ExCalCurvPlot <- renderPlot({
    ggplot(data = ExCalCurvMyChanges(), aes(x = Conc, y = Signal)) +
      theme_bw() + geom_point(size = 3, shape = 16)  +
      labs(y = 'Signal', x = expression(paste('Concentration (mg k', g^{-1}, ')'))) +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            axis.text.x = element_text(color = "black"),
            axis.text.y = element_text(color = "black")) +
      scale_y_continuous(limits = ExCalCurvXlimYlim()[3:4] + diff(ExCalCurvXlimYlim()[3:4]) * c(-2, 2)) +
      scale_x_continuous(limits = ExCalCurvXlimYlim()[1:2] + diff(ExCalCurvXlimYlim()[1:2]) * c(-2, 2)) +
      coord_cartesian(xlim = ExCalCurvXlimYlim()[1:2], ylim = ExCalCurvXlimYlim()[3:4]) +
      geom_smooth(method = 'lm', formula = y ~ poly(x, as.numeric(input$order)), 
                  fullrange = TRUE, color = 'black', size = 0.4, level = 0.99)})
  
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
  
  
}