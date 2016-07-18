# tokenizer

# load libraries
library(tm)
library(RWeka)
library(dplyr)
library(tidyr)

# read in corpus then convert to data frame
final.corpus <- readRDS("corpus.sample.RData")
final.corpus.dframe <-data.frame(text=unlist(sapply(final.corpus,`[`, "content")), 
                                 stringsAsFactors = FALSE)

# tokenization function
ngramTokenizer <- function(corpus.frame, ngramCount) {
  ngramFunction <- RWeka::NGramTokenizer(corpus.frame, 
                                         RWeka::Weka_control(min = ngramCount, max = ngramCount, 
                                                             delimiters = " \\r\\n\\t.,;:\"()?!"))
  ngramFunction <- data.frame(table(ngramFunction))
  ngramFunction <- ngramFunction[order(ngramFunction$Freq, 
                                       decreasing = TRUE),]
  colnames(ngramFunction) <- c("String","Count")
  test.split <- ngram.corpus.splitter(ngramFunction$String, ngramCount)
  ngramFunction <- cbind(test.split, ngramFunction$Count)
}


# token splitting function
ngram.corpus.splitter <- function(ngram.corpus, ngramCount){
  splitFrame <- as.data.frame(ngram.corpus) %>%
    separate(ngram.corpus, into = paste("gram", 1:ngramCount, sep = "_"))
}


# running functions, renaming, and saving outputs
bigram <- ngramTokenizer(final.corpus.dframe, 2)
colnames(bigram) <- c("unigram", "bigram", "frequency")
saveRDS(bigram, file = "bi.RData")

trigram <- ngramTokenizer(final.corpus.dframe, 3)
colnames(trigram) <- c("unigram", "bigram", "trigram", "frequency")
saveRDS(trigram, file = "tri.RData")

quadgram <- ngramTokenizer(final.corpus.dframe, 4)
colnames(quadgram) <- c("unigram", "bigram", "trigram", "quadgram", "frequency")
saveRDS(quadgram, file = "quad.RData")