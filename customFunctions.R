# Box header colors c('primary', 'info', 'warning', 'danger', 'success')
Hcol <- function(id) {
  if (id == 'Main') return(c('info', 'aqua', '.nav-tabs-custom-main .nav-tabs li.active {border-top-color: #5bc0de;}"'))
  if (id == 'Secondary') return(c('warning', 'yellow', '.nav-tabs-custom-secon .nav-tabs li.active {border-top-color: #f0ad4e;}"'))
  if (id == 'Tertiary') return(c('danger', 'red', '.nav-tabs-custom-terti .nav-tabs li.active {border-top-color: #d73925;}"'))
}

TransProfile <- transPlot <- function(Ex = FALSE, 
                                      trans = NULL, secondary = NULL, tertiary = NULL, trendM = NULL, trendS = NULL, trendT = NULL,
                                      xlab = 'Time (h)', ylab = expression(Phi), gamma = 1) {
  # example;
  if (Ex) {
    data(seawaterLiNaK)
    return(TransProfile(trans = seawaterLiNaK$Lithium.1, trendM = 'paredes', trendS = 'paredes', trendT = 'paredes', gamma = 1.2,
                        secondary = seawaterLiNaK$Sodium.1, tertiary = seawaterLiNaK$Potassium.1))
  }
  p <- ggplot(data = trans, aes(x = Time, y = Fraction)) + theme_bw() + labs(y = ylab, x = xlab) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"), legend.position = 'none')

  if (!missing(trendM)) p <- addTransTrend(p = p, trans = trans, model = trendM, gamma = gamma)
  if (!missing(trendS)) p <- addTransTrend(p = p, trans = secondary, model = trendS, gamma = gamma)
  if (!missing(trendT)) p <- addTransTrend(p = p, trans = tertiary, model = trendT, gamma = gamma)

  if (!missing(secondary)) p <- addNewSpecies(p = p, trans = secondary)
  if (!missing(tertiary)) p <- addNewSpecies(p = p, trans = tertiary, shape = c(19, 21))

  p <- p + geom_point(size = 2.8, shape = rep(c(15, 22), each = nrow(trans)/2), fill = 'white')
  return(p)
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
    p <- p + stat_function(fun = transmem:::AddParTrend(trend, 1, 'strip', gamma), args = list(i = 1)) +
      stat_function(fun = transmem:::AddParTrend(trend, 1, 'feed', gamma), args = list(i = 1))
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
