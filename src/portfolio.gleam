import lustre/event
import gleam/int
import lustre/element/html
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}

type Model = Int

type Message {
  Hello
}

fn init(_) -> #(Model, Effect(Message)) {
  #(0, effect.none())
}

fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  case message {
    Hello -> #(model + 100, effect.none())
  }
}

fn view(model: Model) -> Element(Message) {
  html.div([], [
    html.text(int.to_string(model)),
    html.button([event.on_click(Hello)], [html.text("hello")])
  ])
}

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
