library(shiny)

shinyServer(function(input, output) {
  iris$Sepal.Lengthsp <- ifelse(iris$Sepal.Length - 5 > 0, iris$Sepal.Length - 5, 0)
   model1 <- lm(Petal.Length ~ Sepal.Length, data = iris)
   model2 <- lm(Petal.Length ~ Sepal.Lengthsp + Sepal.Length, data = iris)
   
   model1pred <- reactive({
     Sepal.LengthInput <- input$sliderSepal.Length
     predict(model1, newdata = data.frame(Sepal.Length = Sepal.LengthInput))
  })
  
   model2pred <- reactive({
     Sepal.LengthInput <- input$sliderSepal.Length
     predict(model2, newdata = 
               data.frame(Sepal.Length = Sepal.LengthInput,
                          Sepal.Lengthsp = ifelse(Sepal.LengthInput - 5 > 0, 
                                                  Sepal.LengthInput - 5, 0)))
  })
   output$plot1 <- renderPlot({
     Sepal.LengthInput <- input$sliderSepal.Length
     
     plot(iris$Sepal.Length, iris$Petal.Length, xlab = "Sepal.Length", 
          ylab = "Petal.Length", bty = "n", pch = 16, 
          xlim = c(3.5, 6.5), ylim = c(0.1, 2.5))
     if(input$showModel1){
       abline(model1, col = "red", lwd = 2)
     }
     if(input$showModel2){
       model2lines <- predict(model2, newdata = data.frame(
         Sepal.Length =3.5:6.5, Sepal.Lengthsp = ifelse(3.5:6.5 - 5 > 0, 3.5:6.5 - 5, 0)
       ))
       lines(3.5:6.5, model2lines, col = "blue", lwd = 2)
     }
     legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
            col = c("red", "blue"), bty = "n", cex = 1.2)
     points(Sepal.LengthInput, model1pred(), col = "red", pch = 16, cex = 2)
     points(Sepal.LengthInput, model2pred(), col = "blue", pch = 16, cex = 2)
     })
   
   output$pred1 <- renderText({
     model1pred()
   })
   
   output$pred2 <- renderText({
     model2pred()
  })
})

