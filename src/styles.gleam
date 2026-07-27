import sketch/css
import sketch

pub fn global(stylesheet: sketch.StyleSheet) -> sketch.StyleSheet {
  stylesheet
  |> sketch.global(css.global("body", [css.background_color("red")]))
}