import lustre/attribute
import router
import lustre/element/html
import lustre/element.{type Element}

pub fn view() -> Element(message) {
  html.div([], [html.h1([], [html.text("")])])
  html.a([
    attribute.href(router.path("cv.pdf")),
    attribute.download("cv.pdf")
  ], [html.text("My CV")])
}