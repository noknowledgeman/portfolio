import config
import gleam/uri
import gleam/result
import modem
import lustre/attribute
import lustre/event
import gleam/int
import lustre/element/html
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}

type Route {
  Home
  Projects
  About
  Contact
}

type Model = Route

type Msg {
  UserChandedRoute(Route)
}

/// adds the base path to the front of the path
fn path(path: String) -> String {
  config.base_path <> path
}

fn strip_base(segments: List(String)) -> List(String) {
  case segments {
    [first, ..rest] if first == config.base_path -> rest
    _ -> segments
  }
}

fn init(_) -> #(Model, Effect(Msg)) {
  let route = 
    case modem.initial_uri() 
      |> result.map(uri_to_route) {
      Ok(a) -> a
      Error(_) -> Home
    }
  #(route, modem.init(on_url_change))
}

fn uri_to_route(uri: uri.Uri) -> Route {
  case strip_base(uri.path_segments(uri.path)) {
    ["about"] -> About
    ["contact"] -> Contact
    ["projects"] -> Projects // TODO: make this a sub thing
    _ -> Home
  }
}

fn on_url_change(uri: uri.Uri) -> Msg {
  UserChandedRoute(uri_to_route(uri))
}

fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserChandedRoute(route) -> #(route, effect.none())
  }
}

fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.nav([], [
      html.a([attribute.href(path(""))], [html.text("home")]),
      html.a([attribute.href(path("projects"))], [html.text("projects")]),
      html.a([attribute.href(path("about"))], [html.text("about")]),
      html.a([attribute.href(path("contact"))], [html.text("contact")]),
    ]),
    
    case model {
      Home -> html.div([], [html.text("Oscar Weimann")])
      Contact -> html.div([], [html.h1([], [html.text("Contact")])])
      About -> html.div([], [html.h1([], [html.text("About")])])
      Projects -> html.div([], [html.h1([], [html.text("Projects")])])
    }
  ])
}

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
