// プリアンブル全体の参考元：https://github.com/sahasatvik/typst-theorems/blob/main/differential_calculus.typ

#import "@preview/ctheorems:1.1.2": *
#show: thmrules.with(qed-symbol: $square$)

// Define theorem environments
// 以下、日本語に変更してnumberingを消した。

// 番号なしにする場合
// #let theorem = thmbox("theorem", "定理", fill: rgb("#e8e8f8")).with(numbering: none)
#let theorem = thmbox("theorem", "定理", fill: rgb("#e8e8f8"))

#let lemma = thmbox(
  "theorem", // Lemmas use the same counter as Theorems
  "補題",
  fill: rgb("#efe6ff"),
)

#let corollary = thmbox(
  "theorem",
  "系",
  base: "theorem", // Corollaries are 'attached' to Theorems
  fill: rgb("#f8e8e8"),
)

#let definition = thmbox(
  "theorem", // Theorem と同じ番号
  "定義",
  fill: rgb("#e8f8e8"),
)

#let exercise = thmbox(
  "exercise",
  "演習",
  stroke: rgb("#ffaaaa") + 1pt,
  base: none, // Unattached: count globally
).with(numbering: "I") // Use Roman numerals

// Examples and remarks are not numbered
#let example = thmbox("example", "例")

#let remark = thmplain("remark", "注意", inset: 0em)

// Proofs are attached to theorems, although they are not numbered
#let proof = thmproof("proof", "証明", base: "theorem")

#let solution = thmplain("solution", "解", base: "exercise", inset: 0em)

// #show strong: set text(fill: blue)

// Mapping arrow
#let mapsto = $arrow.r.bar$

// Operators
#let len = (x) => $op(l) (#x)$
// #let mex = (x) => $op("mex") {#x}$
#let mex = (x) => $op("mex") #x$

#let blue(term, color: blue) = {
  text(color, box[#term])
}

// Template

// projectの参考元：https://github.com/stepney141/my_typst_template/blob/main/%E3%83%AA%E3%82%A2%E3%83%9A%E3%83%BB%E3%83%AC%E3%83%9D%E3%83%BC%E3%83%88%E7%94%A8/template.typ

#let project(title: "", author: "", body) = {
  set document(author: author, title: title)

  // フォントの設定
  set text(font: (
    "Nimbus Roman",
    // "Hiragino Mincho ProN",
    // "MS Mincho",
    "Noto Serif CJK JP",
  ), size: 11pt, lang: "ja")

  // 見出しの番号
  set heading(numbering: "1.1.")

  // 行間と字下げ
  set par(leading: 0.8em, first-line-indent: 1em, justify: true)

  // 見出しの隙間を調整
  show heading: it => [
    #v(2em)
    #it
    #v(1em)
  ]

  // ページ数
  set page(numbering: "1 / 1")

  // タイトルと著者
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em)
    #block(text(1em, author))
    #v(1em)
  ]

  // 目次
  // outline(fill: none, indent: true)

  body
}

// ***** start document *****

#show: project.with(title: "不偏ゲームとGrundy数", author: "えおえお  (𝕏 : @eoeo_sub)")

以下、主に将来の自分へ向けたメモであり、@sato （石取りゲームの数学、佐藤文広）を参考にしてまとめる。

#blue[気になる点があればご連絡いただけると幸いです。]

// 目次
#outline(fill: none, indent: true)

= 不偏ゲーム

*不偏ゲーム*とは以下の性質を満たすゲームである。

- 先手と後手の2人で交互に手を進める。
- 同一局面で選択できる手は先手と後手で等しい。
// - ゲームの終了局面が与えられている。
- どの局面からも有限回の手数で必ず終了局面に到達する。

有名な不偏ゲームとしてはNimが挙げられ、これは後ほど例として取り上げる。 一方で、不偏ゲームではないゲームの例としてオセロが挙げられる。
これは、オセロはある局面で打てる手が先手と後手で異なるためである。

