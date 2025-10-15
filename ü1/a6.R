M <- matrix(1:9, nrow = 3, ncol = 3)
x <- rnorm(5)
t <- c("BG", "BG", "BG", "BG", "BG")

thislist <- list(x,t,M)

thislist


df <- data.frame(thislist)
