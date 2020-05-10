rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)
library(shinysky)
library(ggplot2)

source('customFunctions.R')
source('SmallModules.R')
source('moduleExamples.R')
source('moduleCalibration.R')
source('moduleInputData.R')
source('moduleProfile.R')


source('configLayouts.R')

ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),

  dashboardSidebar(width = 325, sidebarMenuUI), # sidebarMenuUI is in Modules/configLayouts.R

  dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 24px;
      }
    '))),
    tabItemsUI
  )
)

server <- function(input, output, session) {
  #session$onSessionEnded(stopApp)
  formatP <- reactive(input$Format)
  dimensP <- reactive(c(input$plotsW, input$plotsH)/25.4)

  callModule(instructionOutputs, 'instructions')

  MainSpCal <- callModule(calibrationModule, "MainSpeciesCal", species = 'Main', formatP = formatP(), dimensP = dimensP())
  SecSpCal <- callModule(calibrationModule, "SeconSpeciesCal", species = 'Secondary', formatP = formatP(), dimensP = dimensP())
  TerSpCal <- callModule(calibrationModule, "TertiSpeciesCal", species = 'Tertiary', formatP = formatP(), dimensP = dimensP())

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

  plotTrPr <- reactive(input$plotTrPr)
  callModule(profileModule, "transProf1", plotTrPr = plotTrPr)
  callModule(examplesOutputs, 'examples')
}


shinyApp(ui, server)
