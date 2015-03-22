library(shiny) 
shinyUI(
  pageWithSidebar(
      headerPanel(
          "Finding Lineair Regression Line Visually with Interactive help "
      ),
      sidebarPanel(
          h2("ControlPanel"),
          
          h4("Data"),
          helpText('Create dataset (Y,X) with:'),
          numericInput("number",label=" number datapoints", value=100),
          actionButton("goUpdate",'Update'),
          
          h4("Line"),
          helpText('Control (red) Line with changing values of: '),
          sliderInput("slope", "Slope",
                      min=-3, max=3, value=0,step=0.01),      
          sliderInput("intercept", "Intercept",
                  min=-20, max=20, value=0, step=0.01),
          
          h4('Want see Lineair Regression Line (green) as answer?'),
          checkboxInput("answer", label = "Check for Yes", value = FALSE),
          h2("How to find your Lineair Regression Line:"),
          helpText(
            " You control your Regression Line, as red line,",
            " in Controlpanel by changing slape and intercept values both.",
            " You can read its standard deviation below.",
            " It needs to be minimized. As help (see below), the lowest value you found will be stored",
            " The corresponding line is plotted as grey line. ",
            " Be aware it can be a local minimum. And pay some attention to take small steps",
            " of changing values to avoid passing a minimum."
          ),
          helpText(
            " If you want to confirm that you have the Lineair Regression Line",
            " after visual contructing, then you can check for Yes ",
            " to compare real Lineair Regression Line as green line with yours.",
            " (Note standard deviation corresponding this line is not shown)"
          )
      ),
      mainPanel(
          h2('Output'),
          h3('Plot'),
          plotOutput("setRandomDataXY"),
          
          h4('Standard deviation from your line (red):'),
          textOutput("deviation"),
          
          h4('Help'),
          h5('Last found (local) minimum of standard deviation: '),
          textOutput("min"),
          h5("corresponding to grey line with "),
          textOutput("line")
      )
  )
)
