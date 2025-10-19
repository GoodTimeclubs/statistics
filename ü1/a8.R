#Write a function z_score(x) that returns standardized values (x - mean(x))/sd(x) but warns if sd(x) == 0. Apply it to c(5,5,5) and to c(1,2,3,4).

z_score <- function(x){
  
  if(sd(x) == 0){
    print("Warning! sd(x) is zero")
  }
  
  return((x - mean(x))/sd(x))
}

z_score(c(5,5,5))

z_score(c(1,2,3,4))