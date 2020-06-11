LytReuCycl <- tabBox(width = 12, height = 800,
                     tabPanel('Data',
                              
                              conditionalPanel(condition = 'input.nDataSts == 1',
                                               infoBox(width = 12, "More datasets required", color = Hcol('Tertiary')[2], icon = icon("eye-slash"),
                                                       h4('Reuse cycles plots require at least two datasets!'))), 
                              conditionalPanel(condition = 'input.nDataSts >= 2', 
                                               #fluidRow(column(2, selectInput("MP.model", label = "Definition to use:", 
                                               #                                choices = list("Batch systems" = 1, "Continous systems" = 2))),
                                               #          column(2, h5('Be sure all data has been entered and transformated (if required).'),
                                               #                 actionButton("plotReuseButton", label = "Plot reuse cycles", styleclass = 'primary'))),
                                               tags$hr(),
                                               reuseModuleUI('reusecyclesM'))),
                     tabPanel('Instructions', inputDataDs))