{ callPackage, stdenv, lib, coreutils, findutils, gawk, git, gnugrep, gnused, lsof, psmisc }:

let packageScript = callPackage ./package.nix {};
in {
     git-authors      = packageScript "git-authors"      [ findutils git gnused  ] "A git script to list committers other a commit range";
     git-bubbles      = packageScript "git-bubbles"      [ git gnused            ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ git                   ] "A git script to browser reflog and follow checkouts";
     wait-tcp         = packageScript "wait-tcp"         [ coreutils gawk gnugrep gnused lsof psmisc ] # FIXME: make buildInputs dependent on the target system (darwin vs linux)
                          "A script to wait for some server sockets to be opened on a TCP";
     ls-colors = callPackage ./ls-colors.nix {};
   }
