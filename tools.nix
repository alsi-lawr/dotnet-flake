{ pkgs, ... }:
let
  centralisedPackageConverter = pkgs.buildDotnetGlobalTool {
    pname = "central-pkg-converter";
    nugetName = "CentralisedPackageConverter";
    version = "1.0.74";

    nugetHash = "sha256-byMgF9JsLJzOqBMrnfB/35y1iTM++zMe4V1BZkDr2Rs=";
  };
in { home.packages = [ centralisedPackageConverter ]; }
