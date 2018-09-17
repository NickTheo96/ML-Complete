dyn.load("distance.c")
# tangent distance
distance <- function(imageOne,imageTwo) {
  out <- .C("distance",
    img1=as.double(imageOne),
    img2=as.double(imageTwo),
    dist=as.double(0))
  return(out$dist)
}
