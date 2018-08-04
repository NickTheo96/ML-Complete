data <- as.matrix(read.csv("Advertising.csv",header=TRUE))   

number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
trainlength <- floor(dim(data)[1]*(2/3))     # the size of the training set (70 or 200)
testlength = number_of_observations - trainlength#define testlength in terms of number of observations
predicted.Y <-matrix(0,nrow =testlength, ncol=1)#initialise the predicted.Y Matrix which will store the predicted values
#of the classification

trainObjects <- data[1:trainlength,2:number_of_attributes]#create the train matrix of attributes
trainLabels <- matrix(data[1:trainlength,number_of_attributes+1])#create the classification vector for the train data

testObjects <- data[(trainlength+1):number_of_observations,2:number_of_attributes]#create the test matrix of attributes
testLabels <- matrix(data[(trainlength+1):number_of_observations,number_of_attributes+1])#create the classification vector for test data
