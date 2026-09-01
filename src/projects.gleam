import sketch/css/length
import lustre/attribute
import sketch/css
import lustre/element.{type Element}
import sketch/lustre/element/html
import shared

fn button_style() -> css.Class {
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
  ])
}

pub fn view() -> Element(msg) {
  html.div_([], [
    html.h1_([], [html.text("Projects")]),
    html.h2_([], [html.text("Raytracing in zig")]),
    html.a(
      button_style(),
      [attribute.href("/raytracing")],
      [html.text("link")],
    ),
    html.h2_([], [html.text("AI in C")]),
    html.a(
      button_style(),
      [attribute.href("/ai")],
      [html.text("link")],
    ),
    html.p_([], [html.text(shared.lorem_ipsum(2, "sentences"))])
  ])
}
