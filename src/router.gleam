import config
import gleam/string
import gleam/uri
import lustre/attribute.{type Attribute}

pub type Route {
  Home
  Projects
  About
  Contact
  NotFound(uri: uri.Uri)
}

/// adds the base path to the front of the path
pub fn path(path: String) -> String {
  config.base_path <> path
}

pub fn strip_base(segments: List(String)) -> List(String) {
  let base = string.replace(config.base_path, "/", "")
  case segments {
    [first, ..rest] if first == base -> rest
    _ -> segments
  }
}

pub fn parse_route(uri: uri.Uri) -> Route {
  case strip_base(uri.path_segments(uri.path)) {
    [] | [""] -> Home
    ["about"] -> About
    ["contact"] -> Contact
    ["projects"] -> Projects
    _ -> NotFound(uri:)
  }
}

pub fn href(route: Route) -> Attribute(message) {
  let url = case route {
    Home -> path("")
    About -> path("about")
    Projects -> path("projects")
    Contact -> path("contact")
    NotFound(_) -> path("404")
  }

  attribute.href(url)
}
