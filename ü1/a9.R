sapply(mtcars, mean) 
#eine Funktion auf jedes Element einer Liste, eines Vektors oder eines Datenframes anwenden und als Ergebnis einen Vektor anstelle einer Liste erhalten möchten.


apply(mtcars, 2, quantile, probs = c(0.25, 0.75))

df <- data.frame(mtcars)

aggregate(. ~ cyl, data = mtcars, FUN = mean)

#Erklärung:
  
#  aggregate() ist eine Funktion zum Gruppieren und Anwenden von Operationen auf Datenrahmen.

#. bedeutet: alle numerischen Spalten außer der Gruppierungsvariable (cyl).

#~ cyl heißt: gruppiere nach der Spalte cyl.

#data = mtcars gibt den Datensatz an.

#FUN = mean bedeutet, dass für jede Spalte der Mittelwert berechnet wird.