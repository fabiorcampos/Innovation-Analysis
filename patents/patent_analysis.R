install.packages("tm")
install.packages("sna")
install.packages("cluster")
install.packages("NLP")
library("dplyr")
library(NLP)
library(tm)
library(ggplot2)
getwd()
databasepat <- read.csv("/home/fabio/Documentos/innovationmanagement/patentvehicles.csv")
str(databasepat)
View(databasepat)
summary(databasepat$Applicants)
ls(databasepat)
listvar <- ls(databasepat)
plot(databasepat$Applicants)
data.cor <- Corpus(VectorSource(databasepat$Applicants))
data.dtm <- DocumentTermMatrix(data.cor)
plot(databasepat$Applicants, databasepat$X.)

head(select(databasepat, Applicants:Inventors))
appli.counts <- select(databasepat, Applicants, Publication.Year, Inventors)
#Filter Company
Google <- filter(appli.counts, Applicants == "GOOGLE INC" )

#Count the quantities of Applicants
sum.appli <- count(databasepat, Applicants)
sum.appli2 <- arrange(sum.appli, desc(n))
View(sum.appli2)
sum.appli3 <- head(sum.appli2, n = 10) 
View(sum.appli3)

##Text Mining Title
dfCorpus = Corpus(VectorSource(databasepat$Title)) 
inspect(dfCorpus)
# Convert the text to lower case
dfCorpus <- tm_map(dfCorpus, content_transformer(tolower))
# Remove numbers
dfCorpus <- tm_map(dfCorpus, removeNumbers)
# Remove english common stopwords
dfCorpus <- tm_map(dfCorpus, removeWords, stopwords("english"))
# Remove punctuations
dfCorpus <- tm_map(dfCorpus, removePunctuation)
# Eliminate extra white spaces
dfCorpus <- tm_map(dfCorpus, stripWhitespace)

# Text stemming (reduces words to their root form)
library("SnowballC")
dfCorpus <- tm_map(dfCorpus, stemDocument)

dtm <- TermDocumentMatrix(dfCorpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 50)

# Generate the WordCloud
library("wordcloud")
library("RColorBrewer")
par(bg="grey30")
png(file="WordCloud.png",width=1000,height=700, bg="grey30")
wordcloud(d$word, d$freq, col=terrain.colors(length(d$word), alpha=0.9), random.order=FALSE, rot.per=0.3 )
title(main = "Patents Terms", font.main = 1, col.main = "cornsilk3", cex.main = 1.5)
dev.off()

