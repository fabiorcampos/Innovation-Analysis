eco <- read.csv("set_economico.csv", header = TRUE, sep = ",")
colnames(eco) <- c('setor', '2003', '2004', '2005', '2006')
snames <- as.data.frame(eco$setor)
snames$cod=c(1:11)
s <- snames[1:3, ]
matrix <- as.matrix(eco[1:11,2:5])
date <- c('2003', '2004', '2005', '2006')
cod1 <- as.numeric(c(eco[1, 2:5]))
plot_colors <- c("blue","red","black")

p1 <- plot(cod1, 
           type="o", 
           col="blue", 
           ylim=c(0,50000), 
           xlim=c(1,4),
           axes=FALSE,
           ann = FALSE)

lines(matrix[2, ], type="o", pch=22, lty=2, col="red")
lines(matrix[3, ], type="o", pch=22, lty=2, col="black")
axis(1, at=1:4, lab=date)
axis(2, las=1, at=c(0, 10000, 20000, 30000, 40000, 50000))
title(main="Tics (2003-2006)", col.main="black", font.main=4)
title(xlab="Anos")
title(ylab="R$ (milhões)")

m <- apply(matrix, 1, mean)
s <- apply(matrix, 1, sum)
eco$average=m
eco$total=s

dist=dist(matrix[ , c(3:4)] , diag=TRUE)
hc=hclust(dist)
dhc=as.dendrogram(hc)

clusterCut <- cutree(hc, 3)

table(clusterCut)


