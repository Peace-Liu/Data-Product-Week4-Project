library(shiny)
library(datasets)

shinyServer(function(input, output) {
  # build model 
  galton$parent_sp <- ifelse(galton$parent - 68 > 0, galton$parent - 68, 0)
  model1 <- lm(child ~ parent, data = galton)
  model2 <- lm(galton$child ~ parent_sp + parent, data = galton)
  
  model1pred <- reactive({
    parentInput <- input$parentheight
    predict(model1, newdata = data.frame(parent = parentInput))
  })
  
  model2pred <- reactive({
    parentInput <- input$parentheight
    predict(model2, newdata=data.frame(parent=parentInput, parent_sp=ifelse(parentInput-68>0, parentInput-68, 0)))
  })
  
  # plot
  output$plot1 <- renderPlot({
    parentInput <- input$parentheight
    
    plot(galton$parent, galton$child, xlab = "parent height (inch)", ylab = "child height (inch)", bty = "n", pch = 16,
         xlim = c(55, 75), ylim = c(55, 75))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        parent = 55:75, parent_sp = ifelse(55:75 - 68 > 0, 55:75 - 68, 0)
      ))
      lines(55:75, model2lines, col = "blue", lwd = 2)
    }
    
    # legend
    legend("topleft", c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(parentInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(parentInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })  # end of renderplot
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
  
})
