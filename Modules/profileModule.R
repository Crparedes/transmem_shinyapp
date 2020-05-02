profileModuleUI <- function(id, IntID = 1, Spc = "Main species") {
  ns <- NS(id)
  selectInput("nSpecies", label = label1,
              choices = list("1"= 1, "2" = 2, "3" = 2), selected = "2")
  selectInput("EmpirModelYN", label = label2,
              choices = list("1"= 1, "2" = 2, "3" = 2), selected = "2")
}

profileModule <- function(input, output, session) {
  count1 <- reactiveVal(0)
  observeEvent(input$nSpecies, {
    count1(count1() + 1)
  })
  output$out1 <- renderText({
    count1()
  })
  count1
}