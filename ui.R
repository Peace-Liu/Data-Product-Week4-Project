#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/  
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict child height from parent height"),
  
  # Sidebar with a slider input to pick parent height 
  sidebarLayout(
    sidebarPanel(
       sliderInput("parentheight", "Parent height (inch):", min=55, max=75, value=68),
       checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
       checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
       hr(),
       helpText("This shiny app will show the relationship of the height between parent and child in scatter plot  
                and build two linear regression models to predict child height from parent height. Please select 
                parent height with slider input and check one or two models to see predicted child height shown 
                in the main panel"),
       hr(), 
       helpText("Source code ui.R & server.R stored in below link https://github.com/Peace-Liu/Data-Product-Week4-Project")
    ),
    
    # Show a scatter plot of child vs parent
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted child height from Model 1:"),
      textOutput("pred1"),
      h3("Predicted child height from Model 2:"),
      textOutput("pred2")
    )
  )
))
