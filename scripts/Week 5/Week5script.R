#install.packages('ISLR')
#install.packages('leaps')
library(ISLR)
library(leaps)
#??hitters
Hitters <- na.omit(Hitters)

regfit.full <- regsubsets(Salary~.,Hitters,nvmax=19)
reg.summary <- summary(regfit.full)
#summary(regfit.full)
#names(reg.summary)
#reg.summary$rsq

par(mfrow=c(2,2))
plot(reg.summary$rss,xlab="Number of attributes",ylab="RSS",type ="l")
plot(reg.summary$adjr2,xlab="Number of attributes",ylab ="Adjusted RSq",type="l")

which.max(reg.summary$adjr2)#red dot to indicate the model with the largest adjusted R2 statistic.
points(11,reg.summary$adjr2[11],col="red",cex=2,pch=20)
#In a similar fashion we can plot the Cp and BIC statistics, and indicate the models with the smallest statistic using which.min().

plot(reg.summary$cp,xlab="Number of attributes",ylab="Cp",type="l")
which.min(reg.summary$cp)
points(10,reg.summary$cp[10],col="red",cex=2,pch=20)
which.min(reg.summary$bic)
plot(reg.summary$bic,xlab="Number of attributes",ylab="BIC",type="l")
points(6,reg.summary$bic[6],col="red",cex=2,pch=20)

#coef(regfit.full,6)

#We can also use the regsubsets() function to perform forward stepwise or back-ward stepwise selection, using the 
#argument method="forward" or method="backward".

regfit.fwd <- regsubsets(Salary~.,data=Hitters,nvmax=19,method="forward")
summary(regfit.fwd)
regfit.bwd <- regsubsets(Salary~.,data=Hitters,nvmax=19,method="backward")
summary(regfit.bwd)



