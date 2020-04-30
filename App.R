rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)
library(ggplot2)

source('Modules/profileModule.R')
source('Modules/testModule.R')
source('Modules/calibrationModule.R')
source('Modules/configLayouts.R')

ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),
  
  dashboardSidebar(width = 325, sidebarMenuUI), # sidebarMenuUI is in Modules/configLayouts.R
  
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
      tabItemsUI#,
      #box(title = "Histogram", status = "primary"),
      #tabsetPanel(type = "tabs",
      #            tabPanel("Single profile",
      #                     multiProfilesUI("Multiprof"),
      #                     profileModuleUI("profileModule"))
      #)
    )
  )

server <- function(input, output, session) {
  
  callModule(calibrationModule, "MainSpeciesCal")
  callModule(calibrationModule, "SeconSpeciesCal")
  callModule(calibrationModule, "TertiSpeciesCal")
  
  callModule(multiProfiles, "Multipfor")
  callModule(profileModule, "profileModule")
  
}

shinyApp(ui, server)