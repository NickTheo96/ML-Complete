data <- as.matrix(read.csv("iris.txt",header=FALSE))   # iris or ionosphere
number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
trainlength <- 70     # the size of the training set (70 or 200)
testlength = number_of_observations - trainlength
predicted.Y <-matrix(0,nrow =testlength, ncol=1)

trainObjects <- data[1:trainlength,1:number_of_attributes]
trainLabels <- data[1:trainlength,number_of_attributes+1]

testObjects <- data[(trainlength+1):number_of_observations,1:number_of_attributes]
testLabels <- matrix(data[(trainlength+1):number_of_observations,number_of_attributes+1])


for (i in 1:number_of_attributes){
mean.minus1 <- mean(trainObjects[(testLabels==-1),i])
mean.1 <- mean(trainObjects[(testLabels==1),i])
st.dev <- sd(trainObjects[,i])

cat("The difference in mean over standard deviation for the", i, "th atrrubute is", (mean.1-mean.minus1)/st.dev ,"\n")
}
#consider the second attribute as it has the largest change in mean over standard deviation

minuscounter=0
pluscounter=0

for (i in 1:trainlength)
{
  if(trainLabels[i]==-1)
    {
      minuscounter=minuscounter+1
  }
  if(trainLabels[i]==1)
  {
    pluscounter = pluscounter+1
  }
}

pi_minus1 = minuscounter/trainlength
pi_plus1 = pluscounter/trainlength
sum_2nd_attribute_minus=0
sum_2nd_attribute_plus=0

for (i in 1:trainlength)
{
  if(trainLabels[i]==-1)
  {
  sum_2nd_attribute_minus= trainObjects[i,2] + sum_2nd_attribute_minus
  }
  if(trainLabels[i]==1)
  {
    sum_2nd_attribute_plus= trainObjects[i,2] + sum_2nd_attribute_plus 
  }
}
mu_minus1=0
mu_plus1=0 

mu_minus1 = sum_2nd_attribute_minus/minuscounter
mu_plus1 = sum_2nd_attribute_plus/pluscounter

difference_minus_and_mean_squared = 0
difference_plus_and_mean_squared = 0

for (i in 1:trainlength)
{
  difference_minus_and_mean_squared=difference_minus_and_mean_squared+(trainObjects[i,2]-mu_minus1)^2
  difference_plus_and_mean_squared=difference_plus_and_mean_squared+(trainObjects[i,2]-mu_plus1)^2
}

sigma_minus1sq=difference_minus_and_mean_squared/(minuscounter-1)
sigma_plus1sq=difference_plus_and_mean_squared/(pluscounter-1)

delta_matrix <- matrix(0,nrow=testlength,ncol=2)

for(i in 1:testlength)
{
  delta_matrix[i,1]=(-(1/2)*log(sigma_minus1sq^2))-(1/(2*(sigma_minus1sq^2))*(testObjects[i,2]-mu_minus1)^2)+log(pi_minus1)
  delta_matrix[i,2]=(-(1/2)*log(sigma_plus1sq^2))-(1/(2*(sigma_plus1sq^2))*(testObjects[i,2]-mu_plus1)^2)+log(pi_plus1)
}

for(i in 1:testlength)
{
  if(delta_matrix[i,1]>delta_matrix[i,2])
  {
    predicted.Y[i]=-1
  }
  if(delta_matrix[i,1]<delta_matrix[i,2])
  {
    predicted.Y[i]=1
  }
}

confusionmatrix <- matrix(c(0,0,0,0),nrow = 2, ncol=2)

for (i in 1:testlength)
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



