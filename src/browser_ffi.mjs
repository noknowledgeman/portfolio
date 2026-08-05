/// From the plinth
import { Result$Ok, Result$Error } from "./gleam.mjs";

export async function readText() {
  try {
    return Result$Ok(await globalThis.navigator.clipboard.readText());
  } catch (error) {
    return Result$Error(error.toString());
  }
}

export async function writeText(clipText) {
  try {
    return Result$Ok(await globalThis.navigator.clipboard.writeText(clipText));
  } catch (error) {
    return Result$Error(error.toString());
  }
}

export function prefersDark() {
  return window.matchMedia("(prefers-color-scheme: dark)").matches
}

export function onSchemeChange(callback) {
  const mq = window.matchMedia("(prefers-color-scheme: dark)");
  mq.addEventListener("change", (e) => callback(e.matches));
}

export function setAttribute(attrib, state) {
  document.documentElement.setAttribute(attrib, state)
}