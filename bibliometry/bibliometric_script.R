##Bibliometrix
##install.packages
install.packages("dplyr") 
install.packages("factoextra") 
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("igraph")
install.packages("Matrix")
install.packages("rscopus")
install.packages("SnowballC")
install.packages("stringr")
install.packages("bibliometrix")
getwd() #view the directory
setwd("/home/fabio/Documentos/innovationmanagement") #set the directory to work
##How to download database of scopus and isi
library(bibliometrix) #load the package

##Isi analysis
Dtisi <- readFiles("/home/fabio/Documentos/innovationmanagement/savedrecs.bib") ##readbibtex isi
database <- convert2df(Dtisi, dbsource = "isi", format = "bibtex")
results <- biblioAnalysis(database, sep = ";")
S=summary(object = results, k = 10, pause = FALSE)

##visual analysis - citations per article
plot(x = results, k = 10, pause = FALSE) 
##article more cited
CR <- citations(database, field = "article", sep = ".  ")
CR$Cited[1:10] 
##author more cited
CR <- citations(database, field = "author", sep = ".  ")
CR$Cited[1:10] 
#location
CR <- localCitations(database, results, sep = ".  ")
CR[1:10] 
##Authors Dominance ranking --> The function dominance calculates the authors dominance ranking as proposed by Kumar & Kumar, 2008.
DF <- dominance(results, k = 10)
DF

##Authors h-index
indices <- Hindex(database, authors="ALTHOFF M", sep = ";",years=10)
indices$H
indices$CitationList
authors=gsub(","," ",names(results$Authors)[1:10])
indices <- Hindex(database, authors, sep = ";",years=50)
indices$H

##Lotka
L <- lotka(results)
L$AuthorProd
Observed=L$AuthorProd[,3]
Theoretical=10^(log10(L$C)-2*log10(L$AuthorProd[,1]))
plot(L$AuthorProd[,1],Theoretical,type="l",col="red",ylim=c(0, 1), xlab="Articles",ylab="Freq. of Authors",main="Scientific Productivity")
lines(L$AuthorProd[,1],Observed,col="blue")
legend(x="topright",c("Theoretical (B=2)","Observed"),col=c("red","blue"),lty = c(1,1,1),cex=0.6,bty="n")

##Bibliometric network
net <- cocMatrix(database, Field = "SO", sep = ";")
sort(Matrix::colSums(net), decreasing = TRUE)[1:5]
biblionet <- cocMatrix(database, Field = "CR", sep = ".  ")
sort(Matrix::colSums(biblionet), decreasing = TRUE)[1:5]

#Citation network
citationet <- sort(Matrix::colSums(biblionet), decreasing = TRUE)[1:5]

#Author network
Authornet <- cocMatrix(database, Field = "AU", sep = ";")
A <- cocMatrix(database, Field = "DE", sep = ";")

NetMatrix <- biblioNetwork(database, analysis = "coupling", network = "references", sep = ".  ")

NetMatrix <- biblioNetwork(database, analysis = "coupling", network = "authors", sep = ";")

# calculate jaccard similarity coefficient
S <- couplingSimilarity(NetMatrix, type="jaccard")

# plot authors' similarity (first 20 authors)
net=networkPlot(S, n = 20, Title = "Authors' Coupling", type = "fruchterman", size=FALSE,remove.multiple=TRUE)

# Create a country collaboration network

M <- metaTagExtraction(database, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = 20, Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE)

# Create keyword co-occurrencies network

NetMatrix <- biblioNetwork(database, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = 20, Title = "Keyword Co-occurrences", type = "kamada", size=T)

CS <- conceptualStructure(database, 
                          field="ID", 
                          minDegree=4, 
                          k.max=5, 
                          stemming=FALSE,
                          labelsize=7)

# Create a historical co-citation network

histResults <- histNetwork(database, n = 15, sep = ".  ")

# Plot a historical co-citation network
net <- histPlot(histResults, size = TRUE)



