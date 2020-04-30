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
  box(title = label.1, status = "primary", width = 12,
      selectInput(ns("calModel"), label = 'Model', 
                  choices = list("Canonical (use when the transport data is already in the desired units)" = "calCnncl", 
                                 "Univariate external standard" = "calUnES",
                                 "Bivariate external standard" = "calBiES",
                                 "Standard addition with dilution" = "calSAWiD",
                                 "Standard addition without dilution (single point)" = "calSAWoD"), 
                  selected = "calCnncl"),
      conditionalPanel(condition = "input.calModel == 'calUnES' || input.calModel == 'calBiES'", ns = ns,
                       sliderInput(ns("calStdN"), label = "Number of standards", min = 3, max = 12, value = 6)),
      
      conditionalPanel(condition = "input.calModel == 'calUnES'", ns = ns,
                       hotable(ns("ExCalCurv")), 
                       selectInput(ns("order"), label = 'Model order', 
                                   choices = list("Linear" = 1, "Quadratic" = 2), selected = 1)#,
                       #plotOutput(ns('ExCalCurvPlot'))
                       ),
      
      conditionalPanel(condition = "input.calModel == 'calBiES'", ns = ns,
                       hotable(ns("ExCalPlne"))),
      
      conditionalPanel(condition = "input.calModel == 'calSAWiD' || input.calModel == 'calSAWoD'", ns = ns,
                       h3('Under implementation...')))
}

calibrationModule <- function(input, output, session) {
  # External calibration univariate
  ExCalCurvPrevious <- reactive({data.frame(Conc = rep(0, as.numeric(input$calStdN)), 
                                            Signal = rep(0, as.numeric(input$calStdN)))})
  ExCalCurvMyChanges <- reactive({
    if(all(as.data.frame(hot.to.df(input$ExCalCurv)) == 0)){return(ExCalCurvPrevious())}
    else if(!identical(ExCalCurvPrevious(), input$ExCalCurv)){
      as.data.frame(hot.to.df(input$ExCalCurv)) # hot.to.df function will convert your updated table into the dataframe
    }
  })
  output$ExCalCurv <- renderHotable({ExCalCurvMyChanges()}, readOnly = F)
  cCurveESU <- reactive({calibCurve(curve = as.data.frame(hot.to.df(input$ExCalCurv)), order = input$order)})
  output$ExCalCurvPlot <- renderPlot({expr = plot(1:10)})
  
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