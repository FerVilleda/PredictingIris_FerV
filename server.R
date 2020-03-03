#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data(iris)
library(caret)
library(rattle)
library(party)
library(e1071)
library(ggplot2)
library(gbm)

# Define server logic required
shinyServer(function(input, output) {

    #Data sets I will use
    set.seed(6895)
    inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
    training <- iris[inTrain,]
    testing <- iris[-inTrain,]
    mod1 <- train(Species ~., method="rpart", data=training)
    mod2 <- ctree(Species~., data = training)
    mod3 <- train(Species~., method="gbm", data=training, verbose=FALSE)
    mod4 <- kmeans(subset(training, select=-c(Species)), centers=3)
    training$clusters <- as.factor(mod4$cluster)


    output$distPlot <- renderPlot({

        if(input$Method=="Decision Trees"){
            # draw the resulting tree
            fancyRpartPlot(mod1$finalModel)
        } else if(input$Method=="Random Forest"){
            plot(mod2,type="simple")
        } else if(input$Method=="Boosting with Trees"){
            qplot(predict(mod3,testing),Species,data=testing)
        } else if (input$Method=="K-means"){
            qplot(training$Petal.Width, training$Petal.Length, colour=clusters, data = training)
        }

    })

    output$datatable <- renderDataTable({
        if(input$Method=="Decision Trees"){
            pred1 <- predict(mod1,testing)
            table(pred1,testing$Species)
        } else if(input$Method=="Random Forest"){
            pred2 <- predict(mod2,testing)
            table(pred2,testing$Species)
        } else if(input$Method=="Boosting with Trees"){
            pred3 <- predict(mod3,testing)
            table(pred3,testing$Species)
        } else if(input$Method=="K-means"){
            pred4 <- predict(mod4,testing)
            table(pred4,testing$Species)
        }
    })

})
