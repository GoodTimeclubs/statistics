
N = 1000000

#Simuliere N faire würfe
die = sample (1:6, N , replace = TRUE)

#Zufallswert
X = die / 6

plot(ecdf(X), main = "Empirical CDF of  = (die outcome)/6")
