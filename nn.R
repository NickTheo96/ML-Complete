#Need to run the setwd()code to set to a folder that has the iris data set inside it
#source... may be run in a terminal to run the code

# setwd("C:/Users/Nick/Google Drive/Free Time/CS3920_CS4920_CS5920 Machine Learning/Assignment 1/My work")
# source("nn.R")
# setwd("/Users/nick/R/Assignment1")

#Load in the data set, no header, na strings just incase there are missing values
iris <- read.csv("iris.txt",header=F, na.strings="?")

trainlength =70#this must be specified by the user
#Initialise the values 
number_of_attributes = dim(iris)[2]-1
EuclidSqSum=0
EuclidSq=0
testlength = dim(iris)[1]-trainlength
K_number_n_n=3
sumclassificationelement=0
counter=0
percent_of_correct_predictions=0

#Initialise the matrices
train.X <- matrix(nrow =trainlength, ncol=number_of_attributes)
test.X <- matrix(nrow =testlength, ncol=number_of_attributes)
sumclassificationmatrix <-matrix(nrow =testlength, ncol=1)
EuclidianMatrix <- matrix(nrow = trainlength, ncol = testlength)
knnelements <- matrix(nrow = K_number_n_n, ncol = testlength)


#loop creating the train.X and test.X matrices
for(i in 1:number_of_attributes)
  {#train.X is to be a 4x70 matrix (in iris case), of the first 70 rows of the attributes the next 2 lines create this
    train.X[,i] <- matrix(iris[1:trainlength,i])#for loop to create each column of a given attribute first
    train.X <- cbind(train.X)#this bunds each column to creat a number_of_attributes by trainlength matrix
    #test.X is also created in this 4loop which has the dimensions of (dataset-trainlength) by number of attributes
    test.X[,i] <- matrix(iris[(trainlength+1):dim(iris)[1],i])
    test.X <- cbind(test.X)
  }

train.Y <- matrix(iris[1:trainlength,number_of_attributes+1])#create the train.Y and test.Y matrices
test.Y <- matrix(iris[(trainlength+1):dim(iris)[1],number_of_attributes+1])


#triplenested 4 loop to find the Euclidean distance for the first test data row
for (k in 1:testlength)#sums through the test data column by column
  {
    for (j in 1:trainlength)#sums through the train data column by column
      {
        for (i in 1:number_of_attributes)#sums through the train data rows to calculate each row euclidian distance
          {
            EuclidSq[i]=(train.X[j,i]-test.X[k,i])^2 #this calculated the distance square for each element
            EuclidSqSum=EuclidSqSum+EuclidSq[i] #sums the 4 distance square to get euclidian distance for the ith row in train.X
          } #put the Euclidiean distance into a matrix where the columns are each euclidian distance squared for a jth
            #train data for the kth test data. The rows are the kth test data euclidian distance
        EuclidianMatrix[j,k] <-matrix(EuclidSqSum) 
        EuclidSqSum=0 #set the sum back to zero so that the matrix doesnt add the previous element each time a new one is aded
      }

}

#nested 4loop that creates a matrix of the k nearest neighbours for each test data in the matrix knnelements
#each column is a column of nearest neighbours for the jth row in test.Y
for (j in 1:testlength)
  {
    for(i in 1:K_number_n_n)#sums through the nearest neighbour
      {#matrix that is ordered, i will later use my own algorithm to order it so that k nearest neighbours can be found
        knnelements[i,j] <- matrix(order(EuclidianMatrix[,j])[i])
      }
}

for (j in 1:testlength)#create a 1 by testlength matrix that has the  classification of each element
  {
    for (i in 1:K_number_n_n)
      {
        sumclassificationelement=sumclassificationelement+train.Y[knnelements[i,j]]#adds the knn columns to perform an average
        if (sumclassificationelement>0)#as the classification ia either p/m 1 this is a simple if statement that decidesif the 
          {#classification is either plus 1 or minus 1 after adding all the elements
            sumclassificationelement=1  
          }
        else if(sumclassificationelement<0)
          {
            sumclassificationelement=-1 
          }
        else#idealy a odd number is chosen for k such that the total is not 0 however if in an edge case an error is printed
          {
            print ("There is an error, there are the same amount of +1 and -1 classifications for the nearest neighbours")
          }
      }
    sumclassificationmatrix[j]<-matrix(sumclassificationelement)#puts all the values into a matrix
    sumclassificationelement=0#resets the counter for each iteration 
  }

for(i in 1:testlength)#for loop to compare my predicted results with test.Y
  {
    if (test.Y[i]==sumclassificationmatrix[i])#if statement to see if each element is the same
      {
        counter = counter +1#counts the number of correct predictions
      }
  }

percent_of_correct_predictions=(counter/testlength)*100
cat ("The percentage of correct predictions for k =",K_number_n_n, "is",percent_of_correct_predictions)
