data <- as.matrix(read.csv("iris.txt",header=FALSE))   # iris or ionosphere
number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
trainlength <- 70     # the size of the training set (70 or 200)
testlength = number_of_observations - trainlength#define testlength in terms of number of observations
predicted.Y <-matrix(0,nrow =testlength, ncol=1)#initialise the predicted.Y Matrix which will store the predicted values
#of the classification

trainObjects <- data[1:trainlength,1:number_of_attributes]#create the train matrix of attributes
trainLabels <- data[1:trainlength,number_of_attributes+1]#create the classification vector for the train data

testObjects <- data[(trainlength+1):number_of_observations,1:number_of_attributes]#create the test matrix of attributes
testLabels <- matrix(data[(trainlength+1):number_of_observations,number_of_attributes+1])#create the classification vector for test data

#initualise the minus and plus counters to find pi of plus one and minus one
minuscounter=0
pluscounter=0

for (i in 1:trainlength)
{
  if(trainLabels[i]==-1)
  {
    minuscounter=minuscounter+1#counts the number of minus classifications
  }
  if(trainLabels[i]==1)
  {
    pluscounter = pluscounter+1#counts the number of plus classifications
  }
}

pi_minus1 = minuscounter/trainlength#define the two pi needed for the delta matrix
pi_plus1 = pluscounter/trainlength

mu_minus <-matrix(0,nrow =1, ncol=number_of_attributes)
mu_plus <-matrix(0,nrow =1, ncol=number_of_attributes)

for(j in 1:number_of_attributes){
  for (i in 1:trainlength)#for loop to find the mean of both the plus one and minus one classification
  {
    if(trainLabels[i]==-1)#if the classification is minus one, then add the value to the summation of the mean of the minus class
    {
      mu_minus[1,j]= mu_minus[1,j] + trainObjects[i,j] 
    }
    if(trainLabels[i]==1)
    {
      mu_plus[1,j]= mu_plus[1,j]+ trainObjects[i,j] 
    }
  }
}

for(i in 1:number_of_attributes)
{
  mu_minus[1,i] = mu_minus[1,i]/minuscounter#define the means
  mu_plus[1,i] = mu_plus[1,i]/pluscounter
}

sigma_minus <-matrix(0,nrow =number_of_attributes, ncol=number_of_attributes)#initialise the minus sigma matrix
sigma_plus <-matrix(0,nrow =number_of_attributes, ncol=number_of_attributes)#initialise the minus sigma matrix

for(k in 1:trainlength)#triple nested for loop to find the sigma matrix
{
  for(j in 1:number_of_attributes)
  {
    for(l in 1:number_of_attributes)
    {
      if(trainLabels[k]==-1)#the equation depends on the mean of the classification
      {
        sigma_minus[l,j]=sigma_minus[l,j]+((trainObjects[k,l]-mu_minus[1,l])*(trainObjects[k,j]-mu_minus[1,j]))
      }
      if(trainLabels[k]==1)
      {
        sigma_plus[l,j]=sigma_plus[l,j]+((trainObjects[k,l]-mu_plus[1,l])*(trainObjects[k,j]-mu_plus[1,j]))
      }
    }
  }
}


sigma_minus <-(1/(minuscounter-1))*sigma_minus
sigma_plus <-(1/(pluscounter-1))*sigma_plus

mu_minus_column <-matrix(0,nrow =number_of_attributes, ncol=1)#initialise the column matrix equivalent of the mean vector
mu_plus_column <-matrix(0,nrow =number_of_attributes, ncol=1)

for(i in 1:number_of_attributes)#swap the indicies to create a colum matrix
{
  mu_minus_column[i,1]=mu_minus[1,i]
  mu_plus_column [i,1]=mu_plus[1,i]
}

testObjects_transpose <-matrix(0,nrow =number_of_attributes, ncol=trainlength)#transpose the x matrix in the formula
for(i in 1:number_of_attributes)
{
  for(j in 1:testlength)
  {
    testObjects_transpose[i,j]=testObjects[j,i]
  }
}

det_sigma_minus = det(sigma_minus)
det_sigma_plus = det(sigma_plus)

inverse_sigma_minus =solve(sigma_minus)#r function that finds the inverse of the matrix so that delta can be calculated 
inverse_sigma_plus = solve(sigma_plus)

delta_matrix <- matrix(0,nrow=testlength,ncol=2)#define a 2 by testlength matrix that stores the delta values for the two
#classifications so that they can be compared. 

for(i in 1:testlength)
{
  delta_matrix[i,1]=((-1/2)*log(abs(det_sigma_minus)))-((1/2)*testObjects[i,1:4]%*%inverse_sigma_minus%*%testObjects_transpose[1:4,i])+(testObjects[i,1:4]%*%inverse_sigma_minus%*%mu_minus_column)-((1/2)*mu_minus%*%inverse_sigma_minus%*%mu_minus_column)+log(pi_minus1)
  delta_matrix[i,2]=((-1/2)*log(abs(det_sigma_plus)))-((1/2)*testObjects[i,1:4]%*%inverse_sigma_plus%*%testObjects_transpose[1:4,i])+(testObjects[i,1:4]%*%inverse_sigma_plus%*%mu_plus_column)-((1/2)*mu_plus%*%inverse_sigma_plus%*%mu_plus_column)+log(pi_plus1)
}

for(i in 1:testlength)
{
  if(delta_matrix[i,1]>delta_matrix[i,2])#if the delta corresponnding to minus one is larger than the one correspinding to plus
    #one, then the predicted class will be minus one
  {
    predicted.Y[i]=-1
  }
  if(delta_matrix[i,1]<delta_matrix[i,2])
  {
    predicted.Y[i]=1
  }
}

confusionmatrix <- matrix(c(0,0,0,0),nrow = 2, ncol=2)#initialise the confusion matrix

for (i in 1:testlength)#inefficient nested for loop used to create the confusion matrix
{
  if(predicted.Y[i]==-1)
  {
    if(testLabels[i]==-1)
    {
      confusionmatrix[1,1]=confusionmatrix[1,1]+1
    }
    else if(testLabels[i]==1)
    {
      confusionmatrix[1,2]=confusionmatrix[1,2]+1
    }
  }
  else if(predicted.Y[i]==1)
  {
    if(testLabels[i]==1)
    {
      confusionmatrix[2,2]=confusionmatrix[2,2]+1
    }
    else if(testLabels[i]==-1)
    {
      confusionmatrix[2,1]=confusionmatrix[2,1]+1
    }
  }
}



