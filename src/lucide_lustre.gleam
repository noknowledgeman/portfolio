import lustre/attribute.{type Attribute, attribute}
import lustre/element/svg

pub fn sun(attributes: List(Attribute(a))) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      ..attributes
    ],
    [
      svg.circle([
        attribute("r", "4"),
        attribute("cy", "12"),
        attribute("cx", "12"),
      ]),
      svg.path([attribute("d", "M12 2v2")]),
      svg.path([attribute("d", "M12 20v2")]),
      svg.path([attribute("d", "m4.93 4.93 1.41 1.41")]),
      svg.path([attribute("d", "m17.66 17.66 1.41 1.41")]),
      svg.path([attribute("d", "M2 12h2")]),
      svg.path([attribute("d", "M20 12h2")]),
      svg.path([attribute("d", "m6.34 17.66-1.41 1.41")]),
      svg.path([attribute("d", "m19.07 4.93-1.41 1.41")]),
    ],
  )
}
