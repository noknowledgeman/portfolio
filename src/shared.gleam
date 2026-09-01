
pub type ColourMode {
  // lazy but true is dark and false is light
  System(is_dark: Bool)
  Light
  Dark
}

pub type Model {
  Model(colour_mode: ColourMode)
}

pub type Msg {
  UserToggledColourMode
  UserPressedEmail
  SystemThemeChanged(is_dark: Bool)
}

@external(javascript, "./browser_ffi.mjs", "loremIpsumGleam")
pub fn lorem_ipsum(count: Int, units: String) -> String