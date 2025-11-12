#Binominial = zwei outcomes und mit zurücklegen

# wahrscheinlichkeit das wir möglichst oft 11 mal den korb bei 12 würfen treffeb
# p s in vektor in 0.0er schritten
grid <- seq(0,1,0.01)
#Pro p werden nrep Zahlen erstellt
nrep <- 20000

p11_est <- numeric(length(grid))

for (i in seq_along(grid)){ # für alle im Grid
  x <- rbinom (nrep, size = 12, prob = grid[i])
  p11_est[i] <- mean(x == 11)
}

imax <- which.max(p11_est)

data.frame(p_grid = grid[imax], P_Xeq11_est = p11_est[imax])

plot(p11_est)