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

// #show strong: set text(fill: blue)

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
- ある局面で選択できる手は先手と後手で等しい。
// - ゲームの終了局面が与えられている。
- どの局面からも有限回の手数で必ず終了局面に到達する。

有名な不偏ゲームとしてはNimが挙げられ、これは後ほど例として取り上げる。
一方で、不偏ゲームではないゲームの例としてオセロが挙げられる。
これは、オセロはある局面で打てる手が先手と後手で異なるためである。

== 不偏ゲームの数学的な定義

#definition("不偏ゲーム")[
  $cal(P)$ を集合、$cal(R)$ を写像 $cal(R) : cal(P) -> 2^cal(P)$ とする。
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

  $ cal(G) &:= cal(E) union { P in cal(P) | forall Q in cal(R)(P), Q in cal(S) } \
   cal(S) &:= { P in cal(P) | exists Q in cal(R)(P), Q in cal(G) } $

  $cal(G)$ の元を*後手必勝局面*、$cal(S)$ の元を*先手必勝局面*という。

  局面の長さが小さい順に考えることで、任意の $P in cal(P)$ が $P in cal(G) union cal(S)$ となることが分かる。さらに、$cal(P) = cal(G) union.sq cal(S)$ となることも分かる。
]

#remark[
  上の定義で定まる勝敗を考えたゲームを*正規形*の不偏ゲームという。本記事では正規形の不偏ゲームのみを扱う。
]

不偏ゲームの勝敗を直観的に説明する。

- 不偏ゲームの勝敗は、交互に手を打ってこれ以上手を進められなくなった方の負け、というルールのことである。
- 後手必勝局面とは、その局面で手番のものが負けという意味である。つまり、その局面を渡した方の勝ちである。
- 先手必勝局面とは、その局面で手番のものが勝ちという意味である。つまり、その局面を渡した法の負けである。

後手必勝であるか先手必勝であるかは、以下のように順に定まっていく。

- ( $l(P) = 1$ ) これ以上手が打てない終了局面は後手必勝である。（ $cal(E) subset cal(G)$ のこと。）
- ( $l(P) = 2$ ) 後手必勝局面である終了局面に、一手で進められる局面は先手必勝局面である。
- ( $l(P) >= 3$ ) 後続局面がすべて先手必勝局面であるような局面は後手必勝であり、後続局面に後手必勝局面が存在するような局面は先手必勝である。

すなわち、先手必勝局面からはある手を選び続けることで、

（先手必勝）$->$（後手必勝）$->$（先手必勝）$->$（後手必勝）$-> dots ->$（先手必勝）$->$（終了局面） 

となるゲーム列を必ず構成することができる。なぜなら、先手必勝局面からは必ず後手必勝局面を選択でき、
後手必勝局面では先手必勝となる局面しか選択できないからである。


== 不偏ゲームの例

#example("一山Nim")[
  $n$ 個の石が積み上げられている山が一つある。このとき、二人で交互に山から好きなだけ石を取り合う。
  先に石を取ることができなくなった方の負けである。このゲームを *Nim* という。
  Nimを定義にもとづいて集合論の言葉で述べよう。

  $cal(P) = {0, 1, dots, n}$ とおき、$cal(R) : cal(P) -> 2^cal(P)$ を
   $ 
   cal(R)(0) &= emptyset, quad \
   cal(R)(i) &= {0, dots, i - 1} quad (0 < i <= n) 
   $
  と定める。このとき、組 $(cal(P), cal(R))$ は有限型の不偏ゲームである。
  さらに、後手必勝局面全体の集合 $cal(G)$ と先手必勝局面全体の集合 $cal(S)$ は、
  $
  cal(G) &= { 0 } \
  cal(S) &= {1, dots, n}
  $
  であることが分かる。これは定義から、
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    $n$, [0], [1], [2], [3], [4], [5], [6], [$dots$],
    [],
    $cal(G)$,
    $cal(S)$,
    $cal(S)$,
    $cal(S)$,
    $cal(S)$,
    $cal(S)$,
    $cal(S)$,
    $dots$,
  )
  のように順に考えることで分かる。$cal(G)$ は後手必勝局面、$cal(S)$ は先手必勝局面という意味。
]

#example("制限付きNim")[

]

== Grundy数








