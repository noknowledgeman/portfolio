import sketch/css
import sketch/lustre/element/html
import lustre/element.{type Element}

pub fn view() -> Element(a) {
  html.div_([], [
    html.text("Oscar Weimann"),
    html.div(css.class([]), [], [])
  ])
}