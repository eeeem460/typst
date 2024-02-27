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

// Operators
#let len = (x) => $op(l) (#x)$

#show: report.with(
  title: "不偏ゲームとGrundy数",
  author: "eoeo"
)

以下、将来の自分のためのメモであり、「石取りゲームの数学、佐藤文広」を参考にしてまとめる。

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
  $cal(P)$ を集合、$cal(R)$ を写像 $cal(R) colon cal(P) arrow 2^cal(P)$ とする。
  // さらに、$O$ を $X$ の空でない部分集合で $f(O) = emptyset$ を満たすものとする。
  このとき、組 $cal(A) = (cal(P), cal(R))$ のことを*不偏ゲーム*という。
  さらに、$cal(P)$ の元を *$cal(A)$ の局面*、$cal(R)$ を*$cal(A)$のルール*という。
  また、$cal(R) (P)$ の元を*局面 $P$ の後続局面*という。
  // 、$O$ を*終了局面の集合*という。
]

#remark[
  $2^X$ は $X$ のべき集合である。
]

以下、本記事では $cal(A) = (cal(P), cal(R))$ を不偏ゲームとする。

さらに、本記事では不偏ゲームには有限回の手で終了するという条件を課す。

#definition("ゲームの進行")[
  $n > 0$ を自然数とする。$P_1, dots, P_n in cal(P)$  が
  $P_(i + 1) in cal(R)(P_i) space (i = 1, dots, n - 1)$ を満たすとき、列 $(P_1, dots, P_n)$ は *$P_1$ から始まる長さ $n$ のゲーム列*であるという。
  一つの局面 $P$ からなる列 $(P)$ も長さ 1 のゲーム列であるとみなす。
]

#definition("有限性条件")[
  次を満たすとき、$cal(A)$ を*有限型の不偏ゲーム*という。
  - ある $n_0 in NN$ が存在して、$cal(A)$ の長さ $n_0$ 以上のゲーム列が存在しない。
]

以下、本記事では有限型の不偏ゲームのみを扱う。

#definition("局面の長さ")[
  局面 $P in cal(P)$ に対して、$l(P)$ を $P$ から始まるゲーム列の長さの最大値とする。
  // また、$P in cal(E)$ に対しては、$l(P) = 1$ と定めることにする。
  $len(P)$ は不偏ゲームの有限性条件から一意に定まる。$l(P)$ を*局面 $P$ の長さ* という。
]

#definition("終了局面")[
  局面 $P$ が $cal(R)(P) = emptyset$ を満たすとき、$P$ を*終了局面*という。
  終了局面全体の集合を $cal(E)$ とおく：
  $ cal(E) := { P in cal(P) | cal(R)(P) = emptyset} $
  $cal(A)$ の有限性から、$cal(E) eq.not emptyset$
  となることが分かる。また、$P in cal(E)$ に対して $l(P) = 1$ が成り立つ。
]


== 不偏ゲームの勝敗

不偏ゲームの勝敗を考える。

#definition("不偏ゲームの勝敗")[
  このとき、以下のように再帰的に $cal(G)$ と $cal(S)$ を定義する。

  - $cal(E) subset cal(G)$ とする。
  - $P in cal(P)$ に対して、任意の後続局面 $Q in cal(R)(P)$ が $Q in cal(S)$ を満たすなら、$P in cal(G)$ とする。
  - $P in cal(P)$ に対して、ある後続局面 $Q in cal(R)(P)$ が存在して、$Q in cal(G)$ を満たすなら、$P in cal(S)$ とする。

  $cal(G)$ の元を*後手必勝局面*、$cal(S)$ の元を*先手必勝局面*という。

  局面の長さが小さい順に考えることで、任意の $P in cal(P)$ が $P in cal(G) union cal(S)$ となることが分かる。さらに、$cal(P) = cal(G) union.sq cal(S)$ となることも分かる。
]

== 不偏ゲームの例

#example("一山Nim")[
  石が $n$ 個つまれている山が一つある。このとき、二人で交互に好きなだけ石を取り合う。
]

== Grundy数








