{
  description = "Personal toolbox: A collection of Unix scripts to ease my life. Mostly around git.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    trapd00r-ls-colors.url = "github:trapd00r/LS_COLORS";
    trapd00r-ls-colors.flake = false;

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, trapd00r-ls-colors, home-manager, ... }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };

        posix-toolbox = pkgs.callPackages ./src {
          inherit trapd00r-ls-colors;
        };

        tests = pkgs.callPackages ./tests {};

        defaultOverlay = _: _: { inherit posix-toolbox; };
        linterOverlay = _: _: { posix-toolbox = { inherit (posix-toolbox) nix-linter; }; };

        packages = tests // {
          default = pkgs.symlinkJoin {
            name = "posix-toolbox";
            paths = builtins.attrValues posix-toolbox;
          };

          lint = posix-toolbox.nix-linter;
        };

        homeManagerModule = import ./home-manager posix-toolbox;

        helpers = pkgs.callPackages tests/helpers.nix {};

     in {
          overlays.default = defaultOverlay;
          overlays.linter = linterOverlay;

          packages.${system} = packages;

          checks.${system} = helpers.mkChecks {
            lint = "${posix-toolbox.nix-linter}/bin/nix-linter ${./.}";
            spell = "${tests.spell}/bin/posix-toolbox-spell ${./.}";
          };

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
