source("./test.predictor.1.R")
bi.corpus <- readRDS("bi.corpus.RData")
tri.corpus <- readRDS("tri.corpus.RData")
quad.corpus <- readRDS("quad.corpus.RData")


shinyServer(function(input, output) {
  
  input.word.prediction <- reactive({
    text <- input$text
    input.text <- cleanInput(text)
    input.word.count <- length(input.text)
    input.word.prediction <- nextinput.word.prediction(input.word.count,input.text)})
  
  output$predicted.word <- renderPrint(input.word.prediction())
  output$entered.words <- renderText({ input$text }, quoted = FALSE)
})