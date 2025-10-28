N <- sample(10000:15999,1)

o1 <- sample(1:6,N, replace = T)
o2 <- sample(1:6,N, replace = T)

M <- cbind(o1,o2)

s <- rowSums(M)

est <- mean(s==10)

eq10 <- sum(s == 10)

exact <- eq10 / N

result <- c(estimate = est , exact = exact)
result