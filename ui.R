#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predicting with iris data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h5("This is my project for Coursera Developing Data Products"),
            h5("1. Please select a method to train a model for predicting the Species form the iris data set."),
            selectInput("Method", "Choose a method:",
                       list("Decision Trees", "Random Forest", "Boosting with Trees","K-means")
            ),
            h5("2. A plot will be showed to help you understand the model and the prediction results."),
            h5("3. A table shows the results of predicts(left of the columns) vs real state (top of the columns) of the variable in a testing data set"),
            img(src='table.png', align = "center")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            dataTableOutput("datatable")
        )
    )
))
