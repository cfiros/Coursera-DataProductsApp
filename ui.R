library(shiny)
shinyUI(pageWithSidebar(
    headerPanel('MPG prediction app'),
    sidebarPanel(
        h3('Instructions'),
        p('Enter the weight, number of cylinders, and horsepower of your 
          car below.  The predicted MPG will be shown to the right.'),
        h3('Please enter predictors of MPG below.'),
        numericInput('wt', 'Weight (lbs):', 3500, min = 1500, max = 5500, step = 100),
        radioButtons('cyl', 'Number of cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'), 
        numericInput('hp', 'horsepower:', 170, min = 50, max = 350, step = 10),
        h3('Process'),
        p('To predict the MPG value I fitted the linear model of mpg as outcome and weight, number of
          cylinders and horsepower as predictors, which discovered as the most influenced predictors
          in the data set on mpg. I treated the input values according to thier types, also doing an adjusment
          on the weight. my output is the prediction relating to dataset, and 3 plots which shows exactly
          how it falls in the data.'), 
        h6('Course Project by Cfir Rahimi')
    ),
    mainPanel(
        h3('Predicted MPG'),
        h4('You entered:'),
        verbatimTextOutput("inputValues"),
        h4('the predicted MPG is:'),
        verbatimTextOutput("prediction"),
        h4('MPG relative to cars in mtcars data set'),
        plotOutput('plots'),
        img(src="Fuel.png", height = 300, width = 1300))))
