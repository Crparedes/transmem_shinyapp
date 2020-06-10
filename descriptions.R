introductionDs <- infoBox(width = 12, "transmem package", color = 'light-blue', icon = icon("align-justify"),
                         h4("This is the graphical user interface for the R-package transmem.", tags$br(), tags$br(),
                            "The tools here provided aim to ease the treatment of membrane transport processes data for
                            the obtention of many membrane performance parameters and beautiful publication-ready plots 
                            suitable for several experimental setups. The App focuses on processes in which species concentrations 
                            envolve as a function of time at both sides of the membrane.", tags$br(), tags$br(),
                            "This App is divided in a big main panel (where you are reading this right now) and an abatible side 
                            panel to the left. The main panel is the place to input data and extract results, while the 
                            side panel is used to configure the ", icon("cog"), tags$b("Main Settings. "), " and 
                            navigate through the App or redirect to other related web sites.", tags$br(), tags$br(),
                            "Below are ilustrated the features of this App.", tags$hr()),
                         h5("If you have found this App or the R-package transmem itself, useful in your research, we encourage you
                            to cite it as shown in ", icon("creative-commons"), tags$b("Citation."),
                            "This App runs the powerful object-oriented R programming capabilities [1] in this interactive web App 
                            thanks (mainly) to the R-package Shiny [2]."))
 
mainSettDs <- box(solidHeader = TRUE, status = "primary", width = 3, title = "Main settings", height = 700,
                  h4("The main chararacteristics that must be defined are the number of species
                     considered and the number of datasets (experiments) to analize. Those options are selected at the side panel
                     in the ", icon("cog"), tags$b("Main Settings"), " section. The package allows the inclusion of up
                     to three species and 12 transport data sets.", tags$br(), tags$br(), 
                     "Other important characteristics that are selected here deal with the size and format of the
                     dowloadable plot files. The formats available are PDF and PNG. Both are ussually accepted by most journals
                     but PDF files host better quality (vectorized) plots that  that never get pixelated when enlarged.", tags$hr(),
                     "When entering data to the App, it may be provided manually or may be copied from any spreadsheet.
                     It is important to note that the number of rows to use must be indicated before entering any data. If 
                     the user has noticed that more o less rows than available are neccesary, table values must be set to zero
                     to change the table.", tags$br(), tags$br(),
                     "Some example datasets have been included and can be visualized by clicking the", tags$br(),
                     icon("folder-open"), tags$b('Example datasets'), "option in the side panel."))

intrTransProfDs1 <- h4('The widely used transport profiles are plots that show the changes of species fractions (or concentrations)
                       at both sides of a membrane as a function of time. Such plots are useful to assess the membrane performance
                       for the selective transport of determined species. A typical transport profile involving three species is
                       shown below.', tags$br(), tags$br())
intrTransProfDs2 <- h4('The fractions (or concentrations) of the feed and strip solutions are represented with filled and void
                       polygons, respectively. Squares are used for the main species while secondary and tertiary species
                       (when included) are represented using triangles and circles, respectively.', tags$br(), tags$br(),
                       'The points in the plot may be conected (as usual) with trend lines. Several options are available 
                       ... details... details...')

intrPermCoefDs1 <- h4('Permeability coefficients are')
intrPermCoefDs2 <- h4('')


inputDataDs <- box(solidHeader = TRUE, status = "primary", width = 4, title = "Data input", height = 500,
               h5("Depending on the data units and nature, it may be required some conversion from signal values to
                  concentration or fractions using some calibration technique.", tags$hr(),
                  "If your data is already in concentration or transported fraction values, proceed to ",
                  icon("exchange-alt"), tags$b("Data input and transformation"), "and enter the transport data
                  for all species in each transport dataset.", tags$hr(),
                  "If your data are signal values to be converted to concentration by using calibration curves, the
                  information regarding the standards concentration and their signals must be provided in ",
                  icon("signal"), tags$b("Calibration models"), ". Available models are univariated external standard calibration
                  (linear and polynomial) and bivariated external standard calibration. The calibration plot is displayed
                  and the residuals plot is also shown to assess the model convenience. Regression  parameters and their statistical
                  significance are also given.", tags$b(), "Now it is possible to proceed to ",
                  icon("exchange-alt"), tags$b("Data input and transformation"), "to enter the signals for the analytes in both phases
                  for each transport data.", tags$hr(),
                  "By default the data is nomalized to the initial concentration in the feed solution. To change this unselect
                  the", tags$b(" Normalize data"), " option."))

profileDs <- h4('')