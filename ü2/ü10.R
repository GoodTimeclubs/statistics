#init
wstwin <- logical(0)
nsims <- 20000
for(i in 1:nsims){
  doors <- logical(3)
  doors[sample(3,1)] <- TRUE
  #Türen initialisierung mit einer Gewinnertür
  
  choosen <- sample(3,1)
  #Auswahl der Tür
  
  
  doorToOpen <- sample(3,1)
  while(doorToOpen == choosen || doors[doorToOpen] == TRUE){
    doorToOpen <- sample(3,1)
  }
  #Verlierertür durch Moderator geöffnet
  
  doors[doorToOpen] <- NA
  #geöffnete Tür entfernen
  
  #would a stay win
  if(doors[choosen] == TRUE){
    wstwin <- c(wstwin, TRUE)
  }else{
    wstwin <- c(wstwin, FALSE)
  }
}

result <- mean(wstwin)
result