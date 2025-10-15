sapply(mtcars, mean) 
#eine Funktion auf jedes Element einer Liste, eines Vektors oder eines Datenframes anwenden und als Ergebnis einen Vektor anstelle einer Liste erhalten möchten.


apply(mtcars, 2, quantile, probs = c(0.25, 0.75))

df <- data.frame(mtcars)