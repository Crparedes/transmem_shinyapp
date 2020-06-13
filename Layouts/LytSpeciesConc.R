LytSpConc <- tabBox(width = 12, height = 800,
                     tabPanel('Data',
                              conditionalPanel(condition = 'input.nDataSts == 1',
                                               infoBox(width = 12, "More species required", color = Hcol('Tertiary')[2], 
                                                       icon = icon("eye-slash"),
                                                       h4('Species concentration plots require at least two datasets!')))#,
                              #conditionalPanel(condition = 'input.nDataSts >= 2', {
                              #  fluidRow(inputDataModuleUI('MainDset1', value0 = 7),
                              #           conditionalPanel(condition = "input.nSpecies >= 2",
                              #                            inputDataModuleUI('SecDset1', Spc = "Secondary", value0 = 4)),
                              #           conditionalPanel(condition = "input.nSpecies == 3",
                              #                            inputDataModuleUI('TerDset1', Spc = "Tertiary", value0 = 4)))})
                              ),
                     tabPanel('Instructions', sepSpConcDs))