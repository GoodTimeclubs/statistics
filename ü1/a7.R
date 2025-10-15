df <- data.frame(x = rnorm(10, 5, 2), y = rnorm(10, 10, 3)) #rnorm = random numbers drom a normal dirstribution (amount, mean, standard deviation(abweichung)) 

write.csv(df,file="C:\\Users\\bg\\OneDrive\\1_Studium\\statistik\\Übungen\\ü1\\test.csv", row.names=FALSE)

df2 <- read.csv("C:\\Users\\bg\\OneDrive\\1_Studium\\statistik\\Übungen\\ü1\\test.csv")

plot(df2)

#
abline(lm(y ~ x, data = df2)) # abline = Linie  |  lm = lineares Regressionsmodell mit 'x' als Prädiktor und 'y' als Antwortvariable anpassen
