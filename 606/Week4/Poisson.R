##### 7 #####
set.seed(01191984)
poissonsample <- rpois(2000, 2.2)

##### 8 #####
hist(poissonsample, breaks=seq(-0.5, max(poissonsample)+0.5, 1))

##### 9 #####
mean(poissonsample)

##### 10 #####
sd(poissonsample)

##### 11 #####
poiss.prob <- ecdf(poissonsample)
poiss.prob(1)

##### 12 #####
for(i in 0:max(poissonsample)){
  if(poiss.prob(i) > 0.25){
    print(paste("first quantile is", i))
    break
  }
}
for(i in 0:max(poissonsample)){
  if(poiss.prob(i) > 0.5){
    print(paste("median is", i))
    break
  }
}
for(i in 0:max(poissonsample)){
  if(poiss.prob(i) > 0.75){
    print(paste("third quantile is", i))
    break
  }
}
max(poissonsample)
min(poissonsample)

##### 13 #####
quantile(poissonsample)
