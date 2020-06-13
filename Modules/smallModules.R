introductionModuleUI <- function(id) {
  ns <- NS(id)
  fluidRow(introductionDs, # On modulesSnippets.R
           mainSettDs,
           tabBox(width = 9, height = 700, title = "Results", side = 'left',
                  tabPanel("Transport profiles", intrTransProfDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExProfile')), type = 6)),
                                    column(6, intrTransProfDs2))),
                  tabPanel("Permeability coefficients", intrPermCoefDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExPermCoef')), type = 6)),
                                    column(6, intrPermCoefDs2))),
                  tabPanel("Separation factors", intrSepFactorDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExPermCoef2')), type = 6)),
                                    column(6, intrSepFactorDs2, eq_perm1))),
                  tabPanel("Reuse cycles", intrReuseDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExPermCoef4')), type = 6)),
                                    column(6, intrReuseDs2))),
                  tabPanel("Species concentration", intrSpConcDs1, 
                           fluidRow(column(6, withSpinner(plotOutput(ns('ExPermCoef7')), type = 6)),
                                    column(6, intrSpConcDs2))),
                  tabPanel(''),tabPanel(''),
                  tabPanel("-Details of empiric models", intrEmprcMdlsDs1)))
}

introductionOutputs <- function(input, output, session) {
    output$ExProfile <- renderPlot(custom_transPlot(Ex = TRUE))
    ExPerm <- custom_permcoef(trans = reusecycles[[1]], vol = 85, area = 2.5**2*pi)
    output$ExPermCoef <- renderPlot({
      ggplot(data = data.frame(t = ExPerm[[4]], y = ExPerm[[3]]), aes(x = t, y = y)) +
        theme_bw() + geom_point(size = 3, shape = 16)  + labs(y = expression(paste(log[10](C/C[0]))), x = 'Time (h)') +
        theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
              axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black")) + 
        scale_y_continuous(limits = c(min(ExPerm[[3]]), max(ExPerm[[3]])) + diff(c(min(ExPerm[[3]]), max(ExPerm[[3]]))) * c(-2, 2)) +
        scale_x_continuous(limits = c(min(ExPerm[[4]]), max(ExPerm[[4]])) + diff(c(min(ExPerm[[4]]), max(ExPerm[[4]]))) * c(-2, 2)) +
        coord_cartesian(xlim = c(min(ExPerm[[4]]), max(ExPerm[[4]])), ylim = c(min(ExPerm[[3]]), max(ExPerm[[3]]))) +
        geom_smooth(formula = y ~ x, method = 'lm', fullrange = TRUE, color = 'black', size = 0.4)})
}


citationModuleUI <- function(id) {
  box(width = 12,
      tags$h5('If you have found this App useful for your research, please cite it as:', tags$br(), tags$br(),
              tags$b('Paredes, Cristhian and Rodriguez de San Miguel, Eduardo (2020).
                      transmem: Treatment of Membrane-Transport Data. R package
                      version 0.1.1.', tags$a("https://CRAN.R-project.org/package=transmem",
                                              href = "https://CRAN.R-project.org/package=transmem"))),
      tags$br(),
      tags$h5('A BibTeX entry for LaTeX users is:', tags$br()),
      tags$code('@Manual{,', tags$br(),
                HTML('&nbsp;'), 'title = {transmem: Treatment of Membrane-Transport Data},', tags$br(),
                HTML('&nbsp;'), 'author = {Paredes, Cristhian and {Rodr\'iguez de San Miguel}, Eduardo},', tags$br(),
                HTML('&nbsp;'), 'year = {2020},', tags$br(),
                HTML('&nbsp;'), 'note = {R package version 0.1.1},', tags$br(),
                HTML('&nbsp;'), 'url = {https://CRAN.R-project.org/package=transmem}', tags$br(),
                '}')
  )
}

bibliographyModuleUI <- function(id) {
  box(width = 12,
    h5('[1]. R Core Team (2020). R: A language and environment for statistical computing. R Foundation for Statistical Computing,
    Vienna, Austria. URL ', a("https://www.R-project.org/", href = "https://www.R-project.org/")),
    h5('[s]. Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R
    package version 1.4.0.2. ', a("https://CRAN.R-project.org/package=shiny", href = "https://CRAN.R-project.org/package=shiny"))
  )
}


