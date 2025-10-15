#Create a 3×3 matrix M filled by rows with the numbers 1 to 9. Compute:
 
M <- matrix(1:9, nrow = 3, ncol = 3) 

M %*% t(M) #inverts the matrix and creates a sum with the normal matrix

sum(M[,1])
sum(M[,2])
sum(M[,3])

mean(M[1,])
mean(M[2,])
mean(M[3,])

two <- M[,2]

M[3,3] <- 0