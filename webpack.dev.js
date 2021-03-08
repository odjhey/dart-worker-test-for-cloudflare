module.exports = {
  target: "webworker",
  devtool: "cheap-module-source-map", // avoid "eval": Workers environment doesn’t allow it
  entry: "./dist/index.js",
  mode: "production",
};
