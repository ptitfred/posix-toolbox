{ callPackage, stdenv, lib, findutils, git, gnused }:

let packageScript = callPackage ./package.nix {};
in {
     git-authors      = packageScript "git-authors"      [ findutils git gnused ] "A git script to list committers other a commit range";
     git-bubbles      = packageScript "git-bubbles"      [ git gnused           ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ git                  ] "A git script to browser reflog and follow checkouts";
     ls-colors = callPackage ./ls-colors.nix {};
   }
