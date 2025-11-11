# ============================================================
# Exercise 2.4.3 — U ~ Uniform[0, 1]
# Ziel: Schätze Wahrscheinlichkeiten durch Simulation
# ============================================================

# 1. Setze die Anzahl der Simulationen (je mehr, desto genauer)
n <- 1e6  # 1 Million Zufallswerte

# 2. Generiere n Zufallszahlen gleichverteilt auf [0, 1]
U <- runif(n, min = 0, max = 1)

# ============================================================
# 3. Berechne die Wahrscheinlichkeiten durch Simulation
# ============================================================

# P(U ≤ 1/2):
# Wir zählen, wie viele simulierte Werte kleiner oder gleich 0.5 sind
# und teilen durch die Gesamtanzahl der Simulationen.
p1 <- mean(U <= 1/2)

# P(U ∈ [1/3, 2/3]):
# Wir prüfen, wie viele Werte im Intervall [1/3, 2/3] liegen
p2 <- mean(U >= 1/3 & U <= 2/3)

# P(U = 1):
# Bei einer stetigen Verteilung (wie Uniform[0,1]) ist P(U=1) theoretisch 0.
# In der Simulation ist es praktisch fast nie der Fall, dass U genau 1 ist.
p3 <- mean(U == 1)

# ============================================================
# 4. Ausgabe der Resultate
# ============================================================

cat("P(U ≤ 1/2)  ≈", p1, "\n")
cat("P(U ∈ [1/3, 2/3]) ≈", p2, "\n")
cat("P(U = 1)    ≈", p3, "\n")

# ============================================================
# 5. Theoretische Werte zum Vergleich
# ============================================================

# Für die Uniform[0,1]-Verteilung gilt:
# P(U ≤ x) = x  für 0 ≤ x ≤ 1
# Daher:
# P(U ≤ 1/2) = 0.5
# P(U ∈ [1/3, 2/3]) = 2/3 - 1/3 = 1/3 ≈ 0.3333
# P(U = 1) = 0

cat("\nTheoretische Werte:\n")
cat("P(U ≤ 1/2)  = 0.5\n")
cat("P(U ∈ [1/3, 2/3]) = 1/3 ≈ 0.3333\n")
cat("P(U = 1)    = 0\n")
