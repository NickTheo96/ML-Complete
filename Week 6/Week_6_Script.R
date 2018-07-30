library(ISLR)
library(glmnet)

Hitters <- na.omit(Hitters)

x <- model.matrix(Salary~.,Hitters)[,-1]
y <- Hitters$Salary

grid <- 10^seq(10,-2,length=100)
rr.fit <- glmnet(x,y,alpha=0,lambda=grid)

dim(coef(rr.fit))

rr.fit$lambda[50]
coef(rr.fit)[,50]
sqrt(sum(coef(rr.fit)[-1,50]^2))