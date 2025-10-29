# Probability_models.R
# Abbildung der Vorlesungsinhalte "Probability Models" in R-Befehlen
# Sprache: Deutsch (Kommentare)

# ---- 1) Stichprobenraum (sample space) ----
Omega <- c("rain", "snow", "clear")  # Beispiel aus der Vorlesung: Wetter morgen

# Hilfsfunktion: alle Teilmengen (Potenzmenge) von Omega erzeugen
all_subsets <- function(universe) {
  n <- length(universe)
  # 0:(2^n -1) verwenden, binäre Auswahl
  subsets <- vector("list", 2^n)
  for(i in 0:(2^n - 1)) {
    choose_idx <- which(intToBits(i)[1:n] == as.raw(1))
    if(length(choose_idx) == 0) {
      subsets[[i+1]] <- character(0)  # leere Menge
    } else {
      subsets[[i+1]] <- universe[choose_idx]
    }
  }
  names(subsets) <- sapply(subsets, function(x) paste(sort(x), collapse = ","))
  return(subsets)
}

F <- all_subsets(Omega)  # im endlichen Fall: typischerweise die Potenzmenge
# Hinweis: In unendlichen Fällen braucht man eine σ-Algebra; hier ist F = 2^Ω.

# ---- 2) Mengenoperationen definieren ----
complement <- function(A, universe = Omega) {
  setdiff(universe, A)
}

union_sets <- function(...) {
  Reduce(union, list(...))
}

intersect_sets <- function(...) {
  Reduce(intersect, list(...))
}

set_equal <- function(A, B) {
  setequal(A, B)
}

# ---- 3) Prüffunktion: ist F eine σ-Algebra über Omega? (für endliches F) ----
is_sigma_algebra <- function(F_list, universe = Omega) {
  # 1) Omega in F?
  cond1 <- any(sapply(F_list, function(x) set_equal(x, universe)))
  # 2) Abschluss unter Komplement
  cond2 <- all(sapply(F_list, function(A) {
    any(sapply(F_list, function(B) set_equal(B, complement(A, universe))))
  }))
  # 3) Abschluss unter abzählbaren Vereinigungen -> im endlichen Fall genügt kombinatorisch:
  # Prüfe Vereinigung von beliebigen Elementen in F (alle Kombinationen)
  m <- length(F_list)
  cond3 <- TRUE
  # wir prüfen alle nicht-leeren Kombinationen von Indizes
  if(m > 0) {
    idx <- seq_len(m)
    # k von 1..m Kombinationen
    for(k in 1:m) {
      combs <- combn(idx, k, simplify = FALSE)
      for(cmb in combs) {
        U <- union_sets(F_list[[cmb[1]]], if(length(cmb) > 1) F_list[cmb[-1]] else character(0))
        # union_sets obiges nimmt list, daher vereinfachen:
        # hier einfacher: Reduce(union, selected)
        U <- Reduce(union, F_list[cmb])
        # prüfen ob U in F_list
        found <- any(sapply(F_list, function(X) set_equal(X, U)))
        if(!found) {
          cond3 <- FALSE
          break
        }
      }
      if(!cond3) break
    }
  }
  return(cond1 && cond2 && cond3)
}

cat("Ist F eine σ-Algebra über Omega? ", is_sigma_algebra(F, Omega), "\n")
# Erwartung: TRUE (da F = Potenzmenge)

# ---- 4) Wahrscheinlichkeitsmaß definieren (Probability measure) ----
# Wir definieren Wahrscheinlichkeiten auf den Atomen (Elementen von Omega).
# (Dies ist ein zulässiges Beispiel — in Vorlesung wurde das Prinzip erklärt.)
p_atoms <- c(rain = 1/3, snow = 1/3, clear = 1/3)  # einfache gleichverteilte Beispiel-Verteilung
stopifnot(abs(sum(p_atoms) - 1) < 1e-12)           # Prüfe: Summe = 1

# P(A) = Summe der Wahrscheinlichkeiten der Atome in A
P <- function(A) {
  # A kann ein Character-Vektor sein oder leere Menge
  if(length(A) == 0) return(0)
  # Fehlerbehandlung: Elemente außerhalb von Omega ignorieren oder Fehler?
  A_valid <- intersect(A, names(p_atoms))
  return(sum(p_atoms[A_valid]))
}

# ---- 5) Axiomprüfungen ----
# 1) 0 <= P(A) <= 1 für alle A in F
axiom1_all <- all(sapply(F, function(A) { v <- P(A); (v >= 0) && (v <= 1) }))
cat("Axiom 1 (0 <= P(A) <= 1) erfüllt für alle A?: ", axiom1_all, "\n")

# 2) P(empty set) == 0
axiom2 <- P(character(0)) == 0
cat("Axiom 2 (P(∅)=0) erfüllt?: ", axiom2, "\n")

# 3) P(Omega) == 1
axiom3 <- abs(P(Omega) - 1) < 1e-12
cat("Axiom 3 (P(Ω)=1) erfüllt?: ", axiom3, "\n")

# 4) Additivität: für disjunkte A1, A2, ... gilt P(∪ Ai) = sum P(Ai)
# Beispiel: A1 = {rain}, A2 = {snow}
A1 <- c("rain")
A2 <- c("snow")
disjoint_example <- length(intersect(A1, A2)) == 0
lhs <- P(union_sets(A1, A2))
rhs <- P(A1) + P(A2)
cat("Beispiel disjunkte Mengen: disjoint=", disjoint_example, 
    "  P(A1 ∪ A2)=", lhs, " sum=", rhs, "\n")

# allgemeiner Test: für alle Paare disjunkter Mengen in F überprüfen
test_additivity_pairs <- function(F_list) {
  m <- length(F_list)
  ok <- TRUE
  for(i in 1:m) {
    for(j in 1:m) {
      Ai <- F_list[[i]]; Aj <- F_list[[j]]
      if(length(intersect(Ai, Aj)) == 0) {
        if(abs(P(union_sets(Ai, Aj)) - (P(Ai) + P(Aj))) > 1e-12) {
          ok <- FALSE
          return(ok)
        }
      }
    }
  }
  return(ok)
}
cat("Additivität für disjunkte Paare in F erfüllt?: ", test_additivity_pairs(F), "\n")

# ---- 6) Venn-Operationen / nützliche Identitäten (De Morgan) ----
# De Morgan: (A ∪ B)^c = A^c ∩ B^c   und   (A ∩ B)^c = A^c ∪ B^c
A <- c("rain", "snow")
B <- c("snow", "clear")
lhs1 <- complement(union_sets(A,B), Omega)
rhs1 <- intersect_sets(complement(A,Omega), complement(B,Omega))
cat("De Morgan 1 korrekt? ", set_equal(lhs1, rhs1), "\n")

lhs2 <- complement(intersect_sets(A,B), Omega)
rhs2 <- union_sets(complement(A,Omega), complement(B,Omega))
cat("De Morgan 2 korrekt? ", set_equal(lhs2, rhs2), "\n")

# ---- 7) Abschließende Rekapitulation (Ausgabe) ----
cat("\n--- Rekapituliert ---\n")
cat("Stichprobenraum Ω: ", paste(Omega, collapse = ", "), "\n")
cat("Anzahl Ereignisse in F (Potenzmenge):", length(F), "\n")
cat("Beispielwahrscheinlichkeiten der Atome:\n")
print(p_atoms)
cat("Beispiel: P({rain, snow}) = ", P(c("rain", "snow")), "\n")
cat("Beispiel: P(∅) = ", P(character(0)), "\n")
