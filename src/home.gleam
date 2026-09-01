import icons
import lustre/attribute
import lustre/element.{type Element}
import sketch/css
import sketch/lustre/element/html

pub fn view() -> Element(a) {
  html.section_([attribute.id("home")], [
    html.h1_([], [html.text("Oscar Weimann")]),
    html.div_([], [
      html.a_([attribute.href("https://github.com/oslewei")], [icons.github()]),
      html.a_([], []),
    ]),
  ])
}
