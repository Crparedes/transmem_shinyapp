rm(list = ls())
library(shiny)
library(transmem)
library(shinydashboard)
library(rhandsontable)


source('Modules/profileModule.R')
source('Modules/testModule.R')
source('Modules/calibrationModule.R')
source('Modules/configLayouts.R')


ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),
  
  dashboardSidebar(width = 325, sidebarMenuUI), # sidebarMenuUI is in Modules/configLayouts.R
  
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tabItemsUI,
    box(title = "Histogram", status = "primary"),
    tabsetPanel(type = "tabs",
                tabPanel("Single profile",
                         multiProfilesUI("Multiprof"),
                         profileModuleUI("profileModule"))
    ),
    hotable("hotable1")
  )
)


server <- function(input, output, session) {
  callModule(testModule, "counter1")
  #callModule(testModule, "counter2")
  callModule(calibrationModule, "MainSpeciesCal")
  callModule(multiProfiles, "Multipfor")
  callModule(profileModule, "profileModule")
  
  # Initiate your table
  previous <- reactive({data.frame(Conc = rep(0, 6), Signal = rep(0, 6))})
  MyChanges <- reactive({
    if(is.null(input$hotable1)){return(previous())}
    else if(!identical(previous(), input$hotable1)){
      # hot.to.df function will convert your updated table into the dataframe
      as.data.frame(hot.to.df(input$hotable1))
    }
  })
  output$hotable1 <- renderHotable({MyChanges()}, readOnly = F)
}


shinyApp(ui, server)