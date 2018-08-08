data <- as.matrix(read.csv("Advertising.csv",header=TRUE))  

number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
trainlength <- floor(dim(data)[1]*(2/3))     # the size of the training set (70 or 200)
testlength = number_of_observations - trainlength#define testlength in terms of number of observations
predicted.Y <-matrix(0,nrow =testlength, ncol=1)#initialise the predicted.Y Matrix which will store the predicted values
#of the classification

trainObjects <- data[1:trainlength,2:number_of_attributes]#create the train matrix of attributes
trainLabels <- t(matrix(data[1:trainlength,number_of_attributes+1]))#create the classification vector for the train data



testObjects <- data[(trainlength+1):number_of_observations,2:number_of_attributes]#create the test matrix of attributes
testLabels <- matrix(data[(trainlength+1):number_of_observations,number_of_attributes+1])#create the classification vector for test data

#1 create the K matrix
#2 normalise the K matrix
#3 create the k matrix which is a collection of all the ith k vectors corresponding to the ith column of the matrix
#4 normalise the k matrix

K_matrix=matrix(0, nrow = trainlength, ncol= trainlength)

for(k in 1:trainlength)
  {
    for(j in 1:trainlength)
      {
      for(i in 1:dim(trainObjects)[2])
        {
          K_matrix[j,k] = K_matrix[j,k] + trainObjects[j,i]*trainObjects[k,i]#finds the dot product of each element
        }
      K_matrix[j,k] = (K_matrix[j,k] +1)^2
      }
}

K_matrix_normalised=matrix(0, nrow = trainlength, ncol= trainlength)#need a new matrix otherwise the elements would update
#during the loop

for(k in 1:trainlength)#normalise the matrix in seperate loop after all the elements have been computed
  {
    for(j in 1:trainlength)
    {
      K_matrix_normalised[j,k] = K_matrix[j,k]/(sqrt(K_matrix[j,j])*sqrt(K_matrix[k,k]))
    }
}

#create a matrix k so that the ith column can later be used to find the expected value of y for each test object
k_matrix=matrix(0, nrow = trainlength, ncol= testlength)

for(k in 1:testlength)
  {
    for(j in 1:trainlength)
      {
        for(i in 1:dim(trainObjects)[2])
          {
            k_matrix[j,k]=k_matrix[j,k] + trainObjects[j,i]*testObjects[k,i]#creates un-normalised k matrix
          }
      }
  }

#create dot product of train objects for normalisation
K_dot=matrix(0, nrow = trainlength, ncol= 1)

for(j in 1:trainlength)
{
  for(i in 1:dim(trainObjects)[2])
  {
    K_dot[j]=K_dot[j]+ trainObjects[j,i]*trainObjects[j,i]
  }
}



#create dot product of test objects to later normalise
k_dot=matrix(0, nrow = testlength, ncol= 1)

for(j in 1:testlength)
{
  for(i in 1:dim(testObjects)[2])
  {
    k_dot[j]=k_dot[j]+ testObjects[j,i]*testObjects[j,i]
  }
}


#create a new normalized matrix k otherwise the loop would not work
k_matrix_normalised=matrix(0, nrow = trainlength, ncol= testlength)

for(k in 1:testlength)
  {
    for(j in 1:trainlength)
      {
      k_matrix_normalised[j,k]= k_matrix[j,k]/(sqrt(K_dot[j])*sqrt(k_dot[k]))
      }
  }

lambda_matrix = diag(trainlength)

for(i in 1:testlength)
  {
    predicted.Y[i] = trainLabels %*% solve(lambda_matrix + K_matrix_normalised) %*% k_matrix_normalised[,i]
  }


