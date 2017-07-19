library(bibliometrix) #load the package
library(treemap)
library(tm)

##Isi analysis
Dtisi <- readFiles("/home/fabio/Documentos/innovationmanagement/savedrecs.bib") ##readbibtex isi
database <- convert2df(Dtisi, dbsource = "isi", format = "bibtex")
results <- biblioAnalysis(database, sep = ";")

### the authors’ frequency distribution
head(results$Authors, n = 15)

### the authors’ frequency distribution (fractionalized)
head(results$AuthorsFrac, n = 15)

### Pubblication year of each manuscript
hist <- hist(results$Years, 
             main = paste("Amount of Publication by Year"), 
             breaks=20 , col=rgb(0.2,0.8,0.5,0.5), 
             border=F, 
             xlab = "Years", 
             ylab = "Quantity")
print(hist)

### the frequency distribution of keywords associated to the manuscript bySCOPUS and Thomson Reu
top20key <- head(results$ID, n = 20)
top20key <- as.data.frame(top20key)
treemap <- treemap(top20key,
                   index="Tab",
                   vSize="Freq",
                   type="index",
                   title="Treemap of Top 20 Keywords")
print(treemap)
print(top20key)

### Create keyword co-occurrencies network

NetMatrix <- biblioNetwork(database, analysis = "co-occurrences", network = "keywords", sep = ";")

net=networkPlot(NetMatrix, n = 20, Title = "Keyword Co-occurrences", type = "mds", size=T)
CS <- conceptualStructure(database, 
                          field="ID", 
                          minDegree=10, 
                          k.max=5, 
                          stemming=FALSE,
                          labelsize=7)

print(CS)

##Text mining of Abstract
dfCorpus = Corpus(VectorSource(database$AB)) 
inspect(dfCorpus)
dfCorpus <- tm_map(dfCorpus, content_transformer(tolower))
inspect(dfCorpus)
dfCorpus <- tm_map(dfCorpus, removeNumbers)
inspect(dfCorpus)
dfCorpus <- tm_map(dfCorpus, removeWords, stopwords("english"))
dfCorpus <- tm_map(dfCorpus, removeWords, c("paper", "can", "system", "systems", "model", "proposed", "results", "based", "using", "used", "approach", "use", "time", "new", "also", "two"))
inspect(dfCorpus)
dfCorpus <- tm_map(dfCorpus, removePunctuation)
inspect(dfCorpus)
dfCorpus <- tm_map(dfCorpus, stripWhitespace)
inspect(dfCorpus)
dtm <- TermDocumentMatrix(dfCorpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 50)

AB <- conceptualStructure(database, 
                          field="AB", 
                          minDegree=50, 
                          k.max=5, 
                          stemming=FALSE,
                          labelsize=7)
