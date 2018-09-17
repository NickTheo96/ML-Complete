# setwd("/Users/nick/R/week2")
# source("normalisation.R")

USPS <- read.table("USPS.txt")

minimum <- min(USPS[1,1:256])
maximum <- max(USPS[1,1:256])
first.image <- (USPS[1,1:256]-minimum) / (maximum-minimum)