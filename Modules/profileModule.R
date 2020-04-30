profileModuleUI <- function(id, label1 = "Species to include", label2 = "Add empirical equation?") {
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


multiProfilesUI <- function(id) {
  ns <- NS(id)
  tabBox(
    title = "intro",
    id = "ttabs", width = 8, height = "420px",
    tabPanel("Files",value=1, dataTableOutput("Filesa")),
    tabPanel("Files1",value=2, dataTableOutput("Files1a"))
  )
  sliderInput("nProfiles", label = "How many systems?", min = 1, max = 12, value = 1)
}

multiProfiles <- function(input, output, session) {
  nProfiles <- reactiveVal(0)
  observeEvent(input$nProfiles, {
    nProfiles(nProfiles() + 1)
  })
  output$out1 <- renderText({
    nProfiles()
  })
}
