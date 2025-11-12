
#Uniform = jede Wahrscheinlichkeit von eienm ereignis ist gleich
#all outcomes are equally likely.

N = 100

U = runif(N)

p1 = mean (U <= 0.5)

p2 = mean (U >= 1/3 & U <= 2/3)

p3 = mean (U == 1)







