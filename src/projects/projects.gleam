import lustre/element.{type Element}
import sketch/lustre/element/html

pub fn view() -> Element(a) {
  html.div_([], [html.h1_([], [html.text("Projects")])])
}
