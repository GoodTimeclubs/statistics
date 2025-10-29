N <- 1e5

x <- sample(1:100,N)

estimate <- mean(x%%3==0 | x%%5==0)
