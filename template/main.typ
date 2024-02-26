#import "./template.typ": *
#import "./theorems.typ": *

#show: thmrules.with(qed-symbol: $square$)

// Define theorem environments

#let theorem = thmbox(
  "theorem",
  "定理",
  fill: rgb("#e8e8f8")
).with(numbering: none)

#let lemma = thmbox(
  "theorem",            // Lemmas use the same counter as Theorems
  "補題",
  fill: rgb("#efe6ff")
).with(numbering: none)

#let corollary = thmbox(
  "corollary",
  "系",
  base: "theorem",      // Corollaries are 'attached' to Theorems
  fill: rgb("#f8e8e8")
).with(numbering: none)

#let definition = thmbox(
  "definition",         // Definitions use their own counter
  "定義",
  fill: rgb("#e8f8e8")
).with(numbering: none)

#let exercise = thmbox(
  "exercise",
  "演習",
  stroke: rgb("#ffaaaa") + 1pt,
  base: none,           // Unattached: count globally
).with(numbering: "I")  // Use Roman numerals

// Examples and remarks are not numbered
#let example = thmplain("example", "Example").with(numbering: none)
#let remark = thmplain(
  "remark",
  "注意",
  inset: 0em
).with(numbering: none)

// Proofs are attached to theorems, although they are not numbered
#let proof = thmproof(
  "proof",
  "証明",
  base: "theorem",
)

#let solution = thmplain(
  "solution",
  "解",
  base: "exercise",
  inset: 0em,
).with(numbering: none)

// Mapping arrow
#let mapsto = $arrow.r.bar$

#show: report.with()

= 不偏ゲームとGrundy数

#block(
  [著者：えおえお (\@eoeo_ooo)]
)

== 目的

あいうえお

#theorem("アイウエオ")[
  あいうえお
]

#definition[

]

== 目的2

== 行間

ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ

