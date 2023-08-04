{ callPackage, trapd00r-ls-colors
, lib, stdenv, makeWrapper
, coreutils, findutils, gawk, git, gnugrep, gnused, i3lock, imagemagick, less
, lsof, psmisc, scrot, tree, utillinux }:

let packageScript =
      script: inputs: description:
        stdenv.mkDerivation {
          name = "posix-toolbox-" + script;

          src = ./scripts;

          buildInputs = inputs ++ [ makeWrapper ] ;

          installPhase =
            let runtimePath = lib.makeBinPath inputs;
             in ''
                  mkdir -p $out/bin
                  cp $src/${script} $out/bin/${script}
                  wrapProgram $out/bin/${script} --prefix PATH : "${runtimePath}"
                '';

          meta = {
            homepage = "https://github.com/ptitfred/posix-toolbox";
            inherit description;
            license = lib.licenses.mit;
          };
        };
in
rec {
   git-authors      = packageScript "git-authors"      [ coreutils findutils git gnused            ] "A git script to list committers other a commit range";
   git-bubbles      = packageScript "git-bubbles"      [ coreutils git gnused                      ] "A git script to handle pull requests";
   git-checkout-log = packageScript "git-checkout-log" [ coreutils git gnused less                 ] "A git script to browser reflog and follow checkouts";
   git-prd          = packageScript "git-prd"          [ git prd                                   ] "A git script to display the path of the root of a git repository relative to your HOME directory";
   git-pwd          = packageScript "git-pwd"          [ coreutils git                             ] "A git script to display the path relative to the root of a git repository";
   git-rm-others    = packageScript "git-rm-others"    [ coreutils findutils git                   ] "A git script to clean the working copy from untracked files";
   git-search       = packageScript "git-search"       [ findutils git gnugrep                     ] "A git script to search the diff other a commit range";
   git-short        = packageScript "git-short"        [ git                                       ] "A git script to display short SHA1 of a given commit";
   git-std-init     = packageScript "git-std-init"     [ coreutils git                             ] "A git script to setup a repository with an initial empty commit and a base and master branches";
   git-tree         = packageScript "git-tree"         [ coreutils git tree                        ] "A git script to tree files handled by git";
   i3-screen-locker = packageScript "i3-screen-locker" [ coreutils i3lock imagemagick scrot        ] "A variant of i3lock that take a screenshot to use as background of the lock screen";
   prd              = packageScript "prd"              [ coreutils                                 ] "A script to print the working directory relative to your HOME directory";
   repeat           = packageScript "repeat"           [ coreutils gnused utillinux                ] "A script to repeat a command some times";
   short-path       = packageScript "short-path"       [ coreutils gnused                          ] "A script to abbreviate every directory unless the last part of a path";

   # FIXME: make buildInputs dependent on the target system (darwin vs linux)
   wait-tcp         = packageScript "wait-tcp"         [ coreutils gawk gnugrep gnused lsof psmisc ] "A script to wait for some server sockets to be opened on a TCP";

   ls-colors = callPackage ./ls-colors.nix { inherit trapd00r-ls-colors; };
   git-ps1   = callPackage ./git-ps1.nix   { inherit git-pwd git-prd prd short-path; };
 }

