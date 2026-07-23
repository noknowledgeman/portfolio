import lustre/event
import lustre/element/html
import lustre/element.{type Element}
import gleam/javascript/promise.{type Promise}

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
      let _ = write_text("oslewei@gmx.de")

      Nil
    }
  }
}

pub fn view() -> Element(Msg) {
  html.div([], [
    html.text("Contact"),
    html.p([], [html.text("WOlrd")]),
    html.p([event.on_click(UserPressedEmail)], [html.text("Email: oslewei@gmx.de")])
  ])
}
