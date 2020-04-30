library(shiny)
library(transmem)
library(shinythemes)
library(shinydashboard)

source('Modules/profileModule.R')
source('Modules/testModule.R')
source('Modules/configLayouts.R')


ui <- dashboardPage(
  dashboardHeader(title = "transmem: Treatment of Membrane-Transport Data", titleWidth = 750),
  
  dashboardSidebar(
    width = 330,
    sidebarMenuUI,
    sliderInput("nSpecies", label = h4("Species considered"), min = 1, max = 3, value = 2),
    checkboxGroupInput("MoreTabs", label = h4("moretabpanel"), choices = list("moretabs" = "moretabs"),selected = NULL)
  ),
  
  dashboardBody(
    tabItemsUI,
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabsetPanel(type = "tabs",
                tabPanel("Single profile",
                         multiProfilesUI("Multiprof"),
                         profileModuleUI("profileModule"))
    ),
    conditionalPanel(
      condition = "input.MoreTabs == 'moretabs'",
      tabBox(
        title = "intro",
        id= "ttabs", width = 8, height = "420px",
        tabPanel("Files",value=1, dataTableOutput("Filesa")),
        tabPanel("Files1",value=2, dataTableOutput("Files1a"))
      )
    ),
    
    conditionalPanel(
      condition = "input.Tabs == 'tabs' && input.MoreTabs != 'moretabs'",
      tabBox(
        title = "intro",
        id= "ttabs", width = 8, height = "420px",
        tabPanel("Files",value=3, dataTableOutput("Files"))
      ))  
  ))





server <- function(input, output, session) {
  callModule(testModule, "counter1")
  #callModule(testModule, "counter2")
  callModule(multiProfiles, "Multipfor")
  callModule(profileModule, "profileModule")
}

shinyApp(ui, server)