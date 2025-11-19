N = 1000000

L = -2
R = 5
c_coef = 1.5
d_coef = -0.25

Xu = runif(N, min = L, max = R)
Yt = c_coef * Xu + d_coef

hist(Yt)