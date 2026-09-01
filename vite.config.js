import { defineConfig } from "vite";
import gleam from "vite-gleam";
import { resolve } from "path";

export default defineConfig({
  plugins: [
    gleam(),
  ],
  input: {
    main: resolve(__dirname, "index.html"),
    // projects: resolve(__dirname, "projects.html"),
  },
  build: {
    outDir: "dist",
    rollDownOptions: {
      
    },
  },
});