#pagebreak()

= 不偏ゲームの数学的な定義  <sec_def>

#definition(
  "不偏ゲーム"
)[ (@sato, p. 22) 
  $cal(P)$ を空でない集合、$cal(R)$ を写像 $cal(R) : cal(P) -> 2^cal(P)$ とする。 // さらに、$O$ を $X$ の空でない部分集合で $f(O) = emptyset$ を満たすものとする。
  このとき、組 $cal(A) = (cal(P), cal(R))$ のことを*不偏ゲーム*という。 さらに、$cal(P)$ の元を *$cal(A)$
  の局面*、$cal(R)$ を*$cal(A)$のルール*という。 また、$cal(R) (P)$ の元を*局面 $P$ の後続局面*という。
  // 、$O$を*終了局面の集合*という。
]

#remark[
  $2^X$ は $X$ のべき集合である。
]

以下、@sec_def では $cal(A) = (cal(P), cal(R))$ を不偏ゲームとする。

さらに、本記事では不偏ゲームには有限回の手で終了するという条件を課す。

#definition(
  "ゲームの進行",
)[ (@sato, p. 23)
  $n > 0$ を自然数とする。$P_1, dots, P_n in cal(P)$ が
  $P_(i + 1) in cal(R)(P_i) space (i = 1, dots, n - 1)$ を満たすとき、列 $(P_1, dots, P_n)$ は
  *$P_1$ から始まる長さ $n$ のゲーム列*であるという。 一つの局面 $P$ からなる列 $(P)$ も長さ 1 のゲーム列であるとみなす。
]

#definition("有限性条件")[ (@sato, p. 23)
  次を満たすとき、$cal(A)$ を*有限型の不偏ゲーム*という。
  - ある $n_0 in NN$ が存在して、$cal(A)$ の長さ $n_0$ 以上のゲーム列が存在しない。
    すなわち、$cal(A)$ のゲーム列の長さは有界である。
]

以下、本記事では有限型の不偏ゲームのみを扱う。

#definition("局面の長さ")[ (@sato, p. 23)
  局面 $P in cal(P)$ に対して、$l(P)$ を $P$ から始まるゲーム列の長さの最大値とする。
  // また、$P in cal(E)$ に対しては、$l(P) = 1$ と定めることにする。
  $len(P)$ は不偏ゲームの有限性条件から一意に定まる。$l(P)$ を*局面 $P$ の長さ* という。
]

#definition(
  "終了局面"
)[ (@sato, p.23)
  局面 $P$ が $cal(R)(P) = emptyset$ を満たすとき、$P$ を*終了局面*という。 終了局面全体の集合を $cal(E)$ とおく：
  $ cal(E) := { P in cal(P) | cal(R)(P) = emptyset} $
  $cal(A)$ の有限性から、$cal(E) eq.not emptyset$
  となることが分かる。また、$P in cal(E)$ に対して $l(P) = 1$ が成り立つ。
]

#pagebreak()

= 不偏ゲームの勝敗

不偏ゲームの勝敗を考える。

#definition(
  "不偏ゲームの勝敗",
)[ (@sato, 補題2.4)
  $cal(A) = (cal(P), cal(R))$ を不偏ゲームとする。
  再帰的に $cal(G)$ と $cal(S)$ を定義する：

  $ cal(G) &:= cal(E) union { P in cal(P) | forall Q in cal(R)(P), thin Q in cal(S) } \
  cal(S) &:= { P in cal(P) | exists Q in cal(R)(P), thin Q in cal(G) } $

  $cal(G)$ の元を*後手必勝局面*、$cal(S)$ の元を*先手必勝局面*という。

  局面の長さが小さい順に考えることで、任意の $P in cal(P)$ が $P in cal(G) union cal(S)$ となることが分かる。さらに、$cal(P) = cal(G) union.sq cal(S)$ となることも分かる。

  #blue[これちゃんと再帰的に定義できてますかね？]
] <df_win_lose>

