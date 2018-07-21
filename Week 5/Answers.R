library(leaps)

X = rnorm(100, mean = 0, sd = 1)
epsilon = rnorm(100, mean = 0, sd = 1)
Y=matrix(0,100,1)


for(i in 1:100)
{
  Y[i]=0.5+(0.6*X[i])+(0.7*(X[i]^2))+(0.8*(X[i]^3))+epsilon[i]
}

power = 3
X_power_matrix=matrix(0,100,power)

for(j in 1:100)
{
  for(i in 1:power)
  {
    X_power_matrix[j,i]=X[j]^i
  } 
}

dataset <- data.frame(Y,X_power_matrix)

regfit <-regsubsets(Y~.,data=dataset,nvmax=10)
reg.summary <- summary(regfit)
plot(1:10,reg.summary$bic,type="l")