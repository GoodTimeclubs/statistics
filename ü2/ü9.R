#Urn filling
nBlue <- 12
nRed <- 8
total <- nBlue + nRed
nsims <- 2000

Urn <- logical(0)
check <- matrix(nrow=nsims, ncol=5)

for(i in 1:nBlue){
  Urn <- c(Urn, FALSE)
}
for(i in 1:nRed){
  Urn <- c(Urn, TRUE)
}

for(i in 1:nsims){

  draws = sample(20, 5, replace = FALSE)

  check[i,] = Urn[draws]

}

out = colMeans(check)

out