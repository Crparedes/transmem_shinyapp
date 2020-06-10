# Box header colors c('primary', 'info', 'warning', 'danger', 'success')
Hcol <- function(id) {
  if (id == 'Main') return(c('info', 'aqua', '.nav-tabs-custom-main .nav-tabs li.active {border-top-color: #5bc0de;}"'))
  if (id == 'Secondary') return(c('warning', 'yellow', '.nav-tabs-custom-secon .nav-tabs li.active {border-top-color: #f0ad4e;}"'))
  if (id == 'Tertiary') return(c('danger', 'red', '.nav-tabs-custom-terti .nav-tabs li.active {border-top-color: #d73925;}"'))
}


addNewSpecies <- function(p, trans, shape = c(17, 24)) p <- p + geom_point(data = trans, shape = rep(shape, each = nrow(trans)/2),
                                                                           size = 2.8, fill = 'white')
addTransTrend <- function(p, trans, model, gamma) {
  if (model == 'paredes') {
    trend <- list(transTrend(trans = trans, eccen = gamma))
    p <- p + stat_function(fun = transmem:::AddParTrend(trend, 1, 'strip', gamma), args = list(i = 1)) +
      stat_function(fun = transmem:::AddParTrend(trend, 1, 'feed', gamma), args = list(i = 1))
  }
  if (model == 'rodriguez') {
    trend <- list(transTrend(trans = trans, eccen = gamma, model = 'rodriguez'))
    #p <- p + stat_function(fun = transmem:::AddParTrend(trend, 1, 'strip', gamma), args = list(i = 1)) +
    #  stat_function(fun = transmem:::AddParTrend(trend, 1, 'feed', gamma), args = list(i = 1))
  }
  return(p)
}

invertTrDat <- function(df) return(data.frame(Time = unique(df$Time),
                                              Feed = df$Fraction[which(df$Phase == 'Feed')],
                                              Strip = df$Fraction[which(df$Phase == 'Strip')]))

AddParedesTrend <- function() {
}

AddRodriguezTrend <- function() {
}

dwldhndlr <- function(name, formatP, dimensP, plt) {
  return(downloadHandler(filename = function(){paste0(name, formatP())},
                         content = function(file){
                           if (formatP() == '.pdf') {
                             pdf(file, width = dimensP()[1], height = dimensP()[2])
                           } else {
                             png(file, width = dimensP()[1], height = dimensP()[2], units = 'in', res = 300)
                           }
                           print(plt)
                           dev.off()
                         }
  ))
}