#remark[
  @sato では @df_win_lose を定義ではなく補題として与えている。
]

#remark[
  上の定義で定まる勝敗を考えたゲームを*正規形*の不偏ゲームという。本記事では正規形の不偏ゲームのみを扱う。
]

不偏ゲームの勝敗を直観的に説明する。

- 不偏ゲームの勝敗は、交互に手を打ってこれ以上手を進められなくなった方の負け、というルールのことである。
- 後手必勝局面とは、その局面で手番のものが負けという意味である。つまり、その局面を渡したものが勝ちである。
- 先手必勝局面とは、その局面で手番のものが勝ちという意味である。つまり、その局面を渡したものが負けである。

後手必勝であるか先手必勝であるかは、以下のように順に定まっていく。

- ( $l(P) = 1$ ) これ以上手が打てない終了局面は後手必勝である。（ $cal(E) subset cal(G)$ のこと。）
- ( $l(P) = 2$ ) 後手必勝局面である終了局面に、一手で進められる局面は先手必勝局面である。
- ( $l(P) >= 3$ ) 後続局面がすべて先手必勝局面であるような局面は後手必勝であり、後続局面に後手必勝局面が存在するような局面は先手必勝である。

すなわち、先手必勝局面からはある手を選び続けることで、

（先手必勝）$->$（後手必勝）$->$（先手必勝）$->$（後手必勝）$-> dots ->$（先手必勝）$->$（終了局面）

となるゲーム列を必ず構成することができる。なぜなら、先手必勝局面からは必ず後手必勝局面を選択でき、
後手必勝局面では先手必勝となる局面しか選択できないからである。

#pagebreak()

= 不偏ゲームの例 <game_ex>

#example(
  "一山Nim",
)[
  $n$ 個の石が積み上げられている山が一つある。このとき、二人で交互に山から好きなだけ石を取り合う。
  先に石を取ることができなくなった方の負けである。このゲームを *一山Nim* という。

  一山Nimを不偏ゲームの定義にもとづいて集合論の言葉で述べる。 局面全体の集合を $cal(P) = {0, 1, dots, n}$ とおき、ルール$cal(R) : cal(P) -> 2^cal(P)$ を
  $
    cal(R)(0) &= emptyset, quad \
    cal(R)(i) &= {0, dots, i - 1} quad (0 < i <= n)
  $
  と定める。このとき、組 $(cal(P), cal(R))$ は一山Nimを表す有限型の不偏ゲームである。 局面 $i$ は山に $i$ 個の石が残っている局面を表している。

  さらに、後手必勝局面全体の集合 $cal(G)$ と先手必勝局面全体の集合 $cal(S)$ は、
  $
    cal(G) &= { 0 } \
    cal(S) &= {1, dots, n}
  $
  である。なぜなら、定義より終了局面 $0$ は後手必勝局面であり、任意の局面 $i > 0$ に対して、$i$ からは後手必勝局面 $0 in cal(R)(i)$ に遷移できるからである。

  これを表にすると、
  #align(center)[
    #figure(table(
      columns: 9,
      inset: 8pt,
      $i$,
      [0],
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [$dots$],
      [$cal(G) \/ cal(S)$],
      $cal(G)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $dots$,
    )) <table1>
  ]
  となる。 上の表で、$cal(G)$ は後手必勝局面、$cal(S)$ は先手必勝局面という意味である。 競技プログラミングでは、このような先後の必勝判定を
  bool 型の配列で行うことがある。 その際には、局面の長さが小さい順に判定を行えばよい。
] <one_nim>

