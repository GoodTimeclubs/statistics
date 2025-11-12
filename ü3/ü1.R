nsamples <- 1000
Y <- c()
result <- c()


dice1 <- sample(6,nsamples, replace = TRUE)
dice2 <- sample(6,nsamples, replace = TRUE)
Y <- dice1 * dice2

counts <- table(Y)
totalcount <- length(counts)

pmf_hat <- sort(prop.table(counts))

highest <- tail(pmf_hat,1)
