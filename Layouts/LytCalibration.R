LytCalibration <- tabBox(width = 12, height = 800,
                     tabPanel('Data',
                              calibrationModuleUI('MainSpeciesCal'),
                              conditionalPanel(condition = "input.nSpecies >= 2",
                                               calibrationModuleUI('SeconSpeciesCal', label.1 = "Secondary")),
                              conditionalPanel(condition = "input.nSpecies == 3",
                                               calibrationModuleUI('TertiSpeciesCal', label.1 = "Tertiary"))),
                     tabPanel('Instructions', calibrationDs))