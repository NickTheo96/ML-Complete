library(e1071)

set.seed(0)
x <- matrix(rnorm(20*2),ncol=2)
y <- c(rep(-1,10),rep(1,10))
x[y==1,] <- x[y==1,] + 1
plot(x,col=(3-y))

dat <- data.frame(x=x,y=as.factor(y))

svm.fit <- svm(y~.,data=dat,kernel="linear",cost=10,scale=FALSE)
#argument scale=FALSE tells the svm() function not to scale each attribute to have mean zero or standard deviation one
plot(svm.fit,dat)
svm.fit$index
summary(svm.fit)

#The e1071 library includes a built-in function, tune(), to perform cross- validation.

set.seed(0)
tune.out <- tune(svm,y~.,data=dat,kernel="linear", ranges=list(cost=c(0.001,0.01,0.1,1,5,10,100)))
summary(tune.out)

best <- tune.out$best.model
summary(best)




#First we generate a test set
x.test <- matrix(rnorm(20*2),ncol=2)
y.test <- sample(c(-1,1),20,rep=TRUE)
x.test[y.test==1,] <- x.test[y.test==1,] + 1
test.data <- data.frame(x=x.test,y=as.factor(y.test))
#Now we predict the class labels of these test observations. Here we use the best model obtained through cross-validation in order to make predictions:

y.pred <- predict(best,test.data)
table(predict=y.pred,truth=test.data$y)

#What if we had instead used cost = 0:01
svm.fit <- svm(y~.,data=dat,kernel="linear",cost =.01,scale=FALSE)
y.pred <- predict(svm.fit,test.data)
table(predict=y.pred,truth=test.data$y)

#non linear
set.seed(0)
x <- matrix(rnorm(200*2),ncol=2)
x[1:100,] <- x[1:100,] + 2
x[101:150,] <- x[101:150,] - 2
y <- c(rep(1,150),rep(2,50))
dat <- data.frame(x=x,y=as.factor(y))
plot(x,col=y)


#split the data randomly into training and test sets and then fit the training data using the svm() function with a radial kernel and gamma = 1:
train <- sample(200,100)
svm.fit <- svm(y~.,data=dat[train,],kernel="radial",gamma=1,cost=1)
plot(svm.fit,dat[train,])
summary(svm.fit)

set.seed(0)
tune.out <- tune(svm,y~.,data=dat[train,],kernel="radial", ranges = list(cost=c(0.1,1,10,100,1000),gamma = c(0.5,1,2,3,4)))
summary(tune.out)
table(true=dat[-train,"y"],pred=predict(tune.out$best.model, newx=dat[-train,]))


#SVM with multiple classes
set.seed(0)
x <- rbind(x,matrix(rnorm(50*2),ncol=2))
y <- c(y,rep(0,50))
x[y==0,2] <- x[y==0,2] + 2 
dat <- data.frame(x=x,y=as.factor(y))
plot(x,col=(y+1))
svm.fit <- svm(y~.,data=dat,kernel="radial",cost=10,gamma=1)
plot(svm.fit,dat)

