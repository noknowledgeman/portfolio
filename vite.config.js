import { defineConfig } from "vite";
import gleam from "vite-gleam";
import { resolve } from "path";

export default defineConfig({
  plugins: [
    gleam(),
  ],
  input: {
    main: resolve(__dirname, "index.html"),
    raytracing: resolve(__dirname, "raytracing.html"),
    ai: resolve(__dirname, "ai.html")
  },
  build: {
    outDir: "dist",
  },
});
