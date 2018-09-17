library(MASS)
attach(Boston)



Polyplot <- function(order)#function that plots an n order polynomial
{
  poly.fit <- lm(nox~poly(dis,order))
  
  dis.limits <- range(dis)
  
  dis.grid <- seq(from=dis.limits[1],to=dis.limits[2],by=0.01)
  preds <- predict(poly.fit,newdata=list(dis=dis.grid),se=TRUE)
  plot(dis,nox,xlim=dis.limits,col="darkgrey",main = paste0(main="Polynomial of order: ", order))
  lines(dis.grid,preds$fit,lwd=2,col="blue")
  
}

RSS <- function(order)#function that returns the RSS
{
  poly.fit <- lm(nox~poly(dis,order))
  preds <- predict(poly.fit)
  RSS <- sum((nox-preds)^2)
  return(RSS)
}

for(i in 1:10)
{
  Polyplot(i)
}

for(i in 1:10)
{
  cat("The RSS of the ",i,"th polynomial is ",RSS(i), "\n")
}

n <- length(dis) # the size of the training set
K <- 4 # the number of folds
MSE <- rep(0,10) # initializing the vector of MSEs
folds <- floor(K*runif(n))+1 # assigning data to folds

#perfroming cross validation
for (k in 1:K) 
  {# K-fold cross validation
    for (d in 1:10) 
      { # trying different degrees
        training <- Boston[folds!=k,]
        test <- Boston[folds==k,]
        fit <- lm(nox~poly(dis,d),data=training)
        pred <- predict(fit,newdata=list(dis=test$dis))
        MSE[d] <- MSE[d] + sum((test$nox-pred)^2)
      }
  }
print(MSE)

#fitting a spline
library(splines)
fit <- lm(nox~bs(dis))
dis.grid <- seq(from=dis.limits[1],to=dis.limits[2],by=0.01)
pred <- predict(fit,newdata=list(dis=dis.grid),se=T)
plot(dis,nox,col="gray")
lines(dis.grid,pred$fit,lwd=2)

RSS <- rep(0,20)
for (d in 4:20) 
  {
    poly.fit <- lm(nox~bs(dis,df=d))
    preds <- predict(poly.fit)
    RSS[d] <- sum((nox-preds)^2)
}

plot(4:20,RSS[4:20],type="l")

#cross-validation or another approach in order to select the best degrees of freedom
n <- length(dis) # the size of the data set
K <- 4 # the number of folds
MSE <- rep(0,20) # initializing MSE for df from 1 to 20
folds <- floor(K*runif(n))+1 # assigning data to folds
for (k in 1:K) 
  {# K-fold cross validation
    for (d in 4:20) 
      { # trying different numbers of df
        training <- Boston[folds!=k,]
        test <- Boston[folds==k,]
        fit <- lm(nox~bs(dis,df=d),data=training)
        pred <- predict(fit,newdata=list(dis=test$dis))
        MSE[d] <- MSE[d] + sum((test$nox-pred)^2)
      }
}

print(MSE[4:20])
#5 or 6 R degrees of freedom (corresponding to 2 or 3 knots) is the best choice.
