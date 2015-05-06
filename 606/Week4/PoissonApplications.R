poissdata <- read.csv(paste0(folder, "lab-data-file-poisson-applications.csv"))
##### 1 #####
matern.lambda <- 25
matern.mean <- 25
matern.sd <- sqrt(25)

# a
matern.lower <- matern.mean - 2*matern.sd
matern.upper <- matern.mean + 2*matern.sd

# b
qpois(p=0.95, matern.lambda)

##### 2 #####
# a
sapply(1:ncol(poissdata), function(x) mean(poissdata[,x]))

# b
cost.pd <- 340
revenue.pd <- 800

calc.profit <- function(lambda){
  possible <- 0:qpois(0.9999, lambda)
  prob.possible <- dpois(x, lambda=lambda)
  charters <- ifelse(x <- rep(staff,length(x)), x, staff)
  rev <- charters * revenue.pd
  cost <- charters * 
  
}