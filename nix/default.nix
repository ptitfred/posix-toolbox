{ callPackage }:

let scripts  = callPackage ./scripts.nix   {};
    lsColors = callPackage ./ls-colors.nix {};
in scripts // lsColors
