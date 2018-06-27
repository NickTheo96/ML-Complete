#Classification function

#dataset <- read.table("USPSsubset.txt",header=F, na.strings="?")

trainlength =9#this must be specified by the user

arr=c(6,10,5,4,9,120,4,6,10)

for(i in 1:i<9)
{
  for(j in 1:j<i)
  {
    if(arr[j] == arr[i])
    {
      break
    }
    if(i==j)
    {
      print(mylist[i])
    }
  }
}