#example(
  "制限一山Nim",
)[
  一山Nimで一度に取ることができる石の数を $3$ 個以下に制限に制限したものを 制限一山Nimという。
  制限一山Nimをモデル化する。

  局面全体の集合は一山Nimと変わらず $cal(P) = {0, 1, dots, n}$ とおく。 ルール $cal(R) : cal(P) -> 2^cal(P)$ を
  $
    cal(R)(i) = { max(0, i - j) | 1 <= j <= 3 } quad (0 <= i <= n)
  $
  と定める。このとき、組 $(cal(P), cal(R))$ は制限一山Nimを表す有限型の不偏ゲームである。

  さらに、
  $
    cal(G) := { i in cal(P) | i equiv 0 thin (mod 4) } \
    cal(S) := { i in cal(P) | i equiv.not 0 thin (mod 4) }
  $
  であることが分かる。これは帰納法、つまり以下の表を $i$ が小さい順に埋めることで分かる。
  #{
    set align(center)

    table(
      columns: 12,
      inset: 8pt,
      $i$,
      [0],
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [$dots$],
      [$cal(G) \/ cal(S)$],
      $cal(G)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(G)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(G)$,
      $cal(S)$,
      $dots$,
    )
  }
  // 一度に山からとることができる石の数が異なっても同様に考えられる。
] <st_nim>

#example(
  "一般化された一山Nim",
)[
  一山Nimで一度に取ることができる石の数を $2$ 個 か $3$ 個のどちらか一方に制限に制限したものを考える。

  局面全体の集合は一山Nimと変わらず $cal(P) = {0, 1, dots, n}$ とおく。 ルール $cal(R) : cal(P) -> 2^cal(P)$ を
  $
    cal(R)(i) &= { max(0, i - j) | j = 2 or j = 3 } quad (0 <= i <= n)
  $
  と定める。このとき、やはり組 $(cal(P), cal(R))$ は有限型の不偏ゲームである。 終了局面全体の集合は$cal(E) = {0, 1}$ であることに注意されたい。

  さらに、
  $
    cal(G) := { i in cal(P) | i equiv 0 thin (mod 5) or i equiv 1 thin (mod 5) } \
    cal(S) := { i in cal(P) | i equiv 2 thin (mod 5) or i equiv 3 thin (mod 5) or i equiv 4 thin (mod 5) }
  $
  であることが分かる。これも帰納法、つまり以下の表を $i$ が小さい順に埋めることで分かる。
  #{
    set align(center)

    table(
      columns: 13,
      inset: 8pt,
      $i$,
      [0],
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [10],
      [$dots$],
      [$cal(G) \/ cal(S)$],
      $cal(G)$,
      $cal(G)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(G)$,
      $cal(G)$,
      $cal(S)$,
      $cal(S)$,
      $cal(S)$,
      $cal(G)$,
      $dots$,
    )
  }
] <gen_nim>

= Grundy数

不偏ゲームの局面に対してGrundy数を定義する。

#definition(
  "Grundy数",
)[ (@sato, pp. 34-35)
  $cal(A) = (cal(P), cal(R))$ を不偏ゲームとする。 局面 $P in cal(P)$ の*Grundy数* $g(P)$
  を次で再帰的に定義する。
  $
    g(P) := mex({ g(Q) | Q in cal(R)(P) })
  $
  ただし、$A subset NN$ に対して、$mex(A) := min (NN without A)$ である。

  特に終了局面 $P in cal(E)$ に対して、$g(P) = mex(emptyset) = 0$ である。
]

Grundy数を用いて不偏ゲームの必勝判定を行うことができる。

#theorem("Grundy数による必勝判定")[ (@sato, 定理3.1)
  不偏ゲーム $cal(A) = (cal(P), cal(R))$ の後手必勝局面全体の集合を$cal(G)$、先手必勝局面全体の集合を
  $cal(S)$ とする。

  このとき、
  $
    cal(G) = { P in cal(P) | g(P) eq 0 } \
    cal(S) = { P in cal(P) | g(P) eq.not 0 }
  $
  が成立する。
]

証明は $"mex"$ の性質そのものである。
#blue[証明は読まなくて良いです。]

