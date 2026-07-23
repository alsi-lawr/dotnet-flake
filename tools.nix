{
  pkgs,
  csharp-language-server,
  ...
}:

let
  csharpLanguageServer = csharp-language-server.packages.${pkgs.system}.csharp-ls;

  centralisedPackageConverter = pkgs.buildDotnetGlobalTool {
    pname = "central-pkg-converter";
    nugetName = "CentralisedPackageConverter";
    version = "1.0.74";

    nugetHash = "sha256-byMgF9JsLJzOqBMrnfB/35y1iTM++zMe4V1BZkDr2Rs=";
  };
in
{
  home.packages = with pkgs; [
    centralisedPackageConverter
    csharpLanguageServer
    csharpier
    dotnet-ef
  ];
}
