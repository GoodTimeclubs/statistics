n <- 100
x <- rnorm(n) #100 verschiedene werte mit mean 0 und st 1 x = beobachtete werte
e <- rnorm(n) # e = noise
y <- 3 + 2*x + e
fit <- lm(y ~ x) # estimate y as a function of x
s <- summary(fit) #summary of the model
coef_est <- coef(fit)#intercept & slope
R2 <- s$r.squared#how well the model explains the data (X % of the var. can be explained by x)
RSE <- s$sigma
list(coef = round(coef_est, 3), R2 = round(R2, 3), RSE = round(RSE, 3))

plot(fitted(fit), resid(fit), pch = 19,
     xlab = "Fitted values", ylab = "Residuals", main = "Residuals vs Fitted")
abline(h = 0, lty = 2)