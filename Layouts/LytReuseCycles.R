LytReuCycl <- tabBox(width = 12, height = 800,
                     tabPanel('Data',
                              conditionalPanel(condition = 'input.nDataSts == 1',
                                               infoBox(width = 12, "More datasets required", color = Hcol('Tertiary')[2], 
                                                       icon = icon("eye-slash"),
                                                       h4('Reuse cycles plots require at least two datasets! See Instructions tab.'))), 
                              conditionalPanel(condition = 'input.nDataSts >= 2', 
                                               tags$hr(), reuseModuleUI('reusecyclesM'))),
                     tabPanel('Instructions', inputDataDs))