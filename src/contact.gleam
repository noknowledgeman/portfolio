import sketch/css
import gleam/javascript/promise.{type Promise}
import lustre/element.{type Element}
import lustre/event
import sketch/lustre/element/html

pub type Msg {
  UserPressedEmail
}

// NOT USED
@external(javascript, "./browser_ffi.mjs", "readText")
pub fn read_text() -> Promise(Result(String, String))

@external(javascript, "./browser_ffi.mjs", "writeText")
pub fn write_text(clip_text: String) -> Promise(Result(Nil, String))

pub fn update(msg: Msg) {
  case msg {
    UserPressedEmail -> {
      let _ = write_text("oslewei@proton.me")

      Nil
    }
  }
}

pub fn view() -> Element(Msg) {
  html.div_([], [
    html.h1_([], [html.text("Contact")]),
    html.p_([], [
      html.text("Email: "),
      html.span(css.class([
        css.cursor("pointer")
      ]), [event.on_click(UserPressedEmail)], [
        html.text("oslewei@proton.me"),
      ]),
    ])
  ])
}
