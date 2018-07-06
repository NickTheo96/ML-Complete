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


for (i in 1:number_of_attributes)#loop to find the change in mean over the standard deviation, the largest spread would be the 
  #most suitable
  {
    mean.minus1 <- mean(trainObjects[(testLabels==-1),i])#built in function to find the mean of the minus one class
    mean.1 <- mean(trainObjects[(testLabels==1),i])#built in function to find the mean of the plus one class
    st.dev <- sd(trainObjects[,i])#built in function to find the standar deviation
    cat("The difference in mean over standard deviation for the", i, "th atrrubute is", (mean.1-mean.minus1)/st.dev ,"\n")
  }
#consider the second attribute as it has the largest change in mean over standard deviation

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
sum_2nd_attribute_minus=0
sum_2nd_attribute_plus=0

for (i in 1:trainlength)#for loop to find the mean of both the plus one and minus one classification
{
  if(trainLabels[i]==-1)#if the classification is minus one, then add the value to the summation of the mean of the minus class
  {
  sum_2nd_attribute_minus= trainObjects[i,2] + sum_2nd_attribute_minus
  }
  if(trainLabels[i]==1)
  {
    sum_2nd_attribute_plus= trainObjects[i,2] + sum_2nd_attribute_plus 
  }
}
mu_minus1=0#initialise the means
mu_plus1=0 

mu_minus1 = sum_2nd_attribute_minus/minuscounter#define the means
mu_plus1 = sum_2nd_attribute_plus/pluscounter

sigma_sq_sum = 0#define the summation in the bracket to find sigma squared

for (i in 1:trainlength)
{
  {
    if(trainLabels[i]==-1)#if the label is minus one, then use the mean for the minus classification to add to the sum
    {
      sigma_sq_sum=sigma_sq_sum+(trainObjects[i,2]-mu_minus1)^2
    }
    if(trainLabels[i]==1)#if label plus one, then add to the plus class
    {
      sigma_sq_sum=sigma_sq_sum+(trainObjects[i,2]-mu_plus1)^2
    }
  }
}
sigma_sq=(1/(trainlength-2))*sigma_sq_sum#define sigma squared

delta_matrix <- matrix(0,nrow=testlength,ncol=2)#define a 2 by testlength matrix that stores the delta values for the two
#classifications so that they can be compared. 

for(i in 1:testlength)
{
  delta_matrix[i,1]=(-(1/2)*log(sigma_sq^2))-(1/(2*(sigma_sq^2))*(testObjects[i,2]-mu_minus1)^2)+log(pi_minus1)
  delta_matrix[i,2]=(-(1/2)*log(sigma_sq^2))-(1/(2*(sigma_sq^2))*(testObjects[i,2]-mu_plus1)^2)+log(pi_plus1)
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



