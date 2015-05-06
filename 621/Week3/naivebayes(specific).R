data.train <- maml.mapInputPort(1)
data.test <- maml.mapInputPort(2)

jury.public <- jury.public[complete.cases(jury.public),]

# Creates the weights for Naive Bayes as a list of lists
create.weights <- function(training.vars, var.interest){
  split.data <- split(training.vars, var.interest)
  weights <- list()
  for(i in names(split.data)){
    temp.total <- nrow(split.data[[i]])
    weights[[i]] <- list()
    for(j in colnames(split.data[[i]])){
      weights[[i]][[j]] <- table(split.data[[i]][[j]])/temp.total
    }
  }
  return(weights)
}

naive.bayes <- function(train.data, test.data){
  weights <- create.weights(train.data[,1:(ncol(train.data)-1)], train.data[ncol(train.data)])
  weighted.df <- data.frame(matrix(data = 0, ncol = length(weights) + 1, nrow = nrow(test.data)))
  colnames(weighted.df) <- c(names(weights), 'prediction')
  for(result in names(weights)){
    for(row in 1:nrow(test.data)){
      temp.total <- 1
      for(i in names(test.data)){
        temp.total <- temp.total * weights[[as.character(result)]][[i]][test.data[i][row,]]
      }
      weighted.df[as.character(result)][row,] <- temp.total
    }
  }
  for(row in 1:nrow(weighted.df)){
    weighted.df['prediction'][row,] <- names(which.max(weighted.df[row,1:(ncol(weighted.df)-1)]))
  }
  return(cbind(train.data, weighted.df['prediction']))
}

temp.test <- data.test[-4]

answer.set <- naive.bayes(data.train, temp.test)


maml.mapOutputPort('answer.set')