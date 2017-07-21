library(httr)
library(devtools)
library(twitteR)
library(base64enc)
library(tidytext)
library(tm)

consumer_key <- 'YetGrrFzoeN0UUQfCZoQERsYg'
consumer_secret <- 'xb2sXMwcLOP5HNERJBgPw2gCHUPjSSFy0VLhRScgJjfkCaP79K'
access_token <- '293631173-p2Kv4K7BW41D0vNXc5OQgdBR5nCwR4D7pmiiTgyh'
access_secret <- 'JpO4Wik99qyREddOfi0zdnxhsUdhhv1PhjbL52i4gqoHv'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets <- searchTwitter("autonomous vehicles",n=1000,lang="en")
tweets_df = twListToDF(tweets)

mycorpus = Corpus(VectorSource(tweets_df$text))
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
mycorpus <- tm_map(mycorpus, content_transformer(removeURL))
mycorpus = tm_map(mycorpus, stripWhitespace)
mycorpus = tm_map(mycorpus, tolower)
mycorpus = tm_map(mycorpus, removePunctuation)
mycorpus = tm_map(mycorpus, removeWords, stopwords(kind = "english"))
mycorpus = tm_map(mycorpus, stemDocument)
mycorpus <- tm_map(mycorpus, removeWords, c("the", "will", "and", "here", "for", "moving", "events", "furry", "using", "with", "them", "two", "its", "are", "via", "how"))
inspect(mycorpus)                  

dtmtweet <- TermDocumentMatrix(mycorpus, control = list(minWordLength = 4)) # matrix
m.t <- as.matrix(dtmtweet)
v.t <- sort(rowSums(m.t),decreasing=TRUE)
d.t <- data.frame(word = names(v.t),freq=v.t)
head(d.t, 50)
wordcloud(d.t)

dtmtweet_norm <- weightTfIdf(dtmtweet, normalize = TRUE) # normalize