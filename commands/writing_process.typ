#import "./constants.typ" as Constants
////////// Writing Process Commands //////////
#let TODO = x => text(red)[
	TODO: #x
]

#let LLMTODO = x => text(green)[
	LLM TODO: #x
]

#let LLMExplains = (x, name: "An LLM") => box(
	fill: rgb("#f0f0f0"),
	inset: 1em,
	stroke: 1pt + rgb("#000000"),
	radius: Constants.borderRadius,
	width: 100%,
)[
	*#name Explains*:	#x
]

