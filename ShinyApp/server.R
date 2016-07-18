# advise server the source script for the predictor algorithm 

# load library
library(shiny)
library(shinyapps)
library(tm)
library(stringr)
library(stylo)

source("text.predictor.r")

# server function takes inputs from ui script and sends them to the 
# predictor script then returns the results to the ui script
shinyServer(function(input, output) {
  input.word.prediction <- reactive({
    text <- input$text
    input.text <- cleanInput(text)
    input.word.count <- length(input.text)
    input.word.prediction <- input.prediction(input.word.count,input.text)})
  
  output$predicted.word <- renderPrint(input.word.prediction())
  output$entered.words <- renderText({ input$text }, quoted = FALSE)
})