#5 aus 52

#wahrscheinlichkeit von 4 assen und ein pik-könig

#Kombination kann genau einmal vorkommen
deck <- 52
cards <- 5

a_part <- choose(deck,cards)
a_prop <- 1/a_part

amm_spakes <- 52 / 4
b_gueldische_decks <- floor(amm_spakes / 5)
b_prop = b_gueldische_decks / deck

c_gueldische_decks = #Anzahl decks ohne paare = gegenteil von Decks mit paaren

c_prop = c_gueldische_decks / deck