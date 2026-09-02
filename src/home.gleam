import icons
import lustre/attribute
import lustre/element.{type Element}
import sketch/lustre/element/html

pub fn view() -> List(Element(a)) {
  [
    html.h1_([], [html.text("Oscar Weimann")]),
    html.h2_([], [html.text("Welcome to my tech portfolio!")]),
    html.div_([], [
      html.a_([attribute.href("https://github.com/oslewei")], [icons.github()]),
      html.a_([], []),
    ]),
  ]
}
