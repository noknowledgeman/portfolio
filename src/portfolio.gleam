import config
import gleam/result
import gleam/string
import gleam/uri
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/attribute.{type Attribute}
import lustre/element/html
import modem

pub type Route {
  Home
  Projects
  About
  Contact
  NotFound(uri: uri.Uri)
}

pub type Model =
  Route

type Msg {
  UserChangedRoute(Route)
}

/// adds the base path to the front of the path
fn path(path: String) -> String {
  config.base_path <> path
}

fn strip_base(segments: List(String)) -> List(String) {
  let base = string.replace(config.base_path, "/", "")
  case segments {
    [first, ..rest] if first == base -> rest
    _ -> segments
  }
}

fn parse_route(uri: uri.Uri) -> Route {
  case strip_base(uri.path_segments(uri.path)) {
    [] | [""] -> Home
    ["about"] -> About
    ["contact"] -> Contact
    ["projects"] -> Projects
    _ -> NotFound(uri:)
  }
}

fn href(route: Route) -> Attribute(Msg) {
  let url = case route {
    Home -> path("")
    About -> path("about")
    Projects -> path("projects")
    Contact -> path("contact")
    NotFound(_) -> path("404")
  }

  attribute.href(url)
}

fn init(_) -> #(Model, Effect(Msg)) {
  let route = case
    modem.initial_uri()
    |> result.map(parse_route)
  {
    Ok(a) -> a
    Error(_) -> Home
  }
  #(route, modem.init(fn (uri) {
    uri
    |> parse_route
    |> UserChangedRoute
  }))
}

fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserChangedRoute(route) -> #(route, effect.none())
  }
}

fn home_view(_model: Model) -> Element(Msg) {
  html.div([], [html.text("Oscar Weimann")])
}

fn contact_view(_model: Model) -> Element(Msg) {
  html.div([], [html.h1([], [html.text("Contact")])])
}

fn about_view(_model: Model) -> Element(Msg) {
  html.div([], [html.h1([], [html.text("About")])])
}

fn projects_view(_model: Model) -> Element(Msg) {
  html.div([], [html.h1([], [html.text("Projects")])])
}

fn not_found_view(_model: Model, uri: uri.Uri) -> Element(Msg) {
  html.div([], [html.h1([], [html.text("Page " <> uri.path <> " not found" )])])
}

fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.nav([attribute.class("flex flex-row justify-between p-2 m-2")], [
      html.a([href(Home)], [html.text("home")]),
      html.a([href(Projects)], [html.text("projects")]),
      html.a([href(About)], [html.text("about")]),
      html.a([href(Contact)], [html.text("contact")]),
    ]),

    case model {
      Home -> home_view(model)
      Contact -> contact_view(model)
      About -> about_view(model)
      Projects -> projects_view(model)
      NotFound(uri) -> not_found_view(model, uri)
    },
  ])
}

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
