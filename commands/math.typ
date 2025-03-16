#import "@preview/ctheorems:1.1.3": *
#import emoji : checkmark

///////////////// Theorem Styles //////////////////
#show: thmrules
#let thmrulesCustom = thmrules.with(qed-symbol: [#checkmark.box])

#set page(width: 16cm, height: auto, margin: 1.5cm)
#set heading(numbering: "1.1.")

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"), base_level: 1)
#let assumption = thmbox("assumption", "Assumption", fill: rgb("#fffeee"), base_level: 1)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base_level: 1,
  base: "theorem",
  titlefmt: strong
)

#let lemma = thmplain(
  "lemma",
  "Lemma",
  base_level: 1,
  base: "theorem",
  titlefmt: strong
)

#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em), base_level: 1,)
#let observation = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em), base_level: 1,)

#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")
///////////////// End Theorem Styles //////////////////

///////////////// Caligraphic Letters //////////////////
#let calA = $cal(A)$
#let calB = $cal(B)$
#let calC = $cal(C)$
#let calD = $cal(D)$
#let calE = $cal(E)$
#let calF = $cal(F)$
#let calG = $cal(G)$
#let calH = $cal(H)$
#let calI = $cal(I)$
#let calJ = $cal(J)$
#let calK = $cal(K)$
#let calL = $cal(L)$
#let calM = $cal(M)$
#let calN = $cal(N)$
#let calO = $cal(O)$
#let calP = $cal(P)$
#let calQ = $cal(Q)$
#let calR = $cal(R)$
#let calS = $cal(S)$
#let calT = $cal(T)$
#let calU = $cal(U)$
#let calV = $cal(V)$
#let calW = $cal(W)$
#let calX = $cal(X)$
#let calY = $cal(Y)$
#let calZ = $cal(Z)$

///////////////// Symbols from Latex That I like //////////////////
#let circ = $circle.small" "$
#let otimes = $times.circle$
#let bigotimes = $times.circle.big$
#let oplus = $plus.circle$
#let bigoplus = $plus.circle.big$

///////////////// Math Symbols //////////////////
#let eps = $epsilon.alt$


