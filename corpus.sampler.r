# load libraries
library(tm)

# load, sample, and clean data

# download and unzip text files
# specify the source and destination of the download
text.zip <- "Coursera-SwiftKey.zip"
text.source <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
# download text zip
download.file(text.source, text.zip)
# extract the files from the zip file
unzip(text.zip)


# load text data
# blog text
blogs <- readLines("en_US.blogs.txt")
# news text
# the file en_US.news.txt contains a SUB-value
# which cannot be load by tm directly or readLines() from base-r
# will resolve by opening the file for BINARY read which takes care
# of the SUB control characters
binary.news <- file("en_us.news.txt", open = "rb")
news <- readLines(binary.news, encoding = "UTF-8")
# twitter text
twitter <- readLines("en_US.twitter.txt")


# create sample subsets of text data
# blog sample
blog.sample <- sample(blogs, length(blogs)*0.01)
# news sample
news.sample <- sample(news, length(news)*0.01)
# twitter sample
twitter.sample <- sample(twitter, length(twitter)*0.01)

# combine samples
combined.sample <- c(blog.sample, news.sample, twitter.sample)

# load combined samples into corpus for cleaning
corpus.sample <- Corpus(VectorSource(combined.sample))

# clean sample corpus
# change case to lower
corpus.sample <- tm_map(corpus.sample, content_transformer(tolower))
# remove jargon by regex
# create function which removes everything between ' ' 
remover <- content_transformer(function(x,pattern)gsub(pattern, ' ', x))
corpus.sample <- tm_map(corpus.sample, remover, '(ftp|http)(s?)://.*\\b')  #URLs (HTTP & FTP formats)
corpus.sample <- tm_map(corpus.sample, remover, 'RT |via ') #Twitter tags
corpus.sample <- tm_map(corpus.sample, remover, '[@][a-zA-Z0-9_]{1,15}') # Twitter usernames
corpus.sample <- tm_map(corpus.sample, remover, '\\b[A-Za-z0-9._-]*[@](.*?)[.].{1,3}\\b') #emails
# remove bad words using list from: http://www.bannedwordlist.com/
bad.words.source <- "http://www.bannedwordlist.com/lists/swearWords.txt"
bad.txt <- "bad.words.txt"
download.file(bad.words.source, bad.txt)
bad.words <- readLines("bad.words.txt")
# remove foul words
corpus.sample <- tm_map(corpus.sample, removeWords, bad.words)
# remove white spaces
corpus.sample <- tm_map(corpus.sample, stripWhitespace)
# remove numbers
corpus.sample <- tm_map(corpus.sample, removeNumbers)
# remove punctuation
corpus.sample <- tm_map(corpus.sample, removePunctuation)
# remove stop words
# corpus.sample <- tm_map(corpus.sample, removeWords, stopwords("english"))
# remove stems from words
# corpus.sample <- tm_map(corpus.sample, stemDocument)
# remove white spaces again for any white spaces created by other removals
corpus.sample <- tm_map(corpus.sample, stripWhitespace)

# save corpus sample
saveRDS(corpus.sample, file = "corpus.sample.RData")

# create term document matrix and save
sample.corpus.tdm <- TermDocumentMatrix(corpus.sample)
saveRDS(sample.corpus.tdm, file = "sample.corpus.tdm.RData")
