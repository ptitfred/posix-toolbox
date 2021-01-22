{ callPackage, stdenv, lib, coreutils, findutils, gawk, git, gnugrep, gnused, lsof, psmisc }:

let packageScript = callPackage ./package.nix {};
in {
     git-authors      = packageScript "git-authors"      [ findutils git gnused  ] "A git script to list committers other a commit range";
     git-bubbles      = packageScript "git-bubbles"      [ git gnused            ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ git                   ] "A git script to browser reflog and follow checkouts";
     git-pwd          = packageScript "git-pwd"          [ coreutils git         ] "A git script to display the path relative to the root of a git repository";
     git-rm-others    = packageScript "git-rm-others"    [ findutils git         ] "A git script to clean the working copy from untracked files";
     git-search       = packageScript "git-search"       [ findutils git gnugrep ] "A git script to search the diff other a commit range";
     git-short        = packageScript "git-short"        [ git                   ] "A git script to display short SHA1 of a given commit";
     prd              = packageScript "prd"              [ coreutils             ] "A script to print the working directory relative to your HOME directory";
     wait-tcp         = packageScript "wait-tcp"         [ coreutils gawk gnugrep gnused lsof psmisc ] # FIXME: make buildInputs dependent on the target system (darwin vs linux)
                          "A script to wait for some server sockets to be opened on a TCP";
     ls-colors = callPackage ./ls-colors.nix {};
   }
