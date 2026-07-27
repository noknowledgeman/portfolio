import projects/projects
import home
import about
import contact
import gleam/uri
import grille_pain
import grille_pain/lustre/toast
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import modem
import router.{type Route}
import sketch
import sketch/css
import sketch/lustre as sketch_lustre
import sketch/lustre/element/html
import styles

pub type Model {
  HomePage
  AboutPage
  ProjectsPage
  ContactPage
  NotFoundPage(uri: uri.Uri)
}

type Msg {
  UserChangedRoute(Route)
  Contact(contact.Msg)
}

fn init_route(route: Route) -> Model {
  case route {
    router.Home -> HomePage
    router.About -> AboutPage
    router.Projects -> ProjectsPage
    router.Contact -> ContactPage
    router.NotFound(uri) -> NotFoundPage(uri)
  }
}

fn init(_) -> #(Model, Effect(Msg)) {
  let route = case modem.initial_uri() {
    Ok(uri) -> init_route(router.parse_route(uri))
    Error(_) -> HomePage
  }
  #(
    route,
    modem.init(fn(uri) {
      uri
      |> router.parse_route
      |> UserChangedRoute
    }),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg, model {
    UserChangedRoute(route), _ -> #(init_route(route), effect.none())
    Contact(msg), ContactPage -> {
      contact.update(msg)
      // TODO: I dont love this but it works, I need to refactor later
      #(model, toast.toast("Copied!"))
    }
    _, _ -> #(model, effect.none())
  }
}



fn not_found_view(uri: uri.Uri) -> Element(Msg) {
  html.div_([], [html.h1_([], [html.text("Page " <> uri.path <> " not found")])])
}

fn view(model: Model, stylesheet: sketch.StyleSheet) -> Element(Msg) {
  use <- sketch_lustre.render(stylesheet, [sketch_lustre.node()])
  html.div_([], [
    // TODO: refactor
    html.nav(
      css.class([
        css.display("flex"),
        css.flex_direction("row"),
        css.justify_content("space-between"),
        css.align_items("center"),
      ]),
      [],
      [
        html.a_([router.href(router.Home)], [html.text("home")]),
        html.a_([router.href(router.Projects)], [html.text("projects")]),
        html.a_([router.href(router.About)], [html.text("about")]),
        html.a_([router.href(router.Contact)], [html.text("contact")]),
      ],
    ),

    case model {
      HomePage -> home.view()
      ContactPage -> contact.view() |> element.map(Contact)
      AboutPage -> about.view()
      ProjectsPage -> projects.view()
      NotFoundPage(uri) -> not_found_view(uri)
    },
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
