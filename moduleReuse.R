reuseModuleUI <- function(id, Species = 'Main') {
  ns <- NS(id)
  box(title = paste0(Species, ' species'), width = 12, status = Hcol(id = Species)[1], solidHeader = TRUE,
      fluidRow(column(2, checkboxInput(ns('Arrows'), label = "Include trend arrows", value = FALSE)),
               column(2, selectInput(ns('trendReuse'), label = "Model to use",
                                     choices = list("Paredes et al." = 1, "Rodriguez de San Miguel et al." = 2))),
               column(2, actionButton(ns("plotReuseButton"), label = "Plot graphics", styleclass = 'primary'))
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
    textInput(session$ns("arrowstrip"), label = "Enter arrow coordinates (x0, x1, y0, y1)", value = "6.1, 6.1, 0.8, 0.6")})
  output$arrowfeed <- renderUI(if (input$Arrows) {
    textInput(session$ns("arrowfeed"), label = "Enter arrow coordinates (x0, x1, y0, y1)", value = "6.1, 6.1, 0.2, 0.6")})
  
  ArrSt <- reactive(as.numeric(unlist(strsplit(input$arrowstrip,","))))
  ArrFd <- reactive(as.numeric(unlist(strsplit(input$arrowfeed,","))))
  
  trans <- eventReactive(input$plotReuseButton, {
    x <- list(as.data.frame(d1()))
    for (i in 2:as.numeric(nDataSts)) x <- c(x, list(as.data.frame(eval(parse(text = paste0('d', i, '()'))))))
    return(x)})
    #return(list(as.data.frame(d1()), as.data.frame(d2())))})
  
  SP.Str <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'strip', bw = TRUE))
  })
  SP.Fd <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'feed', bw = TRUE))
  })
  
  output$SP.Str <- renderPlot(SP.Str())
  output$SP.Fd <- renderPlot(SP.Fd())
  
  #reuse1Strip <- eventReactive(plotTrPr(), {
  #  if (as.numeric(nSpecies) == 1) TransProfile(trans = as.data.frame(MaiTrDt()), trendM = trendOptions[trends[1]])
  #})
  #reuse1Feed <- eventReactive(plotTrPr(), {
  #  if (as.numeric(nSpecies) == 2) TransProfile(trans = as.data.frame(MaiTrDt()), secondary = as.data.frame(SecTrDt()),
  #                                              trendM = trendOptions[trends[1]], trendS = trendOptions[trends[2]])
  #})

  #output$profile1 <- renderPlot(profile1())
  #output$profile2 <- renderPlot(profile2())
  #output$profile3 <- renderPlot(profile3())
  #output$DwnProf <- downloadHandler(filename = function(){paste0('transportProfile', as.character(formatP))},
  #                                  content = function(file){
  #                                    if (as.character(formatP) == '.pdf') {
  #                                      pdf(file, width = dimensP[1], height = dimensP[2])
  #                                    } else {
  #                                      png(file, width = dimensP[1], height = dimensP[2], units = 'in', res = 300)
  #                                    }
  #                                    if(as.numeric(nSpecies) == 1) print(profile1())
  #                                    if(as.numeric(nSpecies) == 2) print(profile2())
  #                                    if(as.numeric(nSpecies) == 3) print(profile3())
  #                                    dev.off()
  #                                  }
  #)
}

