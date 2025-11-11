## ------------------------------------------------------------
## Aufgabe: X ~ Binomial(n = 12, p). Maximiere P(X = 11) via Simulation
## Vorgehen:
##  1) Erzeuge ein feines Gitter für p in [0, 1].
##  2) Für jedes p simuliere viele Binomial-Zufallsvariablen.
##  3) Schätze P(X = 11) als relative Häufigkeit.
##  4) Finde das p mit der größten geschätzten Wahrscheinlichkeit.
##  5) (Optional) Vergleich mit exakter Berechnung via dbinom.
## ------------------------------------------------------------

set.seed(42)                # Reproduzierbarkeit
n      <- 12                # Binomial-Parameter n
k      <- 11                # Wir interessieren uns für P(X = 11)
grid_p <- seq(0, 1, by = 0.001)  # p-Gitter (Schrittweite kann angepasst werden)
B      <- 20000             # Anzahl Simulationen pro p (größer => genauere Schätzung, aber langsamer)

## Speicher für die geschätzten Wahrscheinlichkeiten
p_hat <- numeric(length(grid_p))

## Haupt-Loop: für jedes p die Wahrscheinlichkeit P(X=11) schätzen
for (i in seq_along(grid_p)) {
  p <- grid_p[i]
  
  # Ziehe B Stichproben aus Binomial(n, p)
  # rbinom(B, n, p) liefert B Realisierungen
  x <- rbinom(B, size = n, prob = p)
  
  # Schätze P(X=11) als relative Häufigkeit von 11ern
  p_hat[i] <- mean(x == k)
}

## Finde das p mit maximaler geschätzter Wahrscheinlichkeit
imax <- which.max(p_hat)
p_max_sim <- grid_p[imax]
p_max_sim
# -> Das ist der (simulativ) gefundene Maximierer