### Routines to Text Mining 

library(tm) # Load Library
library(wordcloud) # Load Library

## Clean Data
mycorpus = Corpus(VectorSource(tweets_df$text)) # Create Vector
removeURL <- function(x) gsub("http[^[:space:]]*", "", x) #Remove Url
mycorpus <- tm_map(mycorpus, content_transformer(removeURL)) #Remove Url execution
mycorpus = tm_map(mycorpus, stripWhitespace) # whitespace
mycorpus = tm_map(mycorpus, tolower) # tolower
mycorpus = tm_map(mycorpus, removePunctuation) # remove .
mycorpus = tm_map(mycorpus, stemDocument) # stem remove
mycorpus <- tm_map(mycorpus, removeWords, c("are", "dem", "for", "the", "will", "and", "here", "for", "moving", "events", "furry", "using", "with", "them", "two", "its", "are", "via", "how"))
inspect(mycorpus) 

## Processing Data
dtmtweet <- TermDocumentMatrix(mycorpus, control = list(minWordLength = 4)) # matrix
a <- findFreqTerms(dtmtweet, 5)
m.t <- as.matrix(dtmtweet)
v.t <- sort(rowSums(m.t),decreasing=TRUE)
d.t <- data.frame(word = names(v.t),freq=v.t)


## Exploratory
head(d.t, 50) # see the top ranking
wordcloud(d.t) # create wordcloud
dtmtweet_norm <- weightTfIdf(dtmtweet, normalize = TRUE) # normalize




