data.train <- maml.mapInputPort(1)
data.test <- maml.mapInputPort(2)


k.near.neighbors <- function(unclassified, points){
  point.classification <- points[,4]
  points <- points[,1:3]
  classifications <- array(data = 0, dim = nrow(unclassified))
  k <- 3
  for(row in 1:nrow(unclassified)){
    unclassified[row,]
    distances <- data.frame(matrix(data=0, ncol=1, nrow=nrow(points)))
    for(point in 1:nrow(points)){
      distances[point,1] <- sum((points[point,] - unclassified[row,])^2)
    }
    knns <- order(distances, decreasing=F)[1:k]
    classifications[row] <- names(which.max(table(point.classification[knns])))
  }
  return(cbind(unclassified, classifications))
}

classifs <- k.near.neighbors(data.test[,1:3], data.train)

maml.mapOutputPort('classifs')