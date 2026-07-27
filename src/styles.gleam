//// global styles

import sketch
import sketch/css

const background_color = "#FAF9F6"

const dark_background_color = "#1A1A18"

pub fn global(stylesheet: sketch.StyleSheet) -> sketch.StyleSheet {
  stylesheet
  |> sketch.global(
    css.global(":root", [css.font_family("\"IBM Plex Sans\", sans-serif")]),
  )
  |> sketch.global(css.global("body", [css.background_color(background_color)]))
}
