reuseModuleUI <- function(id, Species = 'Main') {
  ns <- NS(id)
  box(title = paste0(Species, ' species'), width = 12, status = Hcol(id = Species)[1], solidHeader = TRUE,
      fluidRow(column(2, checkboxInput(ns('Arrows'), label = "Include trend arrows in profiles", value = FALSE)),
               column(2, selectInput(ns('trendReuse'), label = "Model to use in profiles",
                                     choices = list("Paredes et al." = 1, "Rodriguez de San Miguel et al." = 2))),
               column(2, selectInput(ns('trendRsFin'), label = "Trend line in final values plot",
                                     choices = list("(no trend line)" = 1, "Linear" = 2, "(non parametric) LOESS"))),
               column(2, actionButton(ns("plotReuseButton"), label = "Plot/replot", styleclass = 'primary'))
      ),
      tags$hr(),
      box(title = 'Single phase profiles: Strip', width = 3, status = Hcol(id = Species)[1],
          uiOutput(ns("arrowstrip")), #tags$hr(), 
          downloadButton(ns('DwnSP.Str'), label = 'Download plot'), plotOutput(ns("SP.Str"))),
      box(title = 'Single phase profiles: Feed', width = 3, status = Hcol(id = Species)[1],
          uiOutput(ns("arrowfeed")), #tags$hr(), 
          downloadButton(ns('DwnSP.Fd'), label = 'Download plot'), plotOutput(ns("SP.Fd"))),
      box(title = 'Final value per cycle: Strip', width = 3, status = Hcol(id = Species)[1],
          downloadButton(ns('DwnFV.Str'), label = 'Download plot'), plotOutput(ns("FV.Str"))),
      box(title = 'Final value per cycle: Feed', width = 3, status = Hcol(id = Species)[1],
          downloadButton(ns('DwnFV.Fd'), label = 'Download plot'), plotOutput(ns("FV.Fd")))
      
  )
}

reuseModule <- function(input, output, session, plotReuseButton, nDataSts, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12,
                        formatP, dimensP) {
  trend <- reactive(c('paredes', 'rodriguez')[as.numeric(input$trendReuse)])
  
  output$arrowstrip <- renderUI(if (input$Arrows) {
    textInput(session$ns("arrowstrip"), label = "Enter arrow coordinates (x0, x1, y0, y1)", value = "0, 0, 0.8, 0.4")})
  output$arrowfeed <- renderUI(if (input$Arrows) {
    textInput(session$ns("arrowfeed"), label = "Enter arrow coordinates", value = "0, 0, 0.2, 0.6")})
  
  ArrSt <- reactive(as.numeric(unlist(strsplit(input$arrowstrip,","))))
  ArrFd <- reactive(as.numeric(unlist(strsplit(input$arrowfeed,","))))
  
  trans <- eventReactive(input$plotReuseButton, {
    x <- list(as.data.frame(d1()))
    for (i in 2:nDataSts()) x <- c(x, list(as.data.frame(eval(parse(text = paste0('d', i, '()'))))))
    return(x)})
    #return(list(as.data.frame(d1()), as.data.frame(d2())))})
  
  SP.Str <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'strip', bw = TRUE, arw = input$Arrows, ylim = c(0, 1),
                       arw.pos = ArrSt()))
  })
  SP.Fd <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'feed', bw = TRUE, arw = input$Arrows, ylim = c(0, 1),
                       arw.pos = ArrFd()))
  })
  
  output$SP.Str <- renderPlot(SP.Str())
  output$SP.Fd <- renderPlot(SP.Fd())
  
}

