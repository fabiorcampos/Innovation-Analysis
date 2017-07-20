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


