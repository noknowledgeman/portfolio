import about
import contact
import gleam/uri
import grille_pain
import grille_pain/lustre/toast
import home
import lucide_lustre
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/event
import projects
import sketch
import sketch/css
import sketch/css/length
import sketch/lustre as sketch_lustre
import sketch/lustre/element/html
import styles

import shared.{
  type Model, type Msg, Dark, Light, Model, System, SystemThemeChanged,
  UserPressedEmail, UserToggledColourMode,
}

fn watch_scheme() -> Effect(Msg) {
  effect.from(fn(dispatch) {
    use is_dark <- styles.on_scheme_change
    dispatch(SystemThemeChanged(is_dark))
  })
}

fn init(_) -> #(Model, Effect(Msg)) {
  #(
    // Change to user preference? 
    Model(System(styles.prefers_dark())),
    effect.batch([
      watch_scheme(),
    ]),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserToggledColourMode -> #(
      Model(colour_mode: case model.colour_mode {
        Light | System(False) -> {
          styles.set_attribute("data-theme", "dark")
          Dark
        }
        Dark | System(True) -> {
          styles.set_attribute("data-theme", "light")
          Light
        }
      }),
      effect.none(),
    )
    UserPressedEmail -> {
      contact.write_text("oslewei.proton.me")
      #(model, toast.toast("Copied Email!"))
    }
    _ -> panic as "what the fuck"
  }
}

fn light_mode_button(model: Model) -> Element(Msg) {
  html.button(css.class([]), [event.on_click(UserToggledColourMode)], [
    case model.colour_mode {
      Light | System(False) -> lucide_lustre.moon([])
      Dark | System(True) -> lucide_lustre.sun([])
    },
  ])
}

fn navbar(model: Model) -> Element(Msg) {
  html.nav(
    css.class([
      css.width(length.vw(100)),
      css.display("flex"),
      css.flex_direction("row"),
      css.justify_content("space-between"),
      css.align_items("center"),
      css.position("sticky"),
      css.top(length.px(0)),
      css.z_index(100),
      css.background(styles.background_color),
      css.border_bottom("solid 1px black"),
    ]),
    [],
    [
      html.a(styles.button(), [attribute.href("#home")], [html.text("home")]),
      html.a(styles.button(), [attribute.href("#projects")], [
        html.text("projects"),
      ]),
      html.a(styles.button(), [attribute.href("#about")], [html.text("about")]),
      html.a(styles.button(), [attribute.href("#contact")], [
        html.text("contact"),
      ]),
      light_mode_button(model),
    ],
  )
}

fn view(model: Model, stylesheet: sketch.StyleSheet) -> Element(Msg) {
  use <- sketch_lustre.render(stylesheet, [sketch_lustre.node()])
  html.div(css.class([]), [], [
    navbar(model),
    html.section(styles.section(), [attribute.id("home")], home.view()),
    html.section(styles.section(), [attribute.id("projects")], projects.view()),
    html.section(styles.section(), [attribute.id("about")], about.view()),
    html.section(styles.section(), [attribute.id("contact")], contact.view()),
  ])
}

pub fn main() -> Nil {
  let assert Ok(stylesheet) = sketch_lustre.construct(styles.global)
  let assert Ok(_) = grille_pain.simple()
  let assert Ok(_) =
    lustre.application(init, update, view(_, stylesheet))
    |> lustre.start("#app", Nil)

  Nil
}
