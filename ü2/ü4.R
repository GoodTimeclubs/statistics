#5 aus 52

#wahrscheinlichkeit von 4 assen und ein pik-könig

#Kombination kann genau einmal vorkommen
deck <- 52
cards <- 5

# (a) Vier Asse und der Pik-König
a_part <- choose(deck,cards)
a_prop <- 1/a_part

# (b) Nur Pik-Karten (alle 5 Karten aus 13 Pik-Karten)
amm_spakes <- 52 / 4
b_gueldische_decks <- floor(amm_spakes / 5)
b_prop = b_gueldische_decks / deck

# (c) Keine Paare (alle Werte distinct)
c_gueldische_decks =  choose(13, 5) * 4^5  # 5 Werte aus 13, jede in 4 Farben
c_prop = c_gueldische_decks / deck

# (d) Full House (drei Karten eines Werts, zwei eines anderen)
d_favorable <- choose(13, 1) * choose(4, 3) * choose(12, 1) * choose(4, 2)
d_prob <- d_favorable / total_hands

# Ergebnisse anzeigen
list(a = a_prob, b = b_prob, c = c_prob, d = d_prob)