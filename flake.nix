{
  description = "Dotnet setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    csharp-language-server = {
      url = "github:alsi-lawr/csharp-language-server/perf/shared-analyzer-diagnostics-a4-002";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotnet-workspace-explorer = {
      url = "git+file:///home/alex/dev/dotnet-workspace-explorer";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotnet-package-explorer = {
      url = "git+file:///home/alex/dev/dotnet-package-explorer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      csharp-language-server,
      dotnet-workspace-explorer,
      dotnet-package-explorer,
      ...
    }:
    {
      homeModules.default =
        { pkgs, ... }:
        let
          dotnetCombined =
            with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_8_0
              sdk_9_0
              sdk_10_0
            ];
        in
        {
          _module.args = {
            inherit csharp-language-server dotnet-workspace-explorer dotnet-package-explorer;
          };

          imports = [ ./tools.nix ];

          home.packages = [ dotnetCombined ];

          home.sessionVariables = {
            DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
          };
        };
    };
}
