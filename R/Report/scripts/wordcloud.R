#! /usr/bin/env Rscript

#
#   Description: report feedback 2017
#   Date: 2017, September- November
#   Copyright (C) 2017 Paula Andrea Martinez
#   ORCID iD 0000-0002-8990-1985

# ###########################################################################
# Make a Wordcloud , receives a column , and a name for the plot 
# http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

myWordCloud <- function(coln, nam){
  # Reference example for wordcloud 
  library(tm)
  library(SnowballC)
  library(wordcloud)
  mydata1 <- as.character(coln) 
  #First, we need to create a corpus
  mydata1 <- Corpus(VectorSource(mydata1))
  #Next, we will convert the corpus to a plain text document
  mydata1 <- tm_map(mydata1, content_transformer(tolower))
  # Remove numbers
  mydata1 <- tm_map(mydata1, removeNumbers)
  # Remove english common stopwords
  mydata1 <- tm_map(mydata1, removeWords, stopwords("english"))
  # Remove your own stop word
  # specify your stopwords as a character vector
  mydata1 <- tm_map(mydata1, removeWords, c("the", "this")) 
  # Remove punctuations
  mydata1 <- tm_map(mydata1, removePunctuation)
  # Eliminate extra white spaces
  mydata1 <- tm_map(mydata1, stripWhitespace)
  # Text stemming
  #mydata1 <- tm_map(mydata1, stemDocument)
  # matrix
  dtm <- TermDocumentMatrix(mydata1)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m), decreasing = TRUE)
  d <- data.frame(word = names(v), freq=v)
  head(d, 10)
  set.seed(1234)
  
  png(filename = paste0("plots/",nam, ".png"), 
      width = 10, height = 10, units = "in", res = 300)
  wordcloud(words = d$word, freq = d$freq, scale=c(7, 1),
            random.order = FALSE,
            colors = c("blue4", "chocolate4", "darkslategray"))
  dev.off()
}
