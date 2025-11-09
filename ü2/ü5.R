birthday <- function(C,M){
  dup <- c()
  for(i in 1:M){
  v <- sample(365, C, replace = TRUE)
  d <- duplicated(v)
  dup <- c(dup,any(d))
  }
  return(mean(dup))
}

Ziehungen <- 1000
Anzahl <- 1000
out <- matrix(nrow = Anzahl, ncol = Ziehungen)
for(j in 1:Ziehungen){
  for(i in 1:Anzahl){
    out[i,j] <- birthday(i,j)
  }
}

means <- rowMeans(out)

crossover_index <- which(means >= 0.5)[1]

plot(1:Anzahl, means, 
     type = "l", 
     xlab = "Anzahl der Personen", 
     ylab = "Kollisionswahrscheinlichkeit",
     main = "Geburtstagsparadoxon")
abline(h = 0.5, col = "red", lty = 2)
abline(v = crossover_index, col = "blue", lty = 2)
points(crossover_index, 0.5, col = "blue", pch = 16)
legend("topleft", 
       legend = c("Mittlere Kollisionswahrscheinlichkeit", 
                  "50% Grenze", 
                  paste("Crossover bei", crossover_index, "Personen")),
       col = c("black", "red", "blue"),
       lty = c(1, 2, 2))