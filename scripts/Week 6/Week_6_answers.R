library(ISLR)
library(glmnet)

#help(College)
#fix(College)

College <- na.omit(College)

levels(College[,1])[1] <- 0
levels(College[,1])[2] <- 1

x <- model.matrix(Apps~.,College)[,-1]
y <- College$Apps

set.seed(0)
train <- sample(1:nrow(x),500)
test <- (-train)
y.test <- y[test]


#linear model using least squares on the training set 
ls.fit<-lm(Apps~.,College)
y.hat <- predict(ls.fit,College[test,-Apps])
mean((y.hat-y[test])^2)#test set MSE obtained

#Ridge regression model fitted
set.seed(0)
cv.out <- cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)
best.lambda <- cv.out$lambda.min
best.lambda
rr.pred <- predict(rr.fit,s=best.lambda,newx=x[test,])
mean((rr.pred-y.test)^2)

#lasso 
lasso.fit <- glmnet(x[train,],y[train],alpha=1,lambda=grid)
plot(lasso.fit)
set.seed(0)
cv.out <- cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
best.lambda <- cv.out$lambda.min
lasso.pred <- predict(lasso.fit,s=best.lambda,newx=x[test,])
mean((lasso.pred-y.test)^2)

out <- glmnet(x,y,alpha=1,lambda=grid)
lasso.coef <- predict(out,type="coefficients",s=best.lambda)[1:18,]
lasso.coef

#accuracy is quite low, around 1000. As expected, ridge regression gives best results, and the lasso worst.