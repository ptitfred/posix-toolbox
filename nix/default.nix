{ callPackage }:

let scripts  = callPackage ./scripts.nix   {};
    lsColors = callPackage ./ls-colors.nix {};
    git-ps1  = callPackage ./git-ps1.nix   {
      git-pwd    = scripts.git-pwd;
      git-prd    = scripts.git-prd;
      prd        = scripts.prd;
      short-path = scripts.short-path;
    };
in scripts // lsColors // git-ps1
