N = 1000000

mu = 1.2
sigma = 0.7
c_coef = -2
d_coef = 0.3

Xg = rnorm (N, mean = mu, sd = sigma)

Yg = c_coef * Xg * d_coef

c(sample_mean= mean(Yg), sample_var= var(Yg))

hist(Yg,breaks = 60, probability = T)
