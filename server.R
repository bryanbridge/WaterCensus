# Remember to make sure working directory is the folder this file is in
library(shiny)
library(mblm)

# Get data frame
df = readRDS("data/census-water-data.rds")

# Server side of app
shinyServer(function(input, output) {
  
  xAxis = reactive({
    switch(input$select,
       "Population" = df$population,
       "Home Ownership (%)" = df$homeOwnRate,
       "Median Value of Owner Occupied Housing ($)" = df$medValOwnOccHous,
       "Persons Per Household" = df$persPerHous,
       "Median Household Income ($)" = df$medHousInc,
       "Land Area (sq. mi.)" = df$landArea,
       "Persons Per Square Mile" = df$persPerSqMi)
  })
  
  yAxis = reactive({
    switch(input$radio,
      "Per Capita Water Use (gal/day)" = df$perCapWatSuppUse,
      "Total Water Use (Mgal/day)" = df$pubWatSuppUse)
  })
  
  regr = reactive({
    m = switch(input$radio2,
        "Least Squares" = lm,
        "Theil-Sen" = mblm)
    y = yAxis()
    x = xAxis()
    m(y~x)
  })
  
  regrCol = reactive({
    switch(input$radio2,
      "Least Squares" = "dodgerblue",
      "Theil-Sen" = "seagreen")
  })
  
  # Get input and generate plot
  output$plot1 = renderPlot({
    
    # Create plot every time input is given
    plot(xAxis(), yAxis(),
         main = "Water Use v. Census Data for CA Counties",
         sub="", xlab=input$select, ylab=input$radio,
         pch = 20, col = "firebrick", col.main = "steelblue",
         cex.main = 2)
    
    # Add regression to plot for given input
    abline(regr(), col = regrCol())
  })

  output$text1 = renderText({
    yInt = coef(regr())[1]
    slope = coef(regr())[2]
    errors = (slope * xAxis() + yInt) - yAxis()
    mse = 1/length(errors) * sum(errors ** 2)
    paste("Mean Squared Error: ", trunc(mse))
  })
  
  output$text2 = renderText({
    yInt = coef(regr())[1]
    slope = coef(regr())[2]
    errors = (slope * xAxis() + yInt) - yAxis()
    mae = 1/length(errors) * sum(abs(errors))
    paste("Mean Absolute Error: ", trunc(mae))
  })
})
