##### 1 #####
library(ggplot2)
folder <- "C:\\Users\\Brett\\Dropbox\\CUNY\\621\\Classification Metrics\\"
pregnancy <- read.csv(file.path(folder, "classification-output.csv"))

# Get the total amount of positive values
baseline.event <- sum(pregnancy$class)

# Order the pregnancy data by the probabilities
pregnancy <- pregnancy[order(pregnancy$Scored.Probabilities, decreasing=TRUE),]

# Gives a vector of the correct.classification percentages
correct.classifications <- pregnancy$class/baseline.event

# Builds the cumulative classification--In hindsight I'm not sure why I took this approach to building it
cumul.classifications <- vector(length = length(correct.classifications))
cumul.sum <- 0
for(i in 1:length(correct.classifications)){
  cumul.sum <- cumul.sum + correct.classifications[i]
  cumul.classifications[i] <- cumul.sum
}

# Cumulative percent of the values gone through so far
to.combine <- (1:(length(correct.classifications)))/length(correct.classifications)
baseline <- data.frame(cbind(to.combine, to.combine))
names(baseline) <- c("x", "y")
lift.data <- data.frame(cbind(to.combine, cumul.classifications))

# The Plot
p <- ggplot() + 
  geom_point(data = lift.data, aes(to.combine, cumul.classifications), color="red") + 
  geom_line(data = lift.data, aes(to.combine, cumul.classifications),color="red") + 
  geom_point(data = baseline, aes(x, y), color="blue") + 
  geom_line(data = baseline, aes(x, y),color="blue") + 
  ylim(0,1) + 
  xlim(0,1) + 
  xlab("Percent of Data") + 
  ylab("Percent of Correct Classifications") +
  ggtitle("Lift Chart for Pregnancy Model")
  
p
# The warnings are simply from the repeat rows, which could be removed, but there is no need.

##### 2 #####
library(caret)
# This was a little annoying to figure out, until I realized that it confused my positive and negative classifications (hacky fix with the '1-')
lift1 <- lift(as.factor(1-pregnancy[,9]) ~ pregnancy[,11], data = data.frame(pregnancy[,10]))
xyplot(lift1, plot = "gain")
