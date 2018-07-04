data <- as.matrix(read.csv("iris.txt",header=FALSE))   # iris or ionosphere
number_of_attributes <- ncol(data)-1 # the number of attributes
number_of_observations <- nrow(data)   # the total number of observations
train_length <- 70     # the size of the training set (70 or 200)

trainObjects <- data[1:train_length,1:number_of_attributes]
trainLabels <- data[1:train_length,number_of_attributes+1]

testObjects <- data[(train_length+1):number_of_observations,1:number_of_attributes]
testLabels <- data[(train_length+1):number_of_observations,number_of_attributes+1]


for (i in 1:number_of_attributes){
mean.minus1 <- mean(trainObjects[(testLabels==-1),i])
mean.1 <- mean(trainObjects[(testLabels==1),i])
st.dev <- sd(trainObjects[,i])

cat("The difference in mean over standard deviation for the", i, "th atrrubute is", (mean.1-mean.minus1)/st.dev ,"\n")
}
#consider the second attribute as it has the largest change in mean over standard deviation

minuscounter=0
pluscounter=0

for (i in 1:train_length)
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

pi_minus1 = minuscounter/train_length
pi_plus1 = pluscounter/train_length
