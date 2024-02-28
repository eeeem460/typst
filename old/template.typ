// https://github.com/stepney141/my_typst_template/blob/main/%E3%83%AA%E3%82%A2%E3%83%9A%E3%83%BB%E3%83%AC%E3%83%9D%E3%83%BC%E3%83%88%E7%94%A8/template.typ をお借りしております。ありがとうございます。

#let empty_par() = {
  v(-1em)
  box()
}

#let report(title: "", author: "", body) = {
  set text(
    font: (
      "Nimbus Roman",
      // "Hiragino Mincho ProN",
      // "MS Mincho",
      "Noto Serif CJK JP", 
    ),
    size: 11pt,
    lang: "ja"
  )

  set page(
    paper: "a4",
    margin: (
      bottom: 1.75cm, top: 2.5cm,
      left: 2cm, right: 2cm
    ),
  )

  set heading(numbering: "1.1.", )

  // set par(leading: 0.8em, first-line-indent: 20pt, justify: true)
  set par(leading: 0.8em, justify: true)

  show par: set block(spacing: 1.4em)

  show link: underline
  show link: set text(fill: rgb("#125ee0"))

  show heading.where(level: 1): it => {
    set text(
      weight: "semibold",
      size: 17pt
    )
    text()[
      #it.body
    ]
  }

  show heading.where(level: 2): it => block({
    set text(
      weight: "medium",
      size: 15pt
    )
    text()[
      #it.body
    ]
  })

  show heading.where(level: 3): it => block({
    set text(
      weight: "medium",
      size: 12pt
    )
    text()[
      #it.body
    ]
  })

  show heading: it => {
    set text(
      weight: "medium",
      size: 12pt,
    )
    set block(above: 2em, below: 1em)
    it
  } + empty_par()

  set page(numbering: "1 / 1")

  // 表示

  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(2em)
    #block(text(weight: 700, 1.25em, author))
    #v(2em)
  ]

  // ↓ 上手く使えない
  outline(fill: none, indent: false)

  set par(first-line-indent: 1em)

  body

}