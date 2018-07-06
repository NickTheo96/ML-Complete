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

sigma <-matrix(0,nrow =number_of_attributes, ncol=number_of_attributes)

for(k in 1:trainlength)
{
  for(j in 1:number_of_attributes)
  {
    for(l in 1:number_of_attributes)
    {
      if(trainLabels[k]==-1)
      {
        sigma[l,j]=sigma[l,j]+((trainObjects[k,l]-mu_minus[1,l])*(trainObjects[k,j]-mu_minus[1,j]))
      }
      if(trainLabels[k]==1)
      {
        sigma[l,j]=sigma[l,j]+((trainObjects[k,l]-mu_plus[1,l])*(trainObjects[k,j]-mu_plus[1,j]))
      }
    }
  }
}




