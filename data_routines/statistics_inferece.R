### Basic Statistics

#Probability distributions

## Normal Distribution
m <- 3 # mean 
sd <- 2 # standard deviation
p <- 4 # prob
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

## Standard normal distribution
rannorm <- rnorm(500)
par(mfrow=c(1,2)) # two plots by side
# A frequency diagram
hist(rannorm, freq=TRUE, main="")
hist(rannorm, freq=FALSE, main="", ylim=c(0,0.4))
curve(dnorm(x), add=TRUE, col="blue")

# A standard normal distribution
curve(dnorm(x, sd=1, mean=0), from=-3, to=3,
      ylab="Density", col="blue")
# Add a t-distribution with 3 degrees of freedom.
curve(dt(x, df=3), from =-3, to=3, add=TRUE, col="red")
# Add a legend (with a few options, see ?legend)
legend("topleft", c("Standard normal","t-distribution, df=3"), lty=1, col=c("blue","red"),
       bty='n', cex=0.8)

## T value 2.5% 
f <- 5 # degrees of freedom
qt(0.975, f) #quantile distribution

<<<<<<< HEAD
##Normal Distribution
a <- sample(1:6, size = 20, replace = TRUE) # Create a sample (dieroll)
ma <- mean(a) # check the mean of sample
sda <- sd(a) # check the standard deviation
boxplot(a) 

ra <- rnorm(1000, mean = ma, sd = sda) #random normal distribution
hist(ra, prob=TRUE)
lines(density(ra, adjust = 1.5)) #adjust the line

=======
>>>>>>> f2183d04cb7cd1e84b050f4cf66d88221478353a
