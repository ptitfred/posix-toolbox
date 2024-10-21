{ pkgs, lib
, pinned-nix-linter
, trapd00r-ls-colors
, excludedPaths ? []
}:

let context = {
      inherit trapd00r-ls-colors pinned-nix-linter excludedPaths;
      packageScript = pkgs.callPackage ./package-script.nix {};
    };

    callPackage = lib.callPackageWith (pkgs // context // scripts);

    scripts = {
      git-authors      = callPackage ./git-authors      {};
      git-bubbles      = callPackage ./git-bubbles      {};
      git-checkout-log = callPackage ./git-checkout-log {};
      git-prd          = callPackage ./git-prd          {};
      git-pwd          = callPackage ./git-pwd          {};
      git-rm-others    = callPackage ./git-rm-others    {};
      git-search       = callPackage ./git-search       {};
      git-short        = callPackage ./git-short        {};
      git-std-init     = callPackage ./git-std-init     {};
      git-tree         = callPackage ./git-tree         {};
      prd              = callPackage ./prd              {};
      repeat           = callPackage ./repeat           {};
      short-path       = callPackage ./short-path       {};
      wait-tcp         = callPackage ./wait-tcp         {};
      ls-colors        = callPackage ./ls-colors.nix    {};
      git-ps1          = callPackage ./git-ps1          {};
      nix-linter       = callPackage ./nix-linter.nix   {};
    };
 in scripts