#proof[
  $A := { P in cal(P) | g(P) eq 0 }$ 、$B := { P in cal(P) | g(P) eq.not 0 }$ とおく。
  $cal(P) = A union.sq B = cal(G) union.sq cal(S)$ であるから $A subset cal(G)$ と $B subset cal(S)$ を示せばよい。

  局面の長さによる帰納法で示す。定義から、
  $
    cal(G) = cal(E) union { P in cal(P) | forall Q in cal(R)(P), thin Q in cal(S) } \
    cal(S) = { P in cal(P) | exists Q in cal(R)(P), thin Q in cal(G) }
  $
  だった。
  - $cal(E) subset A$ について、$cal(E) subset cal(G)$ となることは良い。
  - 長さ $k$ 以下の局面 $P in cal(P)$ に対して、$P in A$ ならば $P in cal(G)$ であり、
    $P in B$ ならば $P in cal(S)$ が成り立つと仮定する。
  - このとき、$P in cal(P)$ を長さ $k + 1$ の局面とする。
    - まず、$P in A$ だったとする。$g(P) = 0$ であるので、$P$ の任意の後続局面 $Q in cal(R)(P)$ に対して、$g(Q) eq.not 0$ をみたす。これは $"mex"$ の定義から従う。$l(Q) <= k$ であるので帰納法の仮定から、$Q in cal(S)$ である。したがって、$P in cal(G)$ となる。
    - 次に、$P in B$ だったとする。$g(P) eq.not 0$ であるので、$P$ のある後続局面 $Q in cal(R)(P)$ が存在して、
      $g(Q) = 0$ をみたす。これも$"mex"$ の定義による。$l(Q) <= k$ であるので、帰納法の仮定から、
      $Q in cal(G)$ である。したがって、$P in cal(S)$ となる。
]

= Grundy数の例 <sec_ex_grundy> 

不偏ゲームの例としてあげた3つのゲームのGrundy数を計算する。この節で求めるGrundy数の表と @game_ex で計算した表とを比べると、
$cal(G)$ が $g(i) eq.not 0$ と、$cal(S)$ が $g(i) eq 0$ と、 それぞれ対応していることを確かめられる。

#example(
  "一山Nim",
)[
  一山Nimの局面全体の集合は $cal(P) = {0, 1, dots, n}$ 、ルール$cal(R) : cal(P) -> 2^cal(P)$ は
  $
    cal(R)(i) = {j | 0 <= j < i} quad (0 <= i <= n)
  $
  // $
  //   cal(R)(0) &= emptyset, quad \
  //   cal(R)(i) &= {0, dots, i - 1} quad (0 < i <= n)
  // $
  だった。

  局面の長さが小さい順に、すなわち、 $i$ について昇順にGrundy数を計算して表にすると、
  #{
    set align(center)

    table(
      columns: 9,
      inset: 8pt,
      $i$,
      $0$,
      $1$,
      $2$,
      $3$,
      $4$,
      $5$,
      $6$,
      $dots$,
      $g(i)$,
      $0$,
      $1$,
      $2$,
      $3$,
      $4$,
      $5$,
      $6$,
      $dots$,
    )
  }
  となる。 一般に $g(i) = i$ であることが分かる。
]

#example(
  "制限一山Nim",
)[
  制限一山Nimの局面全体の集合は $cal(P) = {0, 1, dots, n}$ 、 ルール $cal(R) : cal(P) -> 2^cal(P)$ は
  $
    cal(R)(i) = { max(0, i - j) in cal(P) | 1 <= j <= 3 } quad (0 <= i <= n)
  $
  と定めた。

  局面の長さが小さい順に、すなわち、 $i$ について昇順にGrundy数を計算して表にすると、
  #{
    set align(center)

    table(
      columns: 12,
      inset: 8pt,
      $i$,
      [0],
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [$dots$],
      [$g(i)$],
      $0$,
      $1$,
      $2$,
      $3$,
      $0$,
      $1$,
      $2$,
      $3$,
      $0$,
      $1$,
      $dots$,
    )
  }
  となる。 帰納的に $g(i) = (i mod 4)$ であることが分かる。 ただし、$i mod 4$ は $i$ を $4$ で割ったあまりである。 // 一度に山からとることができる石の数が異なっても同様に考えられる。
]

