custom_transPlot <- function(trans = NULL, secondary = NULL, tertiary = NULL, trendM = NULL, trendS = NULL, trendT = NULL,
                                      xlab = 'Time (h)', ylab = expression(Phi), mdlStt = NULL, Ex = FALSE) {
  # example;
  if (Ex) {
    data(seawaterLiNaK)
    return(custom_transPlot(trans = seawaterLiNaK$Lithium.1, trendM = 'paredes', trendS = 'paredes', trendT = 'paredes', 
                            mdlStt = rep(1, 3), secondary = seawaterLiNaK$Sodium.1, tertiary = seawaterLiNaK$Potassium.1))
  }
  p <- ggplot(data = trans, aes(x = Time, y = Fraction)) + theme_bw() + labs(y = ylab, x = xlab) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"), legend.position = 'none')
  
  if (!missing(trendM)) p <- addTransTrend(p = p, trans = trans, model = trendM, gamma = mdlStt[1])
  if (!missing(trendS)) p <- addTransTrend(p = p, trans = secondary, model = trendS, gamma = mdlStt[2])
  if (!missing(trendT)) p <- addTransTrend(p = p, trans = tertiary, model = trendT, gamma = mdlStt[3])
  
  if (!missing(secondary)) p <- addNewSpecies(p = p, trans = secondary)
  if (!missing(tertiary)) p <- addNewSpecies(p = p, trans = tertiary, shape = c(19, 21))
  
  p <- p + geom_point(size = 2.8, shape = rep(c(15, 22), each = nrow(trans)/2), fill = 'white')
  return(p)
}