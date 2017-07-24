### Download data
library(downloader)
download("http://api.bcb.gov.br/dados/serie/bcdata.sgs.1373/dados?formato=csv", 
         dest="dataset.zip", 
         mode="wb")
dataset <- read.csv("dataset.zip", header = TRUE, sep = ";")

### Pre-processing data routines
summary() # Resume data
str() # check class
boxplot() # check the distribuition
cor() # check the correlation
min.max <- function(x, min, max) {
      x_norm <- (x-min)) / max(x)-min(x)) * (max-min) + min
      return(x_norm)
} # normalization in R
idade_norm <- min.max(d$idade,0,1) # example of function
date <- format(as.POSIXct(dataset$data, format='%d/%m/%Y'), format='%Y') # format data

### Operations with necessary
d$salario[is.na(d$salario)==TRUE] <- 8000.00 # Here a example of put data if the is.na is TRUE
d$idade[18<=d$idade & idade<=49] <- "jovem" # Here a example of transform numerical values in categorical
filtertornado <- aggregate(fatalities ~ date, filtertornado, sum) # Example of aggregate data in same levels

### Order Data Example
damage.order <- df.damage[
      order
      (df.damage$damage, decreasing = TRUE), ]
damage.test <- head(damage.order, n=10)

### Plots
plot(m$quantidade, 
     type = 'l', 
     col = 'red',
     ylab = "Quantidade de Veículos", 
     xlab = "Anos",
     axes = FALSE
) # Simple plot

### Temporal plot

teste <- df.temporal[ ,-1]
teste <- as.data.frame(teste)
legend <- c("Tornado", "Heat", "Flashflood", "Lightstorming")
plot_colors <- c("blue","red","black", "darkgreen")
tornado <- teste$Tornado
heat <- teste$Excessiveheat
flash <- teste$flash
light <- teste$Lightning

p1 <- plot(tornado, 
           type="o", 
           col="blue", 
           ylim=c(0,600), 
           xlim=c(1,17),
           axes=FALSE,
           ann = FALSE)
lines(heat, type="o", pch=22, lty=2, col="red")
lines(flash, type="l", pch=50, lty=3, col="black")
lines(light, type="l", pch=100, lty=4, col="darkgreen")
box()
axis(1, at=1:17, lab=date)
axis(2, las=1, at=c(0, 100, 200, 300, 400, 500, 600))
title(main="Temporal Series of Events in U.S", col.main="black", font.main=4)
title(xlab="Years")
title(ylab="Fatalities")
legend(12, 600, names(teste), cex=0.8, col=plot_colors, 
       pch=21:24, lty=1:4)

### Using functions Apply, Tapply and Lapply
A <- matrix(1:12,nrow=3,byrow=TRUE)
A

apply(A, 1, mean) #Apply in a object a function in all ROWs(1)
apply(A, 1, sum) #Apply in a object a function in all ROWs(1)
apply(A, 1, sd) #Apply in a object a function in all ROWs(1)

apply(A, 2, mean) #Apply in a object a function in all Columns(2)
apply(A, 2, sum) #Apply in a object a function in all Columns(2)
apply(A, 2, sd) #Apply in a object a function in all Columns(2)

###LAPPLY
set.seed(5)
#Cria uma lista contendo os vetores "consumo", "peso" e um data frame "data" contendo duas colunas (a e b) com 10 linhas
minhalista <- list( consumo=c(1.25, 1.54,1.45) , peso = c(45,50,53),data=data.frame(a=rep(1:5,each=2),b=rnorm(10)))
#Soma todos cada um dos elementos da lista e retorna uma lista com os valores
lapply(minhalista,sum)
#Soma todos cada um dos elementos da lista e retorna um vetor com os valores
sapply(minhalista,sum)
#Soma somente as colunas do elemento data(um dataframe) retorna uma lista com os valores
lapply(minhalista$data,sum)

###TAPPLY
consumo <- c(13.10,15.20,16.10,14.75,15.35,16.20) #cria o vetor de resposta
grupo<-as.factor(c("15%PB","18%PB","18%PB","15%PB","15%PB","18%PB"))#cria vetor de fatores indicando o grupo experimental
#Obtêm a média de consumo em função do concentração de PB da dieta
tapply(consumo,grupo,mean)

