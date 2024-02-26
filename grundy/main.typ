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
#let example = thmbox("example", "例").with(numbering: none)

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

#show: report.with(
  title: "不偏ゲームとGrundy数",
  author: "eoeo"
)

== 以下、自分用のメモにします。

== 不偏ゲームの定義

*不偏ゲーム*とは以下の性質を満たすゲームである。

- 先手と後手の2人で交互に手を進める。
- ある局面で打てる手は先手と後手で同じである。
- ゲームの終了局面が与えられている。
- どの局面からも有限回の手数で必ず終了局面に到達する。

有名な不偏ゲームとしてはNimが挙げられる。
一方で、不偏ゲームではないゲームの例としてオセロが挙げられる。
これは、オセロはある局面で打てる手が先手と後手で異なるためである。

== 不偏ゲームの数学的な定義

#definition("不偏ゲーム")[
  $X$ を集合、$f$ を写像 $f colon X arrow 2^X$ とする。
  // さらに、$O$ を $X$ の空でない部分集合で $f(O) = emptyset$ を満たすものとする。
  このとき、組 $cal(A) = (X, f)$ のことを*不偏ゲーム*という。
  さらに、$X$ を* $cal(A)$ の局面全体の集合*、$f$ を*$cal(A)$のルール*という。
  // 、$O$ を*終了局面の集合*という。
]

#remark[
  $2^X$ は $X$ のべき集合である。
]

さらに、本記事では不偏ゲームには有限回の手で終了するという条件を課す。

#definition("ゲームの進行")[
  $cal(A) = (X, f)$ を不偏ゲームとする。
  また、$n$ を自然数とする。$x_0, dots, x_n in X$  が
  $x_(i + 1) in f(x_i) space (i = 0, dots, n - 1)$ を満たすとき、組 $(x_0, dots, x_n)$ はゲーム $cal(A)$ の*長さ $n$ の進行*であるという。また、$x_0$ を進行の始点という。
]

#definition("不偏ゲームの有限性")[
  $cal(A) = (X, f)$ を不偏ゲームとする。
  次を満たすとき、$cal(A)$ を*有限型の不偏ゲーム*という。
  - ある $n_0 in NN$ が存在して、ゲーム $cal(A)$ の長さ $n_0$ 以上の進行が存在しない。
]

以下、本記事では単に不偏ゲームといったときは、有限型の不偏ゲームのことを指す。

#definition("終了局面")[
  $cal(A) = (X, f)$ を不偏ゲームとする。
  $ cal(E) := { x in X | f(x) = emptyset} $
  と定め、$cal(E)$ を *終了局面集合* という。$cal(A)$ の有限性から、$cal(E) eq.not emptyset$
  となることが分かる。
]

== 不偏ゲームの勝敗

不偏ゲームに、勝敗を考える。

#definition("不偏ゲームの勝敗")[
  $cal(A) = (X, f)$ を不偏ゲーム、$cal(E)$ を終了局面集合とする。
  このとき、以下のように再帰的に $cal(G)$ と $cal(S)$ を定義する。

  - $cal(E) subset cal(G)$ である。
  - $$
]

== 不偏ゲームの例

#example("一山Nim")[
  石が $n$ 個つまれている山が一つある。このとき、二人で交互に好きなだけ石を取り合う。
]

== Grundy数