#example(
  "一般化された一山Nim",
)[
  @gen_nim では一山Nimで一度に取ることができる石の数を $2$ 個 か $3$ 個のどちらか一方に制限に制限したものを考えた。

  局面全体の集合 $cal(P) = {0, 1, dots, n}$ として、ルール $cal(R) : cal(P) -> 2^cal(P)$ は
  $
    cal(R)(i) &= { max(0, i - j) | j = 2 or j = 3 } quad (0 <= i <= n)
  $
  と定めた。

  局面の長さが小さい順にすなわち、 $i$ について昇順にGrundy数を計算して表にすると、
  #{
    set align(center)

    table(
      columns: 13,
      inset: 8pt,
      $i$,
      [0],
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [10],
      [$dots$],
      [g(i)],
      $0$,
      $0$,
      $1$,
      $1$,
      $2$,
      $0$,
      $0$,
      $1$,
      $1$,
      $2$,
      $0$,
      $dots$,
    )
  }
  となる。このあとのGrundy数も $0,0,1,1,2$ と繰り返しになることが帰納的に分かる。 すなわち、
  $
    g(i) = cases(
      0 quad (i equiv 0,1) \ 
      1 quad (i equiv 2,3) \
      2 quad (i equiv 4)
    )
  $
  となる。

  一般に、一般化された一山Nimにおいて、取ることができる石の数の集合が有限集合である場合は、Grundy数は周期をもつことが分かる(@sato, 定理5.3)。
]

以上の3つの例、それぞれを @game_ex で計算した表と比べると、
$cal(G)$ が $g(i) eq.not 0$ と、$cal(S)$ が $g(i) eq 0$ と、それぞれ対応しているのが分かる。

このことから分かるように、単純なゲームの必勝判定をしたいだけであればGrundy数を計算する必要はない。 単に @game_ex
で行ったように局面が後手必勝であるか先手必勝であるかの二通りで判定していけばよいからである。 しかし、Grundy数は局面の勝敗以上の情報を含んでいる。
@game_sum で述べるように、複数のゲームを組み合わせた際にその威力が発揮される。

= ゲームの和 <game_sum>

二つの不偏ゲームを独立に行うゲームを二つの*不偏ゲームの和*という。
このとき、もとの二つのゲームのどちらか一方のみを一手進めることを、ゲームの和の一手として定める。

集合論の言葉でより正確に表現しよう。

#definition(
  "不偏ゲームの和",
)[ (@sato, pp. 39-40)
  $cal(A)_1 = (cal(P)_1, cal(R)_1)$ と $cal(A)_2 = (cal(P)_2, cal(R)_2)$ をそれぞれ不偏ゲームとする。
  このとき、$cal(R)_1 times cal(R)_2 : cal(P)_1 times cal(P)_2 -> 2^(cal(P)_1) times 2^(cal(P)_2)$ を $P_1 in cal(P)_1, thin P_2 in cal(P)_2$ に対して、
  $
    cal(R)_1 times cal(R)_2(P_1, P_2) = {(Q_1, P_2) | Q_1 in cal(R)_1(P_1)} union {(P_1, Q_2) | Q_2 in cal(R)_2(P_2)}
  $
  と定める。このとき、不偏ゲーム $(cal(P)_1 times cal(P)_2, cal(R)_1 times cal(R)_2)$ のことを、
  $cal(A)_1 + cal(A)_2$ と表して、*$cal(A)_1$ と $cal(A)_2$ の和*という。
]

すなわち、ゲームの和 $cal(A)_1 + cal(A)_2$ の局面全体の集合は直積 $cal(P)_1 times cal(P)_2$ である。
また、局面 $(P_1, P_2)$ の後続局面は $P_1$ か $P_2$ のどちらか一方を進めた局面である。

