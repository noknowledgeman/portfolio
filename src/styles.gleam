//// global styles

import lustre/effect
import sketch/css/media
import sketch
import sketch/css

@external(javascript, "./browser_ffi.mjs", "setAttribute")
pub fn set_attribute(attrib: String, state: String) -> Nil

@external(javascript, "./browser_ffi.mjs", "prefersDark")
pub fn prefers_dark() -> Bool

@external(javascript, "./browser_ffi.mjs", "onSchemeChange")
pub fn on_scheme_change(callback: fn(Bool) -> Nil) -> Nil

const background_color = "#FAF9F6"

const dark_background_color = "#1A1A18"

pub fn global(stylesheet: sketch.StyleSheet) -> sketch.StyleSheet {
  stylesheet
  |> sketch.global(
    css.global(":root", [
      css.font_family("\"IBM Plex Sans\", sans-serif"),
      css.background_color(background_color),
      css.media(media.dark_theme(), [
        css.background_color(dark_background_color)
      ])
    ]),
  )
  |> sketch.global(
    css.global("[data-theme=\"dark\"]", [
      css.background_color(dark_background_color)
    ])
  )
}
