library(shiny)

shinyUI(fluidPage(
  titlePanel("Sepal.Length vs Petal.Length"),
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderSepal.Length", "What is Sepal.Length?", 3.5,6.5, value = 5),
       checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
       checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    
       ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Petal.Length from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Petal.Length from Model 2:"),
      textOutput("pred2")
    )
  )
))
