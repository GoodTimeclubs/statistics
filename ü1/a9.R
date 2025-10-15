sapply(mtcars, mean) 
#eine Funktion auf jedes Element einer Liste, eines Vektors oder eines Datenframes anwenden und als Ergebnis einen Vektor anstelle einer Liste erhalten möchten.


checkvel <- function(x){
  tf <- sum(x == 0.25)
  sf <- sum(x == 0.75)

  return(c(tf,sf))
}

apply(mtcars, 2, quantile, probs = c(0.25, 0.75))