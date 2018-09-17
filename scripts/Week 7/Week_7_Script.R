library(gam)
library(ISLR)
attach(Wage)


#Polynomial regression and step functions
poly.fit <- lm(wage~poly(age,4),data=Wage)
coef(summary(poly.fit))

head(age)
head(poly(age,4,raw=T))

#several ways to fit the polynomial
poly.fit2 <- lm(wage~poly(age,4,raw=T),data=Wage)
coef(summary(poly.fit2))

poly.fit3 <- lm(wage~age+I(age^2)+I(age^3)+I(age^4),data=Wage)
coef(poly.fit3)

poly.fit4 <- lm(wage~cbind(age,age^2,age^3,age^4),data=Wage)

age.limits <- range(age)
age.grid <- seq(from=age.limits[1],to=age.limits[2])
preds <- predict(poly.fit,newdata=list(age=age.grid),se=TRUE)
se.bands <- cbind(preds$fit+2*preds$se.fit,preds$fit-2*preds$se.fit)

plot(age,wage,xlim=age.limits,col="darkgrey")
lines(age.grid,preds$fit,lwd=2,col="blue")
matlines(age.grid,se.bands,lwd=1,col="blue",lty=3)

help(lines)
help(matlines)

preds2 <- predict(poly.fit2,newdata=list(age=age.grid),se=TRUE)
max(abs(preds$fit-preds2$fit))

#Fitting wage to age using a regression spline

library(splines)
fit <- lm(wage~bs(age,knots=c(25,40,60)),data=Wage)
pred <- predict(fit,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred$fit,lwd=2)
lines(age.grid,pred$fit+2*pred$se,lty="dashed")
lines(age.grid,pred$fit-2*pred$se,lty="dashed")

dim(bs(age,knots=c(25,40,60)))
dim(bs(age,df=6))
attr(bs(age,df=6),"knots")

#In order to instead fit a natural spline, we use the ns() function. Here we fitt a natural spline with four degrees of freedom:


fit2 <- lm(wage~ns(age,df=4),data=Wage)
pred2 <- predict(fit2,newdata=list(age=age.grid),se=T)
lines(age.grid,pred2$fit,col="red",lwd=2)

#GAM
gam <- lm(wage~ns(year,4)+ns(age,5)+education,data=Wage)
plot.gam(gam,se=TRUE,col ="red")
preds <- predict(gam,newdata=Wage)






