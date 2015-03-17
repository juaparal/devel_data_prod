
library(shiny) 
library(caret)
library(rpart)
library(rattle)
library(rpart.plot)
require(rCharts)

data(GermanCredit)
only_ten<-GermanCredit[1:10]  # we select only ten attributes
fit <- rpart(Class ~. , data=only_ten)
imp <- varImp(fit)  # let's see the most important predictors
l<-c(rownames(imp)[order(imp$Overall, decreasing=TRUE)[1:5]], "Class")
datafit<-only_ten[,l] # only select the 5 most important predictors + Class
fit2 <- rpart(Class ~. , data=datafit)  #fit a Rpart tree


shinyServer(
  function(input, output) {
    output$oid1 <- renderText({input$am}) 
    output$oid2 <- renderText({input$dur})  
    output$oid3 <- renderText({input$age})  
    output$oid4 <- renderText({input$inst})  
    output$oid5 <- renderText({input$fore})  
    output$prediction <- renderPrint({
        m <- data.frame(Amount=as.numeric(input$am), Duration=as.numeric(input$dur), 
                        Age=as.numeric(input$age), InstallmentRatePercentage=as.numeric(input$inst), 
                        ForeignWorker=as.numeric(input$fore))
        #make the prediction
        predict(fit2, m, type="class")  
    })
            
    output$newplot1 <- renderChart({ 
        dat<-subset(datafit, (Age>input$range[1] & Age<input$range[2] ))
        n1 <- rPlot(Age ~ Amount, color = 'Class', type = 'point', data =dat)
        n1$set(title="Classification per Age Range vs Credit Amount",
               width = 650, height = 350)
        n1$addParams(dom = 'newplot1')
        return(n1)
    })
    
    output$newplot2 <- renderChart({ 
        dat<-subset(datafit, (Age>input$range[1] & Age<input$range[2]))
        n2 <- rPlot(Age ~ Duration , color = 'Class', type = 'point', data =dat)
        n2$set(title="Classification per Age Range vs Credit Duration",
               width = 650, height = 350)
        n2$addParams(dom = 'newplot2')
        return(n2)
    })
        
    output$newplot3 <- renderPlot({ 
      fancyRpartPlot(fit)
      })
    
  }
)
    