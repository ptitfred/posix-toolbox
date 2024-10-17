{ runCommand, coreutils, trapd00r-ls-colors }:

runCommand "posix-toolbox-ls-colors"
  {
    src = trapd00r-ls-colors;
    buildInputs = [ coreutils ];
  }
  ''
    mkdir -p $out/share/ls-colors
    dircolors -b $src/LS_COLORS > $out/share/ls-colors/bash.sh
  ''
