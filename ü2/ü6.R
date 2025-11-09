#Exercise 1.5.4. If you flip three fair coins, what is the probability that the first coin shows
#heads given that exactly two of the three coins are heads?

#1 = number , 2 = heads

getDice <- function(){
  throws = sample(2,3,replace=TRUE)
  if (sum(throws) == 5){
    return(throws)
  }else{
    getDice()
  }
}

nsims = 200000


isHead = logical(0)

for(i in 1:nsims){

  throws = getDice()
  
  if(throws[1] == 2){
    isHead = c(isHead,TRUE)
  }else{
    isHead = c(isHead,FALSE)
  }
  
  if (i %% 1000 == 0) print(i)
}

result = mean(isHead)

result