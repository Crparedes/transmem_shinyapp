inputDataModuleUI <- function(id, IntID = 1, Spc = "Main species") {
  ns <- NS(id)
  box(title = paste0("System ", IntID, " - ", Spc), width = 4, solidHeader = TRUE, status = "primary",
      sliderInput(ns("nData"), label = "Number of aliquots (set table values to zero to modify)",
                  min = 3, max = 30, value = 6),
      #hotable(ns("TrnsDt")),
      #tableOutput(ns("TrnsfrmdDt")))
      column(12, column(8, uiOutput(ns("chckbx"))),
      column(4, h5(tags$b('Settings')), checkboxInput(ns("nrmliz"), label = "Normalize data", value = TRUE))),
      column(5, hotable(ns("TrnsDt"))),
      column(7, textOutput(ns('ModelMsg')),
             #uiOutput(ns("chckbx")),
             uiOutput(ns("button")), tags$hr(),
             tableOutput(ns("TrnsfrmdDt"))))
}

inputDataModule <- function(input, output, session, Model, ...) {
  chcMdl <- reactive((1:4)[c(c('calCnncl', 'calUnES', 'calBiES', 'calSAWoD') == Model$natModel())])
  messag <- c('No transformation (other than normalization if selected) will be applied',
              rep('Be sure the calibration model has been calculated', 2),
              'Be sure sample and spiked measurements were in linear range of the method')
  output$ModelMsg <- renderText({messag[chcMdl()]})
  output$chckbx <- renderUI(if(as.numeric(chcMdl()) != 1) {
    checkboxGroupInput(session$ns("chckbx"), label = 'Aliquots diluted before measurement?',
                       choices = list("Feed" = 1, "Strip" = 2))})

  output$button <- renderUI(actionButton(session$ns('button'), label = c('Input data', rep('Transform data', 3))[chcMdl()],
                                         styleclass = 'primary'))
  #dilutBool <- reactive({list(input$chckbx[[1]], input$chckbx[[2]])})

  TrnsDtPrevious <- reactive({
    if (chcMdl() == 1 || is.null(input$chckbx)) {#|| !(input$chckbx[[1]] || input$chckbx[[2]])) {
      data.frame(Time  = rep(0, as.numeric(input$nData)),
                 Feed  = rep(0, as.numeric(input$nData)),
                 Strip = rep(0, as.numeric(input$nData)))
    } else {
      if (all(input$chckbx == 1:2)) {
          data.frame(Time  = rep(0, as.numeric(input$nData)),
                     Feed  = rep(0, as.numeric(input$nData)),
                     Dil.Feed  = rep(0, as.numeric(input$nData)),
                     Strip = rep(0, as.numeric(input$nData)),
                     Dil.Strip  = rep(0, as.numeric(input$nData)))
      } else {
        if (input$chckbx == 1) {
          data.frame(Time  = rep(0, as.numeric(input$nData)),
                     Feed  = rep(0, as.numeric(input$nData)),
                     Dil.Feed  = rep(0, as.numeric(input$nData)),
                     Strip = rep(0, as.numeric(input$nData)))
        } else {
          data.frame(Time  = rep(0, as.numeric(input$nData)),
                     Feed  = rep(0, as.numeric(input$nData)),
                     Strip = rep(0, as.numeric(input$nData)),
                     Dil.Strip  = rep(0, as.numeric(input$nData)))
        }
      }
    }
  })
  TrnsDtMyChanges <- reactive({
    TempDatFram1 <- data.frame(apply(as.data.frame(hot.to.df(input$TrnsDt)), 2, function(x) as.numeric(as.character(x))))
    ifelse(all(as.data.frame(hot.to.df(input$TrnsDt)) == 0),
           return(TrnsDtPrevious()),
           return(TempDatFram1)
    ) #hot.to.df function will convert your updated table into the dataframe
  })
  output$TrnsDt <- renderHotable({TrnsDtMyChanges()}, readOnly = F)

  #transDat <- reactive(TrnsDtMyChanges()
  #ModelReactive <- reactive(Model$Model())
  datTabReactive <- eventReactive(input$button, {
    TempDatFram2 <- data.frame(apply(as.data.frame(hot.to.df(input$TrnsDt)), 2, function(x) as.numeric(as.character(x))))
     if (chcMdl() == 2) {
       TempDatFram2 <- data.frame(Time = TempDatFram2$Feed,
                                  Feed = signal2conc(signal = TempDatFram2$Feed, model = Model$calModel()),
                                  Strip = signal2conc(signal = TempDatFram2$Strip, model = Model$calModel()))}
    mxfd <- max(TempDatFram2$Feed)
    ifelse(input$nrmliz, return(data.frame(Time = TempDatFram2$Time,
                                           Feed = TempDatFram2$Feed/mxfd,
                                           Strip = TempDatFram2$Strip/mxfd)),
           return(TempDatFram2))
  }
  #output$model(renderText(Model$catModel))

  )
  output$TrnsfrmdDt <- renderTable(datTabReactive())
  return(reactive(conc2frac(feed = datTabReactive()$Feed,
                            strip = datTabReactive()$Strip,
                            time = datTabReactive()$Time, normalize = FALSE)))
}
