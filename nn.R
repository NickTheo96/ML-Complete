#Need to run the setwd()code to set to a folder that has the dataset data set inside it
#source... may be run in a terminal to run the code

# setwd("C:/Users/Nick/Google Drive/Free Time/CS3920_CS4920_CS5920 Machine Learning/Assignment 1/My work")
# source("nn.R")
# setwd("/Users/nick/R/Assignment1")

#Load in the data set, no header, na strings just incase there are missing values
dataset <- read.csv("ionosphere.txt",header=F, na.strings="?")

trainlength =200#this must be specified by the user
#Initialise the values 
number_of_attributes = dim(dataset)[2]-1
EuclidSqSum=0
EuclidSq=0
testlength = dim(dataset)[1]-trainlength
K_number_n_n=3
sumclassificationelement=0
pluscounter=0
minuscounter=0

#Initialise the matrices
train.X <- matrix(nrow =trainlength, ncol=number_of_attributes)
test.X <- matrix(nrow =testlength, ncol=number_of_attributes)
predicted.Y <-matrix(nrow =testlength, ncol=1)
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

#nested for loop that countes the number of plus and minus in the knnelement matrix for each column and then assignes a classification based on
for(j in 1:testlength)#which ever scores higher 
  {
    for (i in 1:K_number_n_n)
      {
        if(train.Y[knnelements[i,j]]==1)
          {
            pluscounter = pluscounter +1#counts the number of +1 classification for each nearest number
          }
        else if(train.Y[knnelements[i,j]]==-1)
          {
            minuscounter = minuscounter +1
          }
        else
          {
            print ("Please pick an odd number for k")#accounts for any errors that might arrise when an even k is chosen
          }
      }
  if (minuscounter > pluscounter)#decides if the predicted.Y classification should be either plus or minus 1 using the outer loop
    {
      predicted.Y[j]=-1
    }
      else if(minuscounter < pluscounter)
    {
      predicted.Y[j]=+1
    }
  minuscounter=0#resets the counter after the inner loop is performed
  pluscounter=0
}


#confusionmatrix {(a,b),(c,d)} where a= # predicted = -1 and test =-1, d = # predicted = 1 and test = 1, c = #predicted = 1 and test = -1
#b = #predicted -1 and test = 1
for (i in 1:testlength)
  {
    if(predicted.Y[i]==-1)
      {
        if(test.Y[i]==-1)
          {
            confusionmatrix[1,1]=confusionmatrix[1,1]+1
          }
        else if(test.Y[i]==1)
          {
            confusionmatrix[1,2]=confusionmatrix[1,2]+1
          }
      }
    else if(predicted.Y[i]==1)
      {
        if(test.Y[i]==1)
          {
            confusionmatrix[2,2]=confusionmatrix[2,2]+1
          }
        else if(test.Y[i]==-1)
          {
            confusionmatrix[2,1]=confusionmatrix[2,1]+1
          }
      }
}

##########knn built into R can be used to test whether my code works
#library(class)
#predicted.Y <- knn(train.X,test.X,train.Y,k=3)
#table(predicted.Y,test.Y)
########




