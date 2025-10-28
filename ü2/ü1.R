A0 <- character(0)
A1 <- c(1)
A2 <- c(2)
A3 <- c(3)
A4 <- c(1, 2)
A5 <- c(1, 3)
A6 <- c(2, 3)
A7 <- c(1,2,3)



subs <- list(A0,A1,A2,A3,A4,A5,A6,A7)

p <- c("1" = 1/2, "2" = 1/3, "3" = 1/6)

P_12 = sum(p[c("1","2")])

#→ wählt die Wahrscheinlichkeiten für die Ereignisse {1} und {2} aus.
#Ergibt also c(1/2, 1/3).

P_all <- sum(p)

vals <- c(sapply(subs, function(A) {
  if(length(A)>0){
    return(sum(p[A]))
  }
  if(length(A)==0){
    0
  }
}))

names(vals) <- sapply(subs, function(A) {
  if (length(A) == 0) {
    return("{}")
  } else {
    return(paste0("{", paste(A, collapse = ","), "}"))
  }
})

events_p_eq_half <- vals[(vals - 0.5 > 0 - 1e-12) & (vals - 0.5 < 0 + 1e-12)]

result <- list(
  P_12 = P_12,
  P_all = P_all,
  events_p_eq_half = events_p_eq_half
)

print(result)
