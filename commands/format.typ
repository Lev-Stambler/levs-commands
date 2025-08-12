#let fbox = (x) => box(stroke: (paint: black, thickness: 1pt),  inset: 8pt, radius: 2pt, width: 100%)[
	#x
]

#let appendix(body) = {
  set heading(numbering: "A.1", supplement: [Appendix])
  counter(heading).update(0)
  body
}
