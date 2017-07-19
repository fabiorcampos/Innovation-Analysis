library(gtrendsR)
#install updates to work
devtools::install_github('PMassicotte/gtrendsR')

gt.us <- gtrends(c("autonomous vehicles", "self-driving"), 
                 geo="US", 
                 time = "2004-01-01 2016-12-31")
plot(gt.us)

gt.wo <- gtrends(c("autonomous vehicles", "self-driving"), 
                  time = "2004-01-01 2016-12-31")
plot(gt.wo)