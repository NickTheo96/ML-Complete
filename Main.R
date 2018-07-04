data <- as.matrix(read.csv("iris.txt",header=FALSE))   # iris or ionosphere
number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
train_length <- 70     # the size of the training set (70 or 200)
trainObjects <- data[1:train_length,1:number_of_attributes]
testObjects <- data[(train_length+1):number_of_observations,1:number_of_attributes]
trainLabels <- data[1:train_length,number_of_attributes+1]
testLabels <- data[(train_length+1):number_of_observations,number_of_attributes+1]