{ callPackage, stdenv, lib, coreutils, findutils, gawk, git, gnugrep, gnused, lsof, psmisc }:

let packageScript = callPackage ./package.nix {};
    git-authors      = packageScript "git-authors"      [ findutils git gnused  ] "A git script to list committers other a commit range";
    git-bubbles      = packageScript "git-bubbles"      [ git gnused            ] "A git script to handle pull requests";
    git-checkout-log = packageScript "git-checkout-log" [ git                   ] "A git script to browser reflog and follow checkouts";
    git-prd          = packageScript "git-prd"          [ prd git               ] "A git script to display the path of the root of a git repository relative to your HOME directory";
    git-pwd          = packageScript "git-pwd"          [ coreutils git         ] "A git script to display the path relative to the root of a git repository";
    git-rm-others    = packageScript "git-rm-others"    [ findutils git         ] "A git script to clean the working copy from untracked files";
    git-search       = packageScript "git-search"       [ findutils git gnugrep ] "A git script to search the diff other a commit range";
    git-short        = packageScript "git-short"        [ git                   ] "A git script to display short SHA1 of a given commit";
    git-std-init     = packageScript "git-std-init"     [ git                   ] "A git script to setup a repository with an initial empty commit and a base and master branches";
    prd              = packageScript "prd"              [ coreutils             ] "A script to print the working directory relative to your HOME directory";
    wait-tcp         = packageScript "wait-tcp"         [ coreutils gawk gnugrep gnused lsof psmisc ] # FIXME: make buildInputs dependent on the target system (darwin vs linux)
                         "A script to wait for some server sockets to be opened on a TCP";
in {
     inherit git-authors git-bubbles git-checkout-log git-prd git-pwd git-rm-others git-search git-short git-std-init prd wait-tcp;
     ls-colors = callPackage ./ls-colors.nix {};
   }
