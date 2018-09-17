library(ISLR)
library(glmnet)

Hitters <- na.omit(Hitters)

x <- model.matrix(Salary~.,Hitters)[,-1]
y <- Hitters$Salary

grid <- 10^seq(10,-2,length=100)
rr.fit <- glmnet(x,y,alpha=0,lambda=grid)

dim(coef(rr.fit))

rr.fit$lambda[50]#These are the coeffcients when lambda = grid[50] is approximately 11; 498,
coef(rr.fit)[,50]
sqrt(sum(coef(rr.fit)[-1,50]^2))

rr.fit$lambda[60]
coef(rr.fit)[,60]

predict(rr.fit,s=50,type="coefficients")[1:20,]

set.seed(0)#We now split the observations into a training set and a test set, first setting a seed so that the results obtained will 
#be reproducible.
train <- sample(1:nrow(x),nrow(x)/2)
test <- (-train)
y.test <- y[test]

#fit a ridge regression model on the training set, and evaluate its MSE on the test set, using lambda = 4.
rr.fit <- glmnet(x[train,],y[train],alpha=0,lambda=grid)
rr.pred <- predict(rr.fit,s=4,newx=x[test,])
mean((rr.pred-y.test)^2)

rr.pred <- predict(rr.fit,s=1e10,newx=x[test,])
mean((rr.pred-y.test)^2)

#now check whether there isany benefit to performing ridge regression with lambda = 4 instead of just performing least squares regression.
#rr.pred <- predict(rr.fit,s=0,newx=x[test,],exact=T)
#mean((rr.pred-y.test)^2)
#lm(y~x,subset=train)
#predict(rr.fit,s=0,exact=T,type="coefficients")[1:20,]

#Instead of arbitrarily choosing lambda = 4, better to use cross-validation to choose lambda. Use built in function cv.glmnet()
set.seed(0)
cv.out <- cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)
best.lambda <- cv.out$lambda.min
best.lambda

#lasso - same glmnet() function but now instad set alpha=1
lasso.fit <- glmnet(x[train,],y[train],alpha=1,lambda=grid)
plot(lasso.fit)
#perform cross-validation and compute the associated test error.
set.seed(0)
cv.out <- cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
best.lambda <- cv.out$lambda.min
lasso.pred <- predict(lasso.fit,s=best.lambda,newx=x[test,])
mean((lasso.pred-y.test)^2)

out <- glmnet(x,y,alpha=1,lambda=grid)
lasso.coef <- predict(out,type="coefficients",s=best.lambda)[1:20,]
lasso.coef






