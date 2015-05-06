##### 1 #####
##### 1.b #####
pbinom(9, 160, 0.113)
##### 1.c #####
seats <- 150
rebooking <- 100

orig.price <- 75
orig.bookings <- 160
orig.no.show <- 0.113

new.price <- 80
new.bookings <- 155
new.no.show <- 0.032

simul.price <- function(price, bookings, no.show){
  revenue <- bookings * price
  cost <- 0
  attendees <- sum(rbinom(1:bookings, 1, 1 - no.show))
  if(attendees > 150){
    cost <- (attendees - 150)
  }
  return(revenue - cost)
}

orig.bootstrap <- sapply(1:10000, function(x) simul.price(orig.price, orig.bookings, orig.no.show))
mean(orig.bootstrap)
sd(orig.bootstrap)

new.bootstrap <- sapply(1:10000, function(x) simul.price(new.price, new.bookings, new.no.show))
mean(new.bootstrap)
sd(new.bootstrap)

##### 2 #####
##### 2.a #####
eligible.population <- 181535
pop.prob <- 0.791
jurors.population <- 870
jurors.prob <- 0.39

pbinom(7, 12, .791)

phyper(7, 12, .791)

#### 2.b ####
pbinom(339, 870, .791)

q <- 339
m <- 181535 * .791
n <- 181535 * (1-.791)
k <- 870
phyper(q=q, m=m, n=n, k=k)

##### 3 #####
prob.fail <- function(t){
  return(exp(5.085 - 0.1156 * t)/(1+exp(5.085-0.1156 * t)))
}

##### 3.a #####
pbinom(0, 6, prob.fail(81))

##### 3.b #####A?
pbinom(0, 6, prob.fail(31))

##### 3.c #####
prob.no.failures <- pbinom(0, 6, prob.fail(81))
pbinom(0, 23, 1 - prob.no.failures)

##### 3.d #####
temperature <- 81:31
81 - min(which(sapply(81:31, function(x) pbinom(0,6, prob.fail(x))) < .50))
