Package.describe({
  summary: "TokBox video package"
});

Npm.depends({opentok: "0.3.1"});

Package.on_use(function (api) {
  api.add_files("opentok.js", "server");
});
