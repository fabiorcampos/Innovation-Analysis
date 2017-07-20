###Load library
library(downloader)
library(forecast)
library(ggplot2)

###Download data
download("http://api.bcb.gov.br/dados/serie/bcdata.sgs.1373/dados?formato=csv", dest="dataset.zip", mode="wb")
dataset <- read.csv("dataset.zip", header = TRUE, sep = ";")

###format data
date <- format(as.POSIXct(dataset$data, 
                          format='%d/%m/%Y'), 
               format='%Y')
quantidade <- as.numeric(dataset$valor)
format(quantidade, digits = 5)
main <- data.frame(date, quantidade)
main <- aggregate(quantidade ~ date, main, sum)
datelabel <- as.factor(c(1993:2016))
m <- main[-25, ]

###Exploratory Analysis
plot(m$quantidade, 
     type = 'l', 
     col = 'red',
     ylab = "Quantidade de Veículos", 
     xlab = "Anos",
     axes = FALSE
     )
axis(1, at=1:24, lab=datelabel)
axis(2)
summary(m$quantidade)
boxplot(m$quantidade)

## Plot Results

### Production by Year
plot(m$quantidade, 
     type = 'l', 
     col = 'red',
     ylab = "Quantidade de Veículos", 
     xlab = "Anos",
     axes = FALSE
)
axis(1, at=1:24, lab=datelabel)
axis(2)

### Production by month since 1993 until 2016
plot(quantidade, 
     type = 'l', 
     col = 'red',
     ylab = "Quantidade de Veículos", 
     xlab = "Meses",
     axes = FALSE
)
axis(1)
axis(2)

### Forecast production by month since 1993 until 2016
fc <- forecast(quantidade)
plot(fc)

### Forecast production by year 1993 - 2016
fcy <- forecast(m$quantidade)
plot(fcy)


