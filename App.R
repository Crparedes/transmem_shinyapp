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
source('Modules/testModule.R')
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
  callModule(calibrationModule, "SeconSpeciesCal")
  callModule(calibrationModule, "TertiSpeciesCal")
  
  callModule(inputDataModule, "MainDset1", Model = MainSpCal)
  
  callModule(multiProfiles, "Multipfor")
  callModule(profileModule, "profileModule")
  
}

shinyApp(ui, server)