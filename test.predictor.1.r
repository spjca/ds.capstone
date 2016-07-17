# word prediction 

bi.corpus <- readRDS("bi.corpus.RData")
tri.corpus <- readRDS("tri.corpus.RData")
quad.corpus <- readRDS("quad.corpus.RData")

# 
input.cleaner<-function(text){
  
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  
  return(cleanText)
}

# 
cleanInput <- function(text){
  
  input.text <- input.cleaner(text)
  input.text <- txt.to.words.ext(input.text, 
                                language="English.all", 
                                preserve.case = TRUE)
  
  return(input.text)
}

#
input.prediction <- function(input.word.count,input.text){
  
  if (input.word.count>=3) {
    input.text <- input.text[(input.word.count-2):input.word.count] 
    
  }
  
  else if(input.word.count==2) {
    input.text <- c(NA,input.text)   
  }
  
  else {
    input.text <- c(NA,NA,input.text)
  }
  
  
  ### 1 ###
  predictor <- as.character(quad.corpus[quad.corpus$unigram==input.text[1] & 
                                              quad.corpus$bigram==input.text[2] & 
                                              quad.corpus$trigram==input.text[3],][1,]$quadgram)
  
  if(is.na(predictor)) {
    predictor1 <- as.character(tri.corpus[tri.corpus$unigram==input.text[2] & 
                                                 tri.corpus$bigram==input.text[3],][1,]$trigram)
    
    if(is.na(predictor)) {
      predictor <- as.character(bi.corpus[bi.corpus$unigram==input.text[3],][1,]$bigram)
    }
  }
  
  
  print(predictor)
  
}