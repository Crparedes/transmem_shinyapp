custom_permcoef <- function(trans, vol, area, units = c('cm^3', 'cm^2', 'h')) {
  conc <- trans[which(trans$Phase == "Feed"), ]
  y <- log(conc[, 3] / conc[1, 3])
  t <- trans[which(trans$Phase == "Feed"), 1]
  if (units[3] == 'h') t <- t * 3600
  if (units[1] == 'cm^3') vol <- vol / 1000000
  if (units[2] == 'cm^2') area <- area / 10000
  #plot(y ~ t)
  x <- (area / vol) * t
  model <- lm(y ~ 0 + x)
  #abline(lm(y ~ 0 + t), col = 4)
  Xm <- - 1 * summary(model)$coefficients[1]
  sd <- summary(model)$coefficients[2]
  sd <- signif(sd, 2)
  Xm <- signif(Xm, 2 + ceiling(log10(Xm/sd)))
  p.val <- pf(summary(model)$fstatistic[1], summary(model)$fstatistic[2], 
              summary(model)$fstatistic[3], lower.tail = FALSE)
  msg <- ifelse(p.val >= 0.5, 
                paste0('Bad linear behaviour of data. No statistical significance. ',
                       'p-value on F statistic of the regression: ', signif(p.val, 4)), 
                paste0('Acceptable linear behaviour of data. ',
                       'p-value on F statistic of the regression: ', signif(p.val, 4)))
  #cat("Permeability coefficient: ", Xm, "+/-", sd, ' m/s \n')
  return(list(Xm, sd, y, t/3600, msg))
}