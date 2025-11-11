# Parameter
p <- 0.3       # Erfolgswahrscheinlichkeit
n <- 1e6       # Anzahl der Simulationen

# Simulation: Z ~ Geometric(p), mit Werten {1, 2, 3, ...}
Z <- rgeom(n, p) + 1

# Gesuchte Wahrscheinlichkeit: P(5 <= Z <= 9)
prob_est <- mean(Z >= 5 & Z <= 9)
prob_est
