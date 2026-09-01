import { defineConfig } from "vite";
import gleam from "vite-gleam";
import { resolve } from "path";

// 
function flattenPages() {
  return {
    name: "flatten-pages",
    generateBundle(_, bundle) {
      for (const [fileName, asset] of Object.entries(bundle)) {
        if (!fileName.startsWith("pages")) continue;

        const newFilename = fileName.slice("pages/".length)
        delete bundle[fileName]
        asset.fileName = newFileName;
        bundle[newFileName] = asset;
      }
    }
  }
}

export default defineConfig({
  plugins: [
    gleam(),
    flattenPages(),
  ],
  input: {
    main: resolve(__dirname, "pages", "index.html"),
    projects: resolve(__dirname, "pages", "projects.html"),
    404: resolve(__dirname, "pages", "404.html")
  },
  build: {
    outDir: "dist",
    rollDownOptions: {
      
    },
  },
});
