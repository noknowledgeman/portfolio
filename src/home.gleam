import lustre/element.{type Element}
import sketch/css
import sketch/lustre/element/html

pub fn view() -> Element(a) {
  html.div_([], [
    html.h1_([], [html.text("Oscar Weimann")]),
    // TODO: do the github and othe rprofiles: github, linkedin
    // hack the box, and so on
    html.div(css.class([]), [], []),
  ])
}
