#Renbder latex eq as images in https://latex.codecogs.com/eqneditor/editor.php
# Use png format, Latin Modern font at 12pt and 120%
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
                            "This App runs the powerful object-oriented R programming capabilities [R Core Team, 2020] in this 
                            interactive dashboart thanks mainly to the R-package Shiny [Chang et al., 2020]."))
 
genCharDs <- box(solidHeader = TRUE, status = "primary", width = 3, title = "General characteristics", height = 700,
                  h4("Those options are selected at the side panel
                     in the ", icon("cog"), tags$b("Main Settings"), " section.", tags$hr(),
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

intrPermCoefDs1 <- h4('Permeability coefficients are', tags$br(), tags$br())
intrPermCoefDs2 <- h4("If one assumes that interfatial reactions are faster than the difussion process trhough the membrane,
                      the permeability coefficient may be calculated using the Fick's law", 
                      HTML('<center><img src="Eq1.gif" style = "size:150%;">&emsp;&emsp;&emsp;(1)</center>'))

intrSepFactorDs1 <- h4('Many membranes used for transport processes show better performance for some species over others. 
                       Most of the times this is a desirable characteristic related to the ', tags$em('selectivity of the system. '), 
                       'The degree of separation in the process is evaluated by the separation factor (', 
                       tags$em('S', HTML('<sub>F</sub>')), '). Separation factors are 
                       function of time and may have a maximum at a determined time or trend asiptotically to a value.
                       The separation factor between lithium/sodium and lithium/potassium from seawater using a polymer inclusion
                       membrane is shown below [Paredes and Rodriguez de San Miguel, 2020].', tags$br(), tags$br())
intrSepFactorDs2 <- h4('The separation factor between two species A and B is defined as their ratio of concentrations (or fractions) in 
                       the strip solution divided by the same ratio in the feed solution at a given time ', tags$em('t '), 
                       '[Koros et al, 1996]. ', tags$br(), tags$br(),
                       HTML('<center><img src="EqSF.png" style = "size:150%;">&emsp;&emsp;&emsp;(1)</center>'), tags$br(),
                       'Separation factors bigger than 1 indicates better selectivity for species A while separation factors smaller 
                       than this value indicate that the B species is transported preferally across the membrane. 
                       At the beggining of the process, separation factors should equal 1 indicating that no separation has been 
                       made yet.', tags$br(), tags$br(),
                       'For systems involving a continous flow of feed solution with constant composition, there is also the 
                       separation coefficient (', tags$em('S', HTML('<sub>C</sub>')), ') that is similar to the separation factor 
                       but uses in the denominator the concentrations of the fresh feed solution that is provided to the cell.', 
                       tags$br(), tags$br(),
                       HTML('<center><img src="EqSC.png" style = "size:150%;">&emsp;&emsp;&emsp;(2)</center>'), tags$br(), tags$br(),
                       'The selectivity as a system performance parameter by itself is defined as the ratio between the 
                       permeabilities of two given species [Luis, 2018]')

intrReuseDs1 <- h4('Reusability is a good attibute ', tags$br(), tags$br())
intrReuseDs2 <- h4('')

intrSpConcDs1 <- h4('', tags$br(), tags$br())
intrSpConcDs2 <- h4('')

intrEmprcMdlsDs1 <- h4('')

settingsDs <- infoBox(width = 11, "Main options of the app", color = 'light-blue', icon = icon("info-circle"), 
                      h4('The main chararacteristics to define are the number of species considered and datasets 
                         (experiments) to analize. The package allows the inclusion of up to three species and 12 
                         transport data sets.', tags$br(), tags$br(), 
                         'Other important characteristics that are selected here deal with the size and format of the
                         dowloadable plot files. The formats available are PDF and PNG. Both image formats are ussually accepted 
                         by most journals but PDF files host better quality (vectorized) plots that that never get pixelated 
                         when enlarged.'))

calibrationDs <- infoBox(width = 11, "Generating calibration models", color = 'light-blue', icon = icon("info-circle"), h4(''))

inputDataDs <- infoBox(width = 11, "Entering transport data", color = 'light-blue', icon = icon("info-circle"),
                       h4("This is the place to provide the data of the membrane transport experiments performed.
                          Depending on the data units, it might be required some signal to concentration conversion.
                          Note that species concentration data is usually divided by the initial concentration in the
                          feed solution to use the normalized (adimentional) values of transported fractions. 
                          If the relationship between signal and concentration follows a linear relationship, the conversion from
                          signal to concentration may not be necessary. In addition, most modern analitycal instruments already
                          give the results in concentration units so the conversión must not be made in the App. However, if it is
                          not your case, you must calculate the corresponding calibration models in the ", 
                          icon("signal"), tags$b("Calibration Models"), " option of the side panel.", tags$hr(),tags$hr(),tags$hr(),
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

profileDs <- infoBox(width = 11, "Plotting transport profiles", color = 'light-blue', icon = icon("info-circle"), h4(''))

permCoefDs <- infoBox(width = 11, "Plotting transport", color = 'light-blue', icon = icon("info-circle"), h4(''))

sepFactorDs <- infoBox(width = 11, "Plotting separation factors", color = 'light-blue', icon = icon("info-circle"), h4(''))

sepReuCycDs <- infoBox(width = 11, "Plotting reuse cycles", color = 'light-blue', icon = icon("info-circle"), h4(''))

sepSpConcDs <- infoBox(width = 11, "Plotting species concentration", color = 'light-blue', icon = icon("info-circle"), h4(''))

