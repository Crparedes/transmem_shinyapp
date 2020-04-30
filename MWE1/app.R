library(shiny)
# Module for table 1

table1_moduleUI <- function(id){
  ns <- NS(id)
  tagList(
    tableOutput(ns("table")),
    actionButton(ns("submit"), label = "Change values")
  )
}

table1_module <- function(input, output, session) {
  table <- reactiveValues()
  observeEvent(input$submit, {
    table$values <- replicate(3, rnorm(10))
    table$click <- rnorm(1)
  }, ignoreNULL = FALSE)
  
  output$table <- renderTable({
    table$values
  })
  return(table)
}

ui <- fluidPage(
  fluidRow(
    column(6, table1_moduleUI("table1")),
    column(6, table1_moduleUI("table2"))
  )
)

server <- function(input, output, session) {
  table1 <- callModule(table1_module, "table1")
  table2 <- callModule(table1_module, "table2")
}

shinyApp(ui, server)