
library(shiny)
library(rpart)
library(rattle)
library(rpart.plot)
require(rCharts)

shinyUI(fluidPage(
  titlePanel("Developing Data Products Project"),
  sidebarLayout(
    sidebarPanel(
      
      helpText(strong('Instructions:')),
      helpText('In order to make the problem simpler only some variables, 
      the most relevant as predictors of the dataset, have been selected.'),
      br(),
      helpText('You have to choose the values, for the next variables, in order to know if it
      is feasible to give the credit or not. The app is reactive. At the end of the page there is a
      plot of the Decision Tree Implemented that describes how the algorithm predict as Good or Bad 
      the credit applicant.'),
      br(),
      h4('Variables to be selected:'),
      numericInput('am', 'Amount of credit asked:', 0, min = 200, max = 20000, step = 100),
      sliderInput('dur', 'Establish the duration in months:', 
                value = 4, min = 4, max = 72, step = 1,),
      numericInput('age', 'Put his/her age:', 0, min = 18, max = 75, step = 1),
      sliderInput('inst', 'Establish the Installment rate in percentage:', 
               value = 0, min = 1, max = 4, step = 1,),
      radioButtons('fore', "Select that corresponds:",
                   choices = list("Foreign = 1" = 1, "Native = 0" = 0), selected = 1),
         
      br(),
      br(),
      
      img(src = "bigorb.png", height = 60, width = 60), "shiny is a product of ", 
      span("RStudio", style = "color:green")
      
    ),
    
    mainPanel(
    h3('Prediction of Credit Worthiness'),
    p("To do the present project a dataset coming from Dr. Hans Hofmann of the University of Hamburg stored at the ", 
    a("UC Irvine Machine Learning Repository ", href = "http://archive.ics.uci.edu/ml/datasets/Statlog+%28German+Credit+Data%29"), 
    "has been employed. This dataset classifies people described by a set of attributes as", 
    strong("Good or Bad")," credit risks."),
    h4("Dataset description:"),
    p("These data have two classes for the credit worthiness: good or bad. There are predictors related to attributes, 
    such as: checking account status, duration, credit history, purpose of the loan, amount of the loan, savings accounts or bonds, 
    employment duration, Installment rate in percentage of disposable income, personal information, 
    other debtors/guarantors, residence duration, property, age, other installment plans, housing, number of existing credits, 
    job information, Number of people being liable to provide maintenance for, telephone, and foreign worker status.
    Many of these predictors are discrete and have been expanded into several 0/1 indicator variables"),
    p("To access to the dataset from CARET Package: ", a("CARET datasets homepage.", 
    href = "http://topepo.github.io/caret/datasets.html")),    
    code('library(caret); data(GermanCredit)'), 
    br(),  
    br(),
    h5('Values Selected:'), 
    h6('You entered the amount of credit:'), 
    verbatimTextOutput("oid1"), 
    h6('You entered de duration of the credit:'), 
    verbatimTextOutput("oid2"),
    h6('You entered the age of the client:'), 
    verbatimTextOutput("oid3"),
    h6('You entered the installment rate in percentage of disposable income:'), 
    verbatimTextOutput("oid4"),
    h6('You entered the foreignness:'), 
    verbatimTextOutput("oid5"),
    h4(strong('The prediction of credit risk for the data introduced is:'), style = "color:red"),
    verbatimTextOutput("prediction"),
    
    br(),
    
    h3('Plots for comparing the Age in front of Credit Amount and Duration'),
    p("Moreover, two rCharts have been plotted in order to compare if the age of 
      the credit applicants in front of duration or amount of credit has been historically 
      classified as Good or Bad. Both rPlots are reactive."),
    helpText("You have to select the range of ages you want to see for both", strong("rPlots")),
    sliderInput("range", 
                label = "Range of Age of interest:",
                min = 18, max = 75, value = c(25, 40)),
    br(),
    showOutput("newplot1", "polycharts"),    
    br(),
    br(),
    showOutput("newplot2", "polycharts"),  
    br(),
    
    h3('Decision Tree Implemented'),
    p('An Rpart tree has been used to implement the prediction algorithm. Below the decision 
      tree is plotted to show the decision process graphically.'),
    plotOutput('newplot3')
    
    )
  )
))


