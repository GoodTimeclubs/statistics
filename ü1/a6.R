M <- matrix(1:9, nrow = 3, ncol = 3)
x <- rnorm(5)  #random numbers die einer Normalverteilung folgen
t <- rep("BG",5) # BG 5 Mal wiederholen

thislist <- list(x=x,t=t,M=M) #Tag zuweisung für einfachen Zugriff

thislist


df <- data.frame(x,t)
#ohne Matrix, da diese mehr Einträge hat als die Vektoren
