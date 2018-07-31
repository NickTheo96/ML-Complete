library(leaps)
library(ISLR)
Hitters <- na.omit(Hitters)

X <- rnorm(100)
epsilon <- rnorm(100)
library(leaps)
beta0 <- 1
beta1 <- 2
beta2 <- -1
beta3 <- 1

Y <- beta0 + beta1*X + beta2*X^2 + beta3*X^3 + epsilon
dataset <- data.frame(Y,X,X^2,X^3,X^4,X^5,X^6,X^7,X^8,X^9,X^10)
regfit <-regsubsets(Y~.,data=dataset,nvmax=10)
reg.summary <- summary(regfit)
cat("Cp and AIC:")

# AIC is equivalent to C p (see the lecture)
print(reg.summary$cp)
cat("BIC:")
print(reg.summary$bic)
cat("AdjR2:")
print(reg.summary$adjr2)
cat("Minima:")
print(c(which.min(reg.summary$cp),
        which.min(reg.summary$bic),
        which.max(reg.summary$adjr2)))
plot(1:10,reg.summary$bic,type="l")

regfit.fwd <- regsubsets(Salary~.,data=Hitters,nvmax=19,method="forward")
summary(regfit.fwd)