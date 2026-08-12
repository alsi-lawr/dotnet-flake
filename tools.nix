{
  pkgs,
  csharp-language-server,
  dotnet-workspace-explorer,
  dotnet-package-explorer,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  csharpLanguageServer = csharp-language-server.packages.${system}.csharp-ls;
  dotnetWorkspaceExplorer = dotnet-workspace-explorer.packages.${system}.default;
  dotnetPackageExplorer = dotnet-package-explorer.packages.${system}.default;

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
    dotnetWorkspaceExplorer
    dotnetPackageExplorer
    fsautocomplete
    fantomas
  ];
}
