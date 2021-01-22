{ stdenv, coreutils, fetchFromGitHub }:

let fromJSON = path: fetchFromGitHub (builtins.fromJSON (builtins.readFile path));
    ls-colors =
      stdenv.mkDerivation {
        name = "posix-toolbox-ls-colors";

        src = fromJSON ./trapd00r-ls-colors.json;

        buildInputs = [ coreutils ];

        installPhase = ''
          mkdir -p $out/share/ls-colors
          dircolors -b $src/LS_COLORS > $out/share/ls-colors/bash.sh
          dircolors -c $src/LS_COLORS > $out/share/ls-colors/csh.sh
        '';
      };
in { inherit ls-colors; }
