LytSepFactor <- tabBox(width = 12, height = 800,
                       tabPanel('Data',
                                conditionalPanel(condition = 'input.nSpecies == 1',
                                                 infoBox(width = 12, "More species required", color = Hcol('Tertiary')[2], 
                                                         icon = icon("eye-slash"),
                                                         h4('Separation factor calculations require at least two species!
                                                             See Instructions tab.'))), 
                                conditionalPanel(condition = 'input.nSpecies >= 2', 
                                                 fluidRow(column(2, selectInput("SF.model", label = "Definition to use:", 
                                                                                choices = list("Batch systems" = 1, 
                                                                                               "Continous systems" = 2))),
                                                          column(2, h5('Be sure all data has been entered and transformated 
                                                                       (if required).'),
                                                                 actionButton("calcSepFc", 
                                                                              label = "Calculate and plot separation factors", 
                                                                              styleclass = 'primary'))),
                                                 tags$hr(),
                                                 sepFactorModuleUI('sepFactor1'),
                                                 conditionalPanel(condition = 'input.nDataSts >= 2', {
                                                   sepFactorModuleUI('sepFactor2', IntID = 2)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 3', {
                                                   sepFactorModuleUI('sepFactor3', IntID = 3)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 4', {
                                                   sepFactorModuleUI('sepFactor4', IntID = 4)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 5', {
                                                   sepFactorModuleUI('sepFactor5', IntID = 5)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 6', {
                                                   sepFactorModuleUI('sepFactor6', IntID = 6)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 7', {
                                                   sepFactorModuleUI('sepFactor7', IntID = 7)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 8', {
                                                   sepFactorModuleUI('sepFactor8', IntID = 8)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 9', {
                                                   sepFactorModuleUI('sepFactor9', IntID = 9)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 10', {
                                                   sepFactorModuleUI('sepFactor10', IntID = 10)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 11', {
                                                   sepFactorModuleUI('sepFactor11', IntID = 11)}),
                                                 conditionalPanel(condition = 'input.nDataSts >= 12', {
                                                   sepFactorModuleUI('sepFactor12', IntID = 12)})
                                )),
                     tabPanel('Instructions', sepFactorDs))