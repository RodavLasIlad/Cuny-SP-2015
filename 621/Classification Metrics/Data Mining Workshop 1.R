folder <- "C:\\Users\\Brett\\Dropbox\\CUNY\\621\\Classification Metrics\\"
pregnancy <- read.csv(paste0(folder, "classification-output.csv"))

##### 2 #####
confMat <- table(pregnancy$class, pregnancy$Scored.Labels)

##### 3 #####
genConfMat <- function(df, actual, predicted){
  confMat <- matrix(table(df[,actual], df[,predicted]), ncol=2, nrow=2)
  retDf <- data.frame(matrix(ncol = 4, nrow=1))
  names(retDf) <- c("tn", "fp", "fn", "tp")
  retDf$tn <- confMat[1,1]
  retDf$fp <- confMat[1,2]
  retDf$fn <- confMat[2,1]
  retDf$tp <- confMat[2,2]
  return(retDf)
}

accuracy <- function(df, actual, predicted){
  confDf <- genConfMat(df, actual, predicted)
  acc <- (confDf$tp + confDf$tn)/sum(confDf)
  return(acc)
}
accuracy(pregnancy, 9, 10)

##### 4 #####
error.rate <- function(df, actual, predicted){
  confDf <- genConfMat(df, actual, predicted)
  er <- (confDf$fp + confDf$fn)/sum(confDf)
  return(er)
}
error.rate(pregnancy, 9, 10)

##### 5 #####
precision <- function(df, actual, predicted){
  confDf <- genConfMat(df, actual, predicted)
  pr <- confDf$tp/(confDf$tp + confDf$fp)
  return(pr)
}
precision(pregnancy, 9, 10)

##### 6 #####
recall <- function(df, actual, predicted){
  confDf <- genConfMat(df, actual, predicted)
  re <- confDf$tp/(confDf$tp + confDf$fn)
  return(re)
}
recall(pregnancy, 9, 10)


##### 7 #####
specificity <- function(df, actual, predicted){
  confDf <- genConfMat(df, actual, predicted)
  sp <- confDf$tn/(confDf$tn + confDf$fp)
  return(sp)
}
specificity(pregnancy, 9, 10)


##### 8 #####
f.one <- function(df, actual, predicted){
  pr <- precision(df, actual, predicted)
  re <- recall(df, actual, predicted)
  return((2 * pr * re)/(pr + re))
}
f.one(pregnancy, 9, 10)

##### 9 #####


##### 10 #####
calc.auc <- function(dat){
  auc <- 0
  dat <- dat[order(dat$FPRate),]
  for(row in 1:(nrow(dat) - 1)){
    width <- dat[row + 1, 1] - dat[row, 1]
    height1 <- dat[row, 2]
    height2 <- dat[row + 1, 2]
    nmean <- (width * (height1 + height2)) / 2
    auc <- auc + nmean
  }
  return(auc)
}

roc.curve <- function(classifications, predprob){
  require(ggplot2)
  tempVec <- (1:100) * 0.01
  rocData <- data.frame(matrix(ncol = 2, nrow=0))
  for(i in tempVec){
    pred <- as.numeric(predprob > i)
    temp <- cbind(classifications, pred)
    tpr <- recall(temp, 1, 2)
    fpr <- 1 - specificity(temp, 1, 2)
    if(sum(pred) == 0){
      tpr <- 0
      fpr <- 0
    } else if(sum(pred) == length(pred)){
      tpr <- 1
      fpr <- 1
    }
    rocData <- rbind(rocData, c(fpr, tpr))
  }
  colnames(rocData) <- c("FPRate", "TPRate")
  p <- ggplot(rocData, aes(FPRate, TPRate)) + geom_point(color="blue") + geom_line(color="blue") + ylim(0,1) + xlim(0,1)
  p
  auc <- calc.auc(rocData)
  return(list(as.vector(auc), p))
}
roc.curve(pregnancy[,9], pregnancy[,11])

##### 11 #####
library(caret)
confusionMatrix(pregnancy$Scored.Labels, pregnancy$class)
sensitivity(as.factor(pregnancy$class), as.factor(pregnancy$Scored.Labels))
specificity(as.factor(pregnancy$Scored.Labels), as.factor(pregnancy$class))

##### 12 #####
myRoc <- roc(response=pregnancy$class, predictor=pregnancy$Scored.Labels)
myRoc
plot(myRoc)
