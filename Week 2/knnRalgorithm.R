# setwd("/Users/nick/R/week2")
# source("knnRalgorithm.R")

iris <- read.table("iris.txt")

row1.train.X <- c(iris[1:70,1])
row2.train.X <- c(iris[1:70,2])
row3.train.X <- c(iris[1:70,3])
row4.train.X <- c(iris[1:70,4])

row1.test.X <- c(iris[71:100,1])
row2.test.X <- c(iris[71:100,2])
row3.test.X <- c(iris[71:100,3])
row4.test.X <- c(iris[71:100,4])

train.X <- cbind(row1.train.X,row2.train.X,row3.train.X,row4.train.X)
test.X <- cbind(row1.test.X,row2.test.X,row3.test.X,row4.test.X)
train.Y <- matrix(iris[1:70,5])
test.Y <- matrix(iris[71:100,5])

vector.train.Y = train.Y[,1]

library(class)
set.seed(0)
predicted.Y <- knn(train.X,test.X,vector.train.Y,k=1)

#table(predicted.Y,test.Y)