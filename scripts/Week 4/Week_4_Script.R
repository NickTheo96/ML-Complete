data <- read.csv("parkinsons.data")
Y<- data[1:N,18]
X <- data[1:N,c(2:17,19:24)]

mean.0 <- mean(X[(Y==0),20])#for the 0 classification find the mean of the 20th column in X
mean.1 <- mean(X[(Y==1),20])#for the 1 classification find the mean of the 20th column in X
st.dev <- sd(X[,20])
(mean.1-mean.0)/st.dev

plot(X[(Y==0),19],X[(Y==0),22],type="p",col="red",xlab="19",ylab="22")
points(X[(Y==1),19],X[(Y==1),22],type="p",col="blue")