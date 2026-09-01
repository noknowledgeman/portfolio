import { defineConfig } from "vite";
import gleam from "vite-gleam";
import { resolve } from "path";

export default defineConfig({
  plugins: [gleam()],
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, "index.html"),
        projects: resolve(__dirname, "projects.html"),
      },
    },
  },
});
