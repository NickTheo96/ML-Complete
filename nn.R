#Need to run the setwd()code to set to a folder that has the dataset data set inside it
#source... may be run in a terminal to run the code

# setwd("C:/Users/Nick/Google Drive/Free Time/CS3920_CS4920_CS5920 Machine Learning/Assignment 1/My work")
# source("nn.R")
# setwd("/Users/nick/R/Assignment1")

#Load in the data set, no header, na strings just incase there are missing values
dataset <- read.csv("ionosphere.txt",header=F, na.strings="?")
#dataset <- read.table("USPSsubset.txt",header=F, na.strings="?")

trainlength =200#this must be specified by the user
#Initialise the values 
number_of_attributes = dim(dataset)[2]-1
EuclidSqSum=0
EuclidSq=0
testlength = dim(dataset)[1]-trainlength
K_number_n_n=3


#Initialise the matrices
train.X <- matrix(nrow =trainlength, ncol=number_of_attributes)
test.X <- matrix(nrow =testlength, ncol=number_of_attributes)
predicted.Y <-matrix(0,nrow =testlength, ncol=1)
EuclidianMatrix <- matrix(nrow = trainlength, ncol = testlength)
knnelements <- matrix(nrow = K_number_n_n, ncol = testlength)
confusionmatrix <- matrix(c(0,0,0,0),nrow = 2, ncol=2)

#loop creating the train.X and test.X matrices
for(i in 1:number_of_attributes)
{#train.X is to be a 4x70 matrix (in dataset case), of the first 70 rows of the attributes the next 2 lines create this
  train.X[,i] <- matrix(dataset[1:trainlength,i])#for loop to create each column of a given attribute first
  train.X <- cbind(train.X)#this bunds each column to creat a number_of_attributes by trainlength matrix
  #test.X is also created in this 4loop which has the dimensions of (dataset-trainlength) by number of attributes
  test.X[,i] <- matrix(dataset[(trainlength+1):dim(dataset)[1],i])
  test.X <- cbind(test.X)
}

train.Y <- matrix(dataset[1:trainlength,number_of_attributes+1])#create the train.Y and test.Y matrices
test.Y <- matrix(dataset[(trainlength+1):dim(dataset)[1],number_of_attributes+1])


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
  {#matrix that is ordered, i will later use my own algorithm to order it so that k nearest neighbours can be found!!!
    knnelements[i,j] <- matrix(order(EuclidianMatrix[,j])[i])
  }
}

#find the number of elements in train.Y which is how many classifications there are
#this can then be coded myself using a nested 4loop
classification_elements <-unique(train.Y)


####################################################Create code myself################################
#sortclassificationelements (should be implemented by myself later)
#this is used to compare knn elements to ensure 
sortclassification_elements <-sort(classification_elements)
#find number of classifications
number_of_classifications=length(classification_elements)
######################################################################################################

# numberofclassifaction by testlength matrix which will tally the predicted classification for each testset
counter <- matrix(0,nrow = number_of_classifications, ncol = testlength)


for(j in 1:testlength)#sums through each testset
  {
    for(i in 1:K_number_n_n)#sum through k
    {
      for(k in 1: number_of_classifications)
        {#the knnelement are summed through and the classification in train.Y is found, when this equals the
#kth classification element the if statement is met 
          if(train.Y[knnelements[i,j]]==sortclassification_elements[k])
          {
            counter[k,j]=counter[k,j]+1#this increments the kth classification of the jth testset by one to create a
#tally of the classifications for a give number of k
          }
        }
    }
}



for(j in 1:testlength)
  {
    max=counter[1,j]#initialise the first maximum value
    for(i in 2:number_of_classifications)#start looping from the second value
      {
        if(max<counter[i,j])#if the first value is less than the ith value
        {
          max=counter[i,j]#maximum value updated
          predicted.Y[j]=sortclassification_elements[i]#element this corersponds to also updated
        }
        else if(max==counter[1,j])#accounts for the first element being non zero and so needing to be modified
        {
          predicted.Y[j]=sortclassification_elements[1]#the first element is modified correctly
        }
      }
}
#####################################################################################################################
#predicted.Y works as intended however it does not acount for when the counter matrix predicts more than 1 value for
#the classification (will use k=1 for now) for the 9 classification set
#####################################################################################################################

confusionmatrix <- matrix(0,nrow = number_of_classifications, ncol=number_of_classifications)#initialise classification matrix

########################################Later implement myself#############################################################
#match(c(-1),sortclassification_elements) finds the index of -1 in the matrix sortclassification_elements 
#should later implement my own function
#####################################################################################################################
for(i in 1: testlength)
{
  
  confusionmatrix[match(c(predicted.Y[i]),sortclassification_elements),match(c(test.Y[i]),sortclassification_elements)]=confusionmatrix[match(c(predicted.Y[i]),sortclassification_elements),match(c(test.Y[i]),sortclassification_elements)] + 1
}



######################################### knn built into R can be used to test whether my code works########################
# library(class)
# predicted.Y <- knn(train.X,test.X,train.Y,k=3)
# table(predicted.Y,test.Y)
# # #########################################################################################################################




