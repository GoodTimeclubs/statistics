# ============================================================
# Exercise 2.4.5 — Find c so that f(x) is a valid density
# ============================================================

# Ziel: Bestimme c so, dass ∫_0^1 f(x) dx = 1
# Wir machen das per Monte-Carlo-Simulation.

# Anzahl der Zufallswerte für die Approximation
n <- 1e6

# Zufällige x-Werte gleichverteilt auf (0,1)
x <- runif(n, min = 0, max = 1)

# ============================================================
# (a) Fall 1: f(x) = c * x
# ============================================================

# Wir schätzen das Integral von x über (0,1) mit Mittelwertmethode:
# ∫_0^1 x dx ≈ mean(x)
mean_x <- mean(x)

# Wir wollen, dass 1 = c * ∫_0^1 x dx  →  c = 1 / ∫_0^1 x dx
c1_est <- 1 / mean_x

cat("Fall 1: f(x) = c * x\n")
cat("Geschätztes c ≈", c1_est, "\n")

# Zum Vergleich: theoretisch ∫_0^1 x dx = 1/2  →  c = 2
cat("Theoretisch: c = 2\n\n")


# ============================================================
# (b) Fall 2: f(x) = c * x^n   (mit n > -1)
# ============================================================

# Wir wählen einen Beispielwert für n
n_val <- 3   # z. B. n = 3

# Integral von x^n über (0,1) wird simuliert durch mean(x^n)
mean_xn <- mean(x^n_val)

# Bedingung: 1 = c * ∫_0^1 x^n dx → c = 1 / ∫_0^1 x^n dx
c2_est <- 1 / mean_xn

cat("Fall 2: f(x) = c * x^n mit n =", n_val, "\n")
cat("Geschätztes c ≈", c2_est, "\n")

# Theoretisch: ∫_0^1 x^n dx = 1/(n+1) → c = n+1
cat("Theoretisch: c =", n_val + 1, "\n")
