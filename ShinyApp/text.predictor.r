# word prediction 

# load libraries
library(tm)
library(stringr)
library(stylo)

# load text data
bi.corpus <- readRDS("bi.RData")
tri.corpus <- readRDS("tri.RData")
quad.corpus <- readRDS("quad.RData")

# splits input text into seperate strings for cleaning
cleanInput <- function(text){
  input.text <- input.cleaner(text)
  input.text <- txt.to.words.ext(input.text, 
                                 language="English.all", 
                                 preserve.case = TRUE)
  return(input.text)
}

# converts input text to text that is comparable to the cleaned ngrams
input.cleaner<-function(text){
  # lower case
  clean.text <- tolower(text) 
  # remove punctuation
  clean.text <- removePunctuation(clean.text)
  # remove numbers
  clean.text <- removeNumbers(clean.text)
  clean.text <- str_replace_all(clean.text, "[^[:alnum:]]", " ")
  # remove white spaces
  clean.text <- stripWhitespace(clean.text)
  return(clean.text)
}

# predictor function takes in converted split user text and prints next 
# predicted next input
input.prediction <- function(input.word.count,input.text){
  # if the number of words input by the user is greater than or equal to 3
  # change the input text to only the last 3 words
  if (input.word.count>=3) {
    input.text <- input.text[(input.word.count-2):input.word.count] 
  }
  # otherwise, if the number of words input by the user is equal to 2
  # the input text is only 2 words in the second and third positions
  else if(input.word.count==2) {
    input.text <- c(NA,input.text)   
  }
  # otherwise, the input text is a single word in the third position
  else {
    input.text <- c(NA,NA,input.text)
  }
  
  # using the input text, the predicted word is what is the highest frequency to follow
  # the three words in the input text
  predictor <- as.character(quad.corpus[quad.corpus$unigram==input.text[1] & 
                                          quad.corpus$bigram==input.text[2] & 
                                          quad.corpus$trigram==input.text[3],][1,]$quadgram)
  # if the predictor is NA in the first position of the input text, use the trigram corpus
  # to predict the next word
  if(is.na(predictor)) {
    predictor1 <- as.character(tri.corpus[tri.corpus$unigram==input.text[2] & 
                                            tri.corpus$bigram==input.text[3],][1,]$trigram)
    # if the predictor is NA in the first two positions of the input text, use the bigram
    # corpus to predict the next word
    if(is.na(predictor)) {
      predictor <- as.character(bi.corpus[bi.corpus$unigram==input.text[3],][1,]$bigram)
    }
  }
  # print out the predicted next word
  print(predictor)
}