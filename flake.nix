{
  description = "Dotnet setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }: {
    homeModules.default = { pkgs, ... }:
      let
        dotnetCombined = with pkgs.dotnetCorePackages;
          combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ];
      in {
        homeManagerModules.default = { ... }: {
          imports = [ ./tools.nix ];
          home.packages = [ dotnetCombined ];
          home.sessionVariables = {
            DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
          };
        };
      };
  };
}
