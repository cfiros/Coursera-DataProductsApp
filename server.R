library(shiny)
data(mtcars)

fit <- lm(mpg ~ wt + cyl + hp, data=mtcars)

fitted_mpg <- function(wt, cyl, hp) {
  fit$coefficients[1] + fit$coefficients[2] * wt + 
    fit$coefficients[3] * cyl + fit$coefficients[4] * hp
}

shinyServer(
    function(input, output) {
        adjusted_weight <- reactive({input$wt/1000})
        predicted_mpg <- reactive({fitted_mpg(adjusted_weight(), as.numeric(input$cyl), input$hp)})
        output$inputValues <- renderPrint({paste(input$wt, "lbs, ",
                                                 input$cyl, "cylinders, ",
                                                 input$hp, "horsepower")})
        output$prediction <- renderPrint({paste(round(predicted_mpg(), 3), "miles per gallon")})
        output$plots <- renderPlot({
            par(mfrow = c(1, 3))
            with(mtcars, plot(wt, mpg,
                            xlab='Weight (lb/1000)',
                            ylab='MPG',
                            main='MPG vs weight',
                            pch=16))
            points(adjusted_weight(), predicted_mpg(), col='blue', cex=3)  
            with(mtcars, plot(cyl, mpg,
                              xlab='Number of cylinders',
                              ylab='MPG',
                              main='MPG vs cylinders',
                              pch=16))
            points(as.numeric(input$cyl), predicted_mpg(), col='blue', cex=3)  
            with(mtcars, plot(hp, mpg,
                              xlab='horsepower',
                              ylab='MPG',
                              main='MPG vs horsepower',
                              pch=16))
            points(input$hp, predicted_mpg(), col='blue', cex=3)       
            
        })
    }
)