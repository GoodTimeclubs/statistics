# ============================================================
# Exercise 2.4.4 — Z ~ Exponential(4)
# Ziel: Schätze P(Z > 5) und P(2 < Z ≤ 5) durch Simulation
# ============================================================

# 1. Anzahl der Zufallswerte (je größer, desto genauer)
n <- 1e6  # 1 Million Simulationen

# 2. Rateparameter λ = 4
lambda <- 4

# 3. Generiere n Zufallszahlen aus einer Exponentialverteilung
# In R: rexp(n, rate = λ)
Z <- rexp(n, rate = lambda)

# ============================================================
# 4. Simuliere die gewünschten Wahrscheinlichkeiten
# ============================================================

# P(Z > 5): Anteil der Werte, die größer als 5 sind
p1 <- mean(Z > 5)

# P(2 < Z ≤ 5): Anteil der Werte zwischen 2 und 5
p2 <- mean(Z > 2 & Z <= 5)

# ============================================================
# 5. Ausgabe der Simulationsergebnisse
# ============================================================

cat("Simulierte Werte:\n")
cat("P(Z > 5)        ≈", p1, "\n")
cat("P(2 < Z ≤ 5)    ≈", p2, "\n")

# ============================================================
# 6. Theoretische Werte zum Vergleich
# ============================================================
# Für eine Exponentialverteilung mit Rate λ gilt:
#   P(Z > z) = exp(-λ * z)
#   P(a < Z ≤ b) = exp(-λ * a) - exp(-λ * b)

p1_theo <- exp(-lambda * 5)
p2_theo <- exp(-lambda * 2) - exp(-lambda * 5)

cat("\nTheoretische Werte:\n")
cat("P(Z > 5)        =", p1_theo, "\n")
cat("P(2 < Z ≤ 5)    =", p2_theo, "\n")
