import lustre/attribute
import lustre/element.{type Element}
import router
import sketch/lustre/element/html

pub fn view() -> Element(message) {
  html.div_([], [html.h1_([], [html.text("")])])
  html.a_(
    [attribute.href(router.path("cv.pdf")), attribute.download("cv.pdf")],
    [html.text("My CV")],
  )
}
