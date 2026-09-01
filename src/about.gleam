import sketch/css/length
import sketch/css
import lustre/attribute
import lustre/element.{type Element}
import sketch/lustre/element/html

pub fn view() -> Element(message) {
  html.div_([], [
    html.h1_([], [html.text("About")]),
    html.a(
      css.class([
        css.display("inline-block"),
        css.padding_left(length.rem(1.5)),
        css.padding_right(length.rem(1.5)),
        css.padding_top(length.rem(0.75)),
        css.padding_bottom(length.rem(0.75)),
        css.font_weight("500"),
        css.text_align("center"),
        css.transition("background-color 0.2s ease"),
        css.border("1px solid transparent"),

        css.hover([
          css.background_color("#1d4ed8"),
          css.border_color("black"),
        ]),

        css.active([
          css.background_color("#1e40af")
        ]),
      ]),
      [attribute.download("OscarWeimannCV.pdf"), attribute.href("../public/OscarWeimannCV.pdf")],
      [html.text("My CV")],
    ),
  ])
}
