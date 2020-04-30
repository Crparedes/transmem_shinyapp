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
  box(title = label.1, status = "primary", 
      selectInput(ns("calModel"), label = 'Model', 
                  choices = list("Canonical (the data is already in desired units)" = "calCnncl", 
                                 "Univariate external standard" = "calUnES",
                                 "Bivariate external standard" = "calBiES",
                                 "Standard addition with dilution" = "calSAWiD",
                                 "Standard addition without dilution (single point)" = "calSAWoD"), 
                  selected = "calCnncl"),
      conditionalPanel(condition = "input.calModel != 'calCnncl'", ns = ns,
                       sliderInput(ns("calStdN"), label = "Number of standards", min = 2, max = 12, value = 6),
                       hotable(ns("CalCurv"))))
}

calibrationModule <- function(input, output, session) {
  # Initiate your table
  previous <- reactive({data.frame(Conc = rep(0, as.numeric(input$calStdN)), Signal = rep(0, as.numeric(input$calStdN)))})
  MyChanges <- reactive({
    if(all(as.data.frame(hot.to.df(input$CalCurv)) == 0)){return(previous())}
    else if(!identical(previous(), input$CalCurv)){
      as.data.frame(hot.to.df(input$CalCurv)) # hot.to.df function will convert your updated table into the dataframe
    }
  })
  output$CalCurv <- renderHotable({MyChanges()}, readOnly = F)
}