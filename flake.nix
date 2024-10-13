{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-22_11.url = "github:nixos/nixpkgs/nixos-22.11";
    trapd00r-ls-colors.url = "github:trapd00r/LS_COLORS?rev=e91cc9cc69f6c4780f03b121bc633569742de7cd";
    trapd00r-ls-colors.flake = false;

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos-22_11, trapd00r-ls-colors, home-manager, ... }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
        previous = import nixos-22_11 { inherit system; };

        posix-toolbox = pkgs.callPackages ./src { inherit trapd00r-ls-colors; };

        tests = pkgs.callPackages ./tests { inherit (previous) nix-linter; };

        default = pkgs.symlinkJoin {
          name = "posix-toolbox";
          paths = builtins.attrValues posix-toolbox;
        };

        overlay = _: _: { inherit posix-toolbox; };

        homeManagerModule = import ./home-manager-module.nix posix-toolbox;
     in {
          inherit overlay;
          overlays.default = overlay;

          packages.${system} = tests // { inherit default; };

          homeManagerModules.default = homeManagerModule;

          homeConfigurations = {
            tests =
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  homeManagerModule
                  tests/hm-module.nix
                ];
              };
          };
        };
}