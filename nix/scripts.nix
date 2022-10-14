{ callPackage, coreutils, findutils, gawk, git, gnugrep, gnused, i3lock, imagemagick, less, lsof, psmisc, scrot, utillinux }:

let packageScript = callPackage ./package.nix {};
in rec {
     git-authors      = packageScript "git-authors"      [ coreutils findutils git gnused     ] "A git script to list committers other a commit range";
     git-bubbles      = packageScript "git-bubbles"      [ coreutils git gnused               ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ coreutils git gnused less          ] "A git script to browser reflog and follow checkouts";
     git-prd          = packageScript "git-prd"          [ git prd                            ] "A git script to display the path of the root of a git repository relative to your HOME directory";
     git-pwd          = packageScript "git-pwd"          [ coreutils git                      ] "A git script to display the path relative to the root of a git repository";
     git-rm-others    = packageScript "git-rm-others"    [ coreutils findutils git            ] "A git script to clean the working copy from untracked files";
     git-search       = packageScript "git-search"       [ findutils git gnugrep              ] "A git script to search the diff other a commit range";
     git-short        = packageScript "git-short"        [ git                                ] "A git script to display short SHA1 of a given commit";
     git-std-init     = packageScript "git-std-init"     [ coreutils git                      ] "A git script to setup a repository with an initial empty commit and a base and master branches";
     i3-screen-locker = packageScript "i3-screen-locker" [ coreutils i3lock imagemagick scrot ] "A variant of i3lock that take a screenshot to use as background of the lock screen";
     prd              = packageScript "prd"              [ coreutils                          ] "A script to print the working directory relative to your HOME directory";
     repeat           = packageScript "repeat"           [ coreutils gnused utillinux         ] "A script to repeat a command some times";
     short-path       = packageScript "short-path"       [ coreutils gnused                   ] "A script to abbreviate every directory unless the last part of a path";
     wait-tcp         = packageScript "wait-tcp"         [ coreutils gawk gnugrep gnused lsof psmisc ] # FIXME: make buildInputs dependent on the target system (darwin vs linux)
                          "A script to wait for some server sockets to be opened on a TCP";
   }
