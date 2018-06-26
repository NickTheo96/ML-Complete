#Classification function

#dataset <- read.table("USPSsubset.txt",header=F, na.strings="?")

trainlength =9#this must be specified by the user

mylist=c(6,10,5,4,9,120,4,6,10)
classification=c()

for(i in 1:i<trainlength)
{
  for(j in 1:j<i)
  {
    if(mylist[j] == mylist[i])
    {
      break
    }
    if(i==j)
    {
      print(mylist[i])
    }
  }
}