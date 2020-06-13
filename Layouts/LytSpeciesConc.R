LytSpConc <- tabBox(width = 12, height = 800,
                     tabPanel('Data',
                              conditionalPanel(condition = 'input.nDataSts == 1',
                                               infoBox(width = 12, "More species required", color = Hcol('Tertiary')[2], 
                                                       icon = icon("eye-slash"),
                                                       h4('Species concentration plots require at least two datasets!
                                                           See Instructions tab.'))),
                              conditionalPanel(condition = 'input.nDataSts >= 2', {
                                fluidRow(spConcModuleUI('MainSpCnc'),
                                         conditionalPanel(condition = "input.nSpecies >= 2",
                                                          spConcModuleUI('SecSpCnc', Spc = "Secondary")),
                                         conditionalPanel(condition = "input.nSpecies == 3",
                                                          spConcModuleUI('TerSpCnc', Spc = "Tertiary")))})),
                     tabPanel('Instructions', sepSpConcDs))