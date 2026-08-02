{
  description = "Dotnet setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    csharp-language-server = {
      url = "path:/home/alex/dev/csharp-language-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotnet-workspace-explorer = {
      url = "github:alsi-lawr/dotnet-workspace-explorer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      csharp-language-server,
      dotnet-workspace-explorer,
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
            inherit csharp-language-server dotnet-workspace-explorer;
          };

          imports = [ ./tools.nix ];

          home.packages = [ dotnetCombined ];

          home.sessionVariables = {
            DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
          };
        };
    };
}
