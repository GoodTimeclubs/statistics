lambda <- 4

#wahrscheinlichkeit das ereignis in 4 zeitabschnitten stattfindet
p_gt5 = mean (Z>5)

p2to5 = mean(Z>2 & Z <= 5)

#standardfehler des jewailigen schätzers
se_gt5 = sqrt(p_gt5*(1-p_gt5)/N)
se_2to5 = sqrt(p2to5*(1-p_qt5)/N)

