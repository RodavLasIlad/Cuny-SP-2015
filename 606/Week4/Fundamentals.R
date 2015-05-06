##### 1 #####
folder <- "C:\\Users\\Brett\\Dropbox\\CUNY\\606\\Week4\\"
fund <- read.csv(paste0(folder, "lab-data-file-discrete-distributions.csv"))
fund.compile <- table(fund)
##### 2 #####

##### 3 #####
hist(fund[,1], breaks=seq(0.5,8.5,1))

##### 4 #####
fund.compile.prob <- fund.compile/sum(fund.compile)
expected.fund <- sum(as.numeric(names(table(fund))) * fund.compile.prob)

##### 5 ##### 
var.fund <- sum((as.numeric(names(table(fund))) - expected.fund)^2 * fund.compile.prob)
sd.fund <- sqrt(var.fund)

##### 6 #####
set.seed(01191984)
mysample <- array(dim=10000)
mysample <- sapply(mysample, function(x) sample(fund[,1], 1, replace=TRUE))

##### 7 #####
hist(mysample, breaks=seq(0.5, 8.5, 1))

##### 8 #####
mean(mysample)

##### 9 #####
sd(mysample)

##### 10 #####
cdf.fund <- array(1:length(fund.compile.prob))
cdf.fund <- sapply(1:length(fund.compile.prob), function(x) cdf.fund[x] <- sum(fund.compile.prob[1:x]))

##### 11 #####
min.fund <- which.min(cdf.fund)
max.fund <- which.max(cdf.fund)
q1.fund <- min(which(cdf.fund > 0.25))
med.fund <- min(which(cdf.fund > 0.5))
q3.fund <- min(which(cdf.fund > 0.75))

##### 12 #####
quantile(fund[,1])
summary(fund[,1])
