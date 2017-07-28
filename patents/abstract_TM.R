### Load Libraries
library(tm)
library(SnowballC)
library(wordcloud)

### Load data
dfCorpus <- data.frame(pat_072017)

### Text Mining Title
dfCorpus = Corpus(VectorSource(df$AB)) 
inspect(dfCorpus)
### Convert the text to lower case
dfCorpus <- tm_map(dfCorpus, content_transformer(tolower))
inspect(dfCorpus)
### Remove numbers
dfCorpus <- tm_map(dfCorpus, removeNumbers)
inspect(dfCorpus)
### Remove english common stopwords
dfCorpus <- tm_map(dfCorpus, removeWords, stopwords(kind="english"))
dfCorpus <- tm_map(dfCorpus, removeWords, c("novelti"))
inspect(dfCorpus)
### Remove punctuations
dfCorpus <- tm_map(dfCorpus, removePunctuation)
inspect(dfCorpus)
### Eliminate extra white spaces
dfCorpus <- tm_map(dfCorpus, stripWhitespace)
inspect(dfCorpus)

### Stem documents
dictCorpus<-dfCorpus
dfCorpus<-tm_map(dfCorpus,stemDocument)
dfCorpus<-tm_map(dfCorpus,stemCompletion,dictCorpus)

### frequencies
dtm <- TermDocumentMatrix(dfCorpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 50)

### Wordcloud
par(bg="grey30")
png(file="WordCloud.png",width=1000,height=700, bg="grey30")
wordcloud(d$word, d$freq, col=terrain.colors(length(d$word), alpha=0.9), random.order=FALSE, rot.per=0.3 )
title(main = "Patents Terms", font.main = 1, col.main = "cornsilk3", cex.main = 1.5)