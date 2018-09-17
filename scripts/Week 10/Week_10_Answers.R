library(e1071)
library(ISLR)

help(OJ)


OJ <- na.omit(OJ)

x <- model.matrix(Purchase~.,OJ)[,-1]
y <- OJ$Purchase

# dat <- data.frame(x=x,y=as.factor(y))
# svm.fit <- svm(y~.,data=dat,kernel="linear",cost=10,scale=FALSE)
# plot(svm.fit,dat)




# 
# set.seed(0)
# x <- matrix(rnorm(20*2),ncol=2)
# y <- c(rep(-1,10),rep(1,10))
# x[y==1,] <- x[y==1,] + 1
# plot(x,col=(3-y))
# 
# dat <- data.frame(x=x,y=as.factor(y))