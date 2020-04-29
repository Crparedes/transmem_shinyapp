library(shiny)
library(transmem)
library(shinythemes)
source('Modules/profileModule.R')
source('Modules/testModule.R')


ui <- fluidPage(
  theme = shinytheme("sandstone"),
  #El encabezado con el logo del SGC.
  headerPanel(
    list(HTML('<img src="UNAM1.png"/ height="160">   transmem: Treatment of Membrane-Transport Data'))
  ),
  fluidPage(title = "Footer example App",
            # Sidebar panel for inputs ----
            sidebarLayout(sidebarPanel(
              testModuleUI("counter1", "Counter #1")
              ),
              mainPanel(
                #img(src='logoSGC.png', align = "right"),
                tabsetPanel(type = "tabs",
                            tabPanel("Simple profile",
                                     testModuleUI("counter2", "Counter #2")    
                            )
                )
              )
            )
  )
)



server <- function(input, output, session) {
  callModule(testModule, "counter1")
  callModule(testModule, "counter2")
}

shinyApp(ui, server)