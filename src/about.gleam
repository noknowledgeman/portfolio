import styles
import sketch/css/length
import sketch/css
import lustre/attribute
import lustre/element.{type Element}
import sketch/lustre/element/html

pub fn view() -> Element(message) {
  html.div_([], [
    html.h1_([], [html.text("About")]),
    html.a(
      styles.button(),
      [attribute.download("OscarWeimannCV.pdf"), attribute.href("../public/OscarWeimannCV.pdf")],
      [html.text("My CV")],
    ),
  ])
}
