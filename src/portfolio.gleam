import grille_pain
import grille_pain/lustre/toast
import contact
import router.{type Route}
import gleam/uri
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/attribute
import lustre/element/html
import modem

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
  let route = case
    modem.initial_uri() {
    Ok(uri) -> init_route(router.parse_route(uri))
    Error(_) -> HomePage
  }
  #(route, modem.init(fn (uri) {
    uri
    |> router.parse_route
    |> UserChangedRoute
  }))
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

fn home_view() -> Element(Msg) {
  html.div([], [html.text("Oscar Weimann")])
}

fn about_view() -> Element(Msg) {
  html.div([], [html.h1([], [html.text("About")])])
}

fn projects_view() -> Element(Msg) {
  html.div([], [html.h1([], [html.text("Projects")])])
}

fn not_found_view(uri: uri.Uri) -> Element(Msg) {
  html.div([], [html.h1([], [html.text("Page " <> uri.path <> " not found" )])])
}

fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.nav([attribute.class("flex flex-row justify-between p-2 m-2")], [
      html.a([router.href(router.Home)], [html.text("home")]),
      html.a([router.href(router.Projects)], [html.text("projects")]),
      html.a([router.href(router.About)], [html.text("about")]),
      html.a([router.href(router.Contact)], [html.text("contact")]),
    ]),

    case model {
      HomePage -> home_view()
      ContactPage -> contact.view() |> element.map(Contact)
      AboutPage -> about_view()
      ProjectsPage -> projects_view()
      NotFoundPage(uri) -> not_found_view(uri)
    },
  ])
}

pub fn main() -> Nil {
  let assert Ok(_) = grille_pain.simple()
  let assert Ok(_) = lustre.application(init, update, view)
    |> lustre.start("#app", Nil)

  Nil
}
