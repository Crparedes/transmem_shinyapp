examplesModuleUI <- function(id) {
  ns <- NS(id)
  column(12,
         box(width = 12, title = 'Calibration datasets', status = 'primary', solidHeader = TRUE,
             box(width = 2, status = 'info', heigth = 250, title = 'Univariated lithium calibration curve (linear)',
                 h5('FAAS signal at 670.8 nm for lithium calibration standards (lithium concentration in mg/kg)'),
                 tableOutput(ns('ULiCC_L'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Univariated lithium calibration curve (quadratic)',
                 h5('FAAS signal at 670.8 nm for lithium calibration standards (lithium concentration in mg/kg)'),
                 tableOutput(ns('ULiCC_Q'))),
             box(width = 8, status = 'info', heigth = 250,  title = 'Bivariated lithium calibration curve (sodium as secondary variable)',
                 h5('FAAS signal at 670.8 nm for lithium calibration standards (lithium concentration in mg/kg)'),
                 column(3, tableOutput(ns('BLiCC_L_1'))),
                 column(3, tableOutput(ns('BLiCC_L_2'))),
                 column(3, tableOutput(ns('BLiCC_L_3'))),
                 column(3, tableOutput(ns('BLiCC_L_4'))))),

         box(width = 12, title = 'Single transport datasets', status = 'primary', solidHeader = TRUE,
             h5('The following transport datasets correspond to the lithium extraction from seawater.by means of a
                polymer inclusion membrane [ref].
                Units are already in concentration (use canonical calibration or no calibration)'),
             box(width = 2, status = 'info', heigth = 250, title = 'Main species (lithium)',
                 tableOutput(ns('tabSW_Li'))),
             box(width = 2, status = 'warning', heigth = 250, title = 'Secondary species (sodium)',
                 tableOutput(ns('tabSW_Na'))),
             box(width = 2, status = 'danger', heigth = 250,  title = 'Tertiary species (potassium)',
                 tableOutput(ns('tabSW_K')))),

         box(width = 12, title = 'Reuse cycles', status = 'primary', solidHeader = TRUE,
             h5('The following transport datasets correspond to the lithium extraction from alcaline auqeous solutions means of a
                polymer inclusion membrane [ref].
                Units are already in concentration (use canonical calibration or no calibration)'),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 1',
                 tableOutput(ns('tabCycle1'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 2',
                 tableOutput(ns('tabCycle2'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 3',
                 tableOutput(ns('tabCycle3'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 4',
                 tableOutput(ns('tabCycle4'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 5',
                 tableOutput(ns('tabCycle5'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 6',
                 tableOutput(ns('tabCycle6'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 7',
                 tableOutput(ns('tabCycle7'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 8',
                 tableOutput(ns('tabCycle8'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 9',
                 tableOutput(ns('tabCycle9'))),
             box(width = 2, status = 'info', heigth = 250, title = 'Cycle 10',
                 tableOutput(ns('tabCycle10')))),

         box(width = 12, title = 'Species concentration', status = 'primary', solidHeader = TRUE,
             h5('The following transport datasets correspond to the lithium extraction from seawater.by means of a
         polymer inclusion membrane [ref].
         Units are already in concentration (use canonical calibration or no calibration)'),
             box(width = 2, status = 'info', title = 'Cycle 1', tableOutput(ns('tabCoCycle1'))),
             box(width = 2, status = 'info', title = 'Cycle 2', tableOutput(ns('tabCoCycle2'))),
             box(width = 2, status = 'info', title = 'Cycle 3', tableOutput(ns('tabCoCycle3'))),
             box(width = 2, status = 'info', title = 'Cycle 4', tableOutput(ns('tabCoCycle4'))),
             box(width = 2, status = 'info', title = 'Cycle 5', tableOutput(ns('tabCoCycle5'))))
         )
}

examplesOutputs <- function(input, output, session) {
  data(curvelithium); data(planelithium); data(seawaterLiNaK); data(reusecycles); data(concentrationcycles)
  output$ULiCC_L   <- renderTable(data.frame(Conc = c(0, 5, 12, 25, 51, 104),
                                             Signal = c(0.000, 0.015, 0.033, 0.065, 0.131, 0.269)), digits = 3)
  output$ULiCC_Q   <- renderTable(curvelithium, digits = 3)
  output$BLiCC_L_1 <- renderTable(planelithium[1:10, c(1, 3, 2)], digits = 3)
  output$BLiCC_L_2 <- renderTable(planelithium[11:20, c(1, 3, 2)], digits = 3)
  output$BLiCC_L_3 <- renderTable(planelithium[21:30, c(1, 3, 2)], digits = 3)
  output$BLiCC_L_4 <- renderTable(planelithium[31:40, c(1, 3, 2)], digits = 3)

  output$tabSW_Li  <- renderTable(invertTrDat(seawaterLiNaK$Lithium.1), digits = 4)
  output$tabSW_Na  <- renderTable(invertTrDat(seawaterLiNaK$Sodium.1), digits = 4)
  output$tabSW_K   <- renderTable(invertTrDat(seawaterLiNaK$Potassium.1), digits = 4)

  #for (i in 1:10) assign(paste0('output$tabCycle', i), eval(parse(text = paste0('renderTable(reusecycles[[', i, ']])'))))
  output$tabCycle1  <- renderTable(invertTrDat(reusecycles[[1]]), digits = 3)
  output$tabCycle2  <- renderTable(invertTrDat(reusecycles[[2]]), digits = 3)
  output$tabCycle3  <- renderTable(invertTrDat(reusecycles[[3]]), digits = 3)
  output$tabCycle4  <- renderTable(invertTrDat(reusecycles[[4]]), digits = 3)
  output$tabCycle5  <- renderTable(invertTrDat(reusecycles[[5]]), digits = 3)
  output$tabCycle6  <- renderTable(invertTrDat(reusecycles[[6]]), digits = 3)
  output$tabCycle7  <- renderTable(invertTrDat(reusecycles[[7]]), digits = 3)
  output$tabCycle8  <- renderTable(invertTrDat(reusecycles[[8]]), digits = 3)
  output$tabCycle9  <- renderTable(invertTrDat(reusecycles[[9]]), digits = 3)
  output$tabCycle10 <- renderTable(invertTrDat(reusecycles[[10]]), digits = 3)

  output$tabCoCycle1 <- renderTable(invertTrDat(concentrationcycles[[1]]), digits = 3)
  output$tabCoCycle2 <- renderTable(invertTrDat(concentrationcycles[[2]]), digits = 3)
  output$tabCoCycle3 <- renderTable(invertTrDat(concentrationcycles[[3]]), digits = 3)
  output$tabCoCycle4 <- renderTable(invertTrDat(concentrationcycles[[4]]), digits = 3)
  output$tabCoCycle5 <- renderTable(invertTrDat(concentrationcycles[[5]]), digits = 3)
}
