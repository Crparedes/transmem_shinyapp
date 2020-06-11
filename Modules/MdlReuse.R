reuseModuleUI <- function(id, Species = 'Main') {
  ns <- NS(id)
  box(title = paste0(Species, ' species'), width = 12, status = Hcol(id = Species)[1], solidHeader = TRUE,
      fluidRow(column(2, checkboxInput(ns('Arrows'), label = "Include trend arrows in profiles", value = FALSE),
                      uiOutput(ns("arrowstrip")), uiOutput(ns("arrowfeed"))),
               column(2, selectInput(ns('trendReuse'), label = "Model to use in profiles",
                                     choices = list("Paredes et al." = 1, "Rodriguez de San Miguel et al." = 2, 
                                                    "LOESS (non parametric)" = 3)),
                      uiOutput(ns("eccen")), uiOutput(ns("span"))),
               column(2, selectInput(ns('trendRsFin'), label = "Trend line in final values plot",
                                     choices = list("(no trend line)" = 1, "Linear" = 2, "LOESS (non parametric)" = 3,
                                                    "Just join points with lines" = 4)),
                      uiOutput(ns("incldSE"))),
               column(2, actionButton(ns("plotReuseButton"), label = "Plot/replot", styleclass = 'primary'))
      ),
      tags$hr(),
      box(title = 'Single phase profiles: Strip', width = 3, status = Hcol(id = Species)[1],
          downloadButton(ns('DwnSP.Str'), label = 'Download plot'), plotOutput(ns("SP.Str"))),
      box(title = 'Single phase profiles: Feed', width = 3, status = Hcol(id = Species)[1],
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
    textInput(session$ns("arrowstrip"), label = "Enter arrow coordinates for strip (x0, x1, y0, y1)", value = "0, 0, 0.8, 0.4")})
  output$arrowfeed <- renderUI(if (input$Arrows) {
    textInput(session$ns("arrowfeed"), label = "Enter arrow coordinates for feed", value = "0, 0, 0.2, 0.6")})
  output$incldSE   <- renderUI(if (any(input$trendRsFin == 2:3)) {radioButtons(session$ns('incldSE'), 
                                                                               label = "Confidence interval",
                                                                               choices = list("No confidence interval" = 0, 
                                                                                              "95% confidence" = 0.95, 
                                                                                              "99% confidence" = 0.99), 
                                                                               selected = 0.95)})
  output$eccen <- renderUI(if (input$trendReuse == 1) {sliderInput(session$ns('eccen'), label = "Indicate model eccentricity", 
                                                                   min = 0.3, max = 2.5, value = 1, step = 0.1)})
  output$span <- renderUI(if (input$trendReuse == 3) {sliderInput(session$ns('span'), label = "Indicate curve span (smoothness)", 
                                                                   min = 0.01, max = 0.99, value = 0.75, step = 0.05)})
  
  ArrSt <- reactive(as.numeric(unlist(strsplit(input$arrowstrip,","))))
  ArrFd <- reactive(as.numeric(unlist(strsplit(input$arrowfeed,","))))
  
  trans <- eventReactive(input$plotReuseButton, {
    x <- list(as.data.frame(d1()))
    for (i in 2:nDataSts()) x <- c(x, list(as.data.frame(eval(parse(text = paste0('d', i, '()'))))))
    return(x)})
  
  sumarized <- eventReactive(input$plotReuseButton, {
    df <- as.data.frame(d1())
    s <- df$Fraction[length(df$Fraction)]
    f <- df$Fraction[(length(df$Fraction) * 0.5)]
    t <- df$Time[length(df$Fraction)]
    for (i in 2:nDataSts()) {
      df <- as.data.frame(eval(parse(text = paste0('d', i, '()'))))
      s <- c(s, df$Fraction[length(df$Fraction)])
      f <- c(f, df$Fraction[(length(df$Fraction) * 0.5)])
      t <- c(t, df$Time[length(df$Fraction)])
    }
    return(data.frame(n = 1:nDataSts(), s = f, f = s))}) #Fix this some day pls
  
  SP.Str <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'strip', bw = TRUE, arw = input$Arrows, ylim = c(0, 1),
                       arw.pos = ArrSt()))})
  SP.Fd  <- eventReactive(input$plotReuseButton, {
    return(multiPlotSP(trans = trans(), phase = 'feed', bw = TRUE, arw = input$Arrows, ylim = c(0, 1),
                       arw.pos = ArrFd()))})
  
  FV.Str <- eventReactive(input$plotReuseButton, {
    #t <- mean(sumarized()$t)
    p <- ggplot(data = sumarized(), aes(x = n, y = s)) + geom_point(size = 3) + theme_bw() + 
                scale_x_continuous(limits = c(-5, (2 * nDataSts())), breaks = function(x) seq(ceiling(x[1]), floor(x[2]), by = 1)) + 
                scale_y_continuous(limits = c(-5, 4)) +
                theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                      axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) +
                labs(y = expression(Phi['final']), x = 'Cycle') + #theme(text = element_text(size = 9)) +
                coord_cartesian(xlim = c(1, nDataSts()), ylim = c(0, 1)) + 
                geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)
    return(p)})
  FV.Fd  <- eventReactive(input$plotReuseButton, {
    #t <- mean(sumarized()$t)
    p <- ggplot(data = sumarized(), aes(x = n, y = f)) + geom_point(size = 3) + theme_bw() + 
             scale_x_continuous(limits = c(-5, (2 * nDataSts())), breaks = function(x) seq(ceiling(x[1]), floor(x[2]), by = 1)) + 
             scale_y_continuous(limits = c(-5, 4)) +
             theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                   axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) +
             labs(y = expression(Phi['final']), x = 'Cycle') + #theme(text = element_text(size = 9)) +
             coord_cartesian(xlim = c(1, nDataSts()), ylim = c(0, 1))
    if (input$trendRsFin == 2) p <- p + geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, 
                                                    color = 'black', size = 0.4, se = )
    return(p)})
  
  output$SP.Str <- renderPlot(SP.Str())
  output$SP.Fd  <- renderPlot(SP.Fd())
  output$FV.Str <- renderPlot(FV.Str())
  output$FV.Fd  <- renderPlot(FV.Fd())
}

