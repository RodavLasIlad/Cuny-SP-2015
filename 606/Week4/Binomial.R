##### 7 #####
set.seed(01191984)
binomsample <- rbinom(2000, 6, .4)

##### 8 #####
hist(binomsample, seq(-0.5, 6.5, 1))

##### 9 #####
mean(binomsample)

##### 10 #####
sd(binomsample)

##### 11 #####
prob.binomsample <- table(binomsample)/sum(table(binomsample))

cdf.binomsample <- array(1:length(prob.binomsample))
cdf.binomsample <- sapply(1:length(prob.binomsample), function(x) cdf.binomsample[x] <- sum(prob.binomsample[1:x]))

##### 12 #####
min.binomsample <- which.min(cdf.binomsample) - 1
max.binomsample <- which.max(cdf.binomsample) - 1
q1.binomsample <- min(which(cdf.binomsample > 0.25)) - 1
med.binomsample <- min(which(cdf.binomsample > 0.5)) - 1
q3.binomsample <- min(which(cdf.binomsample > 0.75)) - 1

#### 13 #####
quantile(binomsample)
summary(binomsample)
