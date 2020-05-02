rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)
library(shinysky)
library(ggplot2)

source('Modules/calibrationModule.R')
source('Modules/inputDataModule.R')
source('Modules/profileModule.R')


source('Modules/configLayouts.R')

ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),
  
  dashboardSidebar(width = 325, sidebarMenuUI), # sidebarMenuUI is in Modules/configLayouts.R
  
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tabItemsUI
  )
)

server <- function(input, output, session) {
  
  MainSpCal <- callModule(calibrationModule, "MainSpeciesCal")
  SecSpCal <- callModule(calibrationModule, "SeconSpeciesCal")
  TerSpCal <- callModule(calibrationModule, "TertiSpeciesCal")
  
  MainSpTrans1 <- callModule(inputDataModule, "MainDset1", Model = MainSpCal)
  SecSpTrans1 <- callModule(inputDataModule, "SecDset1", Model = SecSpCal)
  TerSpTrans1 <- callModule(inputDataModule, "TerDset1", Model = TerSpCal)
  
  callModule(profileModule, "profileModule")
  
}

shinyApp(ui, server)