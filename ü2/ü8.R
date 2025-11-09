#init

nsims = 100000

A = logical(nsims)
C = logical(nsims)
ACSim = logical(nsims)



for(i in 1:nsims){
  redDice = sample(6, 1)
  blueDice = sample(6, 1)
  
  #A: equal numbers
  if (redDice == blueDice){
    A = c(A,TRUE)
  }else{
    A = c(A,FALSE)
  }
  
  #C: red die = 4
  if (redDice == 4){
    C = c(C,TRUE)
  }else{
    C = c(C,FALSE)
  }
  
  #Combined Sim
  if (redDice == blueDice && redDice == 4){
    ACSim = c(ACSim,TRUE)
  }else{
    ACSim = c(ACSim,FALSE)
  }

  if (i %% 1000 == 0) print(i)
}
#Combined calc

Seperated = mean(A) * mean(C)
Combined = mean(ACSim)

df = data.frame(Seperated, Combined)
df

if (Seperated != Combined){
  print("Not independent")
}else{
  print("independent")
}