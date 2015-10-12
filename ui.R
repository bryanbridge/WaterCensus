library(shiny)

# UI side of app
shinyUI(fluidPage(
  # A blank title panel to keep a margin at top
  titlePanel(""),
  
  sidebarLayout(
    sidebarPanel(
                  # Select box for census input
                  selectInput("select", label = h5("Census Data"),
                      choices = list("Population", "Home Ownership (%)",
                        "Median Value of Owner Occupied Housing ($)",
                        "Persons Per Household", "Median Household Income ($)",
                        "Land Area (sq. mi.)", "Persons Per Square Mile"),
                      selected = "Population"),
                  # Radio buttons for water use input
                  radioButtons("radio", label = h5("Usage Data"),
                      choices = list("Per Capita Water Use (gal/day)",
                        "Total Water Use (Mgal/day)"),
                      selected = "Per Capita Water Use (gal/day)"),
                  # Radio buttons for regression
                  radioButtons("radio2", label = h5("Linear Regression Type"),
                               choices = list("Least Squares",
                                              "Theil-Sen"),
                               selected = "Least Squares"),
                  width = 4
    ),
    # Show plot and put side panel on the right
    mainPanel(
      plotOutput("plot1"),
      textOutput("text1"),
      textOutput("text2")
    ),
      position = "right"
  )
))
