bbinu1 <- 2
bbinu2 <- 7
nsims <- 1000
all <- logical(0)
isu2 <- logical(0)

for (i in 1:bbinu1){
  all <- c(all,FALSE)
}

for (j in 1:bbinu2){
  all <- c(all,TRUE)
}

for(k in 1:nsims){
  if (all[sample(bbinu1+bbinu2,1)] == TRUE){
    isu2 <- c(isu2,TRUE)
  }else{
    isu2 <- c(isu2,FALSE)
  }
}

result <- mean(isu2)
result