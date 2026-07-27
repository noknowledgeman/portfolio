import lustre/attribute
import router
import sketch/lustre/element/html
import lustre/element.{type Element}

pub fn view() -> Element(message) {
  html.div_([], [html.h1_([], [html.text("")])])
  html.a_([
    attribute.href(router.path("cv.pdf")),
    attribute.download("cv.pdf")
  ], [html.text("My CV")])
}