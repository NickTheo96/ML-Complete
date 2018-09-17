
#function that plots x^2 for a user defined range
PlotPower <- function(x_0,x_f,a)
{
  x <-seq(x_0,x_f,length = 50)
  powerfunction <- x^a
  plot(x,powerfunction,main="x^a against x",xlab="x",ylab="x^a")
}
PlotPower(0,10,2)

sum2 <- function(n)
{
  result=0
  for(i in 1:n)
  {
    result = result +i^2
  }
  return (result)
}

sum3(3)