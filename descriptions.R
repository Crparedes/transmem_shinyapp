#Renbder latex eq as images in https://latex.codecogs.com/eqneditor/editor.php
# Use png format, Latin Modern font at 12pt and 120%
introductionDs <- infoBox(width = 12, "transmem package", color = 'light-blue', icon = icon("align-justify"),
                         h4("This is the graphical user interface for the R-package transmem.", #tags$br(), tags$br(),
                            "The tools here provided aim to ease the data treatment from membrane transport processes, to 
                            obtain many membrane performance parameters and beautiful publication-ready plots 
                            suitable for several experimental setups.", tags$br(), tags$br(), 
                            tags$b('The focus here is on processes in which species 
                            concentrations envolve as a function of time at both sides of the membrane. '), "The most common
                            consecuences of the transport is the, the depletion of the species from a feed solution and 
                            the enrichment of the same species in a strip solution 
                            at the other side of the membrane. To monitorate those changes, it is neccessary to determine species
                            concentration in both solutions at the beggining of the experiment and at some time
                            intervals.", tags$br(), tags$br(),
                            "This App is divided in a big main panel (where you are reading at this right now) and an abatible side 
                            panel to the left. The main panel is the place to input data and extract results, while the 
                            side panel is used to configure the ", icon("cog"), tags$b("Main Settings "), ", 
                            navigate through the options in the App or redirect to other related web sites.", tags$br(), tags$br(),
                            "Each reelevant section of the App has an Intructions tab that explains the specific operation of the
                            option clicked. Below are ilustrated the main features of this App.", tags$hr()),
                         h5("If you have found this App or the R-package transmem itself, useful in your research, we encourage you
                            to cite it as shown in ", icon("creative-commons"), tags$b("Citation."),
                            "This App runs the powerful object-oriented R programming capabilities [R Core Team, 2020] in this 
                            interactive dashboard thanks mainly to the R-package Shiny [Chang et al., 2020]."))
 
genCharDs <- box(solidHeader = TRUE, status = "primary", width = 12, title = "General instructions", #height = 700,
                  h5("When entering data to the App, it may be provided manually or may be copied from any spreadsheet.
                     It is important to note that the number of rows to use must be indicated before entering any data. If 
                     the user notices that more (or less) rows are neccesary, all table values must be set to zero
                     to change the table length.", tags$br(), tags$br(),
                     "Some example datasets have been included and can be visualized by clicking the", tags$br(),
                     icon("folder-open"), tags$b('Example datasets'), "option in the side panel."))

intrTransProfDs1 <- h4('The widely used transport profiles are plots that show the changes of species fractions (or concentrations)
                       at both sides of a membrane as a function of time. Such plots are useful to assess the membrane performance
                       for the selective transport of species. To elaborate a transport profile, the changes in
                       species concentration must be measured in time at convenient intervals. A transport profile involving three 
                       species is shown in Figure 1.', tags$br(), tags$br())
intrTransProfDs2 <- h4('The Y-axis may have concentration units but a common practice is to normalize concentration data to the initial
                       concentration in the feed solution to get fractions represented by the greek letter', HTML('&#934;'), '. ', 
                       HTML('&#934;<sub>feed</sub>'), ' represents the remaining fraction in the feed solution and ', 
                       HTML('&#934;<sub>strip</sub>'), ' represents the transported fraction to the strip solution.', tags$br(), tags$br(), 
                       'The points in the plot are conected with trend lines and several options are available. 
                       Two empirical models ', tags$em('Paredes et al.'), ' and ', tags$em('Rodriguez de San Miguel et al.'), 
                       ' a non parametric ', tags$em('LOESS'), ' curve that uses the ',
                       HTML('<a href="https://en.wikipedia.org/wiki/Savitzky%E2%80%93Golay_filter">Savinsky-Golay filter</a></td>'), 
                       ' to produce nice smooth curves, and linear trend lines. The option of no trend line is also available. 
                       The linear trend lines are often adequate for the secondary and tertiary species. 
                       The empirical models are described the last tab of 
                       this box.')
intrTransProfCpt <- h5(HTML('<center><b>Figure 1. </b>Transport profile for lithium, sodium and potassium using a 
                       polymer inclusion membrane. In the convention used in this App, the fractions (or concentrations) 
                       of the species in the feed and strip 
                       solutions are represented with filled and void
                       polygons, respectively. Squares are used for the main species (ussually that of particular interest for the 
                       study) while secondary and tertiary species
                       (when included) are represented using triangles and circles, respectively. </center>'))

intrPermCoefDs1 <- h4("Permeability coefficients are defined as the transport flux per unit transmembrane driving force per 
                      unit membrane thickness [Koros et al., 1996]. As derived by the Fick's law at steady state, it may be 
                      calculated according to the following equation [Ma et al., 2000]:", tags$br(), tags$br(),
                      HTML('<center><img src="EqPC.png">&emsp;&emsp;&emsp;(1)</center>'), tags$br(),
                      'Where ', tags$em('C', HTML('<sup>0</sup><sub>A, feed</sub>')), ' and ', 
                      tags$em('C', HTML('<sub>A, feed</sub>')), ' are the concentration of species A in feed solution at
                      the begining of the experiment and a given time ', tags$em('t'), ', respectively, ', tags$em('P'), 
                      ' is the permeability, ', tags$em('a'), ' is the membrane exposed area, and ', tags$em('V'), ' is the volume
                      of the feed solution.')
intrPermCoefDs2 <- h4("The permeability coefficient may be obtained from the slope of the relation between the natural logarithm of
                      of the  
                      [Ma et al., 2000; ]", tags$br(), tags$br())
intrPermCoefCpt <- h5(HTML('<center><b>Figure 2. </b>Natural logarithm ofTransport profile for lithium, sodium and potassium using a 
                       polymer inclusion membrane. In the convention used in this App, the fractions (or concentrations) 
                       of the species in the feed and strip 
                       solutions are represented with filled and void
                       polygons, respectively. Squares are used for the main species (ussually that of particular interest for the 
                       study) while secondary and tertiary species
                       (when included) are represented using triangles and circles, respectively. </center>'))

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
                       HTML('<center><img src="EqSF.png">&emsp;&emsp;&emsp;(1)</center>'), tags$br(),
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
                       permeabilities of two given species [Luis, 2018]', 
                       tags$br(), tags$br(),
                       HTML('<center><img src="EqSL.png">&emsp;&emsp;&emsp;(3)</center>'), tags$br())

intrReuseDs1 <- h4('Reusability is a good attibute that improves the viability of membrane systems. In batch systems, this may be 
                   evaluated by using the same membrane several times while renewing the feed and strip solutions, monitoring each
                   transport experiment at regular time intervals. The profiles for all the
                   cycles may be ploted in the same plot and the final fraction for each cycle may be plotted as shown below for the strip
                   phase in a lithium transport across a polymer inclusión membrane. The profiles for all the transports is shown to the 
                   left', tags$br(), tags$br())
intrReuseDs2 <- h4('')

intrSpConcDs1 <- h4('', tags$br(), tags$br())
intrSpConcDs2 <- h4('')

intrEmprcMdlsDs1 <- h4('')

settingsDs <- infoBox(width = 11, "Main options of the app", color = 'light-blue', icon = icon("info-circle"), 
                      h4('The main chararacteristics to define are the number of species considered and datasets 
                         (experiments) to analize. The package allows the inclusion of up to three species and 12 
                         transport data sets.', tags$br(), tags$br(), 
                         'Other things that are defined here deal with the size and format of the
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

