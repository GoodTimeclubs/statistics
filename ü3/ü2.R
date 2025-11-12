# Parameter
p <- 0.3       # Erfolgswahrscheinlichkeit
n <- 1e6       # Anzahl der Simulationen

# Simulation: Z ~ Geometric(p), mit Werten {1, 2, 3, ...}
# ohne +1L anzahl der Nieten mit +1 Welches Los gewonnen hat nach nieten
Z <- rgeom(n, prob = p) + 1

# Gesuchte Wahrscheinlichkeit: P(5 <= Z <= 9)
prob_est <- mean(Z >= 5 & Z <= 9)
prob_est

#d____ = wahrscheinlich für genau X
#p_____ = <= X
#1-p____ = >= X

#biominialverteilung = mit wiederholung
#hypergometrisch = ohne wiedrholung