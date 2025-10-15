x <- c(1:8)

#Average
m <- mean(x)
#The average, also known as the mean, is a measure of central tendency. It is calculated by dividing the sum of all data points by the total number of data points. To compute the average of values, R provides a pre-defined function mean(). 
#This function takes a Numerical Vector as an argument and results in the average/mean of that Vector.

# Variance
v <- var(x)
#Variance measures how far each number in the set is from the mean. 
#It is the average of the squared differences from the Mean. We can calculate the variance by using var() function in R.

# Standard Deviation
sd <- sd(x)
#Standard Deviation is the square root of variance. 
#It is a measure of the extent to which data varies from the mean. One can calculate the standard deviation by using sd() function in R.

#logical vector
lv <- x%%2 == 0

#returns modulus and compares if it is equal 0