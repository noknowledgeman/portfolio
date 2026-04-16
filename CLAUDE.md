# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm run dev       # start dev server at localhost:4321
npm run build     # build static output to dist/
npm run preview   # preview the built site locally
```

No linting or test setup exists yet.

## Architecture

This is an **Astro 6** static site (default `output: 'static'`). All pages are in `src/pages/` and use file-based routing.

**Layout system:** Every page wraps its content in `src/layouts/Base.astro`, which accepts a `title` prop and renders the global `<head>`, CSS custom properties, and the fixed `Navbar` component.

**Design tokens** are defined as CSS custom properties in `Base.astro`'s `<style is:global>` block — all pages and components reference these variables (`--bg`, `--red`, `--text`, `--border`, etc.) rather than hardcoding colors.

**Pages:**
- `index.astro` — hero / landing
- `about.astro` — placeholder
- `projects.astro` — placeholder
- `contact.astro` — placeholder

**Fonts:** Inter (sans) and JetBrains Mono (mono) loaded from Google Fonts. The `.mono` utility class applies `var(--font-mono)`.

## GitHub Pages deployment

To deploy, set `site` and `base` in `astro.config.mjs` and add a GitHub Actions workflow that runs `npm run build` and uploads `dist/` via `actions/upload-pages-artifact`.
