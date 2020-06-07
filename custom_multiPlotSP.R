multiPlotSP <- function(trans, phase = 'strip', trend = NULL, legend = FALSE,
                        xlab = 'Time (h)', ylab = expression(Phi), xlim = NULL,
                        ylim = NULL, xbreaks = NULL, ybreaks = NULL, size = 3,
                        plot = TRUE, shape = 15, bw = FALSE, arw = FALSE,
                        arw.pos = NULL, arw.txt = NULL,
                        txt.pos = NULL, txt.size = NULL){
  Time <- Fraction <- Cycle <- NULL
  phase <- tolower(phase)
  if (phase == 'strip') phase <- 'Strip'
  if (phase == 'feed') phase <- 'Feed'

  for (i in 1:length(trans)) {
    trans[[i]] <- trans[[i]][which(trans[[i]]$Phase == phase), ]
  }

  hues = seq(15, 375, length = length(trans) + 1)
  if(bw) {
    cols = rep("black", length(trans))
  } else {
    cols = hcl(h = hues, l = 65, c = 100)[1:length(trans)]
  }


  p <- ggplot(data = trans[[1]], aes(x = Time, y = Fraction)) +
    theme_bw() + #ggsci::scale_color_npg() +
    geom_point(size = size, shape = shape, color = cols[1]) +
    labs(y = ylab, x = xlab) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x = element_text(color = "black"),
          axis.text.y = element_text(color = "black"))

  for (i in 2:length(trans)) {
    p <- p + geom_point(data = trans[[i]], size = size, shape = shape,
                        color = cols[i])
  }

  if (!missing(trend)) {
    for (i in 1:length(trans)) {
      if (trend[[1]]$model == 'paredes') {
        e <- trend[[1]]$eccen
        if (phase == 'Strip'){
          p <- p + stat_function(fun = AddParTrend(trend, i, 'strip', e),
                                 color = cols[i], args = list(i = i),
                                 xlim = xlimTrendWR(1, trans))
        } else {
          p <- p + stat_function(fun = AddParTrend(trend, i, 'feed', e),
                                 color = cols[i], args = list(i = i),
                                 xlim = xlimTrendWR(1, trans))
        }
      }
    }
  }

  if (!missing(xlim) && !missing(xbreaks)) {
    p <- p  + scale_x_continuous(breaks = xbreaks, limits = xlim)
  } else {
    if (!missing(xlim)) {
      p <- p  + scale_x_continuous(limits = xlim)
    }
    if (!missing(xbreaks)) {
      p <- p  + scale_x_continuous(breaks = xbreaks)
    }
  }

  if (!missing(ylim) && !missing(ybreaks)) {
    p <- p  + scale_y_continuous(breaks = ybreaks, limits = ylim)
  } else {
    if (!missing(ylim)) {
      p <- p  + scale_y_continuous(limits = ylim)
    }
    if (!missing(ybreaks)) {
      p <- p  + scale_y_continuous(breaks = ybreaks)
    }
  }

  if (!legend) {
    p <- p + theme(legend.position = 'none')
  }

  if (!bw) {
    x <- y <- vector()
    for (i in 1:length(trans)) {
      x <- c(x, trans[[i]]$Time[1])
      y <- c(y, trans[[i]]$Fraction[1])
    }
    p <- p + geom_point(data = data.frame(Cycle = as.factor(1:length(trans)),
                                          x = x, y = y),
                        aes(x = x, y = y, group = Cycle, color = Cycle))
  }

  if (arw) {
    #x <- 1.25 * layer_scales(plot = p)$x$range$range
    #p <- p + scale_x_continuous(limits = x) +
    if (missing(arw.pos)) {
      if (phase == 'Strip') arw.pos <- c(0.5, 0.5, 0.8, 0.5)
      if (phase == 'Feed') arw.pos <- c(0.5, 0.5, 0.2, 0.5)
    }
    p <- p + annotate("segment", x = arw.pos[1], xend = arw.pos[2],
                      y = arw.pos[3], yend = arw.pos[4],
                      arrow = arrow(angle = 12))
  }
  if (!missing(arw.txt)) {
    if (missing(txt.size)) txt.size <- 3.1
    if (missing(txt.pos)) txt.pos <- c(arw.pos[1] * 1.05,
                                       mean(c(arw.pos[3], arw.pos[4])))
    p <- p + geom_text(x = txt.pos[1], y = txt.pos[2], label = arw.txt,
                       angle = 90, size = txt.size)
  }

  if (plot) print(p)
  return(p)
}
