nsamples <- 1000
Y <- c()
result <- c()

for(i in 1:nsamples){
  dice1 <- sample(6,1)
  dice2 <- sample(6,1)
  Y <- c(Y,dice1 * dice2)
}
counts <- table(Y)
totalcount <- length(counts)

for (j in 1:totalcount){
  result <- c(result,counts[j]/nsamples)
}

result
barplot(result)

#check
sum(result)