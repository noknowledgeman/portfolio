import styles
import sketch/css/length
import sketch/css
import lustre/attribute
import lustre/element.{type Element}
import sketch/lustre/element/html

pub fn view() -> List(Element(message)) {
  [
    html.h1_([], [html.text("About")]),
    html.p_([], [html.text("Hello my name is Oscar, a passionate programmer currently focusing"
      <> " on cybersecurity and backend development")]),
    html.a(
      styles.button(),
      [attribute.download("OscarWeimannCV.pdf"), attribute.href("../public/OscarWeimannCV.pdf")],
      [html.text("My CV")],
    ),
  ]
}
