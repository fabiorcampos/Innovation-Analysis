#install updates to work
devtools::install_github('PMassicotte/gtrendsR')
library(gtrendsR)
library(forecast)

gt.us <- gtrends(c("autonomous vehicles", "self-driving"), 
                 geo="US", 
                 time = "2004-01-01 2016-12-31")
plot(gt.us)
gt.fc <- gt.us$interest_over_time
fc <- forecast(gt.fc$hits)
plot(fc)

gt.wo <- gtrends(c("autonomous vehicles", "self-driving"), 
                  time = "2004-01-01 2016-12-31")
plot(gt.wo)