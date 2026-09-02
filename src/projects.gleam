import styles
import sketch/css/length
import lustre/attribute
import sketch/css
import lustre/element.{type Element}
import sketch/lustre/element/html
import shared


pub fn view() -> Element(msg) {
  html.div_([], [
    html.h1_([], [html.text("Projects")]),
    html.h2_([], [html.text("Raytracing in zig")]),
    html.a(
      styles.button(),
      [attribute.href("/raytracing")],
      [html.text("link")],
    ),
    html.h2_([], [html.text("AI in C")]),
    html.a(
      styles.button(),
      [attribute.href("/ai")],
      [html.text("link")],
    ),
    html.p_([], [html.text(shared.lorem_ipsum(2, "sentences"))])
  ])
}
