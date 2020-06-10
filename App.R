rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)
library(shinysky)
library(ggplot2)
library(shinycssloaders)

customFunctions <- paste0('CustomFunctions/', list.files(path = "CustomFunctions"))
modules         <- paste0('Modules/', list.files(path = "Modules"))

sapply(c(customFunctions, 'descriptions.R', modules, 'layouts.R'), source)


ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),
  dashboardSidebar(width = 325, sidebarMenuUI), # sidebarMenuUI is in Modules/configLayouts.R
  dashboardBody(
    tags$head(tags$style(HTML('.main-header .logo {font-family: "Georgia", Times, "Times New Roman", serif; 
                                                   font-weight: bold; font-size: 24px;}'))),
    tabItemsUI # tabItemsUI is in Modules/configLayouts.R
  )
)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  callModule(introductionOutputs, 'introduction')
  
  formatP  <- reactive(input$Format)
  dimensP  <- reactive(c(input$plotsW, input$plotsH) / 25.4 * 1.6)
  ### Calibration
  MainSpCal <- callModule(calibrationModule, "MainSpeciesCal", species = 'Main', formatP = formatP, dimensP = dimensP)
  SecSpCal <- callModule(calibrationModule, "SeconSpeciesCal", species = 'Secondary', formatP = formatP, dimensP = dimensP)
  TerSpCal <- callModule(calibrationModule, "TertiSpeciesCal", species = 'Tertiary', formatP = formatP, dimensP = dimensP)
  
  ### Data input
  MainSpTrans1  <- callModule(inputDataModule, "MainDset1",  Model = MainSpCal)
  SecSpTrans1   <- callModule(inputDataModule, "SecDset1",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans1   <- callModule(inputDataModule, "TerDset1",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans2  <- callModule(inputDataModule, "MainDset2",  Model = MainSpCal)
  SecSpTrans2   <- callModule(inputDataModule, "SecDset2",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans2   <- callModule(inputDataModule, "TerDset2",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans3  <- callModule(inputDataModule, "MainDset3",  Model = MainSpCal)
  SecSpTrans3   <- callModule(inputDataModule, "SecDset3",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans3   <- callModule(inputDataModule, "TerDset3",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans4  <- callModule(inputDataModule, "MainDset4",  Model = MainSpCal)
  SecSpTrans4   <- callModule(inputDataModule, "SecDset4",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans4   <- callModule(inputDataModule, "TerDset4",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans5  <- callModule(inputDataModule, "MainDset5",  Model = MainSpCal)
  SecSpTrans5   <- callModule(inputDataModule, "SecDset5",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans5   <- callModule(inputDataModule, "TerDset5",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans6  <- callModule(inputDataModule, "MainDset6",  Model = MainSpCal)
  SecSpTrans6   <- callModule(inputDataModule, "SecDset6",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans6   <- callModule(inputDataModule, "TerDset6",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans7  <- callModule(inputDataModule, "MainDset7",  Model = MainSpCal)
  SecSpTrans7   <- callModule(inputDataModule, "SecDset7",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans7   <- callModule(inputDataModule, "TerDset7",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans8  <- callModule(inputDataModule, "MainDset8",  Model = MainSpCal)
  SecSpTrans8   <- callModule(inputDataModule, "SecDset8",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans8   <- callModule(inputDataModule, "TerDset8",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans9  <- callModule(inputDataModule, "MainDset9",  Model = MainSpCal)
  SecSpTrans9   <- callModule(inputDataModule, "SecDset9",   Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans9   <- callModule(inputDataModule, "TerDset9",   Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans10 <- callModule(inputDataModule, "MainDset10", Model = MainSpCal)
  SecSpTrans10  <- callModule(inputDataModule, "SecDset10",  Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans10  <- callModule(inputDataModule, "TerDset10",  Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans11 <- callModule(inputDataModule, "MainDset11", Model = MainSpCal)
  SecSpTrans11  <- callModule(inputDataModule, "SecDset11",  Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans11  <- callModule(inputDataModule, "TerDset11",  Spc = 'Tertiary', Model = TerSpCal)
  MainSpTrans12 <- callModule(inputDataModule, "MainDset12", Model = MainSpCal)
  SecSpTrans12  <- callModule(inputDataModule, "SecDset12",  Spc = 'Secondary', Model = SecSpCal)
  TerSpTrans12  <- callModule(inputDataModule, "TerDset12",  Spc = 'Tertiary', Model = TerSpCal)
  
  ### Transport profiles
  plotTrPr <- reactive(input$plotTrPr)  # ReactiveButton 'Draw'
  nSpecies <- reactive(as.numeric(input$nSpecies))
  trends   <- reactive(as.numeric(c(input$trendM, input$trendS, input$trendT)))
  output$M.mdlStt <- renderUI({
    if (input$trendM == 1) {sliderInput('M.mdlStt', label = "Select model eccentricity", 
                                        min = 0.3, max = 2.5, value = 1, step = 0.1)
    } else {
      if (input$trendM == 3) {sliderInput('M.mdlStt', label = "Select curve span (smoothness)", 
                                          min = 0.01, max = 0.99, value = 0.75, step = 0.05)}}})
  output$S.mdlStt <- renderUI({
    if (input$trendS == 1) {sliderInput('S.mdlStt', label = "Select model eccentricity", 
                                        min = 0.3, max = 2.5, value = 1, step = 0.1)
    } else {
      if (input$trendS == 3) {sliderInput('S.mdlStt', label = "Select curve span (smoothness)", 
                                          min = 0.01, max = 0.99, value = 0.75, step = 0.05)}}})
  output$T.mdlStt <- renderUI({
    if (input$trendT == 1) {sliderInput('T.mdlStt', label = "Select model eccentricity", 
                                        min = 0.3, max = 2.5, value = 1, step = 0.1)
    } else {
      if (input$trendT == 3) {sliderInput('T.mdlStt', label = "Select curve span (smoothness)", 
                                          min = 0.01, max = 0.99, value = 0.75, step = 0.05)}}})
  mdlStt <- reactive(c(input$M.mdlStt, input$S.mdlStt, input$T.mdlStt))
  callModule(profileModule, "transProf1", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans1, SecTrDt = SecSpTrans1, TerTrDt = TerSpTrans1, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf2", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans2, SecTrDt = SecSpTrans2, TerTrDt = TerSpTrans2, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf3", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans3, SecTrDt = SecSpTrans3, TerTrDt = TerSpTrans3, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf4", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans4, SecTrDt = SecSpTrans4, TerTrDt = TerSpTrans4, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf5", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans5, SecTrDt = SecSpTrans5, TerTrDt = TerSpTrans5, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf6", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans6, SecTrDt = SecSpTrans6, TerTrDt = TerSpTrans6, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf7", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans7, SecTrDt = SecSpTrans7, TerTrDt = TerSpTrans7, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf8", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans8, SecTrDt = SecSpTrans8, TerTrDt = TerSpTrans8, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf9", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans9, SecTrDt = SecSpTrans9, TerTrDt = TerSpTrans9, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf10", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans10, SecTrDt = SecSpTrans10, TerTrDt = TerSpTrans10, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf11", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans11, SecTrDt = SecSpTrans11, TerTrDt = TerSpTrans11, trends = trends, mdlStt = mdlStt)
  callModule(profileModule, "transProf12", plotTrPr = plotTrPr, nSpecies = nSpecies, formatP = formatP, dimensP = dimensP,
             MaiTrDt = MainSpTrans12, SecTrDt = SecSpTrans12, TerTrDt = TerSpTrans12, trends = trends, mdlStt = mdlStt)
  ### Permeation coefficients
  calcPrCf <- reactive(input$calcPrCf)  # ReactiveButton 'calc'
  P.data <- reactive(as.numeric(c(input$P.area, input$P.vol0)))
  callModule(permCoefModule, "permCoef1", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans1, SecTrDt = SecSpTrans1, TerTrDt = TerSpTrans1, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef2", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans2, SecTrDt = SecSpTrans2, TerTrDt = TerSpTrans2, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef3", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans3, SecTrDt = SecSpTrans3, TerTrDt = TerSpTrans3, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef4", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans4, SecTrDt = SecSpTrans4, TerTrDt = TerSpTrans4, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef5", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans5, SecTrDt = SecSpTrans5, TerTrDt = TerSpTrans5, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef6", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans6, SecTrDt = SecSpTrans6, TerTrDt = TerSpTrans6, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef7", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans7, SecTrDt = SecSpTrans7, TerTrDt = TerSpTrans7, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef8", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans8, SecTrDt = SecSpTrans8, TerTrDt = TerSpTrans8, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef9", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans9, SecTrDt = SecSpTrans9, TerTrDt = TerSpTrans9, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef10", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans10, SecTrDt = SecSpTrans10, TerTrDt = TerSpTrans10, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef11", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans11, SecTrDt = SecSpTrans11, TerTrDt = TerSpTrans11, formatP = formatP, dimensP = dimensP)
  callModule(permCoefModule, "permCoef12", P.data = P.data, calPermCoef = calcPrCf,
             MaiTrDt = MainSpTrans12, SecTrDt = SecSpTrans12, TerTrDt = TerSpTrans12, formatP = formatP, dimensP = dimensP)
  ### Separation factors
  calcSepFc <- reactive(input$calcSepFc)  # ReactiveButton 'calc'
  SF.model <- reactive(as.numeric(input$SF.model))
  callModule(sepFactorModule, "sepFactor1", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans1, SecTrDt = SecSpTrans1, TerTrDt = TerSpTrans1, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor2", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans2, SecTrDt = SecSpTrans2, TerTrDt = TerSpTrans2, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor3", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans3, SecTrDt = SecSpTrans3, TerTrDt = TerSpTrans3, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor4", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans4, SecTrDt = SecSpTrans4, TerTrDt = TerSpTrans4, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor5", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans5, SecTrDt = SecSpTrans5, TerTrDt = TerSpTrans5, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor6", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans6, SecTrDt = SecSpTrans6, TerTrDt = TerSpTrans6, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor7", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans7, SecTrDt = SecSpTrans7, TerTrDt = TerSpTrans7, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor8", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans8, SecTrDt = SecSpTrans8, TerTrDt = TerSpTrans8, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor9", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans9, SecTrDt = SecSpTrans9, TerTrDt = TerSpTrans9, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor10", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans10, SecTrDt = SecSpTrans10, TerTrDt = TerSpTrans10, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor11", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans11, SecTrDt = SecSpTrans11, TerTrDt = TerSpTrans11, formatP = formatP, dimensP = dimensP)
  callModule(sepFactorModule, "sepFactor12", calcSepFc = calcSepFc, SF.model = SF.model,
             MaiTrDt = MainSpTrans12, SecTrDt = SecSpTrans12, TerTrDt = TerSpTrans12, formatP = formatP, dimensP = dimensP)
  ### Reuse plots
  #plotReuseButton <- reactive(input$plotReuseButton)  # ReactiveButton 'calc'
  nDataSts <- reactive(as.numeric(input$nDataSts))
  callModule(reuseModule, 'reusecyclesM', nDataSts = nDataSts,# plotReuseButton = plotReuseButton, 
             d1 = MainSpTrans1, d2 = MainSpTrans2, d3 = MainSpTrans3, d4 = MainSpTrans4, d5 = MainSpTrans5, d6 = MainSpTrans6, 
             d7 = MainSpTrans7, d8 = MainSpTrans8, d9 = MainSpTrans9, d10 = MainSpTrans10, d11 = MainSpTrans11, d12 = MainSpTrans12,
             formatP = formatP, dimensP = dimensP)
  ### Example datasets
  callModule(examplesOutputs, 'examples')
}


shinyApp(ui, server)
