library(shiny)
library(shinydashboard)

convertMenuItem <- function(mi,tabName) {
  mi$children[[1]]$attribs['data-toggle']="tab"
  mi$children[[1]]$attribs['data-value'] = tabName
  mi
}

sidebar <- dashboardSidebar(
  sidebarMenu(
    convertMenuItem(menuItem("Query1",tabName="Query1",icon=icon("table"),
                             numericInput('Start1','Start Date',19800312,min=20170101,max=20200101),
                             numericInput('End1','End Date',19800312,min=20170101,max=20200101),
                             textInput('Office1','Office ID','0'),
                             submitButton("Submit")), tabName = "Query1"),
    convertMenuItem(menuItem("Query2",tabName="Query2",icon=icon("table"),
                             numericInput('Start2','Start Date',20180101,min=20170101,max=20200101),
                             numericInput('End2','End Date',20180101,min=20170101,max=20200101),
                             textInput('Office2','Office ID','0'),
                             submitButton("Submit")), tabName = "Query2")
  )
)
body <- dashboardBody(
  tabItems(
    tabItem(tabName="Query1", h2("Dashboard tab content")),
    tabItem(tabName = "Query2", h2("Widgets tab content"))
  )
)
ui <- dashboardPage(
  dashboardHeader(title = 'LOSS PREVENTION'),
  sidebar,
  body
)

server <- function(input, output) {}
shinyApp(ui, server)