不偏ゲームの和について結合法則が成り立つ。 すなわち、$cal(A)_1, cal(A)_2, cal(A)_3$ を不偏ゲームとすると、
$
  (cal(A)_1 + cal(A)_2) + cal(A)_3 = cal(A)_1 + (cal(A)_2 + cal(A)_3)
$
が成り立つ。

不偏ゲームの和のGrundy数はそれぞれの不偏ゲームの排他的論理和で表される、という驚くべき定理が成り立つ。

#theorem(
  "ゲームの和のGrundy数",
)[ (@sato, 定理3.4)
  $cal(A)_1 = (cal(P)_1, cal(R)_1), thin cal(A)_2 = (cal(P)_2, cal(R)_2)$ を不偏ゲームとする。$cal(A)_1$ と $cal(A)_2$ のGrundy数をそれぞれ $g_(cal(A)_1)$ と $g_cal(A)_2$ で表す。また、和 $cal(A)_1 + cal(A)_2$ のGrundy数を $g_(cal(A)_1 + cal(A)_2)$ と定める。

  このとき、局面 $P_1 in cal(P)_1, thin P_2 in cal(P)_2$ に対して、
  $
    g_(cal(A)_1 + cal(A)_2)(P_1, P_2) = g_(cal(A)_1)(P_1) plus.circle g_cal(A)_2(P_2)
  $
  が成立する。ただし、$plus.circle$ は各ビットごとの排他的論理和である。
] <thm_sum_grundy>

証明は @sato に詳しい。

#pagebreak()

= ゲームの和のGrundy数の例

最後に具体的なゲームの和のGrundy数を求める。

#example[
  一山Nim $cal(A)_1$（@one_nim）と制限一山Nim $cal(A)_2$（@st_nim）と一般化された一山Nim $cal(A)_3$ （@gen_nim）
  の和 $cal(A)_1 + cal(A)_2 + cal(A)_3$ を考える。それぞれの山の石の数は等しく $n$ 個であるとする。直観的には3つの山を並べて、選択可能な一手は「一つの山を選び、その山で許されている数の石をとること」だと考えればよい。

  $cal(P)_n = {0, 1, dots, n}$ とおく。$cal(A)_1 + cal(A)_2 + cal(A)_3$ の局面全体の集合は $(cal(P)_n)^3 = cal(P)_n times cal(P)_n times cal(P)_n$ である。さらに、ルール $cal(R) : (cal(P)_n)^3 -> 2^((cal(P)_n)^3)$ は
  $
    cal(R)(i, j, k) = {(i', j, k)| 0 <= i' < i} union {(i, max(0, j - s), k) | 1 <= s <= 3} \ union {(i, j, max(0, k - t)) | t = 2 or t = 3} quad ((i, j, k) in (cal(P)_n)^3)
  $
  である。和 $cal(A)_1 + cal(A)_2 + cal(A)_3$ のGrundy数 $g_(cal(A)_1 + cal(A)_2 + cal(A)_3)$ は
  @thm_sum_grundy と @sec_ex_grundy の計算から
  $
    g_(cal(A)_1 + cal(A)_2 + cal(A)_3)(i, j, k) = i plus.circle (j mod 4) plus.circle a_k
  $
  となる。ただし、$a_k$ は 
  $
    a_k = cases(
      0 quad (k equiv 0,1) \ 
      1 quad (k equiv 2,3) \
      2 quad (k equiv 4)
    )
  $
  と定める。
]

競技プログラミングにおいて、非常に大きい自然数 $n$ に対して、$n$ 個のゲームの和を考えることがある。
ゲームの和の局面全体の個数はとても大きいので、grundy数を直接計算するには膨大な計算が必要となる。
しかし、@thm_sum_grundy を用いることで小ない計算回数でゲーム和のGrundy数を求めることができる。すなわち、和をとる前のゲームのgrundy数を計算して、それからゲームの和のgrundy数を求めることができる。

#bibliography("references.bib")
