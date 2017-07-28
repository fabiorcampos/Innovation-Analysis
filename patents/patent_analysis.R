# Load libraries
library(dplyr)
library(stringr)
library(tm)
library(ggplot2)
library(wordcloud)
library(readr)
library(SnowballC)

# Load dataset
pat_072017 <- read_csv("pat_072017.csv")
df <- as.data.frame(pat_072017)

# Analyse Inventors
ae <- as.character(df$AE) 
ae <- str_replace(ae, " \\(.*\\)", "") ### Remove desnecessary text
ae <- as.data.frame(table(ae)) ### combine all elements and make a freq
ae <- ae[order(ae$Freq, decreasing = TRUE), ] ### put in order decreasing
ae <- subset(ae, Freq >= 9, select = c(ae, Freq)) ### create a subset
print(ae)

# Dendrogram Inventors
hc <- hclust(dist(ae)) ### Create
plot(hc, labels = ae$ae, main = "Cluster Dendogram", xlab = "Companies", 
     ylab = "Height", hang=-50, cex=.40) 

# Keywords
dc <- as.character(df$DC)
dc <- str_replace(dc, " \\(.*\\)", "")
dc <- as.data.frame(table(dc))
dc <- dc[order(dc$Freq, decreasing = TRUE), ]
dc <- subset(dc, Freq >= 20, select = c(dc, Freq)) ### create a subset
print(dc)

# Dendrogram Keywords
dchc <- hclust(dist(dc)) ### Create
plot(dchc, labels = dc$dc, main = "Cluster Dendogram", xlab = "Kewys", 
     ylab = "Height", hang=-50, cex=.60) 

# Text Mining in Title



# Text Mining in Abstract


