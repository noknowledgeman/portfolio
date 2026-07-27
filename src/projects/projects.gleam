import sketch/lustre/element/html
import lustre/element.{type Element}

pub fn view() -> Element(a) {
  html.div_([], [html.h1_([], [html.text("Projects")])])
}