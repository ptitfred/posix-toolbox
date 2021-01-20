{ callPackage, stdenv, lib, git, gnused }:

let packageScript = callPackage ./package.nix {};
in { git-bubbles      = packageScript "git-bubbles"      [ git gnused ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ git ]        "A git script to browser reflog and follow checkouts";
   }
