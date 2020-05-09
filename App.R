rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)
library(shinysky)
library(ggplot2)

source('customFunctions.R')
source('SmallModules.R')
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
  formatP <- reactive(input$Format)
  dimensP <- reactive(c(input$plotsW, input$plotsH)/25.4)
  callModule(instructionOutputs, 'instructions')

  MainSpCal <- callModule(calibrationModule, "MainSpeciesCal", species = 'Main', formatP = formatP(), dimensP = dimensP())
  SecSpCal <- callModule(calibrationModule, "SeconSpeciesCal", species = 'Secondary', formatP = formatP(), dimensP = dimensP())
  TerSpCal <- callModule(calibrationModule, "TertiSpeciesCal", species = 'Tertiary', formatP = formatP(), dimensP = dimensP())

  MainSpTrans1 <- callModule(inputDataModule, "MainDset1", Model = MainSpCal)
  SecSpTrans1 <- callModule(inputDataModule, "SecDset1", Model = SecSpCal)
  TerSpTrans1 <- callModule(inputDataModule, "TerDset1", Model = TerSpCal)

  callModule(profileModule, "transProf1")
}


shinyApp(ui, server)
